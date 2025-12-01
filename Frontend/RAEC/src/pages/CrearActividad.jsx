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
  const [camposDinamicos, setCamposDinamicos] = useState([]);

  const agregarCampoDinamico = () => {
    if (camposDinamicos.length >= 3) {
      setMensaje('⚠️ Solo puedes agregar hasta 3 campos adicionales.');
      return;
    }
    setCamposDinamicos([...camposDinamicos, { id: Date.now(), nombre: '' }]);
  };

  const eliminarCampoDinamico = (id) => {
    setCamposDinamicos(camposDinamicos.filter(campo => campo.id !== id));
  };

  const actualizarCampoDinamico = (id, propiedad, valor) => {
    setCamposDinamicos(
      camposDinamicos.map(campo =>
        campo.id === id ? { ...campo, [propiedad]: valor } : campo
      )
    );
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!tipo || !nombre.trim()) {
      setMensaje('Completa todos los campos.');
      return;
    }

    // Validar campos dinámicos
    const camposInvalidos = camposDinamicos.some(campo => !campo.nombre.trim());
    if (camposInvalidos) {
      setMensaje('⚠️ Completa todos los campos dinámicos o elimínalos.');
      return;
    }

    setLoading(true);
    setMensaje('Creando actividad...');

    try {
      const token = localStorage.getItem('access_token') || '';
      
      // Construir array con nombres de campos dinámicos
      const camposAdicionales = camposDinamicos.map(campo => campo.nombre);

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
          campos_adicionales: camposAdicionales, // Campos dinámicos
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
      setCamposDinamicos([]);
    } catch (error) {
      console.error(error);
      setMensaje('❌ Error de conexión con el backend.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <HeaderLayout showBack title="RAEC - Nueva Actividad">
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

          {/* Sección de Campos Dinámicos */}
          <div className="border-t border-gray-200 pt-4">
            <div className="flex justify-between items-center mb-3">
              <label className="block text-sm font-semibold text-gray-700">
                Campos Adicionales {camposDinamicos.length > 0 && `(${camposDinamicos.length}/3)`}
              </label>
              {camposDinamicos.length < 3 && (
                <button
                  type="button"
                  onClick={agregarCampoDinamico}
                  className="text-sm bg-purple-500 hover:bg-purple-600 text-white px-3 py-1 rounded-lg transition flex items-center gap-1"
                >
                  <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
                  </svg>
                  Agregar Campo
                </button>
              )}
            </div>

            {camposDinamicos.length === 0 && (
              <p className="text-sm text-gray-500 italic">
                Puedes agregar hasta 3 campos personalizados para esta actividad
              </p>
            )}

            <div className="space-y-3">
              {camposDinamicos.map((campo, index) => (
                <div key={campo.id} className="bg-gray-50 border border-gray-200 rounded-lg p-4">
                  <div className="flex justify-between items-center mb-3">
                    <span className="text-sm font-semibold text-gray-700">
                      Campo {index + 1}
                    </span>
                    <button
                      type="button"
                      onClick={() => eliminarCampoDinamico(campo.id)}
                      className="text-red-500 hover:text-red-700 transition"
                      title="Eliminar campo"
                    >
                      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                      </svg>
                    </button>
                  </div>
                  
                  <div className="space-y-2">
                    <input
                      type="text"
                      value={campo.nombre}
                      onChange={(e) => actualizarCampoDinamico(campo.id, 'nombre', e.target.value)}
                      placeholder="Nombre del campo (ej: Ubicación, Duración)"
                      className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent transition"
                      required
                    />
                  </div>
                </div>
              ))}
            </div>
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
