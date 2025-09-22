from fastapi import UploadFile
from datetime import datetime, timezone
from sqlalchemy.orm import Session
from fastapi import HTTPException
from sqlalchemy import func, select
from core.models import alumno, profesor, actividad, registro

def verificarDatos(db: Session, rut_alumno: str, id_profesor: int, id_actividad: int):
    if not db.execute(select(alumno).where(alumno.c.rut_alumno == rut_alumno)).first():
        raise HTTPException(status_code=400, detail="Alumno no existe")
    if not db.execute(select(profesor).where(profesor.c.id_profesor == id_profesor)).first():
        raise HTTPException(status_code=400, detail="Profesor no existe")
    if not db.execute(select(actividad).where(actividad.c.id_actividad == id_actividad)).first():
        raise HTTPException(status_code=400, detail="Actividad no existe")
    
def numeroRegistro(db: Session, id_registro: int):
    result = db.query(func.count(id_registro)).scalar()
    return result + 1

async def guardar_formulario(
    nombres: str,
    apellidos: str,
    rut: str,
    email: str,
    academica: int,
    actividad: int,
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
    #verificarDatos(db, rut, 1, actividad)

    #Insertar registro
    nuevo = registro.insert().values(
        id_alumno = rut,
        id_profesor = id_profesor,  # Usar el ID del profesor autenticado
        id_actividad = actividad,
        id_estado = 1,
        fecha_creacion = datetime.now(timezone.utc),
        comentario = about,
        archivo_nombre = archivo_nombre,
        archivo_data = archivo_data
    )
    result = db.execute(nuevo)
    db.commit()

    inserted_id = result.inserted_primary_key[0] if result.inserted_primary_key else None
    return {"message": "Formulario guardado", "id": inserted_id}
