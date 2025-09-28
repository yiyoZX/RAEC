from typing import List, Dict, Any
from sqlalchemy.orm import Session
from sqlalchemy import select, desc
from core.models import registro  # Ya no importamos actividad ni alumno

def _serialize_row(row) -> Dict[str, Any]:
    return {
        "rut": row.rut_alumno,
        "actividad": None,  # Placeholder hasta que exista lógica real
        "fecha_creacion": row.fecha_creacion.isoformat() if row.fecha_creacion else None
    }

def obtener_reporte_alumno(db: Session, rut: str) -> List[Dict[str, Any]]:
    stmt = (
        select(
            registro.c.id_alumno.label("rut_alumno"),
            registro.c.fecha_creacion
        )
        .where(registro.c.id_alumno == rut)
        .order_by(desc(registro.c.fecha_creacion))
    )
    result = db.execute(stmt).mappings().all()
    return [_serialize_row(r) for r in result]

def obtener_reporte_general(db: Session, limite: int) -> List[Dict[str, Any]]:
    stmt = (
        select(
            registro.c.id_alumno.label("rut_alumno"),
            registro.c.fecha_creacion
        )
        .order_by(desc(registro.c.fecha_creacion))
        .limit(limite)
    )
    result = db.execute(stmt).mappings().all()
    return [_serialize_row(r) for r in result]

def obtener_reporte_actividad_equivalente(db: Session, limite: int) -> List[Dict[str, Any]]:
    # Mismo resultado que el general (placeholder)
    return obtener_reporte_general(db, limite)