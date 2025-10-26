import { useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { useAuth } from '../store/AuthContext';
import { isSessionValid, isStudent, isAdmin, isDirector, isAcademic } from '../utils/auth';

/**
 * RouteGuard - Componente que valida permisos en cada cambio de ruta
 * Se ejecuta globalmente para todas las rutas
 */
export const RouteGuard = ({ children }) => {
  const location = useLocation();
  const navigate = useNavigate();
  const { isAuthenticated, logout } = useAuth();

  useEffect(() => {
    const currentPath = location.pathname;
    
    // Rutas públicas que no requieren autenticación
    const publicRoutes = ['/login', '/loginStudent', '/'];
    
    if (publicRoutes.includes(currentPath)) {
      return; // No validar rutas públicas
    }

    // Validar sesión
    if (!isAuthenticated || !isSessionValid()) {
      console.warn('Sesión inválida, redirigiendo al login...');
      logout();
      navigate('/login', { replace: true });
      return;
    }

    // Configuración de permisos por ruta
    const routePermissions = {
      // Rutas exclusivas de estudiantes
      '/dashboardStudent': { type: 'estudiante' },
      '/registroEstudiantes': { type: 'estudiante' },
      '/reportesEstudiantes': { type: 'estudiante' },
      
      // Rutas de académicos (profesor, director, admin)
      '/dashboard': { types: ['academico', 'director', 'admin'] },
      '/crear': { types: ['academico', 'director', 'admin'] },
      '/reportesAcademicos': { types: ['academico', 'director', 'admin'] },
      
      // Rutas de administración (solo admin y director)
      '/dashboardAdmin': { types: ['director', 'admin'] },
      '/registrar': { types: ['director', 'admin'] },
    };

    const routeConfig = routePermissions[currentPath];
    
    if (!routeConfig) {
      // Ruta sin restricciones o no configurada
      return;
    }

    let hasAccess = false;

    // Verificar acceso según configuración
    if (routeConfig.type) {
      // Ruta con un solo tipo permitido
      hasAccess = checkUserType(routeConfig.type);
    } else if (routeConfig.types) {
      // Ruta con múltiples tipos permitidos
      hasAccess = routeConfig.types.some(type => checkUserType(type));
    }

    // Si no tiene acceso, redirigir a su dashboard correspondiente
    if (!hasAccess) {
      console.warn(`❌ Acceso denegado a ${currentPath}`);
      redirectToUserDashboard();
    } else {
      console.log(`✅ Acceso permitido a ${currentPath}`);
    }
  }, [location.pathname, isAuthenticated, logout, navigate]);

  /**
   * Verifica si el usuario actual cumple con el tipo requerido
   */
  const checkUserType = (type) => {
    switch (type) {
      case 'estudiante':
        return isStudent();
      case 'academico':
        return isAcademic() && !isDirector() && !isAdmin();
      case 'director':
        return isDirector();
      case 'admin':
        return isAdmin();
      default:
        return false;
    }
  };

  /**
   * Redirige al dashboard apropiado según el tipo de usuario
   */
  const redirectToUserDashboard = () => {
    if (isStudent()) {
      navigate('/dashboardStudent', { replace: true });
    } else if (isAdmin() || isDirector()) {
      navigate('/dashboardAdmin', { replace: true });
    } else if (isAcademic()) {
      navigate('/dashboard', { replace: true });
    } else {
      logout();
      navigate('/login', { replace: true });
    }
  };

  return children;
};

export default RouteGuard;
