from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from typing import Optional
from core.database import get_db
from core.auth import get_current_user
from services.profesores_service import listar_profesores

router = APIRouter(prefix="/profesores", tags=["Profesores"])

@router.get("/listar")
def obtener_profesores(carrera: Optional[str] = Query(None), db: Session = Depends(get_db),current_user: dict = Depends(get_current_user)):
    # 1. Procesar el string de carreras "1,2,3" a lista de enteros [1, 2, 3]
    lista_ids = []
    if carrera:
        try:
            # Dividimos por coma y convertimos cada pedazo a entero
            lista_ids = [int(id_str) for id_str in carrera.split(',') if id_str.strip()]
        except ValueError:
            # Si alguien manda ?carrera=hola (algo que no es numero), lo ignoramos o damos error.
            # Aquí elegí ignorarlo y mandar lista vacía para no romper todo.
            lista_ids = []

    # 2. Llamamos al servicio pasando la lista procesada
    profesores = listar_profesores(db, lista_carreras_ids=lista_ids)
    
    return {
        "ok": True,
        "total": len(profesores),
        "profesores": profesores
    }