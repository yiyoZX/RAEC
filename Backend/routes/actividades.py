from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from core.database import get_db
from core.auth import get_current_user
from core.schemas import NuevaActividad
from services.actividades_service import crear_actividad, listar_actividades

router = APIRouter(prefix="/actividades", tags=["Actividades"])

@router.post("/nueva")
def crear_nueva_actividad(
    datos: NuevaActividad,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """
    Endpoint para crear una nueva actividad.
    Solo administradores (rol=3) y super administradores (rol=4) pueden crear actividades.
    """
    # Verificar que sea un administrador o super administrador
    id_rol = current_user.get("id_rol")
    if id_rol not in [3, 4]:
        raise HTTPException(
            status_code=403,
            detail="Solo los administradores y super administradores pueden crear actividades"
        )
    
    # Crear la actividad
    resultado = crear_actividad(db, datos)
    
    return resultado

@router.get("/listar")
def obtener_actividades(
    tipo: str = None,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    """
    Endpoint para listar todas las actividades.
    Opcionalmente se puede filtrar por tipo: "academica" o "no_academica"
    """
    # Validar el tipo si se proporciona
    if tipo and tipo not in ["academica", "no_academica"]:
        raise HTTPException(
            status_code=400,
            detail="Tipo debe ser 'academica' o 'no_academica'"
        )
    
    actividades = listar_actividades(db, tipo)
    
    return {
        "total": len(actividades),
        "actividades": actividades
    }
