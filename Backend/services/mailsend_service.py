from fastapi_mail import FastMail, MessageSchema, MessageType
from zoneinfo import ZoneInfo
from datetime import datetime
from pydantic import BaseModel, EmailStr
from sqlalchemy import select
from sqlalchemy.orm import Session
from core.mail_config import conf
from core.models import alumno, profesor

from dotenv import load_dotenv
import os

load_dotenv(dotenv_path=".env")

class Destinatario(BaseModel):
    email: EmailStr
    nombre: str

#Modelo de datos que se requieren para envío de datos
class idData(BaseModel):
    rut_alumno : str
    id_profesor: str
    id_registro: int

#Sacar datos de la base de datos según IDs para añadir a una lista de destinatarios
def extraerDatos(rut_alumno: str, id_profesor: int, db: Session):
    queryAlumno = select(alumno.c.nombres, alumno.c.correo).where(alumno.c.rut_alumno == rut_alumno)
    queryProf = select(profesor.c.nombres, profesor.c.correo).where(profesor.c.id_profesor == id_profesor)
    #Crea queries para buscar nombres según ID en la base de datos y los asigna a variables
    result_alumno = db.execute(queryAlumno).first()
    result_prof = db.execute(queryProf).first()

    lista_datos = []
    if result_alumno:
        lista_datos.append(Destinatario(email = result_alumno.correo, nombre = result_alumno.nombres))
    if result_prof:
        lista_datos.append(Destinatario(email = result_prof.correo, nombre = result_prof.nombres))  

    return lista_datos

#Envío de correos sobre registros de formularios creados
async def formularioMail(data: idData, db :Session):
    lista_datos = extraerDatos(data.rut_alumno, data.id_profesor, db) #Busca nombres en base a IDs
    fm = FastMail(conf) #Asigna datos del correo automático para los envíos

    for d in lista_datos:
        message = MessageSchema(
            subject = "Notificación de Registro",
            recipients = [d.email],
            template_body = {
                "nombre": d.nombre,
                "id_registro": data.id_registro,
                "fecha": datetime.now(ZoneInfo("America/Santiago")).strftime("%d/%m/%Y %H:%M:%S")
            },
            subtype=  MessageType.html
        )
        await fm.send_message(message, template_name=os.getenv("TEMPLATE_DIR")) #Mensaje individual por destinatario, mismo template
    return
