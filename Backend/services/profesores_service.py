from core.models import profesor
from core.auth_utils import autenticar_usuario
from core.schemas import ProfesorLogin

async def autenticar_profesor(prof: ProfesorLogin):
    return await autenticar_usuario(
        tabla=profesor,
        credenciales={'correo': prof.correo, 'password': prof.password},
        campo_busqueda='correo',
        campo_id='id_profesor',
        tipo_usuario='profesor',
        campos_extras=['id_rol', 'id_instituto']
    )