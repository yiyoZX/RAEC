from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from core.database import get_db
from core.auth import get_current_user
from services.carreras_service import listar_carreras

router = APIRouter(prefix="/carreras", tags=["Carreras"])

@router.get("/listar")
def obtener_carreras(db: Session = Depends(get_db),current_user: dict = Depends(get_current_user)):
    carreras = listar_carreras(db)
    
    return {
        "total": len(carreras),
        "carreras": carreras
    }