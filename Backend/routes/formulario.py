from fastapi import APIRouter, Form, File, UploadFile, Depends
from sqlalchemy.orm import Session
from services.formulario_service import guardar_formulario
from core.database import get_db
from core.auth import get_current_user
from datetime import datetime

router = APIRouter()


@router.post("/submit/")
async def submit_form(
    rut: str = Form(...),
    academica: str = Form(...),
    actividad: str = Form(...),
    fecha_inicio: str = Form(...),
    fecha_termino: str = Form(...),
    horas_totales: str = Form(...),
    about: str = Form(""),
    archivos: UploadFile = File(None),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    # Convertir fechas y validar datos
    print("Datos recibidos:", {
        "rut": rut,
        "academica": academica,
        "actividad": actividad,
        "fecha_inicio": fecha_inicio,
        "fecha_termino": fecha_termino,
        "horas_totales": horas_totales,
        "about": about,
        "archivos": archivos.filename if archivos else None
    })
    
    try:
        # Convertir strings a enteros
        academica_int = int(academica)
        actividad_int = int(actividad)
        horas_totales_int = int(horas_totales)
        
        # Validar que las horas totales sean positivas
        if horas_totales_int <= 0:
            from fastapi import HTTPException
            raise HTTPException(status_code=422, detail="Las horas totales deben ser un número positivo")
        
        # Convertir fechas de string a datetime
        fecha_inicio_dt = datetime.strptime(fecha_inicio, "%Y-%m-%d")
        fecha_termino_dt = datetime.strptime(fecha_termino, "%Y-%m-%d")
        
        # Validar que fecha_inicio sea anterior a fecha_termino
        if fecha_inicio_dt > fecha_termino_dt:
            from fastapi import HTTPException
            raise HTTPException(status_code=422, detail="La fecha de inicio debe ser anterior a la fecha de término")
            
    except ValueError as e:
        from fastapi import HTTPException
        if "time data" in str(e):
            raise HTTPException(status_code=422, detail="Formato de fecha inválido. Use YYYY-MM-DD")
        else:
            raise HTTPException(status_code=422, detail="Los campos numéricos deben contener valores válidos")
    
    return await guardar_formulario(
        rut, academica_int, actividad_int, fecha_inicio_dt, fecha_termino_dt, horas_totales_int, about, archivos, db, current_user["id_profesor"]
    )
