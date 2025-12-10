import { useState, useEffect } from 'react';
import { useAuth } from '../store/AuthContext';
import { useNavigate } from 'react-router-dom';
import HeaderLayout from '../layouts/HeaderLayout';
import FormularioActividad from '../components/FormularioActividad';  // Reutiliza
import { authenticatedFetch } from '../services/api';

function RegistroFormularioEstudiante() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  const [solicitudesAbiertas, setSolicitudesAbiertas] = useState(true);

  useEffect(() => {
    let mounted = true;

    const fetchStatus = async () => {
      try {
        const res = await authenticatedFetch('/periodos/status/');
        if (!res || !res.ok) {
          if (mounted) setSolicitudesAbiertas(false);
          return;
        }
        const data = await res.json();
        if (mounted) setSolicitudesAbiertas(Boolean(data.open));
      } catch (err) {
        console.error('Error fetching period status', err);
        if (mounted) setSolicitudesAbiertas(false);
      }
    };

    fetchStatus();
    return () => { mounted = false; };
  }, []);

  const handleSuccess = () => {
    navigate('/dashboardStudent');
  };

  return (
    <HeaderLayout showBack title="RAEC - Registro de Actividades para Estudiantes">
      <div className="w-full max-w-7xl mx-auto px-6 py-8">
        <div className="bg-white rounded-2xl shadow-lg p-8">
          <h2 className="text-3xl font-bold text-gray-900 mb-8 text-center">Registrar Nueva Solicitud</h2>
          {solicitudesAbiertas ? (
            <FormularioActividad userRol='estudiante' onSubmitSuccess={handleSuccess} />
          ) : (
            <div className="text-center py-12 text-gray-600 font-semibold text-lg">
              Período de solicitudes cerrado
            </div>
          )}
        </div>
      </div>
    </HeaderLayout>
  );

}

export default RegistroFormularioEstudiante;