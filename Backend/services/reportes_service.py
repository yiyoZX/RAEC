from typing import List, Dict, Any, Optional
from sqlalchemy.orm import Session
from sqlalchemy import select, desc
from fastapi import HTTPException
from core.models import registro, actividad, alumno, profesor, carrera
from core.models import estado as tabla_estado

# IDs para clasificación de actividades
ACADEMIC_IDS = set(range(1, 7))
NON_ACADEMIC_IDS = set(range(7, 13))

def _serialize_row(row) -> Dict[str, Any]:
    """Convierte el resultado de la DB en un diccionario limpio para el JSON."""
    return {
        "rut": row.rut_alumno,
        "nombres": row.nombres,
        "apellidos": row.apellidos,
        "actividad": row.nombre_actividad,
        "fecha_creacion": row.fecha_creacion.isoformat() if row.fecha_creacion else None,
        "estado": row.nombre_estado if hasattr(row, 'nombre_estado') else None,
        "fecha_inicio_actividad": row.fecha_inicio_actividad.isoformat() if getattr(row, 'fecha_inicio_actividad', None) else None,
        "fecha_termino_actividad": row.fecha_termino_actividad.isoformat() if getattr(row, 'fecha_termino_actividad', None) else None,
        "horas_totales": getattr(row, 'horas_totales', None),
        "comentario": getattr(row, 'comentario', None),
        "profesor_nombres": getattr(row, 'profesor_nombres', None),
        "profesor_apellidos": getattr(row, 'profesor_apellidos', None),
        "carrera": getattr(row, 'nombre_carrera', None),
        "id_registro": getattr(row, 'id_registro', None),
        "archivo_nombre": getattr(row, 'archivo_nombre', None),
        "tiene_archivo": bool(getattr(row, 'archivo_nombre', None))
    }

def _actividad_existe(db: Session, actividad_id: int) -> bool:
    stmt = select(actividad.c.id_actividad).where(actividad.c.id_actividad == actividad_id)
    return db.execute(stmt).first() is not None

def obtener_reporte(
    db: Session,
    current_user: Optional[Dict[str, Any]] = None,
    rut: Optional[str] = None,
    actividad_id: Optional[int] = None,
    tipo_actividad: Optional[str] = None,
    fecha_inicio: Optional[str] = None,
    fecha_fin: Optional[str] = None,
    estado: Optional[str] = None,
    limite: int = 100
) -> List[Dict[str, Any]]:
    
    if actividad_id is not None and not _actividad_existe(db, actividad_id):
        raise HTTPException(status_code=404, detail="Actividad no encontrada")

    # 1. Query Base
    stmt = (
        select(
            registro.c.id_registro,
            registro.c.id_alumno.label("rut_alumno"),
            alumno.c.nombres,
            alumno.c.apellidos,
            actividad.c.id_actividad,
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
    )

    # 2. Filtros Dinámicos
    if rut:
        stmt = stmt.where(registro.c.id_alumno.ilike(f"%{rut}%"))

    if actividad_id:
        stmt = stmt.where(registro.c.id_actividad == actividad_id)

    if tipo_actividad:
        if tipo_actividad == 'academica':
            stmt = stmt.where(actividad.c.id_actividad.in_(ACADEMIC_IDS))
        elif tipo_actividad == 'no_academica':
            stmt = stmt.where(actividad.c.id_actividad.in_(NON_ACADEMIC_IDS))

    if fecha_inicio:
        stmt = stmt.where(registro.c.fecha_inicio_actividad >= fecha_inicio)
    
    if fecha_fin:
        stmt = stmt.where(registro.c.fecha_inicio_actividad <= fecha_fin)

    # 3. Lógica de Roles
    if current_user and current_user.get("type") == "estudiante":
        stmt = stmt.where(registro.c.id_alumno == current_user.get("rut_alumno"))
        
        if estado:
            mapa_estados = {'aprobadas': 1, 'rechazadas': 2, 'pendientes': 3}
            id_estado_filtro = int(estado) if str(estado).isdigit() else mapa_estados.get(estado.lower())
            if id_estado_filtro:
                stmt = stmt.where(registro.c.id_estado == id_estado_filtro)

    elif current_user and current_user.get("type") == "academico":
        id_rol = current_user.get("id_rol")
        
        if id_rol == 1:  # Profesor
            stmt = stmt.where(registro.c.id_profesor == current_user.get("id_profesor"))
        elif id_rol == 2:  # Director
            stmt = stmt.where(profesor.c.id_instituto == current_user.get("id_instituto"))

    # 4. Ejecución
    stmt = stmt.limit(limite)
    result = db.execute(stmt).mappings().all()
    
    return [_serialize_row(r) for r in result]