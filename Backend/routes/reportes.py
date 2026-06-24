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
import csv
from datetime import datetime

router = APIRouter(prefix="/reportes", tags=["Reportes"])

def _return_reporte(rows: List[Dict[str, Any]], filename_base: str, page: int = 1, page_size: int = 50, total_records: int = None):
    csv_path = guardar_csv(filename_base, rows)
    filename = os.path.basename(csv_path)
    total = total_records if total_records is not None else len(rows)
    total_pages = (total + page_size - 1) // page_size  # Redondeo hacia arriba
    
    return {
        "total": total,
        "page": page,
        "page_size": page_size,
        "total_pages": total_pages,
        "csv_file": csv_path,
        "csv_url": f"/exports/{filename}",
        "csv_download_url": f"/reportes/descargar-csv/{filename_base}",
        "data": rows
    }

def _generate_csv_stream(rows: List[Dict[str, Any]]) -> io.StringIO:
    """Genera un CSV en memoria para streaming"""
    output = io.StringIO()
    if not rows:
        return output
    
    headers = list(rows[0].keys())
    writer = csv.DictWriter(output, fieldnames=headers, delimiter=';')
    writer.writeheader()
    for row in rows:
        writer.writerow(row)
    
    output.seek(0)
    return output

# --------------------------------------------------------------------------
# ENDPOINTS DE LISTADO (Utilizan el servicio refactorizado)
# --------------------------------------------------------------------------

