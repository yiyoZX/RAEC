import csv
import io
from passlib.context import CryptContext


pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def validar_rut(rut: str) -> bool:
    """Valida formato básico de RUT chileno"""
    if not rut or '-' not in rut:
        return False
    partes = rut.split('-')
    if len(partes) != 2:
        return False
    return partes[0].isdigit() and len(partes[0]) >= 7
    
def procesar_csv_alumnos(contenido: str):
    """Procesa CSV de alumnos"""
    reader = csv.DictReader(io.StringIO(contenido))
    alumnos_data = []
    errores = []
    
    for idx, row in enumerate(reader, start=2):
        try:
            # Validaciones
            if not validar_rut(row.get('rut_alumno', '')):
                errores.append(f"Fila {idx}: RUT inválido")
                continue
            
            ano_egreso = int(row.get('ano_egreso', 0))
            id_carrera = int(row.get('id_carrera', 0))
            
            if ano_egreso < 2020 or ano_egreso > 2030:
                errores.append(f"Fila {idx}: Año de egreso inválido")
                continue
            
            if id_carrera < 1 or id_carrera > 7:
                errores.append(f"Fila {idx}: ID de carrera inválido (debe ser 1-7)")
                continue
            
            # Hash de password
            password_hash = pwd_context.hash(row.get('password', 'password123'))
            
            alumnos_data.append({
                'rut_alumno': row['rut_alumno'].strip(),
                'nombres': row['nombres'].strip(),
                'apellidos': row['apellidos'].strip(),
                'correo': row['correo'].strip(),
                'ano_egreso': ano_egreso,
                'id_carrera': id_carrera,
                'password_hash': password_hash
            })
        except Exception as e:
            errores.append(f"Fila {idx}: {str(e)}")
    
    return alumnos_data, errores

def procesar_csv_profesores(contenido: str):
    """Procesa CSV de profesores"""
    reader = csv.DictReader(io.StringIO(contenido))
    profesores_data = []
    errores = []
    
    for idx, row in enumerate(reader, start=2):
        try:
            # Validaciones
            if not validar_rut(row.get('id_profesor', '')):
                errores.append(f"Fila {idx}: RUT inválido")
                continue
            
            id_instituto = int(row.get('id_instituto', 0))
            id_rol = int(row.get('id_rol', 0))
            
            if id_instituto < 1 or id_instituto > 7:
                errores.append(f"Fila {idx}: ID de instituto inválido (debe ser 1-7)")
                continue
            
            if id_rol < 1 or id_rol > 3:
                errores.append(f"Fila {idx}: ID de rol inválido (debe ser 1-3)")
                continue
            
            # Hash de password
            password_hash = pwd_context.hash(row.get('password', 'password123'))
            
            profesores_data.append({
                'id_profesor': row['id_profesor'].strip(),
                'nombres': row['nombres'].strip(),
                'apellidos': row['apellidos'].strip(),
                'correo': row['correo'].strip(),
                'id_instituto': id_instituto,
                'id_rol': id_rol,
                'password_hash': password_hash
            })
        except Exception as e:
            errores.append(f"Fila {idx}: {str(e)}")
    
    return profesores_data, errores

def procesar_csv_registros(contenido: str):
    """Procesa CSV de registros de actividades"""
    reader = csv.DictReader(io.StringIO(contenido))
    registros_data = []
    errores = []
    
    for idx, row in enumerate(reader, start=2):
        try:
            # Validaciones
            rut_alumno = row.get('rut_alumno', '').strip()
            if not validar_rut(rut_alumno):
                errores.append(f"Fila {idx}: RUT de alumno inválido")
                continue
            
            # Validar id_profesor (puede ser RUT o número)
            id_profesor = row.get('id_profesor', '').strip()
            if not id_profesor:
                errores.append(f"Fila {idx}: ID de profesor es requerido")
                continue
            
            # Validar id_actividad
            id_actividad = int(row.get('id_actividad', 0))
            if id_actividad < 1:
                errores.append(f"Fila {idx}: ID de actividad inválido")
                continue
            
            # Validar horas_totales
            horas_totales = int(row.get('horas_totales', 0))
            if horas_totales < 1:
                errores.append(f"Fila {idx}: Horas totales debe ser mayor a 0")
                continue
            
            # Validar estado (opcional, por defecto 1 = pendiente)
            id_estado = int(row.get('id_estado', 1))
            
            # Fechas en formato YYYY-MM-DD
            fecha_inicio = row.get('fecha_inicio_actividad', '').strip()
            fecha_termino = row.get('fecha_termino_actividad', '').strip()
            
            if not fecha_inicio or not fecha_termino:
                errores.append(f"Fila {idx}: Fechas de inicio y término son requeridas")
                continue
            
            registro_data = {
                'id_alumno': rut_alumno,
                'id_profesor': id_profesor,
                'id_actividad': id_actividad,
                'id_estado': id_estado,
                'fecha_inicio_actividad': fecha_inicio,
                'fecha_termino_actividad': fecha_termino,
                'horas_totales': horas_totales,
                'comentario': row.get('comentario', '').strip(),
                'dato1': row.get('dato1', '').strip() if row.get('dato1') else None,
                'dato2': row.get('dato2', '').strip() if row.get('dato2') else None,
                'dato3': row.get('dato3', '').strip() if row.get('dato3') else None
            }
            
            registros_data.append(registro_data)
            
        except ValueError as e:
            errores.append(f"Fila {idx}: Error de conversión de datos - {str(e)}")
        except Exception as e:
            errores.append(f"Fila {idx}: {str(e)}")
    
    return registros_data, errores