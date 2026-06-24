from datetime import datetime, timedelta
from typing import Optional
from jose import JWTError, jwt
from fastapi import HTTPException, Depends, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from sqlalchemy.orm import Session
from sqlalchemy import select
from core.database import get_db
from core.models import profesor, alumno  # Cambio: Importa alumno para estudiantes

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
        user_id: str = payload.get("sub")  # Cambio: str en lugar de int, para rut_alumno (string)
        user_type: str = payload.get("type")  # Cambio: Extrae "type" (profesor o estudiante)
        if user_id is None or user_type is None:  # Cambio: Requiere type para seguridad
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Token inválido",
                headers={"WWW-Authenticate": "Bearer"},
            )
        return {"id": user_id, "type": user_type}  # Cambio: Retorna dict con id y type
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
    verified = verify_token(token)  # Ahora es dict con id y type
    
    user_id = verified["id"]
    user_type = verified["type"]
    
    if user_type == "academico":
        # Verificar que el profesor existe en la base de datos
        query = select(profesor).where(profesor.c.id_profesor == user_id)
        result = db.execute(query)
        db_user = result.first()
        
        if db_user is None:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Usuario no encontrado",
                headers={"WWW-Authenticate": "Bearer"},
            )
        
        return {
            "id_profesor": db_user.id_profesor,
            "nombres": db_user.nombres,
            "apellidos": db_user.apellidos,
            "correo": db_user.correo,
            "id_rol": db_user.id_rol,
            "id_instituto": db_user.id_instituto,
            "type": "academico"  
        }
    
    elif user_type == "estudiante":
        query = select(alumno).where(alumno.c.rut_alumno == user_id)
        result = db.execute(query)
        db_user = result.first()
        
        if db_user is None:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Usuario no encontrado",
                headers={"WWW-Authenticate": "Bearer"},
            )
        
        return {
            "rut_alumno": db_user.rut_alumno,
            "nombres": db_user.nombres,
            "apellidos": db_user.apellidos,
            "correo": db_user.correo,
            "ano_egreso": db_user.ano_egreso,
            "id_carrera": db_user.id_carrera,
            "type": "estudiante"  
        }
    
    else:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Tipo de usuario inválido",
            headers={"WWW-Authenticate": "Bearer"},
        )