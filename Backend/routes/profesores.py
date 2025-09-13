from fastapi import APIRouter
from controllers.profesores_controller import login_profesor
from core.schemas import ProfesorLogin

router = APIRouter()

@router.post("/login")
async def login(prof: ProfesorLogin):
    return await login_profesor(prof)
