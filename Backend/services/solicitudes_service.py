from sqlalchemy.orm import Session
from sqlalchemy import select, desc, update, func
from fastapi import HTTPException
from typing import Dict, Any
from core.models import registro, alumno, actividad, profesor
from core.models import registro, alumno, actividad
from services.mailsend_service import resupuestaSolicitudMail
import asyncio

def get_solicitudes_pendientes(db: Session, current_user: dict, page: int = 1, page_size: int = 20):
    print("Debug: Rol del user:", current_user.get("id_rol"))
    if current_user.get("id_rol") not in [2, 3, 4]:  # Directores (2), Administradores (3) y Super Admin (4)
        raise HTTPException(status_code=403, detail="Solo directores, administradores y super administradores")
    
    # Primero, contar el total de registros con COUNT (eficiente)
    count_stmt = (
        select(func.count())
        .select_from(registro)
        .join(alumno, registro.c.id_alumno == alumno.c.rut_alumno)
        .join(actividad, registro.c.id_actividad == actividad.c.id_actividad)
        .join(profesor, registro.c.id_profesor == profesor.c.id_profesor)
        .where(registro.c.id_estado == 3)  # Pendientes
    )
    total_records = db.execute(count_stmt).scalar()
    total_pages = (total_records + page_size - 1) // page_size
    
    # Luego, consultar solo la página actual con LIMIT y OFFSET
    stmt = (
        select(
            registro.c.id_registro,
            registro.c.id_alumno,
            registro.c.id_profesor,
            registro.c.id_actividad,
            registro.c.id_estado,
            registro.c.fecha_creacion,
            registro.c.fecha_emision,
            registro.c.archivo_nombre,
            registro.c.comentario,
            registro.c.fecha_inicio_actividad,
            registro.c.fecha_termino_actividad,
            registro.c.horas_totales,
            registro.c.dato1,
            registro.c.dato2,
            registro.c.dato3,
            alumno.c.nombres.label("alumno_nombres"),
            alumno.c.apellidos.label("alumno_apellidos"),
            actividad.c.nombre_actividad,
            profesor.c.nombres.label("nombres"),
            profesor.c.apellidos.label("apellidos")
        )
        .join(alumno, registro.c.id_alumno == alumno.c.rut_alumno)
        .join(actividad, registro.c.id_actividad == actividad.c.id_actividad)
        .join(profesor, registro.c.id_profesor == profesor.c.id_profesor)
        .where(registro.c.id_estado == 3)  # Pendientes
        .order_by(desc(registro.c.fecha_creacion))
        .limit(page_size)
        .offset((page - 1) * page_size)
    )
    
    paginated_results = db.execute(stmt).mappings().all()
    
    return {
        "total": total_records,
        "page": page,
        "page_size": page_size,
        "total_pages": total_pages,
        "data": [dict(r) for r in paginated_results]
    }

# Función para update estado
async def update_solicitud_estado(db: Session, id_registro: int, nuevo_estado: int, current_user: Dict[str, Any]):
    if current_user.get("id_rol") not in [2, 3, 4]:  # Directores (2), Administradores (3) y Super Admin (4)
        raise HTTPException(status_code=403, detail="Solo directores, administradores y super administradores")

    stmt = update(registro).where(registro.c.id_registro == id_registro).values(id_estado=nuevo_estado)
    result = db.execute(stmt)
    db.commit()
    
    if result.rowcount == 0:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")
    
    # Envía correo en segundo plano sin bloquear la respuesta
    asyncio.create_task(resupuestaSolicitudMail(
        rut_alumno=db.execute(select(registro.c.id_alumno).where(registro.c.id_registro == id_registro)).scalar(),
        id_registro=id_registro,
        respuesta = nuevo_estado,
        db=db
    ))

    return {"message": "Solicitud actualizada"}