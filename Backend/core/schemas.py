from pydantic import BaseModel

class ProfesorLogin(BaseModel):
	correo: str
	password: str
