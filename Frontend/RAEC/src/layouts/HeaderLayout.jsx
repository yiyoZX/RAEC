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

    // 2. Caso Super Admin (rol 4)
    const rolId = Number(user.id_rol || user.rol);
    if (type === 'super_admin' || rolId === 4) {
      return 'Super Administrador';
    }

    // 3. Caso Admin (por tipo o rol 3)
    if (type === 'admin' || type === 'administrador' || rolId === 3) {
      return 'Administrador';
    }

    // 4. Casos Académicos Específicos
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
                <div 
                  className="absolute right-0 mt-2 w-64 z-50 animate-fade-in-down origin-top-right bg-white shadow-xl rounded-lg overflow-hidden"
                >
                  <div className="flex flex-col"> 
                    
                    {/* Cabecera Móvil */}
                    <div className="px-5 py-3 bg-gray-200 md:hidden border-b border-gray-300">
                      <span className="text-xs text-gray-600 font-bold uppercase tracking-wider">
                        {getUserRoleLabel()}
                      </span>
                    </div>

                
                    {navOptions.map((opt, index) => (
                      <button
                        key={index}
                        type="button" 
                        onClick={() => {
                          setIsMenuOpen(false);
                          navigate(opt.path);
                        }}
                        className="block w-full text-left px-5 py-3 transition-colors duration-200 border-b border-blue-400 last:border-0 focus:outline-none !rounded-none !bg-[#4a90e2] hover:!bg-[#357abd] !text-white !font-bold !m-0"
                      >
                        {opt.label}
                      </button>
                    ))}

                    
                    <button
                      onClick={handleLogout}
                      type="button"
                  
                      className="block w-full text-left px-5 py-4 transition-colors duration-200 group !rounded-none !bg-gray-300 hover:!bg-gray-400 !text-gray-700 !font-bold !m-0"
                    >
                      <div className="flex items-center gap-3">
                        <svg 
                         
                          className="w-5 h-5 text-gray-500 group-hover:text-red-600 transition-colors duration-200" 
                          fill="none" 
                          stroke="currentColor" 
                          viewBox="0 0 24 24"
                        >
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                        </svg>
                        <span className="group-hover:text-red-700 transition-colors">Cerrar Sesión</span>
                      </div>
                    </button>
                  </div>
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