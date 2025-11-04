import { useAuth } from '../store/AuthContext';
import { useNavigate } from 'react-router-dom';

/**
 * Layout simple con header reutilizable.
 * Props:
 *  - children: contenido principal
 *  - showBack: mostrar botón volver
 *  - backTo: ruta para volver (opcional, si no se especifica se calcula automáticamente según el rol)
 *  - title: título en el header
 *  - fullScreen: si true, el header ocupa toda la pantalla y muestra los children dentro
 *  - center: centra vertical y horizontalmente el contenido (solo en fullScreen)
 */
const HeaderLayout = ({
  children,
  showBack = false,
  backTo,  // Ya no tiene valor por defecto
  title = 'RAEC',
  fullScreen = false,
  center = false,
}) => {
  const { user, logout, userType } = useAuth();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  // Calcular la ruta de retorno según el rol del usuario
  const getBackRoute = () => {
    // Si se especificó una ruta personalizada, usarla
    if (backTo) return backTo;

    // Si no, determinar según el tipo de usuario
    if (userType === 'estudiante') {
      return '/dashboardStudent';
    } else if (user?.id_rol === 3 || user?.rol === 3 || user?.isAdmin) {
      // Administrador
      return '/dashboardAdmin';
    } else {
      // Profesor o Director (académicos en general)
      return '/dashboard';
    }
  };

  return (
    <>
      {/* Header (barra superior) con color */}
      <header
        className="shadow-md w-full"
        style={{ backgroundColor: '#e3d3e6' }}
      >
        {/* Barra superior */}
        <div className="flex justify-between items-center px-8 py-6">
          <h1 className="text-black text-2xl font-bold">{title}</h1>
          <div className="flex items-center gap-3">
            {showBack && (
              <button
                onClick={() => navigate(getBackRoute())}
                className="bg-gray-500 text-white px-4 py-2 rounded-lg shadow hover:bg-gray-600 transition font-bold border border-black"
              >
                Volver
              </button>
            )}
            <span className="text-black text-sm">{user?.message || 'Bienvenido'}</span>
            <button
              onClick={handleLogout}
              className="bg-red-300 text-black px-4 py-2 rounded-full hover:bg-red-400 transition font-bold"
            >
              Cerrar Sesión
            </button>
          </div>
        </div>
      </header>

      {/* Área de contenido con fondo blanco */}
      <main 
        className={`w-full bg-white ${fullScreen ? 'min-h-screen' : 'flex-grow min-h-screen'} ${
          center ? 'flex items-center justify-center' : ''
        }`}
      >
        {children}
      </main>
    </>
  );
};

export default HeaderLayout;