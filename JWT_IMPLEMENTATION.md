# Sistema RAEC - Autenticación JWT Implementada

## Descripción
Este sistema ahora cuenta con autenticación completa basada en JWT (JSON Web Tokens) que permite asociar automáticamente los registros del formulario con el profesor que inició sesión.

## Cambios Implementados

### Backend
1. **Autenticación JWT**: Se agregó `python-jose` para el manejo de tokens JWT
2. **Middleware de autenticación**: Nuevo archivo `core/auth.py` con funciones para crear y verificar tokens
3. **Login mejorado**: El endpoint de login ahora retorna un token JWT junto con los datos del profesor
4. **Endpoint protegido**: El formulario ahora requiere autenticación y obtiene automáticamente el ID del profesor desde el token
5. **Asociación automática**: Los registros se guardan con el ID del profesor autenticado (ya no el ID fijo = 1)

### Frontend
1. **Contexto de autenticación**: Sistema completo de manejo de estado de autenticación
2. **Almacenamiento de tokens**: Los tokens se guardan en localStorage y se envían automáticamente
3. **Rutas protegidas**: El formulario solo es accesible después del login
4. **Interceptor de peticiones**: Todas las peticiones HTTP incluyen automáticamente el token de autorización
5. **Manejo de sesiones**: Logout automático cuando el token expira

## Estructura de Archivos Nuevos/Modificados

### Backend:
- `core/auth.py` - Utilidades JWT y middleware de autenticación
- `services/profesores_service.py` - Modificado para generar tokens JWT
- `routes/formulario.py` - Modificado para requerir autenticación
- `services/formulario_service.py` - Modificado para recibir ID del profesor autenticado
- `requirements.txt` - Agregada dependencia `python-jose[cryptography]`

### Frontend:
- `src/AuthContext.jsx` - Contexto React para manejo de autenticación
- `src/utils/api.js` - Utilidades para peticiones HTTP autenticadas
- `src/ProtectedRoute.jsx` - Componente para rutas protegidas
- `src/RegistroFormulario.jsx` - Componente separado para el formulario
- `src/Login.jsx` - Modificado para usar el contexto de autenticación
- `src/App.jsx` - Reestructurado para manejar rutas y autenticación

## Cómo Funciona

1. **Login**: 
   - El profesor ingresa correo y contraseña
   - Si es válido, el backend genera un token JWT con el ID del profesor
   - El frontend guarda el token y los datos del usuario

2. **Navegación**:
   - El usuario autenticado es redirigido al formulario
   - Las rutas están protegidas - sin token válido se redirige al login

3. **Envío de formulario**:
   - Todas las peticiones incluyen automáticamente el token en el header Authorization
   - El backend extrae el ID del profesor del token
   - El registro se guarda asociado al profesor autenticado

4. **Seguridad**:
   - Los tokens expiran automáticamente (30 minutos por defecto)
   - Si el token expira, el usuario es redirigido al login
   - No es posible acceder al formulario sin autenticación válida

## Instrucciones de Uso

### 1. Instalar dependencias del backend:
```bash
cd Backend
pip install -r requirements.txt
```

### 2. Instalar dependencias del frontend:
```bash
cd Frontend/RAEC
npm install
```

### 3. Ejecutar el backend:
```bash
cd Backend
uvicorn main_backend:app --reload
```

### 4. Ejecutar el frontend:
```bash
cd Frontend/RAEC
npm run dev
```

### 5. Usar el sistema:
1. Ir a `http://localhost:5173`
2. Iniciar sesión con credenciales de profesor
3. Completar y enviar formularios
4. Los registros se asociarán automáticamente al profesor autenticado

## Configuración de Seguridad

### Producción:
- Usar variables de entorno para la clave secreta jwt
- Configurar HTTPS para el transporte seguro de tokens
- Ajustar el tiempo de expiración según necesidades

### Desarrollo:
- El sistema está configurado con una clave de prueba
- Los tokens expiran en 30 minutos por defecto
- CORS configurado para localhost:5173 (Vite)

## Flujo de Datos

```
1. Login → Backend genera JWT con ID profesor → Frontend guarda token
2. Formulario → Frontend envía token → Backend extrae ID profesor → Guarda registro asociado
3. Expiración → Frontend detecta 401 → Redirige a login automáticamente
```