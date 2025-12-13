from typing import List, Dict, Any, Optional
from sqlalchemy.orm import Session
from sqlalchemy import select, desc, or_
from fastapi import HTTPException
from core.models import registro, actividad, alumno, profesor, carrera
from core.models import estado as tabla_estado

# IDs para clasificación de actividades
ACADEMIC_IDS = set(range(1, 7))
NON_ACADEMIC_IDS = set(range(7, 13))

def _serialize_row(row) -> Dict[str, Any]:
    """Convierte el resultado de la DB en un diccionario limpio para el JSON."""
    return {
        "rut": row.rut_alumno,
        "nombres": row.nombres,
        "apellidos": row.apellidos,
        "actividad": row.nombre_actividad,
        "fecha_creacion": row.fecha_creacion.isoformat() if row.fecha_creacion else None,
        "estado": row.nombre_estado if hasattr(row, 'nombre_estado') else None,
        "fecha_inicio_actividad": row.fecha_inicio_actividad.isoformat() if getattr(row, 'fecha_inicio_actividad', None) else None,
        "fecha_termino_actividad": row.fecha_termino_actividad.isoformat() if getattr(row, 'fecha_termino_actividad', None) else None,
        "horas_totales": getattr(row, 'horas_totales', None),
        "comentario": getattr(row, 'comentario', None),
        "profesor_nombres": getattr(row, 'profesor_nombres', None),
        "profesor_apellidos": getattr(row, 'profesor_apellidos', None),
        "carrera": getattr(row, 'nombre_carrera', None),
        "id_registro": getattr(row, 'id_registro', None),
        "archivo_nombre": getattr(row, 'archivo_nombre', None),
        "tiene_archivo": bool(getattr(row, 'archivo_nombre', None))
    }

def _actividad_existe(db: Session, actividad_id: int) -> bool:
    stmt = select(actividad.c.id_actividad).where(actividad.c.id_actividad == actividad_id)
    return db.execute(stmt).first() is not None

