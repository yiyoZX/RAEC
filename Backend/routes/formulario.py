from fastapi import APIRouter, Form, File, UploadFile, Depends
from sqlalchemy.orm import Session
from services.formulario_service import guardar_formulario
from core.database import get_db
from core.auth import get_current_user

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
    current_user: dict = Depends(get_current_user)
):
    # Convertir a int antes de pasar al servicio
    print("Datos recibidos:", {
        "nombres": nombres,
        "apellidos": apellidos,
        "rut": rut,
        "email": email,
        "academica": academica,
        "actividad": actividad,
        "about": about,
        "archivos": archivos.filename if archivos else None
    })
    print("Tipos de datos:", {
        "nombres": type(nombres),
        "apellidos": type(apellidos),
        "rut": type(rut),
        "email": type(email),
        "academica": type(academica),
        "actividad": type(actividad),
        "about": type(about)
    })
    try:
        academica_int = int(academica)
        actividad_int = int(actividad)
    except ValueError:
        from fastapi import HTTPException
        raise HTTPException(status_code=422, detail="academica y actividad deben ser números")
    return await guardar_formulario(
        nombres, apellidos, rut, email, academica_int, actividad_int, about, archivos, db, current_user["id_profesor"]
    )
