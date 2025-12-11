from fastapi import APIRouter, Form, Depends, HTTPException
from datetime import datetime
from sqlalchemy.orm import Session
from core.auth import get_current_user
from core.database import get_db
from services.periodo_service import guardar_periodos, is_solicitudes_abiertas

router = APIRouter()

@router.post("/periodos")
async def configurar_periodo(
    regular_inicio: str = Form(None),
    regular_termino: str = Form(None),
    extra_inicio: str = Form(None),
    extra_termino: str = Form(None),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    # Validar que solo los administradores (id_rol = 3) puedan establecer periodos de registro
    if current_user["id_rol"] != 3:
        raise HTTPException(status_code=403, detail="Solo los directores pueden registrar actividades no académicas")
    
    # Convertir fechas str a datetime.date() para evitar problemas de zona horaria
    regular_inicio_dt = None
    regular_termino_dt = None
    if regular_inicio is not None and regular_termino is not None:
        try:
            regular_inicio_dt = datetime.strptime(regular_inicio, "%Y-%m-%d").date()
            regular_termino_dt = datetime.strptime(regular_termino, "%Y-%m-%d").date()
        except Exception:
            raise HTTPException(status_code=422, detail="Formato de fecha inválido para período regular. Use YYYY-MM-DD")

    extra_inicio_dt = None
    extra_termino_dt = None
    if extra_inicio is not None and extra_termino is not None:
        try:
            extra_inicio_dt = datetime.strptime(extra_inicio, "%Y-%m-%d").date()
            extra_termino_dt = datetime.strptime(extra_termino, "%Y-%m-%d").date()
        except Exception:
            raise HTTPException(status_code=422, detail="Formato de fecha inválido para período extra. Use YYYY-MM-DD")

    # Validar que las fechas de inicio sean anteriores a la de término
    if regular_inicio_dt is not None and regular_termino_dt is not None:
        if regular_inicio_dt > regular_termino_dt:
            raise HTTPException(status_code=422, detail="La fecha de inicio (regular) debe ser anterior a la fecha de término")

    if extra_inicio_dt is not None and extra_termino_dt is not None:
        if extra_inicio_dt > extra_termino_dt:
            raise HTTPException(status_code=422, detail="La fecha de inicio (extra) debe ser anterior a la fecha de término")

    return await guardar_periodos(
        db, current_user, regular_inicio_dt, regular_termino_dt, extra_inicio_dt, extra_termino_dt
    )


@router.get("/periodos/status/")
def periodo_status(db: Session = Depends(get_db)):
    try:
        abierto = is_solicitudes_abiertas(db)
        return {"open": bool(abierto)}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))