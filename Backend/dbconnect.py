from datetime import datetime, timezone
from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.sql import select

from Dbase.database import get_db
from Backend.models import alumnos, profesores, actividad, registro
#Para el link con react, inportar librerías, 

app = FastAPI()

class Registro():
    id_alumno: int
    verificador: str
    id_profesor: int
    id_actividad: int
    id_estado: int | None = None
    fecha_creacion: datetime | None = None
    fecha_emision: datetime | None = None
    evidencia: bytes | None = None
    comentario: str | None = None

def verificarDatos(db: Session, id_alumno: int, id_profesor: int, id_actividad: int):
    if not db.execute(select(alumnos).where(alumnos.c.id_alumno == id_alumno)).first():
        raise HTTPException(status_code=400, detail="Alumno no existe")
    if not db.execute(select(profesores).where(profesores.c.id_profesor == id_profesor)).first():
        raise HTTPException(status_code=400, detail="Profesor no existe")
    if not db.execute(select(actividad).where(actividad.c.id_actividad == id_actividad)).first():
        raise HTTPException(status_code=400, detail="Actividad no existe")

@app.post("/Backend formulario/", response_model=None)
async def guardar_formulario(data: Registro, db: Session = Depends(get_db)):
    #Ver si datos de id existen en la DB
    verificarDatos(db, data.id_alumno, data.id_profesor, data.id_actividad)

    #Insertar registro
    nuevo = registro.insert().values(
        id_alumno = data.id_alumno,
        verificador = data.verificador,
        id_profesor = data.id_profesor,
        id_actividad = data.id_actividad,
        id_estado = 1,
        fecha_creacion = datetime.now(timezone.utc),
        comentario = data.comentario
    )
    db.execute(nuevo)
    db.commit()

    return {"message": "Registro completado"}