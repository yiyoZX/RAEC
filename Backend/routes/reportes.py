from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from core.database import get_db
from core.auth import get_current_user
from services.reportes_service import (
    obtener_reporte_alumno,
    obtener_reporte_general,
    obtener_reporte_por_actividad   # <-- nombre correcto
)

router = APIRouter(prefix="/reportes", tags=["Reportes"])

@router.get("/alumno")
def reporte_por_alumno(
    rut: str = Query(..., description="RUT del alumno"),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    return obtener_reporte_alumno(db, rut)

@router.get("/actividad")
def reporte_por_actividad(
    actividad_id: int = Query(..., description="ID de la actividad (1-12)"),
    limite: int = Query(50, ge=1, le=500),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    return obtener_reporte_por_actividad(db, actividad_id, limite)

@router.get("/general")
def reporte_general(
    limite: int = Query(50, ge=1, le=500),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    return obtener_reporte_general(db, limite)