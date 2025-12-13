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

class idForm(BaseModel):
    rut_alumno: str
    id_profesor: str
    id_registro: int

class idMailing(BaseModel):
    regular_inicio: datetime = None
    regular_fin: datetime = None
    extra_inicio: datetime = None
    extra_fin: datetime = None
    estado: int = None

def extraerDatos(rut_alumno: str, id_profesor: str, db: Session):
    queryAlumno = select(alumno.c.nombres, alumno.c.correo).where(alumno.c.rut_alumno == rut_alumno)
    queryProf = select(profesor.c.nombres, profesor.c.correo).where(profesor.c.id_profesor == id_profesor)
    # Crea queries para buscar nombres según ID en la base de datos y los asigna a variables
    result_alumno = db.execute(queryAlumno).first()
    result_prof = db.execute(queryProf).first()

    lista_datos = []
    if result_alumno:
        lista_datos.append(Destinatario(email=result_alumno.correo, nombre=result_alumno.nombres))
    if result_prof:
        lista_datos.append(Destinatario(email=result_prof.correo, nombre=result_prof.nombres))  

    return lista_datos

#Busca todos los estudiantes en la base de datos
def getEstudiantes(db: Session):
    query = select(alumno.c.correo)
    result = db.execute(query).scalars().all()
    return result

#Envío de correos sobre registros de formularios creados
async def formularioMail(data: idForm, db: Session, esAcademico: bool):
    lista_datos = extraerDatos(data.rut_alumno, data.id_profesor, db)  # Busca nombres en base a IDs
    fm = FastMail(conf)  # Asigna datos del correo automático para los envíos

    if esAcademico:
        env_key = "FORM_DIR"
        sub = "RAEC: Registro de Formulario de Actividad"
    else:
        env_key = "REQ_DIR"
        sub = "RAEC: Solicitud de Registro de Actividad"

    template_name = os.getenv(env_key)

    for d in lista_datos:
        message = MessageSchema(
            subject=sub,
            recipients=[d.email],
            template_body={
                "nombre": d.nombre,
                "id_registro": data.id_registro,
                **({"rut_alumno": data.rut_alumno} if not esAcademico else {}),
                "fecha": datetime.now(ZoneInfo("America/Santiago")).strftime("%d/%m/%Y %H:%M:%S")
            },
            subtype=MessageType.html
        )

        await fm.send_message(message, template_name=template_name)  # Mensaje individual por destinatario, mismo template
    return

#Correo para notificar cambios en periodos de inscripción
async def periodoMail(data: idMailing, db: Session):
    fm = FastMail(conf)
    env_key = "PERIODO_DIR"
    template_name = os.getenv(env_key)

    correo_estudiantes = getEstudiantes(db)
    
    periodo_type = data.estado
    # Determina qué tipo de período está
    has_regular = getattr(data, 'regular_inicio', None) is not None or getattr(data, 'regular_fin', None) is not None
    has_extra = getattr(data, 'extra_inicio', None) is not None or getattr(data, 'extra_fin', None) is not None
    if periodo_type is None:
        if has_regular and has_extra:
            periodo_type = 3
        elif has_regular:
            periodo_type = 1
        elif has_extra:
            periodo_type = 2

    #Formatea fechas para el mensaje
    def formato(d):
        if d is None:
            return None
        try:
            return d.strftime('%d/%m/%Y')
        except Exception:
            return str(d)

    template_body = {
        'periodo_type': periodo_type
    }
    if has_regular:
        if getattr(data, 'regular_inicio', None) is not None:
            template_body['regular_inicio'] = formato(data.regular_inicio)
        if getattr(data, 'regular_fin', None) is not None:
            template_body['regular_fin'] = formato(data.regular_fin)
    if has_extra:
        if getattr(data, 'extra_inicio', None) is not None:
            template_body['extra_inicio'] = formato(data.extra_inicio)
        if getattr(data, 'extra_fin', None) is not None:
            template_body['extra_fin'] = formato(data.extra_fin)

    message = MessageSchema(
        subject="RAEC: Nuevos Periodos de Inscripción",
        recipients=correo_estudiantes,
        template_body=template_body,
        subtype=MessageType.html
    )
    await fm.send_message(message, template_name=template_name)
    return

async def resupuestaSolicitudMail(
    rut_alumno: str,
    id_registro: int,
    respuesta: int,
    db: Session
):
    fm = FastMail(conf)
    env_key = "RESPUESTA_DIR"
    template_name = os.getenv(env_key)

    query = select(alumno.c.nombres, alumno.c.correo).where(alumno.c.rut_alumno == rut_alumno)
    result = db.execute(query).first()

    message = MessageSchema(
        subject="RAEC: Actualización de registro",
        recipients=[result.correo],
        template_body={
            "nombre": result.nombres,
            "id_registro": id_registro,
            "respuesta": respuesta
        },
        subtype=MessageType.html
    )

    await fm.send_message(message, template_name=template_name)
    return