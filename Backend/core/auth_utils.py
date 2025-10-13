import bcrypt
from core.database import database
from core.auth import create_access_token

async def autenticar_usuario(
    tabla,
    credenciales: dict,
    campo_busqueda: str = 'correo',
    campo_id: str = 'id',
    tipo_usuario: str = None,
    campos_extras: list = []
):
    valor_busqueda = credenciales.get(campo_busqueda)
    if not valor_busqueda:
        return None
    
    query = tabla.select().where(tabla.c[campo_busqueda] == valor_busqueda)
    db_usuario = await database.fetch_one(query)
    
    if not db_usuario:
        return None
    
    if not bcrypt.checkpw(credenciales['password'].encode("utf-8"), db_usuario["password_hash"].encode("utf-8")):
        return None
    
    token_data = {"sub": str(db_usuario[campo_id])}
    if tipo_usuario:
        token_data["type"] = tipo_usuario
    access_token = create_access_token(data=token_data)
    
    response = {
        "message": f"Bienvenido {db_usuario['nombres']} {db_usuario['apellidos']}",
        "access_token": access_token,
        "token_type": "bearer",
        f"id_{tipo_usuario or 'usuario'}": db_usuario[campo_id]
    }
    
    for campo in campos_extras:
        if campo in db_usuario:
            response[campo] = db_usuario[campo]
    
    return response