def obtener_reporte(
    db: Session,
    current_user: Optional[Dict[str, Any]] = None,
    rut: Optional[str] = None,
    # AHORA RECIBIMOS STRINGS (ej: "1,2,3") O LISTAS
    actividad_ids: Optional[str] = None, 
    carrera_ids: Optional[str] = None,   
    profesor_ids: Optional[str] = None,  
    tipo_actividad: Optional[str] = None,
    fecha_creacion_inicio: Optional[str] = None,
    fecha_creacion_termino: Optional [str] = None,
    fecha_inicio: Optional[str] = None,
    fecha_fin: Optional[str] = None,
    estado: Optional[str] = None,
    horas_min: Optional[int] = None, # Agregué esto por si acaso (vimos horas en el front)
) -> List[Dict[str, Any]]:

    # 1. Query Base (Con todos los JOINS necesarios)
    # Nota: Asegúrate de que los modelos importados sean los correctos
    stmt = (
        select(
            registro.c.id_registro,
            registro.c.id_alumno.label("rut_alumno"),
            alumno.c.nombres,
            alumno.c.apellidos,
            alumno.c.id_carrera, # Necesario para filtrar carrera si no estaba antes
            actividad.c.id_actividad,
            actividad.c.nombre_actividad,
            registro.c.fecha_creacion,
            registro.c.fecha_inicio_actividad,
            registro.c.fecha_termino_actividad,
            registro.c.horas_totales,
            registro.c.comentario,
            registro.c.archivo_nombre,
            registro.c.id_profesor, # Necesario para filtrar profesor
            tabla_estado.c.nombre_estado,
            profesor.c.nombres.label("profesor_nombres"),
            profesor.c.apellidos.label("profesor_apellidos"),
            carrera.c.nombre_carrera
        )
        .join(alumno, registro.c.id_alumno == alumno.c.rut_alumno, isouter=True)
        .join(actividad, registro.c.id_actividad == actividad.c.id_actividad, isouter=True)
        .join(tabla_estado, registro.c.id_estado == tabla_estado.c.id_estado, isouter=True)
        .join(profesor, registro.c.id_profesor == profesor.c.id_profesor, isouter=True)
        .join(carrera, alumno.c.id_carrera == carrera.c.id_carrera, isouter=True)
        .order_by(desc(registro.c.fecha_creacion))
    )

    # ==========================================
    # 2. PROCESAMIENTO DE FILTROS (ARREGLOS)
    # ==========================================

    # A. Filtro por ACTIVIDADES (Múltiples)
    if actividad_ids:
        # Convertimos "1,2,3" -> [1, 2, 3]
        lista_act = [int(x) for x in actividad_ids.split(',') if x.isdigit()]
        if lista_act:
            stmt = stmt.where(registro.c.id_actividad.in_(lista_act))

    # B. Filtro por CARRERAS (Múltiples)
    if carrera_ids:
        # Convertimos "1,2" -> [1, 2]
        lista_carreras = [int(x) for x in carrera_ids.split(',') if x.isdigit()]
        if lista_carreras:
            stmt = stmt.where(alumno.c.id_carrera.in_(lista_carreras))

    # C. Filtro por PROFESORES SELECCIONADOS (Múltiples)
    if profesor_ids:
        # Convertimos "111-1,222-2" -> ["111-1", "222-2"] (RUTs son strings)
        lista_profes = [x.strip() for x in profesor_ids.split(',') if x.strip()]
        if lista_profes:
            stmt = stmt.where(registro.c.id_profesor.in_(lista_profes))

    # ==========================================
    # 3. OTROS FILTROS
    # ==========================================
    
    if rut:
        stmt = stmt.where(registro.c.id_alumno.ilike(f"%{rut}%"))

    if tipo_actividad:
        # Asumiendo que ACADEMIC_IDS y NON_ACADEMIC_IDS son listas globales constantes
        if tipo_actividad == 'academica':
            stmt = stmt.where(actividad.c.id_actividad.in_(ACADEMIC_IDS))
        elif tipo_actividad == 'no_academica':
            stmt = stmt.where(actividad.c.id_actividad.in_(NON_ACADEMIC_IDS))

    if fecha_creacion_inicio:
        stmt = stmt.where(registro.c.fecha_creacion >= fecha_creacion_inicio)

    if fecha_creacion_termino:
        stmt = stmt.where(registro.c.fecha_creacion <= fecha_creacion_termino)

    if fecha_inicio:
        stmt = stmt.where(registro.c.fecha_inicio_actividad >= fecha_inicio)
    
    if fecha_fin:
        stmt = stmt.where(registro.c.fecha_inicio_actividad <= fecha_fin)

    if horas_min:
        stmt = stmt.where(registro.c.horas_totales >= horas_min)

    # ==========================================
    # 4. SEGURIDAD Y ROLES
    # ==========================================
    
    if current_user:
        rol = current_user.get("type") # 'estudiante' o 'academico'
        
        # --- LÓGICA ESTUDIANTE ---
        if rol == "estudiante":
            stmt = stmt.where(registro.c.id_alumno == current_user.get("rut_alumno"))
            
            # Filtro de estado específico para vistas de estudiante
            if estado:
                mapa_estados = {'aprobadas': 1, 'rechazadas': 2, 'pendientes': 3}
                # Intentamos ver si es número ("1") o texto ("aprobadas")
                val_estado = int(estado) if str(estado).isdigit() else mapa_estados.get(str(estado).lower())
                if val_estado:
                    stmt = stmt.where(registro.c.id_estado == val_estado)

        # --- LÓGICA ACADÉMICO ---
        elif rol == "academico":
            id_rol_bd = current_user.get("id_rol") # 1: Profe, 2: Director, 3: Admin
            
            if id_rol_bd == 1:  # Profesor normal
                # Solo ve registros donde él es el tutor
                stmt = stmt.where(registro.c.id_profesor == current_user.get("id_profesor"))
            
            elif id_rol_bd == 2:  # Director
                # Ve registros de SU instituto
                # (OJO: Esto se suma a los filtros anteriores, es un AND)
                stmt = stmt.where(profesor.c.id_instituto == current_user.get("id_instituto"))

    # 5. Ejecución
    result = db.execute(stmt).mappings().all()
    
    return [_serialize_row(r) for r in result]

# Helper (si no lo tenías definido)
def _serialize_row(row):
    return dict(row)