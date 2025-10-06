import { useAuth } from '../store/AuthContext';
import { useNavigate } from 'react-router-dom';

/**
 * Layout simple con header reutilizable.
 * Props:
 *  - children: contenido principal
 *  - showBack: mostrar botón volver
 *  - backTo: ruta para volver (por defecto /dashboard)
 */
const HeaderLayout = ({ children, showBack = false, backTo = '/dashboard', title = 'RAEC' }) => {
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  return (
    <div className="bg-white min-h-screen flex flex-col">
      <header className="shadow-md py-6" style={{ backgroundColor: '#e3d3e6' }}>
        <div className="flex justify-between items-center px-8">
          <h1 className="text-black text-2xl font-bold">{title}</h1>
          <div className="flex items-center gap-3">
            {showBack && (
              <button onClick={() => navigate(backTo)} className="bg-gray-500 text-white px-4 py-2 rounded-lg shadow hover:bg-gray-600 transition font-bold border border-black">Volver</button>
            )}
            <span className="text-black text-sm">{user?.message || 'Bienvenido'}</span>
            <button onClick={handleLogout} className="bg-red-300 text-black px-4 py-2 rounded-full hover:bg-red-400 transition font-bold">Cerrar Sesión</button>
          </div>
        </div>
      </header>
      <main className="flex-grow">{children}</main>
    </div>
  );
};

export default HeaderLayout;