/**
 * Utilidades para manejo de autenticación y tokens
 */

/**
 * Decodifica un JWT sin verificar la firma (solo lectura del payload)
 * IMPORTANTE: Esto es solo para leer datos del token en el frontend.
 * La verificación real de seguridad SIEMPRE se hace en el backend.
 */
export const decodeToken = (token) => {
  try {
    if (!token) return null;
    
    // El token JWT tiene 3 partes separadas por puntos: header.payload.signature
    const parts = token.split('.');
    if (parts.length !== 3) return null;
    
    // Decodificamos el payload (segunda parte)
    const payload = parts[1];
    
    // Reemplazamos caracteres URL-safe de base64
    const base64 = payload.replace(/-/g, '+').replace(/_/g, '/');
    
    // Decodificamos de base64
    const decoded = decodeURIComponent(
      atob(base64)
        .split('')
        .map((c) => '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2))
        .join('')
    );
    
    return JSON.parse(decoded);
  } catch (error) {
    console.error('Error decodificando token:', error);
    return null;
  }
};

/**
 * Verifica si el token ha expirado
 */
export const isTokenExpired = (token) => {
  try {
    const decoded = decodeToken(token);
    if (!decoded || !decoded.exp) return true;
    
    // exp viene en segundos, Date.now() en milisegundos
    const expirationTime = decoded.exp * 1000;
    return Date.now() >= expirationTime;
  } catch (error) {
    return true;
  }
};

/**
 * Obtiene el tipo de usuario del token (profesor/estudiante)
 */
export const getUserTypeFromToken = (token) => {
  const decoded = decodeToken(token);
  return decoded?.type || null;
};

/**
 * Obtiene el rol del usuario desde localStorage
 * Para académicos: retorna el id_rol (1, 2 o 3)
 * Para estudiantes: retorna null
 */
export const getUserRole = () => {
  try {
    const userData = localStorage.getItem('user_data');
    if (!userData) return null;
    
    const user = JSON.parse(userData);
    return user?.id_rol || null;
  } catch (error) {
    return null;
  }
};

/**
 * Verifica si el usuario tiene un rol específico
 */
export const hasRole = (requiredRole) => {
  const userRole = getUserRole();
  if (Array.isArray(requiredRole)) {
    return requiredRole.includes(userRole);
  }
  return userRole === requiredRole;
};

/**
 * Verifica si el usuario es estudiante
 */
export const isStudent = () => {
  const userType = localStorage.getItem('user_type');
  return userType === 'estudiante';
};

/**
 * Verifica si el usuario es académico (cualquier tipo)
 * Incluye: profesores, directores, administradores y super administradores
 */
export const isAcademic = () => {
  const userType = localStorage.getItem('user_type');
  return userType === 'profesor' || userType === 'academico' || userType === 'director' || userType === 'admin' || userType === 'super_admin';
};

/**
 * Verifica si el usuario es administrador
 */
export const isAdmin = () => {
  try {
    const userData = localStorage.getItem('user_data');
    if (!userData) return false;
    
    const user = JSON.parse(userData);
    return user?.id_rol === 3 || user?.isAdmin === true;
  } catch (error) {
    return false;
  }
};

/**
 * Verifica si el usuario es super administrador
 */
export const isSuperAdmin = () => {
  try {
    const userData = localStorage.getItem('user_data');
    if (!userData) return false;
    
    const user = JSON.parse(userData);
    return user?.id_rol === 4;
  } catch (error) {
    return false;
  }
};

/**
 * Verifica si el usuario es director
 */
export const isDirector = () => {
  try {
    const userData = localStorage.getItem('user_data');
    if (!userData) return false;
    
    const user = JSON.parse(userData);
    return user?.id_rol === 2;
  } catch (error) {
    return false;
  }
};

/**
 * Verifica si el usuario tiene permisos de administrador, super administrador O director
 */
export const hasAdminOrDirectorRole = () => {
  return isAdmin() || isSuperAdmin() || isDirector();
};

/**
 * Limpia la sesión del usuario
 */
export const clearSession = () => {
  localStorage.removeItem('access_token');
  localStorage.removeItem('user_data');
  localStorage.removeItem('user_type');
  localStorage.removeItem('isAuthenticated');
};

/**
 * Valida la sesión completa (token válido y no expirado)
 */
export const isSessionValid = () => {
  const token = localStorage.getItem('access_token');
  const isAuth = localStorage.getItem('isAuthenticated');
  
  if (!token || !isAuth) return false;
  if (isTokenExpired(token)) {
    clearSession();
    return false;
  }
  
  return true;
};
