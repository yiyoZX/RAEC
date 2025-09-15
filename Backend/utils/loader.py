from passlib.hash import bcrypt
import psycopg2
from dotenv import load_dotenv
import os

# Cargar .env
load_dotenv()

# Abrir archivo de profesores
with open(os.path.join(os.path.dirname(__file__), 'Lista.txt'), 'r', encoding='utf-8') as fichero:
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
    datos = linea.strip().split(', ')
    nombre = datos[0]
    apellido = datos[1]
    correo = datos[2]
    password = datos[3]
    id_instituto = datos[4]
    id_rol = datos[5]

    # Hash con salt automático usando passlib
    password_hash = bcrypt.hash(password)

    # Insertar en la tabla
    cur.execute("""
        INSERT INTO Profesores (nombres, apellidos, correo, password_hash, id_instituto, id_rol)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (nombre, apellido, correo, password_hash, id_instituto, id_rol))

# Confirmar transacciones y cerrar
conn.commit()
cur.close()
conn.close()
