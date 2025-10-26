from pydantic import BaseModel

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

class ActividadCreate(BaseModel):
    nombre: str
    id_subcategoria: int