from pydantic import BaseModel
from typing import Optional, List

class ProfesorLogin(BaseModel):
	correo: str
	password: str

class EstudianteLogin(BaseModel):
    correo: str
    password: str

class NuevaActividad(BaseModel):
    tipo: str  # "academica" o "no_academica"
    nombre: str
    creador: str  # email del creador
    campos_adicionales: Optional[List[str]] = []  # Lista de nombres de campos adicionales (máximo 3)

class ActividadCreate(BaseModel):
    nombre: str
    id_subcategoria: int