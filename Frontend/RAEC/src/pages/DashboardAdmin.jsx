import { useNavigate } from 'react-router-dom';
import HeaderLayout from '../layouts/HeaderLayout';

const DashboardAdmin = () => {
  const navigate = useNavigate();

  const actions = [
    { label: 'Registrar', to: '/registrar', icon: '✔️' },
    { label: 'Solicitudes', to: '/solicitudes', icon: '👥' },
    { label: 'Reportes', to: '/reportesAcademicos', icon: '📊' },
    { label: 'Crear categoria', to: '/crear', icon: '🧾' },
    { label: 'Activar periodos', to: '/periodos', icon: '📅' },
    { label: 'Carga masiva', to: '/carga-masiva', icon: '📥' },
  ];

  return (
    <HeaderLayout fullScreen>
      {/* Contenedor centrado */}
      <div className="w-full max-w-6xl mx-auto px-8 py-12">
        <div className="mb-12 text-center">
          <h1 className="text-4xl font-bold text-gray-900 mb-2">Bienvenido!</h1>
          <p className="text-gray-600 text-lg">Por favor selecciona una opción:</p>
        </div>

        {/* Botones */}
        <div className="flex flex-col gap-6">
          {actions.map((action) => (
            <button
              key={action.to}
              onClick={() => navigate(action.to)}
              className="w-full bg-blue-600 hover:bg-blue-700 text-white rounded-2xl shadow-lg hover:shadow-xl transition-all duration-300 p-8 flex items-center justify-center gap-4 min-h-[120px] text-3xl font-semibold"
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

export default DashboardAdmin;