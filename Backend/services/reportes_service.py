from typing import List, Dict, Any, Optional
from sqlalchemy.orm import Session
from sqlalchemy import select, desc
from fastapi import HTTPException
from core.models import registro, actividad, alumno

# Rangos sólo para clasificar si necesitas (no se usa en la query)
ACADEMIC_IDS = set(range(1, 7))       # 1..6
NON_ACADEMIC_IDS = set(range(7, 13))  # 7..12

def _serialize_row(row) -> Dict[str, Any]:
    return {
        "rut": row.rut_alumno,
        "nombres": row.nombres,
        "apellidos": row.apellidos,
        "actividad": row.nombre_actividad,
        "fecha_creacion": row.fecha_creacion.isoformat() if row.fecha_creacion else None
    }

def _actividad_existe(db: Session, actividad_id: int) -> bool:
    stmt = select(actividad.c.id_actividad).where(actividad.c.id_actividad == actividad_id)
    return db.execute(stmt).first() is not None

# Función genérica factorizada (nueva - maneja todos los tipos de reportes)
def obtener_reporte(
    db: Session,
    current_user: Optional[Dict[str, Any]] = None,  # Para filtrar por user en estudiantes
    rut: Optional[str] = None,  # Para reporte por alumno
    actividad_id: Optional[int] = None,  # Para reporte por actividad
    estado: Optional[int] = None,  # Para estudiantes: 1=aprobadas, 2=rechazadas, 3=pendientes
    limite: int = 10  # Default 10
) -> List[Dict[str, Any]]:
    # Validaciones básicas
    if actividad_id is not None:
        if not _actividad_existe(db, actividad_id):
            raise HTTPException(status_code=404, detail="Actividad no encontrada")
    
    # Query base común - joins a alumno y actividad
    stmt = (
        select(
            registro.c.id_alumno.label("rut_alumno"),
            alumno.c.nombres,
            alumno.c.apellidos,
            actividad.c.nombre_actividad,
            registro.c.fecha_creacion
        )
        .join(alumno, registro.c.id_alumno == alumno.c.rut_alumno, isouter=True)
        .join(actividad, registro.c.id_actividad == actividad.c.id_actividad, isouter=True)
        .order_by(desc(registro.c.fecha_creacion))
        .limit(limite)
    )

    # Agrega filtros basados en params (factorización - uno por filtro)
    if rut is not None:  # Reporte por alumno
        stmt = stmt.where(registro.c.id_alumno == rut)
    if actividad_id is not None:  # Por actividad
        stmt = stmt.where(registro.c.id_actividad == actividad_id)
    if estado is not None:  # Para estudiantes por estado
        if current_user and current_user.get("type") == "estudiante":
            stmt = stmt.where(registro.c.id_estado == estado, registro.c.id_alumno == current_user.get("rut_alumno"))
        else:
            raise HTTPException(status_code=403, detail="Permiso denegado para este filtro")
    if current_user and current_user.get("type") == "estudiante" and estado is None:  # General para estudiantes - solo suyos
        stmt = stmt.where(registro.c.id_alumno == current_user.get("rut_alumno"))

    # Ejecuta y serializa (común)
    result = db.execute(stmt).mappings().all()
    return [_serialize_row(r) for r in result]
