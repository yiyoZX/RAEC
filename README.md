# RAEC (Registro de Actividades Extracurriculares)

RAEC es un sistema web para gestionar y registrar actividades extracurriculares de estudiantes en instituciones educativas. Permite a docentes registrar, validar y generar reportes de actividades realizadas por los alumnos.

## 1. Requisitos Previos

### Para Despliegue con Docker (Recomendado)
- Git
- Docker Desktop
- Archivo `.env` (proporcionado por el equipo)

### Para Desarrollo Local
- Git
- Python 3.12+
- Node.js y npm
- PostgreSQL 17
- Archivo `.env` (proporcionado por el equipo)

## 2. Instalación

### Paso 1: Clonar el repositorio
```bash
git clone https://github.com/yiyoZX/RAEC.git
cd RAEC
```

### Paso 2: Configurar variables de entorno
- Crear un archivo `.env` en la raíz del proyecto con las variables necesarias
- **IMPORTANTE**: No publiques ni subas el `.env` al repositorio
- Los datos del `.env` serán proporcionados por el equipo


## 3. Despliegue

Con el .env proporcionado este debe ser colocado en los siguientes lugares:

```
RAEC/
├── Backend/           <-igualmente coloca el .env en la carpeta backend.
├── Frontend/RAEC/     
├── Dbase/           
├── docker-compose.yml
├── README.md 
└── .env               <-carpeta raiz del proyecto.
```

### Opción A: Docker (Recomendado) 🐳

**Ventajas:**
- Configuración automática de base de datos
- Ambiente consistente entre desarrolladores
- No requiere instalación manual de dependencias

**Error comun**
revisa si la end line sequence del archivo wait-for-postgres.sh esta en crlf o lf. si esta en crlf cambialo a lf.

**Pasos:**
```bash
# Construir las imágenes y levantar los servicios
servidor:
   docker-compose build
   docker-compose up
local:
   docker-compose -f docker-compose-local.yml up --build

# O en modo detached (segundo plano)
servidor:
   docker-compose up -d
Local:
   docker-compose -f docker-compose-local.yml up --build
```

**Acceso:**
- Frontend: http://localhost:3001
- Backend API: http://localhost:4001
- Base de datos: localhost:5001

**Comandos útiles:**
```bash
# Ver logs
docker-compose logs backend
docker-compose logs frontend

# Reiniciar un servicio específico
docker-compose restart backend

# Detener todos los servicios
docker-compose down
```

### Opción B: Desarrollo Local

**Requisitos adicionales:**
- Haber instalado PostgreSQL 17 localmente
- Node.js y Python configurados

**Paso 1: Instalar dependencias**
```bash
# Frontend (desde ./Frontend/RAEC)
cd Frontend/RAEC
npm install

# Backend (desde ./Backend)
cd ../../Backend
pip install -r requirements.txt
```

**Paso 2: Configurar base de datos**
```bash
# Crear usuario y base de datos
psql -U postgres
CREATE USER raecuser WITH PASSWORD 'tu_password';
CREATE DATABASE raecdb OWNER raecuser;
\q

# Importar datos
psql -U raecuser -d raecdb -f Dbase/init-complete.sql
```

**Paso 3: Configurar .env para desarrollo local**
```env
DATABASE_URL=postgresql://raecuser:tu_password@localhost:5432/raecdb
JWT_SECRET_KEY=tu_secret_key
JWT_ALGORITHM=HS256
JWT_ACCESS_TOKEN_EXPIRE_MINUTES=30
``` 

**Paso 4: Ejecutar servicios**
```bash
# Terminal 1: Backend
cd Backend
python -m uvicorn main_backend:app --reload --port 4001

# Terminal 2: Frontend  
cd Frontend/RAEC
npm run dev
```

**Acceso:**
- Frontend: http://localhost:3001
- Backend API: http://localhost:4001

## 4. Uso

### Acceso al Sistema
1. Abrir el navegador en http://localhost:3001
2. Iniciar sesión con las credenciales proporcionadas
3. Navegar por las diferentes secciones:
   - **Dashboard**: Vista principal del sistema
   - **Registro de Actividades**: Formulario para registrar nuevas actividades
   - **Reportes**: Generar reportes por alumno, actividad o general

### Funcionalidades Principales
- **Gestión de Usuarios**: Administración de profesores y alumnos
- **Registro de Actividades**: Documentar actividades extracurriculares
- **Generación de Reportes**: Reportes detallados y exportación CSV
- **Autenticación JWT**: Sistema seguro de login

## 5. Desarrollo

### Estructura del Proyecto
```
RAEC/
├── Backend/           # API FastAPI
├── Frontend/RAEC/     # Aplicación web con Vite
├── Dbase/            # Scripts SQL y dumps
├── docker-compose.yml # Configuración Docker
└── README.md         # Este archivo
```

### Base de Datos
El archivo `Dbase/init-complete.sql` contiene:
- Estructura completa de tablas
- Datos de prueba para desarrollo
- Configuraciones iniciales

**Tablas principales:**
- `alumno`: Información de estudiantes
- `profesor`: Información de docentes  
- `actividad`: Catálogo de actividades extracurriculares
- `registro`: Registros de actividades realizadas
- `rol`: Roles del sistema
- `instituto`: Institutos o facultades
- `periodos`: Fechas de inscripciones para alumnos

### Comandos Útiles

**Docker:**
```bash
# Reconstruir imágenes
docker-compose build --no-cache

# Ver logs específicos
docker-compose logs -f backend

# Acceder a la base de datos
docker exec -it raec-db psql -U raecuser -d raecdb

# Limpiar Docker si hay problemas
docker system prune -f
docker-compose down -v
```

**Base de datos:**
```bash
# Backup
docker exec -t raec-db pg_dump -U raecuser raecdb > backup_$(date +%Y%m%d_%H%M%S).sql

# Restaurar
docker exec -i raec-db psql -U raecuser -d raecdb < backup_file.sql
```

## 6. Contribución

- Sigue convenciones de commit (por ejemplo, Conventional Commits).
- Abre un Pull Request describiendo:
  - Qué problema resuelve
  - Consideraciones de seguridad y de migración
  - Pasos de prueba manuals