@router.get("/general")
def reporte_general(
    rut: Optional[str] = Query(None),
    tipo_actividad: Optional[str] = Query(None),
    
    # ### CAMBIO 1: actividad_id ahora es str para recibir "1,2,3"
    actividad_id: Optional[str] = Query(None), 
    
    # ### CAMBIO 2: Agregamos los nuevos filtros que envía el Frontend
    carrera: Optional[str] = Query(None),
    profesor: Optional[str] = Query(None),
    fecha_creacion_inicio: Optional[str] = Query(None),
    fecha_creacion_termino :Optional[str] = Query(None),
    fecha_inicio: Optional[str] = Query(None),
    fecha_fin: Optional[str] = Query(None),
    horas: Optional[int] = Query(None),
    page: int = Query(1, ge=1),
    page_size: int = Query(50, ge=1, le=500),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    if current_user.get("type") != "academico":
        raise HTTPException(status_code=403, detail="Acceso denegado")
    
    # Primero contar total sin paginación
    total_records = obtener_reporte(
        db, 
        current_user=current_user, 
        rut=rut, 
        actividad_ids=actividad_id, 
        carrera_ids=carrera,        
        profesor_ids=profesor,      
        horas_min=horas,
        tipo_actividad=tipo_actividad, 
        fecha_creacion_inicio=fecha_creacion_inicio,
        fecha_creacion_termino=fecha_creacion_termino,
        fecha_inicio=fecha_inicio,
        fecha_fin=fecha_fin
    )
    total_count = len(total_records)
    
    # Luego obtener solo la página actual
    rows = obtener_reporte(
        db, 
        current_user=current_user, 
        rut=rut, 
        actividad_ids=actividad_id, 
        carrera_ids=carrera,        
        profesor_ids=profesor,      
        horas_min=horas,
        tipo_actividad=tipo_actividad, 
        fecha_creacion_inicio=fecha_creacion_inicio,
        fecha_creacion_termino=fecha_creacion_termino,
        fecha_inicio=fecha_inicio,
        fecha_fin=fecha_fin,
        page=page,
        page_size=page_size
    )
    
    return _return_reporte(rows, "reporte_general_filtrado", page, page_size, total_count)

@router.get("/estudiante")
def reporte_estudiante(
    estado: Optional[str] = Query(None),
    page: int = Query(1, ge=1),
    page_size: int = Query(50, ge=1, le=500),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    if current_user.get("type") != "estudiante":
        raise HTTPException(status_code=403, detail="Acceso denegado")
    
    # Contar total
    all_rows = obtener_reporte(db, current_user=current_user, estado=estado)
    total_records = len(all_rows)
    
    # Obtener página actual
    rows = obtener_reporte(db, current_user=current_user, estado=estado, page=page, page_size=page_size)
    
    return _return_reporte(rows, "reporte_estudiante", page, page_size, total_records)

# Mantenidos por compatibilidad
@router.get("/alumno")
def reporte_por_alumno(rut: str, db: Session = Depends(get_db), current_user: dict = Depends(get_current_user)):
    if current_user.get("type") != "academico": raise HTTPException(403, "Acceso denegado")
    return _return_reporte(obtener_reporte(db, rut=rut, current_user=current_user), f"reporte_alumno_{rut}")

@router.get("/actividad")
def reporte_por_actividad(actividad_id: int, db: Session = Depends(get_db), current_user: dict = Depends(get_current_user)):
    if current_user.get("type") != "academico": raise HTTPException(403, "Acceso denegado")
    return _return_reporte(obtener_reporte(db, actividad_id=actividad_id, current_user=current_user), f"reporte_actividad_{actividad_id}")

# --------------------------------------------------------------------------
# ENDPOINT OPTIMIZADO: DESCARGA CSV COMPLETO CON STREAMING
# --------------------------------------------------------------------------
@router.get("/descargar-csv/reporte_general_filtrado")
def descargar_csv_general(
    rut: Optional[str] = Query(None),
    tipo_actividad: Optional[str] = Query(None),
    actividad_id: Optional[str] = Query(None), 
    carrera: Optional[str] = Query(None),
    profesor: Optional[str] = Query(None),
    fecha_creacion_inicio: Optional[str] = Query(None),
    fecha_creacion_termino: Optional[str] = Query(None),
    fecha_inicio: Optional[str] = Query(None),
    fecha_fin: Optional[str] = Query(None),
    horas: Optional[int] = Query(None),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Descarga CSV completo con streaming para reportes de académicos"""
    if current_user.get("type") != "academico":
        raise HTTPException(status_code=403, detail="Acceso denegado")
    
    # Obtener TODOS los datos (sin paginación)
    all_rows = obtener_reporte(
        db, 
        current_user=current_user, 
        rut=rut,
        actividad_ids=actividad_id, 
        carrera_ids=carrera,        
        profesor_ids=profesor,      
        horas_min=horas,
        tipo_actividad=tipo_actividad, 
        fecha_creacion_inicio=fecha_creacion_inicio,
        fecha_creacion_termino=fecha_creacion_termino,
        fecha_inicio=fecha_inicio,
        fecha_fin=fecha_fin
    )
    
    # Generar CSV en memoria
    csv_content = _generate_csv_stream(all_rows)
    
    # Nombre del archivo con timestamp
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"reporte_general_{timestamp}.csv"
    
    # Retornar como streaming response
    return StreamingResponse(
        iter([csv_content.getvalue()]),
        media_type="text/csv",
        headers={
            "Content-Disposition": f"attachment; filename={filename}",
            "Cache-Control": "no-cache"
        }
    )

@router.get("/descargar-csv/reporte_estudiante")
def descargar_csv_estudiante(
    estado: Optional[str] = Query(None),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """Descarga CSV completo con streaming para reportes de estudiantes"""
    if current_user.get("type") != "estudiante":
        raise HTTPException(status_code=403, detail="Acceso denegado")
    
    # Obtener TODOS los datos (sin paginación)
    all_rows = obtener_reporte(db, current_user=current_user, estado=estado)
    
    # Generar CSV en memoria
    csv_content = _generate_csv_stream(all_rows)
    
    # Nombre del archivo con timestamp
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"reporte_estudiante_{timestamp}.csv"
    
    # Retornar como streaming response
    return StreamingResponse(
        iter([csv_content.getvalue()]),
        media_type="text/csv",
        headers={
            "Content-Disposition": f"attachment; filename={filename}",
            "Cache-Control": "no-cache"
        }
    )

# --------------------------------------------------------------------------
# ENDPOINT OPTIMIZADO: DESCARGA DE ARCHIVOS ADJUNTOS
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