import { useState } from 'react';
import { authenticatedFetch } from '../services/api';
import Button from '../components/Button';
import { useNavigate } from 'react-router-dom';
import HeaderLayout from '../layouts/HeaderLayout';

export default function ChangeUserRole() {
  const navigate = useNavigate();

  const [correo, setCorreo] = useState('');
  const [newRol, setNewRol] = useState('');
  const [loading, setLoading] = useState(false);
  const [msg, setMsg] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setMsg(null);

    try {
      const res = await authenticatedFetch(
        'http://localhost:4001/updateRole',
        {
          method: 'POST',
          body: JSON.stringify({
            correo,
            newRol,
          }),
        }
      );

      if (!res.ok) throw new Error('Error del servidor');

      const data = await res.json();
      setMsg({ type: 'success', text: data.message || 'Rol actualizado correctamente' });
    } catch (error) {
      setMsg({ type: 'error', text: 'No se pudo actualizar el rol' });
    } finally {
      setLoading(false);
    }
  };

  return (
    <HeaderLayout showBack title="RAEC - Cambiar Rol de Usuario">
      <div className="min-h-screen flex items-center justify-center p-4">
        <div className="w-full max-w-md bg-white rounded-xl shadow-lg p-6">
          <h2 className="text-2xl font-bold text-center text-gray-800 mb-6">
            Cambiar Rol de Usuario
          </h2>

          <form onSubmit={handleSubmit} className="space-y-4">

            {/* CORREO */}
            <div>
              <label className="block text-gray-700 font-medium mb-1">
                CORREO DEL ACADÉMICO
              </label>
              <input
                type="text"
                value={correo}
                onChange={(e) => setCorreo(e.target.value)}
                placeholder="Ej: juan.lego@instituto2.cl"
                className="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500"
                required
              />
            </div>

            {/* Selector de Rol */}
            <div>
              <label className="block text-gray-700 font-medium mb-1">
                Nuevo Rol
              </label>
              <select
                value={newRol}
                onChange={(e) => setNewRol(Number(e.target.value))}
                className="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500"
                required
              >
                <option value="">Seleccione un rol</option>
                <option value="1">Profesor</option>
                <option value="2">Director</option>
                <option value="3">Administrador</option>
              </select>
            </div>

            {msg && (
              <p
                className={`text-center text-sm ${
                  msg.type === "error" ? "text-red-600" : "text-green-600"
                }`}
              >
                {msg.text}
              </p>
            )}

            <Button
              type="submit"
              isLoading={loading}
              className="w-full"
              variant="primary"
            >
              Actualizar Rol
            </Button>

            <button
              type="button"
              onClick={() => navigate('/dashboardAdmin')}
              className="w-full border border-gray-300 text-gray-700 px-4 py-2 rounded-lg hover:bg-gray-100 transition"
              disabled={loading}
            >
              Volver
            </button>
          </form>
        </div>
      </div>
    </HeaderLayout>
  );
}
