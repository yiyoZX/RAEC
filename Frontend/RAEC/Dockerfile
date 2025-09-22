# Dockerfile para el frontend (Vite/React)
FROM node:22-alpine

WORKDIR /app

# Copiar archivos de dependencias
COPY package.json package-lock.json /app/

# Instalar dependencias
RUN npm install

# Copiar el código fuente
COPY . /app

EXPOSE 5173

# Ejecutar en modo desarrollo con host 0.0.0.0 para Docker
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
