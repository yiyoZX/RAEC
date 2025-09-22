from datetime import datetime, timedelta
from typing import Optional
from jose import JWTError, jwt
from fastapi import HTTPException, Depends, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from sqlalchemy.orm import Session
from sqlalchemy import select
from core.database import get_db
from core.models import profesor
import os

# Configuración del JWT desde variables de entorno
SECRET_KEY = os.getenv("JWT_SECRET_KEY")
ALGORITHM = os.getenv("JWT_ALGORITHM")
ACCESS_TOKEN_EXPIRE_MINUTES = int(os.getenv("JWT_ACCESS_TOKEN_EXPIRE_MINUTES"))

security = HTTPBearer()

def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    """Crear un token JWT"""
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

def verify_token(token: str):
    """Verificar y decodificar un token JWT"""
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        id_profesor: int = payload.get("sub")
        if id_profesor is None:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Token inválido",
                headers={"WWW-Authenticate": "Bearer"},
            )
        return id_profesor
    except JWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token inválido",
            headers={"WWW-Authenticate": "Bearer"},
        )

async def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(security),
    db: Session = Depends(get_db)
):
    """Obtener el usuario actual desde el token JWT"""
    token = credentials.credentials
    id_profesor = verify_token(token)
    
    # Verificar que el profesor existe en la base de datos
    query = select(profesor).where(profesor.c.id_profesor == id_profesor)
    result = db.execute(query)
    db_profesor = result.first()
    
    if db_profesor is None:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Usuario no encontrado",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    return {
        "id_profesor": db_profesor.id_profesor,
        "nombres": db_profesor.nombres,
        "apellidos": db_profesor.apellidos,
        "correo": db_profesor.correo,
        "id_rol": db_profesor.id_rol,
        "id_instituto": db_profesor.id_instituto
    }
