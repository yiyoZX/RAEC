from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from core.database import get_db
from core.auth import get_current_user
from services.reportes_service import (
    obtener_reporte_alumno,
    obtener_reporte_general,
    obtener_reporte_por_actividad
)
from services.exportador_csv import guardar_csv
import os

router = APIRouter(prefix="/reportes", tags=["Reportes"])

@router.get("/alumno")
def reporte_por_alumno(
    rut: str = Query(..., description="RUT del alumno"),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    rows = obtener_reporte_alumno(db, rut)
    csv_path = guardar_csv(f"reporte_alumno_{rut}", rows)
    filename = os.path.basename(csv_path)
    return {
        "total": len(rows),
        "csv_file": csv_path,
        "csv_url": f"/exports/{filename}",
        "data": rows
    }

@router.get("/actividad")
def reporte_por_actividad(
    actividad_id: int = Query(..., description="ID de la actividad (1-12)"),
    limite: int = Query(50, ge=1, le=500),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    rows = obtener_reporte_por_actividad(db, actividad_id, limite)
    csv_path = guardar_csv(f"reporte_actividad_{actividad_id}", rows)
    filename = os.path.basename(csv_path)
    return {
        "total": len(rows),
        "csv_file": csv_path,
        "csv_url": f"/exports/{filename}",
        "data": rows
    }

@router.get("/general")
def reporte_general(
    limite: int = Query(50, ge=1, le=500),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    rows = obtener_reporte_general(db, limite)
    csv_path = guardar_csv("reporte_general", rows)
    filename = os.path.basename(csv_path)
    return {
        "total": len(rows),
        "csv_file": csv_path,
        "csv_url": f"/exports/{filename}",
        "data": rows
    }