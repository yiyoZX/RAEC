from sqlalchemy.orm import Session
from sqlalchemy import select
from sqlalchemy.exc import SQLAlchemyError
from fastapi import HTTPException
from core.models import carrera
import logging 

logger = logging.getLogger(__name__)

def listar_carreras (db: Session) -> list:
    try:
        stmt = select (
            carrera.c.id_carrera,
            carrera.c.nombre_carrera
        )

        result = db.execute(stmt).mappings().all()


        return [{"value": row.id_carrera, "label": row.nombre_carrera} for row in result]
    
    except SQLAlchemyError as e:
        # CASO 1: Error de Base de Datos (Conexión caída, tabla no existe, etc.)
        logger.error(f"Error grave en base de datos al listar carreras: {str(e)}")
        # Lanzamos un error HTTP 500 controlado
        raise HTTPException(
            status_code=500, 
            detail="Error interno al intentar obtener las carreras. Contacte a soporte."
        )

    except Exception as e:
        # CASO 2: Error desconocido (Bug de lógica en tu Python)
        logger.error(f"Error inesperado en listar_carreras: {str(e)}")
        raise HTTPException(
            status_code=500, 
            detail="Ocurrió un error inesperado."
        )