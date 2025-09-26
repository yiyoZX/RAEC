# RAEC (Registro de Actividades Extracurriculares)

RAEC es un sistema web para gestionar y registrar actividades extracurriculares de estudiantes en instituciones educativas. Permite a docentes registrar, validar y generar reportes de actividades realizadas por los alumnos.

## 1. Instalación / Requisitos

Requisitos generales:
- Git
- Python 3.12
- Node y vite
- PostgreSQL:17
- Opcional: Docker Desktop (para ejecución con contenedores)


Pasos:
1) Clonar el repositorio 
   - Terminal (PowerShell):
     - git clone https://https://github.com/yiyoZX/RAEC/tree/main.git
     - cd RAEC
   - Se pueden usar otros metodos como github desktop

2) Variables de entorno
   - Crear un archivo .env en la raíz del proyecto con las variables necesarias.
   - No publiques ni subas el .env al repositorio.
   - Los Datos del .env seran proporcionados

3) Instalar dependencias
   - Node.js:
     - npm install
   - Python (ejemplo):
     - py -m venv .venv
     - .\.venv\Scripts\Activate.ps1
     - pip install -r requirements.txt

4) Base de datos
    - Importar la base de datos con el dumb.

Docker: si se ocupa docker se puede usar:
- Docker-compose build
- Docker-compose up
Con esto el proyecto deberia estar levantado
   

## 3. Uso

Entorno de desarrollo:
Para inicializar:
- Node.js:
  - npm run dev
- Python:
    En windows:
  - python -m uvicorn main_backend:app --reload
    En linux:
  - uvicorn main_backend:app --reload

Accede a la URL que muestre la terminal (por ejemplo, http://localhost:3000 o similar).

## 4. Despliegue

Opciones comunes:
  Docker: si se ocupa docker se puede usar:
    - Docker-compose build
    - Docker-compose up
con esto el proyecto deberia estar levantado

## 5. Contribución

- Sigue convenciones de commit (por ejemplo, Conventional Commits).
- Abre un Pull Request describiendo:
  - Qué problema resuelve
  - Consideraciones de seguridad y de migración
  - Pasos de prueba manual