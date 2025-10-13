from pydantic import BaseModel

class ProfesorLogin(BaseModel):
	correo: str
	password: str

class EstudianteLogin(BaseModel):
    correo: str
    password: str