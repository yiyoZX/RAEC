from pydantic import BaseModel

class ProfesorLogin(BaseModel):
	correo: str
	password: str

class EstudianteLogin(BaseModel):
    correo: str
    password: str

class ActividadCreate(BaseModel):
    nombre: str
    id_subcategoria: int