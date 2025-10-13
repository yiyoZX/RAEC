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

async def guardar_formulario(
    rut: str,
    academica: int,
    actividad: int,
    fecha_inicio: datetime,
    fecha_termino: datetime,
    horas_totales: int,
    about: str,
    archivos: UploadFile,
    db: Session,
    id_profesor: int
):
    archivo_nombre = None
    archivo_data = None
    if archivos:
        archivo_nombre = archivos.filename
        archivo_data = await archivos.read()
    
    # Verificar datos (opcional, descomentado para validaciones)
    # verificarDatos(db, rut, id_profesor, actividad)

    # Insertar registro con los nuevos campos
    verificarDatos(db, rut, actividad)
    nuevo = registro.insert().values(
        id_alumno = rut,
        id_profesor = id_profesor,  # Usar el ID del profesor autenticado
        id_actividad = actividad,
        id_estado = 1,
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
        rut_alumno = rut,
        id_profesor = id_profesor,
        id_registro = inserted_id
    )
    await formularioMail(mailData, db)

    return {"message": "Formulario guardado exitosamente", "id": inserted_id, "horas_totales": horas_totales}
