from fastapi import UploadFile
from datetime import datetime, timezone
from sqlalchemy.orm import Session
from fastapi import HTTPException
from sqlalchemy import func, select
from core.models import alumno, profesor, actividad, registro
from services.mailsend_service import idData, formularioMail

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
    academica: int,
    actividad: int,
    fecha_inicio: datetime,
    fecha_termino: datetime,
    horas_totales: int,
    about: str,
    archivos: UploadFile,
    db: Session,
    current_user: dict,
    rut: str = None  # Opcional - solo para académicos
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
        id_profesor = current_user.get("id_profesor", 1)  # De user o 1 temporal
    elif user_type == "estudiante":
        rut_alumno = current_user.get("rut_alumno")  # De user, no form
        estado = 3
        if not rut_alumno:
            raise HTTPException(status_code=400, detail="No se encontró RUT del estudiante")
        id_profesor = 1  # Temporal, como dijiste
    else:
        raise HTTPException(status_code=403, detail="Tipo de usuario no autorizado")

    # Validaciones comunes
    verificarDatos(db, rut_alumno, actividad)

    # Insertar registro
    nuevo = registro.insert().values(
        id_alumno = rut_alumno,
        id_profesor = id_profesor,
        id_actividad = actividad,
        id_estado = estado,  # solucionado si es estudiante estado es 3 sino 1
        fecha_creacion = datetime.now(timezone.utc),
        fecha_inicio_actividad = fecha_inicio,
        fecha_termino_actividad = fecha_termino,
        horas_totales = horas_totales,
        comentario = about,
        archivo_nombre = archivo_nombre,
        archivo_data = archivo_data
    )
    result = db.execute(nuevo)
    db.commit()

    inserted_id = result.inserted_primary_key[0] if result.inserted_primary_key else None

    mailData = idData(
        rut_alumno = rut_alumno,
        id_profesor = str(id_profesor),
        id_registro = inserted_id
    )
    await formularioMail(mailData, db)

    return {"message": "Formulario guardado exitosamente", "id": inserted_id, "horas_totales": horas_totales}

# Quita la antigua guardar_formulario - usa la genérica