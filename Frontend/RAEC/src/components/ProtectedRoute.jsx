import { Navigate } from 'react-router-dom';
import { useAuth } from '../store/AuthContext';
import { isSessionValid, isStudent, isAdmin, isDirector, hasAdminOrDirectorRole } from '../utils/auth';
import { useEffect } from 'react';

/**
 * ProtectedRoute - Componente de guarda de rutas con validación de roles
 * 
 * @param {React.ReactNode} children - Componente hijo a renderizar si tiene permisos
 * @param {Array<string>|string} allowedRoles - Roles permitidos: 'estudiante', 'academico', 'director', 'admin'
 * @param {boolean} requireAdmin - Si es true, solo permite administradores
 * @param {boolean} requireAdminOrDirector - Si es true, permite administradores y directores
 */
function ProtectedRoute({ 
  children, 
  allowedRoles = null, 
  requireAdmin = false,
  requireAdminOrDirector = false 
}) {
  const { isAuthenticated, loading, userType, logout } = useAuth();

  // Validar sesión en cada renderizado
  useEffect(() => {
    if (!loading && !isSessionValid()) {
      logout();
    }
  }, [loading, logout]);

  // Mostrar loading mientras se verifica la autenticación
  if (loading) {
    return (
      <div className="flex items-center justify-center h-screen">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-gray-600">Verificando permisos...</p>
        </div>
      </div>
    );
  }

  // Si no está autenticado, redirigir al login
  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }

  // Si la sesión expiró, redirigir al login
  if (!isSessionValid()) {
    logout();
    return <Navigate to="/login" replace />;
  }

  // Validación específica de administrador
  if (requireAdmin && !isAdmin()) {
    console.warn('Acceso denegado: Se requiere rol de administrador');
    // Redirigir según el tipo de usuario
    if (isStudent()) {
      return <Navigate to="/dashboardStudent" replace />;
    }
    return <Navigate to="/dashboard" replace />;
  }

  // Validación de administrador o director
  if (requireAdminOrDirector && !hasAdminOrDirectorRole()) {
    console.warn('Acceso denegado: Se requiere rol de administrador o director');
    if (isStudent()) {
      return <Navigate to="/dashboardStudent" replace />;
    }
    return <Navigate to="/dashboard" replace />;
  }

  // Validación de roles específicos
  if (allowedRoles) {
    const roles = Array.isArray(allowedRoles) ? allowedRoles : [allowedRoles];
    let hasPermission = false;

    for (const role of roles) {
      switch (role) {
        case 'estudiante':
          if (isStudent()) hasPermission = true;
          break;
        case 'academico':
          if (userType === 'profesor' || userType === 'academico') hasPermission = true;
          break;
        case 'director':
          if (isDirector()) hasPermission = true;
          break;
        case 'admin':
          if (isAdmin()) hasPermission = true;
          break;
        default:
          console.warn(`Rol desconocido: ${role}`);
      }
      
      if (hasPermission) break;
    }

    if (!hasPermission) {
      console.warn(`Acceso denegado: Se requiere uno de los roles: ${roles.join(', ')}`);
      
      // Redirigir a la página apropiada según el tipo de usuario
      if (isStudent()) {
        return <Navigate to="/dashboardStudent" replace />;
      } else if (isAdmin()) {
        return <Navigate to="/dashboardAdmin" replace />;
      } else {
        return <Navigate to="/dashboard" replace />;
      }
    }
  }

  // Si pasa todas las validaciones, renderizar el componente
  return children;
}

export default ProtectedRoute;