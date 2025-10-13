from core.models import alumno
from core.auth_utils import autenticar_usuario
from core.schemas import EstudianteLogin

async def autenticar_estudiante(est: EstudianteLogin):
    return await autenticar_usuario(
        tabla=alumno,
        credenciales={'correo': est.correo, 'password': est.password},
        campo_busqueda='correo',  
        campo_id='rut_alumno',
        tipo_usuario='estudiante',
        campos_extras=['id_carrera', 'ano_egreso']
    )