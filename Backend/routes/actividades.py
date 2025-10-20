from fastapi import APIRouter, Depends, HTTPException
from core.database import database
from core.auth import get_current_user

router = APIRouter()

@router.post("/actividades/nueva")
async def crear_actividad(data: dict, current_user = Depends(get_current_user)):
    # Solo admin puede crear
    if current_user.rol != 1:
        raise HTTPException(status_code=403, detail="Solo el administrador puede crear actividades.")

    nombre = data.get("nombre")
    tipo = data.get("tipo")

    if not nombre or not tipo:
        raise HTTPException(status_code=400, detail="Faltan campos obligatorios.")

    # Buscar la categoría según el tipo
    if tipo == "academica":
        query_cat = "SELECT id_categoria FROM categoria WHERE LOWER(nombre_categoria) LIKE 'acad%'"
    else:
        query_cat = "SELECT id_categoria FROM categoria WHERE LOWER(nombre_categoria) LIKE 'no acad%'"

    categoria = await database.fetch_one(query_cat)
    if not categoria:
        raise HTTPException(status_code=404, detail=f"No se encontró la categoría para tipo '{tipo}'")

    # Buscar una subcategoría asociada
    query_sub = "SELECT id_subcategoria FROM subcategoria WHERE id_categoria = :cat_id LIMIT 1"
    subcat = await database.fetch_one(query_sub, {"cat_id": categoria["id_categoria"]})
    print(subcat)
    if not subcat:
        raise HTTPException(status_code=404, detail="No hay subcategorías disponibles para esta categoría.")

    # Insertar la nueva actividad
    query_insert = """
        INSERT INTO actividad (nombre_actividad, id_subcategoria)
        VALUES (:nombre, :id_sub)
    """
    await database.execute(query_insert, {"nombre": nombre, "id_sub": subcat["id_subcategoria"]})

    return {"message": f"✅ Actividad '{nombre}' creada correctamente."}
