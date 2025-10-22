import { useState, useEffect } from 'react';
import { useAuth } from '../store/AuthContext';
import HeaderLayout from '../layouts/HeaderLayout';
import Button from '../components/Button';

const SolicitudesPage = () => {
  const { user } = useAuth();  // Para rol y token
  const [solicitudes, setSolicitudes] = useState([]);  // Lista de pendientes
  const [loading, setLoading] = useState(true);  // Cargando al inicio
  const [error, setError] = useState(null);  // Errores

  // Cargar solicitudes al inicio
  useEffect(() => {
    const fetchSolicitudes = async () => {
      setLoading(true);
      setError(null);
      try {
        const token = localStorage.getItem('access_token') || '';
        const response = await fetch('http://localhost:4001/solicitudes/pendientes', {
          headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' }
        });
        if (!response.ok) throw new Error('Error al cargar solicitudes');
        const data = await response.json();
        setSolicitudes(data);
      } catch (e) {
        console.log('Error fetch:', e.message, response ? response.status : 'No response');
        setError('No se pudieron cargar las solicitudes.');

      } finally {
        setLoading(false);
      }
    };

    if (user && user.rol === 2) {  // Cambio: Agrega user && para evitar null.rol error
      fetchSolicitudes();
    } else {
      setError('Solo directores pueden acceder a esta página.');
      setLoading(false);
    }
  }, [user]);  // Depend de user - recarga si cambia

  // Función para aprobar/rechazar
  const handleUpdate = async (id, nuevoEstado) => {
    // Chequeo de seguridad: Verifica si id es válido (número, no undefined)
    if (id === undefined || typeof id !== 'number' || isNaN(id)) {
      console.error('ID inválido:', id);
      alert('Error: ID de la solicitud no definido o inválido. Revisa la lista.');
      return;  // No continúa si hay error
    }

    try {
      console.log(`Intentando actualizar ID: ${id} con estado: ${nuevoEstado}`);  // Log para ver qué valores se envían
      console.log(`Tipo de ID: ${typeof id}`);  // Debe ser 'number' o 'string' que se convierta a número

      const token = localStorage.getItem('access_token') || '';
      const response = await fetch(`http://localhost:4001/solicitudes/${id}/update`, {
        method: 'POST',
        headers: { 'Authorization': `Bearer ${token}`, 'Content-Type': 'application/json' },
        body: JSON.stringify({ id_estado: nuevoEstado })
      });

      if (!response.ok) {
        const errorText = await response.text();  // Lee el cuerpo del error (JSON o texto)
        console.error(`Error del servidor: Código ${response.status} - ${errorText}`);  // Muestra en consola
        throw new Error(`Error al actualizar: ${response.status} - ${errorText}`);
      }

      setSolicitudes(solicitudes.filter(s => s.id_registro !== id));  // Cambiado: Usa id_registro para filtrar
      alert('Solicitud actualizada');
    } catch (e) {
      console.error('Excepción completa:', e);  // Log la excepción completa
      alert(`No se pudo actualizar: ${e.message}`);
    }
  };

  if (loading) return <div>Cargando solicitudes...</div>;
  if (error) return <div>{error}</div>;

  return (
    <HeaderLayout showBack backTo="/dashboard" title="Solicitudes Pendientes">
      <div className="p-6">
        <h2 className="text-2xl font-bold text-center mb-4">Solicitudes de Estudiantes Pendientes</h2>
        {solicitudes.length === 0 ? (
          <p className="text-center text-gray-600">No hay solicitudes pendientes.</p>
        ) : (
          <ul className="space-y-4">
            {solicitudes.map((solicitud) => (
              <li key={solicitud.id_registro} className="bg-white p-4 rounded-lg shadow">  // Cambiado: key usa id_registro
                <p><strong>RUT Estudiante:</strong> {solicitud.rut_alumno}</p>
                <p><strong>Actividad:</strong> {solicitud.nombre_actividad}</p>
                <p><strong>Fechas:</strong> {solicitud.fecha_inicio} a {solicitud.fecha_termino}</p>
                <p><strong>Horas:</strong> {solicitud.horas_totales}</p>
                <p><strong>Comentario:</strong> {solicitud.comentario}</p>
                <p><strong>Archivo:</strong> {solicitud.archivo_nombre || 'Ninguno'}</p>
                <div className="mt-4 flex gap-2">
                  <Button variant="primary" onClick={() => handleUpdate(solicitud.id_registro, 1)}>Aprobar</Button>  
                  <Button variant="secondary" onClick={() => handleUpdate(solicitud.id_registro, 2)}>Rechazar</Button> 
                </div>
              </li>
            ))}
          </ul>
        )}
      </div>
    </HeaderLayout>
  );
};

export default SolicitudesPage;