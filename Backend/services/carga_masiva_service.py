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