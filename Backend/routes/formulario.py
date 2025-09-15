from fastapi import APIRouter, Form, File, UploadFile, Depends
from sqlalchemy.orm import Session
from services.formulario_service import guardar_formulario
from core.database import get_db

router = APIRouter()

@router.post("/submit/")
async def submit_form(
    nombres: str = Form(...),
    apellidos: str = Form(...),
    rut: str = Form(...),
    email: str = Form(...),
    academica: str = Form(...),
    actividad: str = Form(...),
    about: str = Form(""),
    archivos: UploadFile = File(None),
    db: Session = Depends(get_db),
):
    return await guardar_formulario(
        nombres, apellidos, rut, email, academica, actividad, about, archivos, db
    )
