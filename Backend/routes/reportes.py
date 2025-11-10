from fastapi import APIRouter, Depends, Query, HTTPException
from fastapi.responses import StreamingResponse
from sqlalchemy.orm import Session
from sqlalchemy import select, func
from core.database import get_db
from core.auth import get_current_user
from core.models import registro, actividad, carrera, alumno, profesor
from services.reportes_service import obtener_reporte  # Usa genérica de clase anterior
from services.exportador_csv import guardar_csv
from typing import List, Dict, Any, Optional
import os
import io

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
    if current_user.get("type") != "academico":  # Solo académicos
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
    if current_user.get("type") != "academico":  # Solo académicos
        raise HTTPException(status_code=403, detail="Acceso denegado")
    rows = obtener_reporte(db, actividad_id=actividad_id, limite=limite, current_user=current_user)  # Pasa current_user
    return _return_reporte(rows, f"reporte_actividad_{actividad_id}")

@router.get("/general")
def reporte_general(
    limite: int = Query(50, ge=1, le=500),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    if current_user.get("type") != "academico":  # Solo académicos
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

@router.get("/download/{id_registro}")
def descargar_archivo(
    id_registro: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Descargar archivo adjunto de un registro"""
    # Buscar el registro
    stmt = select(registro).where(registro.c.id_registro == id_registro)
    result = db.execute(stmt).first()
    
    if not result:
        raise HTTPException(status_code=404, detail="Registro no encontrado")
    
    # Verificar permisos: el usuario debe ser el dueño del registro o un académico
    user_type = current_user.get("type")
    if user_type == "estudiante":
        if result.id_alumno != current_user.get("rut_alumno"):
            raise HTTPException(status_code=403, detail="No tiene permiso para acceder a este archivo")
    elif user_type == "academico":
        # Los académicos pueden ver según su rol (profesor, director, admin)
        id_rol = current_user.get("id_rol")
        if id_rol == 1:  # Profesor - solo sus registros
            if result.id_profesor != current_user.get("id_profesor"):
                raise HTTPException(status_code=403, detail="No tiene permiso para acceder a este archivo")
        # id_rol 2 (director) y 3 (admin) pueden acceder a todos
    
    # Verificar que existe archivo
    if not result.archivo_data or not result.archivo_nombre:
        raise HTTPException(status_code=404, detail="Este registro no tiene archivo adjunto")
    
    # Retornar el archivo
    return StreamingResponse(
        io.BytesIO(result.archivo_data),
        media_type="application/octet-stream",
        headers={
            "Content-Disposition": f"attachment; filename={result.archivo_nombre}"
        }
    )

@router.get("/estadisticas/carreras")
def estadisticas_carreras(
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Obtener distribución de solicitudes por carrera"""
    if current_user.get("type") != "academico":
        raise HTTPException(status_code=403, detail="Acceso denegado")
    
    # Query base con filtros según rol
    query = (
        select(
            carrera.c.nombre_carrera,
            func.count(registro.c.id_registro).label("total")
        )
        .join(alumno, registro.c.id_alumno == alumno.c.rut_alumno)
        .join(carrera, alumno.c.id_carrera == carrera.c.id_carrera)
        .group_by(carrera.c.nombre_carrera)
        .order_by(func.count(registro.c.id_registro).desc())
    )
    
    # Aplicar filtros según rol del usuario
    id_rol = current_user.get("id_rol")
    if id_rol == 1:  # Profesor - solo sus registros
        query = query.where(registro.c.id_profesor == current_user.get("id_profesor"))
    elif id_rol == 2:  # Director - solo su instituto
        query = query.join(profesor, registro.c.id_profesor == profesor.c.id_profesor)
        query = query.where(profesor.c.id_instituto == current_user.get("id_instituto"))
    
    result = db.execute(query).all()
    
    return [
        {"nombre": row.nombre_carrera, "total": row.total}
        for row in result
    ]

@router.get("/estadisticas/actividades")
def estadisticas_actividades(
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Obtener distribución de solicitudes por actividad"""
    if current_user.get("type") != "academico":
        raise HTTPException(status_code=403, detail="Acceso denegado")
    
    # Query base con filtros según rol
    query = (
        select(
            actividad.c.nombre_actividad,
            func.count(registro.c.id_registro).label("total")
        )
        .join(actividad, registro.c.id_actividad == actividad.c.id_actividad)
        .group_by(actividad.c.nombre_actividad)
        .order_by(func.count(registro.c.id_registro).desc())
    )
    
    # Aplicar filtros según rol del usuario
    id_rol = current_user.get("id_rol")
    if id_rol == 1:  # Profesor - solo sus registros
        query = query.where(registro.c.id_profesor == current_user.get("id_profesor"))
    elif id_rol == 2:  # Director - solo su instituto
        query = query.join(profesor, registro.c.id_profesor == profesor.c.id_profesor)
        query = query.where(profesor.c.id_instituto == current_user.get("id_instituto"))
    
    result = db.execute(query).all()
    
    return [
        {"nombre": row.nombre_actividad, "total": row.total}
        for row in result
    ]

@router.get("/estadisticas/estados")
def estadisticas_estados(
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Obtener distribución de solicitudes por estado"""
    from core.models import estado as tabla_estado
    
    # Query base con filtros según rol y tipo de usuario
    query = (
        select(
            tabla_estado.c.nombre_estado,
            func.count(registro.c.id_registro).label("total")
        )
        .join(tabla_estado, registro.c.id_estado == tabla_estado.c.id_estado, isouter=True)
        .group_by(tabla_estado.c.nombre_estado)
    )
    
    # Aplicar filtros según tipo de usuario
    user_type = current_user.get("type")
    if user_type == "estudiante":
        query = query.where(registro.c.id_alumno == current_user.get("rut_alumno"))
    elif user_type == "academico":
        id_rol = current_user.get("id_rol")
        if id_rol == 1:  # Profesor
            query = query.where(registro.c.id_profesor == current_user.get("id_profesor"))
        elif id_rol == 2:  # Director
            query = query.join(profesor, registro.c.id_profesor == profesor.c.id_profesor)
            query = query.where(profesor.c.id_instituto == current_user.get("id_instituto"))
    
    result = db.execute(query).all()
    
    return [
        {"nombre": row.nombre_estado or "Pendiente", "total": row.total}
        for row in result
    ]