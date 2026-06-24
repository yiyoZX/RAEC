import { useNavigate } from 'react-router-dom';
import { useAuth } from '../store/AuthContext';
import HeaderLayout from '../layouts/HeaderLayout';
import registroIcon from '../assets/Registro.png';
import reportesIcon from '../assets/Reportes (2).png';
import solicitudesIcon from '../assets/Solicitudes.png';
import crearCategoriaIcon from '../assets/Crear_categoria.png';
import periodosIcon from '../assets/Periodos.png';
import cambiarRolIcon from '../assets/Cambiar_rol.png';
import cargaMasivaIcon from '../assets/Carga_masiva.png';

const Dashboard = () => {
  const navigate = useNavigate();
  const { user, userType } = useAuth();

  // Determinar el rol del usuario
  const getRol = () => {
    if (userType === 'estudiante') return 'estudiante';
    if (user?.id_rol === 1) return 'profesor';
    if (user?.id_rol === 2) return 'director';
    if (user?.id_rol === 3) return 'admin';
    if (user?.id_rol === 4) return 'Super Admin';
    return null;
  };

  const rol = getRol();

  // Configuración de acciones según el rol
  const getActions = () => {
    switch (rol) {
      case 'estudiante':
        return [
          { label: 'Registrar actividad extracurricular', to: '/registroEstudiantes', icon: registroIcon },
          { label: 'Historial', to: '/reportesEstudiantes', icon: reportesIcon },
        ];
      
      case 'profesor':
        return [
          { label: 'Registrar actividad cosas que probar', to: '/registrar', icon: registroIcon },
          { label: 'Reportes de actividades', to: '/reportesAcademicos', icon: reportesIcon },
        ];
      
      case 'director':
        return [
          { label: 'Registrar actividad extracurricular', to: '/registrar', icon: registroIcon },
          { label: 'Solicitudes de estudiantes', to: '/solicitudes', icon: solicitudesIcon },
          { label: 'Reportes de actividades', to: '/reportesAcademicos', icon: reportesIcon },
        ];
      
      case 'admin':
        return [
          { label: 'Registrar actividad extracurricular', to: '/registrar', icon: registroIcon },
          { label: 'Solicitudes de estudiantes', to: '/solicitudes', icon: solicitudesIcon },
          { label: 'Reportes de actividades', to: '/reportesAcademicos', icon: reportesIcon },
          { label: 'Crear categoría de actividad', to: '/crear', icon: crearCategoriaIcon },
          { label: 'Activar periodos de inscripción', to: '/periodos', icon: periodosIcon },
          { label: 'Carga masiva', to: '/carga-masiva', icon: cargaMasivaIcon },
        ];
      
      case 'Super Admin':
        return [
          { label: 'Registrar actividad extracurricular', to: '/registrar', icon: registroIcon },
          { label: 'Solicitudes de estudiantes', to: '/solicitudes', icon: solicitudesIcon },
          { label: 'Reportes de actividades', to: '/reportesAcademicos', icon: reportesIcon },
          { label: 'Crear categoría de actividad', to: '/crear', icon: crearCategoriaIcon },
          { label: 'Activar periodos de inscripción', to: '/periodos', icon: periodosIcon },
          { label: 'Cambiar Rol', to: '/CambiarRol', icon: cambiarRolIcon },
          { label: 'Carga masiva', to: '/carga-masiva', icon: cargaMasivaIcon },
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
      case 'Super Admin':
        return 'RAEC - Super Administrador';
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
              <img src={action.icon} alt={action.label} className="w-20 h-20 object-contain" />
              <span>{action.label}</span>
            </button>
          ))}
        </div>
      </div>
    </HeaderLayout>
  );
};

export default Dashboard;
