from pydantic import BaseModel

class UsuarioCreate(BaseModel):
	username: str
	password: str

class ProfesorLogin(BaseModel):
	correo: str
	password: str
