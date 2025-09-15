from fastapi import UploadFile
from sqlalchemy.orm import Session
from core.models import formularios

async def guardar_formulario(
    nombres: str,
    apellidos: str,
    rut: str,
    email: str,
    academica: str,
    actividad: str,
    about: str,
    archivos: UploadFile,
    db: Session,
):
    archivo_nombre = None
    archivo_data = None
    if archivos:
        archivo_nombre = archivos.filename
        archivo_data = await archivos.read()
    insert_stmt = formularios.insert().values(
        nombres=nombres,
        apellidos=apellidos,
        rut=rut,
        email=email,
        academica=academica,
        actividad=actividad,
        about=about,
        archivo_nombre=archivo_nombre,
        archivo_data=archivo_data,
    )
    result = db.execute(insert_stmt)
    db.commit()
    inserted_id = result.inserted_primary_key[0] if result.inserted_primary_key else None
    return {"message": "Formulario guardado", "id": inserted_id}
