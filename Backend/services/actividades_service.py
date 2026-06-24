from sqlalchemy.orm import Session
from sqlalchemy import select, func, text
from sqlalchemy.exc import IntegrityError
from fastapi import HTTPException
from core.models import actividad, subcategoria
from core.schemas import NuevaActividad


def obtener_id_subcategoria(tipo: str) -> int:
    """
    Mapea el tipo de actividad a su id_subcategoria correspondiente.
    
    Según la base de datos:
    - id_subcategoria = 1: academico (id_categoria = 1)
    - id_subcategoria = 4: varios (id_categoria = 2) - para no académicas
    """
    if tipo == "academica":
        return 3  # subcategoria: academico
    elif tipo == "no_academica":
        return 4  # subcategoria: varios (no académico)
    else:
        raise HTTPException(status_code=400, detail="Tipo de actividad inválido")

def crear_actividad(db: Session, datos: NuevaActividad) -> dict:
    """
    Crea una nueva actividad en la base de datos.
    
    Args:
        db: Sesión de base de datos
        datos: Datos de la actividad a crear
    
    Returns:
        Diccionario con el mensaje y el ID de la actividad creada
    """
    # Validar que el nombre no esté vacío
    if not datos.nombre or not datos.nombre.strip():
        raise HTTPException(status_code=400, detail="El nombre de la actividad no puede estar vacío")
    
    # Verificar si ya existe una actividad con el mismo nombre
    stmt = select(actividad).where(
        func.lower(actividad.c.nombre_actividad) == func.lower(datos.nombre.strip())
    )
    existe = db.execute(stmt).first()
    if existe:
        raise HTTPException(
            status_code=409, 
            detail=f"Ya existe una actividad con el nombre '{datos.nombre}'"
        )
    
    # Obtener el id_subcategoria según el tipo
    id_subcategoria = obtener_id_subcategoria(datos.tipo)
    
    # Preparar los campos adicionales (máximo 3)
    dato1 = datos.campos_adicionales[0] if len(datos.campos_adicionales) > 0 else None
    dato2 = datos.campos_adicionales[1] if len(datos.campos_adicionales) > 1 else None
    dato3 = datos.campos_adicionales[2] if len(datos.campos_adicionales) > 2 else None
    
    try:
        # Insertar la nueva actividad con campos dinámicos
        stmt_insert = actividad.insert().values(
            nombre_actividad=datos.nombre.strip(),
            id_subcategoria=id_subcategoria,
            dato1=dato1,
            dato2=dato2,
            dato3=dato3
        )
        
        result = db.execute(stmt_insert)
        db.commit()
        
        # Obtener el ID de la actividad creada
        id_actividad = result.inserted_primary_key[0] if result.inserted_primary_key else None
        
        response = {
            "message": "Actividad creada exitosamente",
            "id_actividad": id_actividad,
            "nombre_actividad": datos.nombre.strip(),
            "tipo": datos.tipo
        }
        
        # Agregar campos adicionales si existen
        if dato1:
            response["dato1"] = dato1
        if dato2:
            response["dato2"] = dato2
        if dato3:
            response["dato3"] = dato3
        
        return response
    except IntegrityError as e:
        db.rollback()
        # Capturar errores de secuencia o duplicados
        if "duplicate key" in str(e.orig):
            raise HTTPException(
                status_code=409,
                detail="Error al crear la actividad. Por favor, contacte al administrador del sistema."
            )
        raise HTTPException(status_code=500, detail="Error de integridad en la base de datos")

def listar_actividades(db: Session, tipo: str = None) -> list:
    """
    Lista todas las actividades, opcionalmente filtradas por tipo.
    
    Args:
        db: Sesión de base de datos
        tipo: Tipo de actividad ("academica" o "no_academica"), opcional
    
    Returns:
        Lista de actividades
    """
    stmt = select(
        actividad.c.id_actividad,
        actividad.c.nombre_actividad,
        actividad.c.id_subcategoria,
        actividad.c.dato1,
        actividad.c.dato2,
        actividad.c.dato3
    )
    
    # Filtrar por tipo si se especifica
    if tipo:
        id_subcategoria = obtener_id_subcategoria(tipo)
        stmt = stmt.where(actividad.c.id_subcategoria == id_subcategoria)
    
    result = db.execute(stmt).mappings().all()
    
    # Convertir a lista de diccionarios
    actividades = []
    for row in result:
        act = {
            "id_actividad": row.id_actividad,
            "nombre_actividad": row.nombre_actividad,
            "id_subcategoria": row.id_subcategoria,
            "tipo": "academica" if row.id_subcategoria in [1, 2, 3] else "no_academica"
        }
        
        # Agregar campos adicionales si existen
        if row.dato1:
            act["dato1"] = row.dato1
        if row.dato2:
            act["dato2"] = row.dato2
        if row.dato3:
            act["dato3"] = row.dato3
        
        actividades.append(act)
    
    return actividades
