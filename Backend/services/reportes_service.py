from typing import List, Dict, Any, Optional
from sqlalchemy.orm import Session
from sqlalchemy import select, desc, and_, or_
from fastapi import HTTPException
from core.models import registro, actividad, alumno, profesor, carrera, instituto_carrera
from core.models import estado as tabla_estado
import re

# Rangos sólo para clasificar si necesitas (no se usa en la query)
ACADEMIC_IDS = set(range(1, 7))       # 1..6
NON_ACADEMIC_IDS = set(range(7, 13))  # 7..12

def _serialize_row(row) -> Dict[str, Any]:
    return {
        "rut": row.rut_alumno,
        "nombres": row.nombres,
        "apellidos": row.apellidos,
        "actividad": row.nombre_actividad,
        "fecha_creacion": row.fecha_creacion.isoformat() if row.fecha_creacion else None,
        "estado": row.nombre_estado if hasattr(row, 'nombre_estado') else None,
        "fecha_inicio_actividad": row.fecha_inicio_actividad.isoformat() if hasattr(row, 'fecha_inicio_actividad') and row.fecha_inicio_actividad else None,
        "fecha_termino_actividad": row.fecha_termino_actividad.isoformat() if hasattr(row, 'fecha_termino_actividad') and row.fecha_termino_actividad else None,
        "horas_totales": row.horas_totales if hasattr(row, 'horas_totales') else None,
        "comentario": row.comentario if hasattr(row, 'comentario') else None,
        "profesor_nombres": row.profesor_nombres if hasattr(row, 'profesor_nombres') else None,
        "profesor_apellidos": row.profesor_apellidos if hasattr(row, 'profesor_apellidos') else None,
        "carrera": row.nombre_carrera if hasattr(row, 'nombre_carrera') else None,
        "id_registro": row.id_registro if hasattr(row, 'id_registro') else None,
        "archivo_nombre": row.archivo_nombre if hasattr(row, 'archivo_nombre') else None,
        "tiene_archivo": bool(row.archivo_nombre) if hasattr(row, 'archivo_nombre') else False
    }

def _actividad_existe(db: Session, actividad_id: int) -> bool:
    stmt = select(actividad.c.id_actividad).where(actividad.c.id_actividad == actividad_id)
    return db.execute(stmt).first() is not None

# Función genérica factorizada (nueva - maneja todos los tipos de reportes)
def obtener_reporte(
    db: Session,
    current_user: Optional[Dict[str, Any]] = None,  # Para filtrar por user en estudiantes/profesores
    rut: Optional[str] = None,  # Para reporte por alumno
    actividad_id: Optional[int] = None,  # Para reporte por actividad
    estado: Optional[int] = None,  # Para estudiantes: 1=aprobadas, 2=rechazadas, 3=pendientes
    limite: int = 10  # Default 10
) -> List[Dict[str, Any]]:
    # Validaciones básicas
    if actividad_id is not None:
        if not _actividad_existe(db, actividad_id):
            raise HTTPException(status_code=404, detail="Actividad no encontrada")
    
    # Query base común - joins a alumno, actividad, estado, profesor y carrera
    stmt = (
        select(
            registro.c.id_registro,
            registro.c.id_alumno.label("rut_alumno"),
            alumno.c.nombres,
            alumno.c.apellidos,
            actividad.c.nombre_actividad,
            registro.c.fecha_creacion,
            registro.c.fecha_inicio_actividad,
            registro.c.fecha_termino_actividad,
            registro.c.horas_totales,
            registro.c.comentario,
            registro.c.archivo_nombre,
            tabla_estado.c.nombre_estado,
            profesor.c.nombres.label("profesor_nombres"),
            profesor.c.apellidos.label("profesor_apellidos"),
            carrera.c.nombre_carrera
        )
        .join(alumno, registro.c.id_alumno == alumno.c.rut_alumno, isouter=True)
        .join(actividad, registro.c.id_actividad == actividad.c.id_actividad, isouter=True)
        .join(tabla_estado, registro.c.id_estado == tabla_estado.c.id_estado, isouter=True)
        .join(profesor, registro.c.id_profesor == profesor.c.id_profesor, isouter=True)
        .join(carrera, alumno.c.id_carrera == carrera.c.id_carrera, isouter=True)
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
    
    # Filtros para profesores y directores
    if current_user and current_user.get("type") == "academico":
        id_rol = current_user.get("id_rol")
        id_profesor = current_user.get("id_profesor")
        id_instituto = current_user.get("id_instituto")
        
        if id_rol == 1:  # Rol profesor - solo sus registros
            stmt = stmt.where(registro.c.id_profesor == id_profesor)
        elif id_rol == 2:  # Rol director - todos los registros de su instituto
            # Ya tenemos el join con profesor, solo agregamos el filtro
            stmt = stmt.where(profesor.c.id_instituto == id_instituto)
        # id_rol == 3 (admin) no necesita filtro adicional - ve todo

    # Ejecuta y serializa (común)
    result = db.execute(stmt).mappings().all()
    return [_serialize_row(r) for r in result]
