from fastapi import APIRouter
from controllers.profesores_controller import login_profesor
from controllers.estudiantes_controller import login_estudiante
from core.schemas import ProfesorLogin, EstudianteLogin

router = APIRouter()

@router.post("/login")
async def login(prof: ProfesorLogin):
    return await login_profesor(prof)

@router.post("/loginStudent")
async def route_login_estudiante(est: EstudianteLogin):
    return await login_estudiante(est)