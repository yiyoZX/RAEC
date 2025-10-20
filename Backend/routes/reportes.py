from fastapi import APIRouter, Depends, Query, HTTPException
from sqlalchemy.orm import Session
from core.database import get_db
from core.auth import get_current_user
from services.reportes_service import obtener_reporte  # Usa genérica de clase anterior
from services.exportador_csv import guardar_csv
from typing import List, Dict, Any, Optional
import os

router = APIRouter(prefix="/reportes", tags=["Reportes"])

# Función común para retornar (factorización pequeña)
def _return_reporte(rows: List[Dict[str, Any]], filename_base: str):
    csv_path = guardar_csv(filename_base, rows)
    filename = os.path.basename(csv_path)
    return {
        "total": len(rows),
        "csv_file": csv_path,
        "csv_url": f"/exports/{filename}",
        "data": rows
    }

@router.get("/alumno")
def reporte_por_alumno(
    rut: str = Query(..., description="RUT del alumno"),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    if current_user.get("type") != "profesor":  # Solo académicos
        raise HTTPException(status_code=403, detail="Acceso denegado")
    rows = obtener_reporte(db, rut=rut, current_user=current_user)  # Pasa current_user
    return _return_reporte(rows, f"reporte_alumno_{rut}")

@router.get("/actividad")
def reporte_por_actividad(
    actividad_id: int = Query(..., description="ID de la actividad (1-12)"),
    limite: int = Query(50, ge=1, le=500),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    if current_user.get("type") != "profesor":  # Solo académicos
        raise HTTPException(status_code=403, detail="Acceso denegado")
    rows = obtener_reporte(db, actividad_id=actividad_id, limite=limite, current_user=current_user)  # Pasa current_user
    return _return_reporte(rows, f"reporte_actividad_{actividad_id}")

@router.get("/general")
def reporte_general(
    limite: int = Query(50, ge=1, le=500),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    if current_user.get("type") != "profesor":  # Solo académicos
        raise HTTPException(status_code=403, detail="Acceso denegado")
    rows = obtener_reporte(db, limite=limite, current_user=current_user)  # Pasa current_user
    return _return_reporte(rows, "reporte_general")

@router.get("/estudiante")
def reporte_estudiante(
    estado: Optional[str] = Query(None, description="Estado: aprobadas, rechazadas, pendientes"),
    limite: int = Query(50, ge=1, le=500),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    if current_user.get("type") != "estudiante":  # Solo estudiantes
        raise HTTPException(status_code=403, detail="Acceso denegado")
    estado_map = {'aprobadas': 1, 'rechazadas': 2, 'pendientes': 3}  # Asume IDs
    estado_id = estado_map.get(estado) if estado else None
    rows = obtener_reporte(db, current_user=current_user, estado=estado_id, limite=limite)
    return _return_reporte(rows, "reporte_estudiante")