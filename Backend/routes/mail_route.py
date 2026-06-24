from fastapi import APIRouter, BackgroundTasks, Depends
from starlette.responses import JSONResponse
from sqlalchemy.orm import Session
from core.database import get_db
from services.mailsend_service import formularioMail, idForm

router = APIRouter()

@router.post("/Enviar-mail")
async def correoDeFormulario(data: idForm, tasks: BackgroundTasks, db: Session = Depends(get_db)):
    tasks.add_task(formularioMail, data, db)
    return JSONResponse(status_code=200, content={"message": "Correo en cola"})