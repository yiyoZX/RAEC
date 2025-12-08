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
  const { isAuthenticated, logout, loading } = useAuth();

  useEffect(() => {
    const currentPath = location.pathname;
    
    // Rutas públicas que no requieren autenticación
    const publicRoutes = ['/login', '/loginStudent', '/'];
    
    if (publicRoutes.includes(currentPath)) {
      return; // No validar rutas públicas
    }

    // Esperar a que termine de cargar antes de validar
    if (loading) {
      return; // No hacer nada mientras está cargando
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
      '/dashboard': { types: ['profesor', 'director', 'admin', 'academico'] },
      '/crear': { types: ['profesor', 'academico', 'director', 'admin'] },
      '/reportesAcademicos': { types: ['profesor', 'academico', 'director', 'admin'] },
      '/registrar': { types: ['profesor', 'academico', 'director', 'admin'] },  // Todos los académicos pueden registrar
      '/solicitudes': { types: ['profesor', 'academico', 'director', 'admin'] },  // Todos los académicos pueden ver solicitudes
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
  }, [location.pathname, isAuthenticated, loading, logout, navigate]);

  /**
   * Verifica si el usuario actual cumple con el tipo requerido
   */
  const checkUserType = (type) => {
    switch (type) {
      case 'estudiante':
        return isStudent();
      case 'profesor':
        // Profesor normal (rol 1) - no es director ni admin
        return isAcademic() && !isDirector() && !isAdmin();
      case 'academico':
        // Cualquier académico (profesor, director o admin)
        return isAcademic();
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
      navigate('/dashboard', { replace: true });
    } else if (isAcademic()) {
      navigate('/dashboard', { replace: true });
    } else {
      logout();
      navigate('/login', { replace: true });
    }
  };

  // Mostrar pantalla de carga mientras se verifica la autenticación
  if (loading) {
    const currentPath = location.pathname;
    const publicRoutes = ['/login', '/loginStudent', '/'];
    
    // No mostrar loading en rutas públicas
    if (publicRoutes.includes(currentPath)) {
      return children;
    }
    
    return (
      <div className="flex items-center justify-center h-screen bg-gray-50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-16 w-16 border-b-4 border-blue-600 mx-auto mb-4"></div>
          <p className="text-gray-600 text-lg">Verificando sesión...</p>
        </div>
      </div>
    );
  }

  return children;
};

export default RouteGuard;
