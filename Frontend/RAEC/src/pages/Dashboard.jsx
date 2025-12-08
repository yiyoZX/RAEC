import { useNavigate } from 'react-router-dom';
import { useAuth } from '../store/AuthContext';
import HeaderLayout from '../layouts/HeaderLayout';

const Dashboard = () => {
  const navigate = useNavigate();
  const { user, userType } = useAuth();

  // Determinar el rol del usuario
  const getRol = () => {
    if (userType === 'estudiante') return 'estudiante';
    if (user?.id_rol === 1) return 'profesor';
    if (user?.id_rol === 2) return 'director';
    if (user?.id_rol === 3) return 'admin';
    return null;
  };

  const rol = getRol();

  // Configuración de acciones según el rol
  const getActions = () => {
    switch (rol) {
      case 'estudiante':
        return [
          { label: 'Registrar', to: '/registroEstudiantes', icon: '✔️' },
          { label: 'Historial', to: '/reportesEstudiantes', icon: '📊' },
        ];
      
      case 'profesor':
        return [
          { label: 'Registrar', to: '/registrar', icon: '✔️' },
          { label: 'Reportes', to: '/reportesAcademicos', icon: '📊' },
        ];
      
      case 'director':
        return [
          { label: 'Registrar', to: '/registrar', icon: '✔️' },
          { label: 'Solicitudes', to: '/solicitudes', icon: '👥' },
          { label: 'Reportes', to: '/reportesAcademicos', icon: '📊' },
          { label: 'Cambiar Rol', to: '/CambiarRol', icon: '🔄' },
        ];
      
      case 'admin':
        return [
          { label: 'Registrar', to: '/registrar', icon: '✔️' },
          { label: 'Solicitudes', to: '/solicitudes', icon: '👥' },
          { label: 'Reportes', to: '/reportesAcademicos', icon: '📊' },
          { label: 'Crear categoría', to: '/crear', icon: '🧾' },
          { label: 'Activar periodos', to: '/periodos', icon: '📅' },
          { label: 'Cambiar Rol', to: '/CambiarRol', icon: '🔄' },
          { label: 'Carga masiva', to: '/carga-masiva', icon: '📥' },
        ];
      
      default:
        return [];
    }
  };

  const actions = getActions();

  // Título según el rol
  const getTitle = () => {
    switch (rol) {
      case 'estudiante':
        return 'RAEC - Estudiantes';
      case 'profesor':
        return 'RAEC - Profesor';
      case 'director':
        return 'RAEC - Director';
      case 'admin':
        return 'RAEC - Administrador';
      default:
        return 'RAEC';
    }
  };

  return (
    <HeaderLayout fullScreen title={getTitle()}>
      {/* Contenedor centrado */}
      <div className="w-full max-w-6xl mx-auto px-8 py-12">
        <div className="mb-12 text-center">
          <h1 className="text-4xl font-bold text-gray-900 mb-2">¡Bienvenido!</h1>
          <p className="text-gray-600 text-lg">Por favor selecciona una opción:</p>
        </div>

        {/* Botones */}
        <div className="flex flex-row flex-wrap gap-6 justify-center">
          {actions.map((action) => (
            <button
              key={action.to}
              onClick={() => navigate(action.to)}
              className="bg-blue-600 hover:bg-blue-700 text-white rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 p-8 flex flex-col items-center justify-center gap-4 w-64 h-64 text-2xl font-semibold"
            >
              <span className="text-5xl">{action.icon}</span>
              <span>{action.label}</span>
            </button>
          ))}
        </div>
      </div>
    </HeaderLayout>
  );
};

export default Dashboard;
