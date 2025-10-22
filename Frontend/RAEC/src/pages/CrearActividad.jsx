import { useState } from 'react';
import { useAuth } from '../store/AuthContext';
import HeaderLayout from '../layouts/HeaderLayout';
import Button from '../components/Button';

const NuevaActividadPage = () => {
  const { user } = useAuth();
  const [tipo, setTipo] = useState('');
  const [nombre, setNombre] = useState('');
  const [mensaje, setMensaje] = useState(null);
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!tipo || !nombre.trim()) {
      setMensaje('Completa todos los campos.');
      return;
    }

    setLoading(true);
    setMensaje('Creando actividad...');

    try {
      const token = localStorage.getItem('access_token') || '';
      const res = await fetch('http://localhost:4001/actividades/nueva', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify({
          tipo,        // 'academica' o 'no_academica'
          nombre: nombre.trim(),
          creador: user?.email || '',
        }),
      });

      if (res.status === 401) {
        setMensaje('No autorizado. Inicia sesión nuevamente.');
        return;
      }

      if (!res.ok) {
        const err = await res.text();
        setMensaje('Error del servidor: ' + err);
        return;
      }

      const data = await res.json();
      setMensaje(data.message || '✅ Actividad creada correctamente');
      setNombre('');
      setTipo('');
    } catch (error) {
      console.error(error);
      setMensaje('❌ Error de conexión con el backend.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <HeaderLayout showBack backTo="/dashboard" title="Nueva Actividad">
      <div className="w-full max-w-xl mx-auto p-6 mt-8 bg-white rounded-xl shadow-md">
        <h2 className="text-2xl font-bold text-center mb-6 text-gray-800">
          Registrar Nueva Actividad
        </h2>

        <form onSubmit={handleSubmit} className="space-y-6">
          <div>
            <label className="block text-sm font-semibold text-gray-700 mb-2">
              Tipo de Actividad
            </label>
            <select
              value={tipo}
              onChange={(e) => setTipo(e.target.value)}
              className="w-full border border-gray-300 rounded-lg px-4 py-3 focus:ring-2 focus:ring-purple-500 focus:border-transparent transition"
              required
            >
              <option value="">Seleccione tipo</option>
              <option value="academica">Académica</option>
              <option value="no_academica">No Académica</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-semibold text-gray-700 mb-2">
              Nombre de la Actividad
            </label>
            <input
              type="text"
              value={nombre}
              onChange={(e) => setNombre(e.target.value)}
              placeholder="Ej: Olimpiadas de Programación"
              className="w-full border border-gray-300 rounded-lg px-4 py-3 focus:ring-2 focus:ring-purple-500 focus:border-transparent transition"
              required
            />
          </div>

          {mensaje && (
            <div className="text-sm text-center text-gray-700 bg-gray-100 border border-gray-300 rounded-lg py-2 px-3">
              {mensaje}
            </div>
          )}

          <Button
            type="submit"
            variant="primary"
            className="w-full"
            isLoading={loading}
          >
            {loading ? 'Guardando...' : 'Crear Actividad'}
          </Button>
        </form>
      </div>
    </HeaderLayout>
  );
};

export default NuevaActividadPage;
