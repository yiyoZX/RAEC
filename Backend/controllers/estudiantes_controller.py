from fastapi import HTTPException
from services.estudiantes_services import autenticar_estudiante
from core.schemas import EstudianteLogin

async def login_estudiante(est: EstudianteLogin):
    resultado = await autenticar_estudiante(est)
    if not resultado:
        raise HTTPException(status_code=401, detail="Credenciales inválidas")
    return resultado