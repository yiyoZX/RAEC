"""
Endpoint para carga masiva de datos desde archivos CSV
"""
from fastapi import APIRouter, UploadFile, File, Form, HTTPException
from fastapi.responses import JSONResponse
from core.database import database
from core.models import alumno, profesor, registro
from sqlalchemy import insert
from passlib.context import CryptContext
from services.carga_masiva_service import procesar_csv_alumnos, procesar_csv_profesores, procesar_csv_registros

router = APIRouter(tags=["Carga Masiva"])
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

@router.post("/carga-masiva")
async def carga_masiva(
    file: UploadFile = File(...),
    tipo_entidad: str = Form(...)
):
    """
    Endpoint para carga masiva de datos desde CSV
    """
    # Validar tipo de archivo
    if not file.filename.endswith('.csv'):
        raise HTTPException(status_code=400, detail="El archivo debe ser CSV")
    
    # Validar tipo de entidad
    if tipo_entidad not in ['alumnos', 'profesores', 'registros']:
        raise HTTPException(status_code=400, detail="Tipo de entidad inválido")
    
    try:
        # Leer contenido del archivo
        contenido = await file.read()
        contenido_str = contenido.decode('utf-8-sig')  # UTF-8 con BOM
        
        # Procesar según tipo de entidad
        if tipo_entidad == 'alumnos':
            datos, errores = procesar_csv_alumnos(contenido_str)
            tabla = alumno
        elif tipo_entidad == 'profesores':
            datos, errores = procesar_csv_profesores(contenido_str)
            tabla = profesor
        elif tipo_entidad == 'registros':
            datos, errores = procesar_csv_registros(contenido_str)
            tabla = registro
        
        if not datos:
            return JSONResponse(
                status_code=400,
                content={
                    "detail": "No se pudieron procesar datos válidos",
                    "errores": errores
                }
            )
        
        # Insertar datos en lotes
        insertados = 0
        errores_insercion = []
        batch_size = 100
        
        for i in range(0, len(datos), batch_size):
            batch = datos[i:i + batch_size]
            try:
                query = insert(tabla).values(batch)
                await database.execute(query)
                insertados += len(batch)
            except Exception as e:
                # Intentar insertar uno por uno
                for dato in batch:
                    try:
                        query = insert(tabla).values(dato)
                        await database.execute(query)
                        insertados += 1
                    except Exception as e2:
                        errores_insercion.append(str(e2))
        
        return {
            "success": True,
            "insertados": insertados,
            "total_procesado": len(datos),
            "errores_validacion": errores,
            "errores_insercion": errores_insercion[:10]  # Solo primeros 10
        }
        
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Error al procesar archivo: {str(e)}"
        )
