from fastapi import APIRouter, Body, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from core.database import get_db
from core.auth import get_current_user
from services.solicitudes_service import get_solicitudes_pendientes, update_solicitud_estado

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
    return update_solicitud_estado(db, id_registro, nuevo_estado, current_user)