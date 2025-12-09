import { useState, useRef, useEffect } from 'react';
import { useAuth } from '../store/AuthContext';
import { useNavigate } from 'react-router-dom';
import { getMenuForUser } from '../config/navigationConfig';

const HeaderLayout = ({
  children,
  showBack = false,
  backTo,
  title = 'RAEC',
  fullScreen = false,
  center = false,
}) => {
  const { user, logout, userType } = useAuth();
  const navigate = useNavigate();
  
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const menuRef = useRef(null);

  const navOptions = getMenuForUser(user, userType);

  // --- LÓGICA PARA ETIQUETA DE ROL ---
  const getUserRoleLabel = () => {
    if (!user) return '';

    // Normalizamos a minúsculas para comparar seguro
    const type = userType ? userType.toLowerCase() : '';

    // 1. Caso Estudiante
    if (type === 'estudiante') return 'Estudiante';

    // 2. Caso Admin (por tipo o rol 3)
    const rolId = Number(user.id_rol || user.rol);
    if (type === 'admin' || type === 'administrador' || rolId === 3) {
      return 'Administrador';
    }

    // 3. Casos Académicos Específicos
    if (rolId === 2) return 'Director de Escuela';
    if (rolId === 1) return 'Profesor';

    // Fallback genérico (por si acaso)
    return 'Usuario';
  };

  const handleLogout = () => {
    setIsMenuOpen(false);
    logout();
    navigate('/login');
  };

  const getBackRoute = () => {
    if (backTo) return backTo;
    return '/dashboard';
  };

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (menuRef.current && !menuRef.current.contains(event.target)) {
        setIsMenuOpen(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  return (
    <>
      <header
        className="shadow-md w-full relative z-50"
        style={{ backgroundColor: '#D4A574' }}
      >
        <div className="flex justify-between items-center px-8 py-4"> {/* Ajusté py-6 a py-4 para que no quede gigante con las 2 líneas */}
          
          {/* Título (Izquierda) */}
          <h1 className="text-black text-2xl font-bold">{title}</h1>
          
          <div className="flex items-center gap-4">
            {showBack && (
              <button
                onClick={() => navigate(getBackRoute())}
                className="bg-gray-500 text-white px-4 py-2 rounded-lg shadow hover:bg-gray-600 transition font-bold border border-black text-sm"
              >
                Volver
              </button>
            )}

            {/* --- MENÚ DESPLEGABLE --- */}
            <div className="relative" ref={menuRef}>
              <button
                onClick={() => setIsMenuOpen(!isMenuOpen)}
                className="flex items-center gap-3 focus:outline-none text-black hover:text-gray-800 transition group"
              >
                {/* BLOQUE DE TEXTO: NOMBRE + ROL */}
                <div className="flex flex-col items-end leading-tight">
                    <span className="font-bold text-sm md:text-base">
                        {user?.message || user?.nombres || 'Usuario'}
                    </span>
                    {/* Aquí mostramos el ROL debajo del nombre */}
                    <span className="text-xs font-medium text-gray-600 uppercase tracking-wide group-hover:text-gray-800">
                        {getUserRoleLabel()}
                    </span>
                </div>

                <svg 
                  className={`w-5 h-5 transition-transform ${isMenuOpen ? 'rotate-180' : ''}`} 
                  fill="none" stroke="currentColor" viewBox="0 0 24 24"
                >
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                </svg>
              </button>

              {isMenuOpen && (
                <div className="absolute right-0 mt-3 w-56 bg-white rounded-md shadow-lg py-1 border border-gray-200 animate-fade-in-down origin-top-right">
                  
                  {/* Cabecera del menú (Opcional: Repetir rol aquí también si se desea) */}
                  <div className="px-4 py-2 border-b border-gray-100 md:hidden bg-gray-50">
                     <span className="text-xs text-gray-500 font-bold uppercase">{getUserRoleLabel()}</span>
                  </div>

                  {navOptions.map((opt, index) => (
                    <button
                      key={index}
                      onClick={() => {
                        setIsMenuOpen(false);
                        navigate(opt.path);
                      }}
                      className="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-purple-50 hover:text-purple-700 transition-colors"
                    >
                      {opt.label}
                    </button>
                  ))}

                  <div className="border-t border-gray-100 my-1"></div>

                  <button
                    onClick={handleLogout}
                    className="block w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-red-50 hover:text-red-700 font-medium transition-colors"
                  >
                    <div className="flex items-center gap-2">
                        <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" /></svg>
                        Cerrar Sesión
                    </div>
                  </button>
                </div>
              )}
            </div>
          </div>
        </div>
      </header>

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