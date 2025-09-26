# Dockerfile para el backend (Python)
FROM python:3.12-alpine

WORKDIR /app

# Instalar dependencias del sistema necesarias
RUN apk add --no-cache postgresql-client

# Copiar requirements y script de espera
COPY requirements.txt /app/requirements.txt
COPY wait-for-postgres.sh /wait-for-postgres.sh

# Instalar dependencias de Python
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt \
    && chmod +x /wait-for-postgres.sh

# Copiar el código fuente
COPY . /app

EXPOSE 4001

# Esperar a que la base de datos esté lista antes de arrancar Uvicorn
CMD ["/wait-for-postgres.sh", "db", "uvicorn", "main_backend:app", "--host", "0.0.0.0", "--port", "4001"]