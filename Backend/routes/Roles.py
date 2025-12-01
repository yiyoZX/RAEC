from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm import Session
from sqlalchemy import select, update
from core.database import get_db
from core.auth import get_current_user
from core.models import profesor, rol

router = APIRouter()

class RoleUpdate(BaseModel):
    correo: str
    newRol: int


@router.post("/updateRole")
async def update_role(
    payload: RoleUpdate,
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):

    # Solo administrador puede cambiar roles
    if current_user.get("id_rol") != 3:
        raise HTTPException(status_code=403, detail="No autorizado")

    correo = payload.correo
    newRol = payload.newRol

    # Buscar profesor destino
    row = db.execute(
        select(profesor).where(profesor.c.correo == correo)
    ).first()

    if not row:
        raise HTTPException(status_code=404, detail="No existe un profesor con ese correo")

    prof = row._mapping  # <-- convertir resultado en dict

    # Validar rol
    rol_row = db.execute(
        select(rol).where(rol.c.id_rol == newRol)
    ).first()

    if not rol_row:
        raise HTTPException(status_code=400, detail="El rol especificado no existe")

    #   SI ASIGNAMOS NUEVO ADMINISTRADOR (id_rol = 3)
    if newRol == 3:
        admin_row = db.execute(
            select(profesor).where(profesor.c.id_rol == 3)
        ).first()

        if admin_row:
            admin = admin_row._mapping

            # Evitar auto-downgrade
            if admin["correo"] != correo:
                db.execute(
                    update(profesor)
                    .where(profesor.c.id_profesor == admin["id_profesor"])
                    .values(id_rol=1)  # bajar a profesor
                )

    #   SI ASIGNAMOS NUEVO DIRECTOR (id_rol = 2)
    if newRol == 2:
        director_row = db.execute(
            select(profesor)
            .where(
                profesor.c.id_rol == 2,
                profesor.c.id_instituto == prof["id_instituto"]
            )
        ).first()

        if director_row:
            director = director_row._mapping

            if director["correo"] != correo:
                db.execute(
                    update(profesor)
                    .where(profesor.c.id_profesor == director["id_profesor"])
                    .values(id_rol=1)
                )

    #   ACTUALIZAR EL ROL DEL PROFESOR DESTINO
    db.execute(
        update(profesor)
        .where(profesor.c.correo == correo)
        .values(id_rol=newRol)
    )

    db.commit()

    return {"message": "Rol actualizado correctamente"}
