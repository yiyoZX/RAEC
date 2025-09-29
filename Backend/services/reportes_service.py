# ...existing code...
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

def obtener_reporte_alumno(db: Session, rut: str) -> List[Dict[str, Any]]:
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
        .where(registro.c.id_alumno == rut)
        .order_by(desc(registro.c.fecha_creacion))
    )
    result = db.execute(stmt).mappings().all()
    return [_serialize_row(r) for r in result]

def obtener_reporte_general(db: Session, limite: int) -> List[Dict[str, Any]]:
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
    result = db.execute(stmt).mappings().all()
    return [_serialize_row(r) for r in result]

def obtener_reporte_por_actividad(db: Session, actividad_id: Optional[int], limite: int) -> List[Dict[str, Any]]:
    if actividad_id is None:
        raise HTTPException(status_code=422, detail="actividad_id es obligatorio")
    try:
        actividad_id = int(actividad_id)
    except ValueError:
        raise HTTPException(status_code=422, detail="actividad_id debe ser entero")
    if not _actividad_existe(db, actividad_id):
        raise HTTPException(status_code=404, detail="Actividad no encontrada")

    stmt = (
        select(
            registro.c.id_alumno.label("rut_alumno"),
            alumno.c.nombres,
            alumno.c.apellidos,
            actividad.c.nombre_actividad,
            registro.c.fecha_creacion
        )
        .join(alumno, registro.c.id_alumno == alumno.c.rut_alumno, isouter=True)
        .join(actividad, registro.c.id_actividad == actividad.c.id_actividad)
        .where(registro.c.id_actividad == actividad_id)
        .order_by(desc(registro.c.fecha_creacion))
        .limit(limite)
    )
    result = db.execute(stmt).mappings().all()
    return [_serialize_row(r) for r in result]
# ...existing code...