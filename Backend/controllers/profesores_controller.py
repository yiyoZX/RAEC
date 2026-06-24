from fastapi import HTTPException
from services.profesores_service import autenticar_profesor
from core.schemas import ProfesorLogin

async def login_profesor(prof: ProfesorLogin):
    resultado = await autenticar_profesor(prof)
    if not resultado:
        raise HTTPException(status_code=401, detail="Credenciales inválidas")
    return resultado
