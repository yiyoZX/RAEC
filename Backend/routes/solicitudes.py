from fastapi import APIRouter, Body, Depends, HTTPException, Query
from fastapi.responses import StreamingResponse
from sqlalchemy.orm import Session
from sqlalchemy import select
from core.database import get_db
from core.auth import get_current_user
from core.models import registro
from services.solicitudes_service import get_solicitudes_pendientes, update_solicitud_estado
import io

router = APIRouter(prefix="/solicitudes", tags=["Solicitudes"])

@router.get("/pendientes")
async def get_pendientes(
    page: int = Query(1, ge=1),
    page_size: int = Query(20, ge=1, le=100),
    db: Session = Depends(get_db), 
    current_user: dict = Depends(get_current_user)
):
    return get_solicitudes_pendientes(db, current_user, page, page_size)

@router.post("/{id_registro}/update")
async def update_estado(
    id_registro: int,
    body: dict = Body(...),  # { "id_estado": 1 or 2 }
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    nuevo_estado = body.get("id_estado")
    if nuevo_estado not in [1, 2]:
        raise HTTPException(status_code=400, detail="Estado inválido")
    return await update_solicitud_estado(db, id_registro, nuevo_estado, current_user)

@router.get("/download/{id_registro}")
def descargar_archivo_solicitud(
    id_registro: int,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """
    Descarga el archivo adjunto de una solicitud.
    Solo directores, administradores y super administradores pueden descargar.
    """
    # Verificar permisos
    if current_user.get("id_rol") not in [2, 3, 4]:
        raise HTTPException(status_code=403, detail="Solo directores, administradores y super administradores")
    
    # Obtener metadatos del registro
    stmt_meta = select(
        registro.c.id_registro,
        registro.c.archivo_nombre
    ).where(registro.c.id_registro == id_registro)
    
    meta = db.execute(stmt_meta).first()
    
    if not meta:
        raise HTTPException(status_code=404, detail="Solicitud no encontrada")
    
    if not meta.archivo_nombre:
        raise HTTPException(status_code=404, detail="La solicitud no tiene archivo adjunto")
    
    # Obtener el archivo binario
    stmt_data = select(registro.c.archivo_data).where(registro.c.id_registro == id_registro)
    row_data = db.execute(stmt_data).first()
    
    if not row_data or not row_data.archivo_data:
        raise HTTPException(status_code=404, detail="Archivo no encontrado o vacío")
    
    # Retornar el archivo
    return StreamingResponse(
        io.BytesIO(row_data.archivo_data),
        media_type="application/octet-stream",
        headers={
            "Content-Disposition": f"attachment; filename={meta.archivo_nombre}"
        }
    )