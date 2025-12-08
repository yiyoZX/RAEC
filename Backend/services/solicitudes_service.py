from sqlalchemy.orm import Session
from sqlalchemy import select, desc, update
from fastapi import HTTPException
from typing import Dict, Any
from core.models import registro, alumno, actividad

def get_solicitudes_pendientes(db: Session, current_user: dict, page: int = 1, page_size: int = 20):
    print("Debug: Rol del user:", current_user.get("id_rol"))
    if current_user.get("id_rol") not in [2, 3]:  # Directores (2) y Administradores (3)
        raise HTTPException(status_code=403, detail="Solo directores y administradores")
    
    # Obtener todas las solicitudes primero para contar el total
    stmt = (
        select(
            registro,
            alumno.c.nombres.label("alumno_nombres"),
            alumno.c.apellidos.label("alumno_apellidos"),
            actividad.c.nombre_actividad
        )
        .join(alumno, registro.c.id_alumno == alumno.c.rut_alumno)
        .join(actividad, registro.c.id_actividad == actividad.c.id_actividad)
        .where(registro.c.id_estado == 3)  # Pendientes
        .order_by(desc(registro.c.fecha_creacion))
    )
    
    all_results = db.execute(stmt).mappings().all()
    total_records = len(all_results)
    total_pages = (total_records + page_size - 1) // page_size
    
    # Aplicar paginación
    start_idx = (page - 1) * page_size
    end_idx = start_idx + page_size
    paginated_results = all_results[start_idx:end_idx]
    
    return {
        "total": total_records,
        "page": page,
        "page_size": page_size,
        "total_pages": total_pages,
        "data": [dict(r) for r in paginated_results]
    }

# Función para update estado
def update_solicitud_estado(db: Session, id_registro: int, nuevo_estado: int, current_user: Dict[str, Any]):
    if current_user.get("id_rol") not in [2, 3]:  # Directores (2) y Administradores (3)
        raise HTTPException(status_code=403, detail="Solo directores y administradores")

    stmt = update(registro).where(registro.c.id_registro == id_registro).values(id_estado=nuevo_estado)
    result = db.execute(stmt)
    db.commit()
    
    if result.rowcount == 0:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")
    
    return {"message": "Solicitud actualizada"}