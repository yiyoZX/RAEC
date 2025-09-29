
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from core.database import database, metadata, DATABASE_URL
from sqlalchemy import create_engine
from routes.profesores import router as profesores_router
from routes.formulario import router as formulario_router
from routes.reportes import router as reportes_router
from fastapi.staticfiles import StaticFiles


# Crear base de datos y conectar
engine = create_engine(DATABASE_URL)
metadata.create_all(engine)

@asynccontextmanager
async def lifespan(app: FastAPI):
    await database.connect()
    yield
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

