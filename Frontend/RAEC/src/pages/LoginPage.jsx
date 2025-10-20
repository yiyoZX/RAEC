import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../store/AuthContext';
import Button from '../components/Button';

const LoginPage = () => {
  const { login } = useAuth();
  const navigate = useNavigate();
  const [correo, setCorreo] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError(null);
    const res = await login(correo, password);
    setLoading(false);
    if (res.success) {
      // Obtener el rol del usuario desde localStorage
      const userData = JSON.parse(localStorage.getItem('user_data'));
      const userRole = userData?.id_rol;
      
      // Redirigir según el rol (asumiendo que el rol admin tiene id_rol = 3)
      // Ajusta el número según tu base de datos
      if (userRole === 3) {
        navigate('/dashboardAdmin');
      } else {
        navigate('/dashboard');
      }
    } else {
      setError(res.error || 'Error al iniciar sesión');
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-100 p-4">
      <div className="w-full max-w-sm bg-white rounded-xl shadow-lg p-6">
        <h1 className="text-2xl font-bold text-center mb-2">RAEC</h1>
        <h2 className="text-lg font-semibold text-center text-gray-700 mb-4">Iniciar sesión</h2>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label htmlFor="correo" className="block text-gray-700 font-medium mb-1">Correo</label>
            <input id="correo" value={correo} onChange={(e)=>setCorreo(e.target.value)} type="text" placeholder="Ingresa tu correo" className="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500 focus:outline-none" />
          </div>
          <div>
            <label htmlFor="password" className="block text-gray-700 font-medium mb-1">Contraseña</label>
            <input id="password" value={password} onChange={(e)=>setPassword(e.target.value)} type="password" placeholder="Ingresa tu contraseña" className="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500 focus:outline-none" />
          </div>
          {error && <div className="text-sm text-red-600">{error}</div>}
          <Button type="submit" isLoading={loading} className="w-full" variant="primary">
            {loading ? 'Ingresando...' : 'Ingresar'}
          </Button>
          <button
            type="button"
            onClick={() => navigate('/loginStudent')}
            className="w-full border border-gray-300 text-gray-700 px-4 py-2 rounded-lg hover:bg-gray-100 transition"
            disabled={loading}
          >
            Ingresar como Estudiante
          </button>
        </form>
      </div>
    </div>
  );
};

export default LoginPage;