from fastapi import APIRouter, Form, File, UploadFile, Depends, BackgroundTasks, HTTPException
from sqlalchemy.orm import Session
from services.formulario_service import guardar_registro
from core.database import get_db
from core.auth import get_current_user
from datetime import datetime

router = APIRouter()


@router.post(
        "/submit",
        tags=["Formularios"],
        summary="Enviar formulario de actividad",
        description="""
        Reegistra actividades académicas y no académicas.
    
        Incluye:
        - Asignación de actividades,
        - Fechas de inicio y término,
        - Carga de archivos,
        - Asignación de profesor responsable.
        """
        )
async def submit_form(
    background_tasks: BackgroundTasks,
    rut: str = Form(None,   # Opcional - estudiantes no lo envían
        description="RUT del estudiante",
        example="12.345.678-9"
    ), 
    academica: str = Form(...,
        description="Define si la actividad es Académica o No-Académica"
    ),
    actividad: str = Form(...,
        description="Nombre de la actividad"
    ),
    fecha_inicio: str = Form(...,
        description="Cuándo el estudiante empezó la actividad (YYYY-MM-DD)"
    ),
    fecha_termino: str = Form(...,
        description="Cuándo el estudiante temrinó la actividad (YYYY-MM-DD)"
    ),
    horas_totales: str = Form(...,
        description="Horas utilizadas en la actividad por el estudiante"
    ),
    about: str = Form(""),
    archivos: UploadFile = File(None,
        description="Archivo para probar que se ejerció la actividad"                            
    ),
    dato1: str = Form(None,
        description="Dato extra de la actividad"                            
    ),
    dato2: str = Form(None,
        description="Dato extra de la actividad"                            
    ),
    dato3: str = Form(None,
        description="Dato extra de la actividad"                            
    ),
    id_profesor: str = Form(None,
        description="Identificador del profesor"                            
    ),
    db: Session = Depends(get_db),
    current_user: dict = Depends(get_current_user)
):
    # Convertir fechas y validar datos
    try:
        # Convertir strings a enteros
        academica_int = int(academica)
        actividad_int = int(actividad)
        horas_totales_int = int(horas_totales)
        
        # Validar que las horas totales sean positivas
        if horas_totales_int <= 0: 
            raise HTTPException(status_code=422, detail="Las horas totales deben ser un número positivo")
        
        # Validar que solo los directores (id_rol = 2), admins (id_rol = 3) y super admins (id_rol = 4) puedan registrar actividades no académicas (academica = 2)
        # Los estudiantes (type = "estudiante") SÍ pueden registrar actividades no académicas
        if academica_int == 2:        
            if current_user.get("type") == "academico" and current_user.get("id_rol") not in [2, 3, 4]:
                raise HTTPException(status_code=403, detail="Solo directores, administradores y super administradores pueden registrar actividades no académicas")

        # Convertir fechas de string a datetime
        fecha_inicio_dt = datetime.strptime(fecha_inicio, "%Y-%m-%d")
        fecha_termino_dt = datetime.strptime(fecha_termino, "%Y-%m-%d")
        
        # Validar que fecha_inicio sea anterior a fecha_termino
        if fecha_inicio_dt > fecha_termino_dt:
            raise HTTPException(status_code=422, detail="La fecha de inicio debe ser anterior a la fecha de término")

        profesor_final = None

        if current_user.get("type") == "estudiante":
            # Para estudiantes, es OBLIGATORIO que venga id_profesor del form
            if not id_profesor:
                raise HTTPException(status_code=422, detail="Debes seleccionar un profesor guía")
            try:
                profesor_final = id_profesor # Convertimos a int
            except ValueError:
                raise HTTPException(status_code=422, detail="ID de profesor inválido")
        
        elif current_user.get("type") == "academico":
            # Para académicos, el profesor responsable son ellos mismos
            # Buscamos su ID en el token
            profesor_final = current_user.get("id_profesor") # Usar id_profesor del token
            
            if not profesor_final:
                 # Fallback por seguridad
                 raise HTTPException(status_code=500, detail="No se pudo identificar al profesor académico")    
                
    except ValueError as e:
        if "time data" in str(e):
            raise HTTPException(status_code=422, detail="Formato de fecha inválido. Use YYYY-MM-DD")
        else:
            raise HTTPException(status_code=422, detail="Los campos numéricos deben contener valores válidos")
    
    return await guardar_registro(
        rut, academica_int, actividad_int, fecha_inicio_dt, fecha_termino_dt, horas_totales_int, about, archivos, dato1, dato2, dato3, profesor_final, db, current_user, background_tasks
    )
