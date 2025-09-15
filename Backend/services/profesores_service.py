from core.database import database
from core.models import profesores
import bcrypt

async def autenticar_profesor(prof):
    query = profesores.select().where(profesores.c.correo == prof.correo)
    db_prof = await database.fetch_one(query)
    if not db_prof:
        return None
    if not bcrypt.checkpw(prof.password.encode("utf-8"), db_prof["password_hash"].encode("utf-8")):
        return None
    return {
        "message": f"Bienvenido {db_prof['nombres']} {db_prof['apellidos']}",
        "id_profesor": db_prof["id_profesores"],
        "rol": db_prof["id_rol"],
        "instituto": db_prof["id_instituto"]
    }