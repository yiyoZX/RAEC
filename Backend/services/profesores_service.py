from core.models import profesor, instituto_carrera
from core.auth_utils import autenticar_usuario
from core.schemas import ProfesorLogin
from sqlalchemy import select
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import Session
from fastapi import HTTPException
import logging

logger = logging.getLogger(__name__)

async def autenticar_profesor(prof: ProfesorLogin):
    return await autenticar_usuario(
        tabla=profesor,
        credenciales={'correo': prof.correo, 'password': prof.password},
        campo_busqueda='correo',
        campo_id='id_profesor',
        tipo_usuario='academico',
        campos_extras=['id_rol', 'id_instituto']
    )

def listar_profesores(db: Session, lista_carreras_ids: list[int] = None) -> list:
    try:
        logger.info(f"📥 SERVICE: Buscando profesores. IDs Carreras: {lista_carreras_ids}")
        
        # 1. Hacemos la consulta uniendo Profesor -> Instituto_Carrera
        # Esto nos da: Datos del Profe + El ID de la carrera asociada a su instituto
        stmt = select(
            profesor.c.id_profesor,
            profesor.c.nombres,    
            profesor.c.apellidos,
            profesor.c.id_instituto,
            instituto_carrera.c.id_carrera
        ).select_from(
            profesor.join(
                instituto_carrera, 
                profesor.c.id_instituto == instituto_carrera.c.id_instituto
            )
        )
        
        # 2. (Opcional) Filtro desde el backend si se quisiera usar
        if lista_carreras_ids and len(lista_carreras_ids) > 0:
            stmt = stmt.where(instituto_carrera.c.id_carrera.in_(lista_carreras_ids))

        result = db.execute(stmt).mappings().all()
        
        # 3. Agrupamos (Por si en el futuro un instituto tiene 2 carreras)
        profesores_dict = {}

        for row in result:
            p_id = row.id_profesor
            
            if p_id not in profesores_dict:
                profesores_dict[p_id] = {
                    "value": row.id_profesor,
                    "label": f"{row.nombres} {row.apellidos}",
                    "carreraIds": [] # Inicializamos la lista
                }
            
            # Agregamos la carrera encontrada a la lista de este profesor
            if row.id_carrera is not None:
                profesores_dict[p_id]["carreraIds"].append(row.id_carrera)

        lista_final = list(profesores_dict.values())
        logger.info(f"✅ SERVICE: Total profesores procesados: {len(lista_final)}")
        
        return lista_final

    except SQLAlchemyError as e:
        logger.error(f"Error BD en listar_profesores: {str(e)}")
        raise HTTPException(status_code=500, detail="Error al obtener listado de profesores.")
    except Exception as e:
        logger.error(f"Error inesperado: {str(e)}")
        raise HTTPException(status_code=500, detail="Error inesperado.")