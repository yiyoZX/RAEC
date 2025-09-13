
from contextlib import asynccontextmanager
from fastapi import FastAPI
from core.database import database, metadata, DATABASE_URL
from sqlalchemy import create_engine
from routes.profesores import router as profesores_router

app = FastAPI()

# Crear base de datos y conectar
engine = create_engine(DATABASE_URL)
metadata.create_all(engine)

@asynccontextmanager
async def lifespan(app: FastAPI):
    await database.connect()
    yield
    await database.disconnect()

app = FastAPI(lifespan=lifespan)
app.include_router(profesores_router)

