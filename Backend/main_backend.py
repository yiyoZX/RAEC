from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from core.database import database, metadata, DATABASE_URL
from sqlalchemy import create_engine
from routes.profesores import router as profesores_router
from routes.formulario import router as formulario_router
from routes.reportes import router as reportes_router
from routes.solicitudes import router as solicitud_router
from routes.actividades import router as actividades_router
from fastapi.staticfiles import StaticFiles
from sqlalchemy.orm import Session
from contextlib import asynccontextmanager
from core.reparar_secuencias import reparar_secuencias

# Crear base de datos y conectar
engine = create_engine(DATABASE_URL)
metadata.create_all(engine)

@asynccontextmanager
async def lifespan(app: FastAPI):
    """Maneja la conexión y desconexión del sistema al iniciar y cerrar FastAPI."""
    # 🔹 Conectar base de datos asíncrona
    await database.connect()
    
    # 🔹 Reparar secuencias al iniciar
    db = Session(bind=engine)  # Crear sesión con el engine
    try:
        reparar_secuencias(db)
    finally:
        db.close()

    # 🔹 Devolver el control a la app
    yield

    # 🔹 Desconectar base de datos al apagar
    await database.disconnect()


app = FastAPI(lifespan=lifespan)
app.mount("/exports", StaticFiles(directory="exports"), name="exports")

# Configurar CORS para permitir solo el frontend
origins = [
    "http://localhost:3001",  # Frontend actual
    "http://127.0.0.1:3001",
    "http://localhost:5173",  # Vite por defecto
    "http://127.0.0.1:5173"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(profesores_router)
app.include_router(formulario_router)
app.include_router(reportes_router)
app.include_router(solicitud_router)
app.include_router(actividades_router)


