from passlib.hash import bcrypt
import psycopg2
from dotenv import load_dotenv
import os

# Cargar .env
load_dotenv()

# Abrir archivo de profesores
with open(os.path.join(os.path.dirname(__file__), 'Lista_alumnos.txt'), 'r', encoding='utf-8') as fichero:
    lineas = fichero.readlines()

# Conexión a PostgreSQL
conn = psycopg2.connect(
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("PASSWORD"),
    host="localhost",
    port=5432  # asegúrate que este sea tu puerto real
)
cur = conn.cursor()

for linea in lineas:
    # Datos del profesor
    datos = linea.strip().split(',')
    rut = datos[0]
    nombre = datos[1]
    apellido = datos[2]
    correo = datos[3]
    año_egreso = datos[4]
    id_carrera = datos[5]
    password = datos[6]

    # Hash con salt automático usando passlib
    password_hash = bcrypt.hash(password)

    # Insertar en la tabla
    cur.execute("""
        INSERT INTO alumno (rut_alumno, nombres, apellidos, correo, ano_egreso, id_carrera, password_hash)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """, (rut, nombre, apellido, correo, año_egreso, id_carrera, password_hash))

# Confirmar transacciones y cerrar
conn.commit()
cur.close()
conn.close()