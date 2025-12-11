from fastapi import UploadFile, BackgroundTasks
from datetime import datetime, timezone
from sqlalchemy.orm import Session
from fastapi import HTTPException
from sqlalchemy import func, select
from core.models import alumno, profesor, actividad, registro
from services.mailsend_service import idForm, formularioMail

def verificarDatos(db: Session, rut_alumno: str, id_actividad: int):
    if not db.execute(select(alumno).where(alumno.c.rut_alumno == rut_alumno)).first():
        raise HTTPException(status_code=400, detail="Alumno no existe")
    if not db.execute(select(actividad).where(actividad.c.id_actividad == id_actividad)).first():
        raise HTTPException(status_code=400, detail="Actividad no existe")

def numeroRegistro(db: Session, id_registro: int):
    result = db.query(func.count(id_registro)).scalar()
    return result + 1

# Función genérica factorizada (nueva, para ambos tipos)
async def guardar_registro(
    rut: str,
    academica: int,
    actividad: int,
    fecha_inicio: datetime,
    fecha_termino: datetime,
    horas_totales: int,
    about: str,
    archivos: UploadFile,
    dato1: str,
    dato2: str,
    dato3: str,
    id_profesor_seleccionado: str,
    db: Session,
    current_user: dict,
    background_tasks: BackgroundTasks = None
):
    archivo_nombre = None
    archivo_data = None
    if archivos:
        archivo_nombre = archivos.filename
        archivo_data = await archivos.read()
    
    # Determina tipo de usuario y ajusta lógica
    user_type = current_user.get("type")
    if user_type == "academico":
        if not rut:  # Rut requerido para académicos
            raise HTTPException(status_code=400, detail="RUT requerido para académicos")
        rut_alumno = rut
        estado = 1
        id_profesor_insert = current_user.get("id_profesor", 1)  # De user o 1 temporal
        print(id_profesor_insert)
    elif user_type == "estudiante":
        rut_alumno = current_user.get("rut_alumno")  # De user, no form
        estado = 3
        if not rut_alumno:
            raise HTTPException(status_code=400, detail="No se encontró RUT del estudiante")
        id_profesor_insert = id_profesor_seleccionado  # Temporal, como dijiste
        print(id_profesor_insert)
    else:
        raise HTTPException(status_code=403, detail="Tipo de usuario no autorizado")

    # Validaciones comunes
    verificarDatos(db, rut_alumno, actividad)

    # Insertar registro
    nuevo = registro.insert().values(
        id_alumno = rut_alumno,
        id_profesor = id_profesor_insert,
        id_actividad = actividad,
        id_estado = estado,  # solucionado si es estudiante estado es 3 sino 1
        fecha_creacion = datetime.now(timezone.utc),
        fecha_inicio_actividad = fecha_inicio,
        fecha_termino_actividad = fecha_termino,
        horas_totales = horas_totales,
        comentario = about,
        archivo_nombre = archivo_nombre,
        archivo_data = archivo_data,
        dato1 = dato1,
        dato2 = dato2,
        dato3 = dato3
    )
    result = db.execute(nuevo)
    db.commit()

    inserted_id = result.inserted_primary_key[0] if result.inserted_primary_key else None
    esAcademico = True

    # Enviar correos en segundo plano para no bloquear la respuesta
    if user_type == "academico":
        if background_tasks:
            mailData = idForm(
                rut_alumno = rut_alumno,  # Usa rut_alumno (no rut) - funciona para estudiantes y profesores
                id_profesor = str(id_profesor_insert),  # Convierte a string según modelo idForm
                id_registro = inserted_id
            )

    elif user_type == "estudiante":
        stmt = (
            select(profesor.c.id_profesor)
            .select_from(
                profesor.join(
                    alumno,
                    profesor.c.id_instituto == alumno.c.id_carrera
                )
            )
            .where(
                profesor.c.id_rol == 2,
                alumno.c.rut_alumno == rut_alumno
            )
            .limit(1)
        )
        id_director = db.execute(stmt).scalar_one_or_none()
        if not id_director:
            raise HTTPException(status_code=404, detail="Director no encontrado para este alumno")

        if background_tasks:
            mailData = idForm(
                rut_alumno = rut_alumno,
                id_profesor = str(id_director),
                id_registro = inserted_id
            )
        esAcademico = False
    
    background_tasks.add_task(formularioMail, mailData, db, esAcademico)

    return {"message": "Formulario guardado exitosamente", "id": inserted_id, "horas_totales": horas_totales}

# Quita la antigua guardar_formulario - usa la genérica 