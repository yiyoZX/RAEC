from fastapi import APIRouter, Depends, Query, HTTPException
from fastapi.responses import StreamingResponse
from sqlalchemy.orm import Session
from sqlalchemy import select, func
from core.database import get_db
from core.auth import get_current_user
from core.models import registro, actividad, carrera, alumno, profesor, estado as tabla_estado
from services.reportes_service import obtener_reporte 
from services.exportador_csv import guardar_csv
from typing import List, Dict, Any, Optional
import os
import io

router = APIRouter(prefix="/reportes", tags=["Reportes"])

def _return_reporte(rows: List[Dict[str, Any]], filename_base: str):
    csv_path = guardar_csv(filename_base, rows)
    filename = os.path.basename(csv_path)
    return {
        "total": len(rows),
        "csv_file": csv_path,
        "csv_url": f"/exports/{filename}",
        "data": rows
    }

# --------------------------------------------------------------------------
# ENDPOINTS DE LISTADO (Utilizan el servicio refactorizado)
# --------------------------------------------------------------------------

@router.get("/general")
def reporte_general(
    rut: Optional[str] = Query(None),
    tipo_actividad: Optional[str] = Query(None),
    actividad_id: Optional[int] = Query(None),
    fecha_inicio: Optional[str] = Query(None),
    fecha_fin: Optional[str] = Query(None),
    limite: int = Query(50, ge=1, le=500),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    if current_user.get("type") != "academico":
        raise HTTPException(status_code=403, detail="Acceso denegado")
    
    rows = obtener_reporte(
        db, current_user=current_user, rut=rut, actividad_id=actividad_id,
        tipo_actividad=tipo_actividad, fecha_inicio=fecha_inicio,
        fecha_fin=fecha_fin, limite=limite
    )
    return _return_reporte(rows, "reporte_general_filtrado")

@router.get("/estudiante")
def reporte_estudiante(
    estado: Optional[str] = Query(None),
    limite: int = Query(50, ge=1, le=500),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    if current_user.get("type") != "estudiante":
        raise HTTPException(status_code=403, detail="Acceso denegado")
    
    rows = obtener_reporte(db, current_user=current_user, estado=estado, limite=limite)
    return _return_reporte(rows, "reporte_estudiante")

# Mantenidos por compatibilidad
@router.get("/alumno")
def reporte_por_alumno(rut: str, db: Session = Depends(get_db), current_user: dict = Depends(get_current_user)):
    if current_user.get("type") != "academico": raise HTTPException(403, "Acceso denegado")
    return _return_reporte(obtener_reporte(db, rut=rut, current_user=current_user), f"reporte_alumno_{rut}")

@router.get("/actividad")
def reporte_por_actividad(actividad_id: int, limite: int = 50, db: Session = Depends(get_db), current_user: dict = Depends(get_current_user)):
    if current_user.get("type") != "academico": raise HTTPException(403, "Acceso denegado")
    return _return_reporte(obtener_reporte(db, actividad_id=actividad_id, limite=limite, current_user=current_user), f"reporte_actividad_{actividad_id}")

# --------------------------------------------------------------------------
# ENDPOINT OPTIMIZADO: DESCARGA
# --------------------------------------------------------------------------
@router.get("/download/{id_registro}")
def descargar_archivo(
    id_registro: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """
    OPTIMIZACIÓN: Separamos la validación de la extracción del BLOB.
    Esto evita cargar el archivo en memoria si el usuario no tiene permiso,
    y hace la query más ligera al pedir columnas explícitas.
    """
    
    # PASO 1: Obtener solo metadatos para verificar existencia y permisos
    stmt_meta = select(
        registro.c.id_registro,
        registro.c.id_alumno,
        registro.c.id_profesor,
        registro.c.archivo_nombre
    ).where(registro.c.id_registro == id_registro)
    
    meta = db.execute(stmt_meta).first()
    
    if not meta:
        raise HTTPException(status_code=404, detail="Registro no encontrado")
    
    # Validar Permisos (Lógica ligera)
    user_type = current_user.get("type")
    if user_type == "estudiante":
        if meta.id_alumno != current_user.get("rut_alumno"):
            raise HTTPException(status_code=403, detail="Sin permiso")
    elif user_type == "academico":
        id_rol = current_user.get("id_rol")
        if id_rol == 1 and meta.id_profesor != current_user.get("id_profesor"):
            raise HTTPException(status_code=403, detail="Sin permiso")

    # Si llegamos aquí, tiene permiso. Verificamos nombre.
    if not meta.archivo_nombre:
        raise HTTPException(status_code=404, detail="El registro no tiene nombre de archivo")

    # PASO 2: Traer SOLO la data binaria (La operación pesada)
    stmt_data = select(registro.c.archivo_data).where(registro.c.id_registro == id_registro)
    row_data = db.execute(stmt_data).first()

    if not row_data or not row_data.archivo_data:
        raise HTTPException(status_code=404, detail="Archivo binario no encontrado o vacío")

    # Retornamos el stream
    return StreamingResponse(
        io.BytesIO(row_data.archivo_data),
        media_type="application/octet-stream",
        headers={
            "Content-Disposition": f"attachment; filename={meta.archivo_nombre}"
        }
    )

# --------------------------------------------------------------------------
# ESTADÍSTICAS (Ligeramente limpias)
# --------------------------------------------------------------------------
@router.get("/estadisticas/carreras")
def estadisticas_carreras(db: Session = Depends(get_db), current_user: dict = Depends(get_current_user)):
    if current_user.get("type") != "academico": raise HTTPException(403, "Acceso denegado")
    
    query = (
        select(carrera.c.nombre_carrera, func.count(registro.c.id_registro).label("total"))
        .join(alumno, registro.c.id_alumno == alumno.c.rut_alumno)
        .join(carrera, alumno.c.id_carrera == carrera.c.id_carrera)
        .group_by(carrera.c.nombre_carrera)
        .order_by(func.count(registro.c.id_registro).desc())
    )
    
    # Filtros de rol
    if current_user.get("id_rol") == 1:
        query = query.where(registro.c.id_profesor == current_user.get("id_profesor"))
    elif current_user.get("id_rol") == 2:
        query = query.join(profesor, registro.c.id_profesor == profesor.c.id_profesor)\
                     .where(profesor.c.id_instituto == current_user.get("id_instituto"))
    
    result = db.execute(query).all()
    return [{"nombre": row.nombre_carrera, "total": row.total} for row in result]

@router.get("/estadisticas/actividades")
def estadisticas_actividades(db: Session = Depends(get_db), current_user: dict = Depends(get_current_user)):
    if current_user.get("type") != "academico": raise HTTPException(403, "Acceso denegado")
    
    query = (
        select(actividad.c.nombre_actividad, func.count(registro.c.id_registro).label("total"))
        .join(actividad, registro.c.id_actividad == actividad.c.id_actividad)
        .group_by(actividad.c.nombre_actividad)
        .order_by(func.count(registro.c.id_registro).desc())
    )
    
    if current_user.get("id_rol") == 1:
        query = query.where(registro.c.id_profesor == current_user.get("id_profesor"))
    elif current_user.get("id_rol") == 2:
        query = query.join(profesor, registro.c.id_profesor == profesor.c.id_profesor)\
                     .where(profesor.c.id_instituto == current_user.get("id_instituto"))
                     
    result = db.execute(query).all()
    return [{"nombre": row.nombre_actividad, "total": row.total} for row in result]

@router.get("/estadisticas/estados")
def estadisticas_estados(db: Session = Depends(get_db), current_user: dict = Depends(get_current_user)):
    query = (
        select(tabla_estado.c.nombre_estado, func.count(registro.c.id_registro).label("total"))
        .join(tabla_estado, registro.c.id_estado == tabla_estado.c.id_estado, isouter=True)
        .group_by(tabla_estado.c.nombre_estado)
    )
    
    user_type = current_user.get("type")
    if user_type == "estudiante":
        query = query.where(registro.c.id_alumno == current_user.get("rut_alumno"))
    elif user_type == "academico":
        if current_user.get("id_rol") == 1:
            query = query.where(registro.c.id_profesor == current_user.get("id_profesor"))
        elif current_user.get("id_rol") == 2:
            query = query.join(profesor, registro.c.id_profesor == profesor.c.id_profesor)\
                         .where(profesor.c.id_instituto == current_user.get("id_instituto"))
    
    result = db.execute(query).all()
    return [{"nombre": row.nombre_estado or "Pendiente", "total": row.total} for row in result]