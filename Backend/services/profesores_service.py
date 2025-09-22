from core.database import database
from core.models import profesor
from core.auth import create_access_token
import bcrypt

async def autenticar_profesor(prof):
    query = profesor.select().where(profesor.c.correo == prof.correo)
    db_prof = await database.fetch_one(query)
    if not db_prof:
        return None
    if not bcrypt.checkpw(prof.password.encode("utf-8"), db_prof["password_hash"].encode("utf-8")):
        return None
    
    # Crear token JWT
    access_token = create_access_token(data={"sub": str(db_prof["id_profesor"])})
    
    return {
        "message": f"Bienvenido {db_prof['nombres']} {db_prof['apellidos']}",
        "access_token": access_token,
        "token_type": "bearer",
        "id_profesor": db_prof["id_profesor"],
        "rol": db_prof["id_rol"],
        "instituto": db_prof["id_instituto"]
    }