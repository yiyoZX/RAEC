import { useState, useEffect } from 'react';
import { useAuth } from '../store/AuthContext';
import HeaderLayout from '../layouts/HeaderLayout';
import Button from '../components/Button';
import Paginacion from '../components/Paginacion';

const SolicitudesPage = () => {
  const { user } = useAuth();  // Para rol y token
  const [solicitudes, setSolicitudes] = useState([]);  // Lista de pendientes
  const [loading, setLoading] = useState(true);  // Cargando al inicio
  const [error, setError] = useState(null);  // Errores
  
  // Estados de paginación
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(0);
  const [totalRecords, setTotalRecords] = useState(0);
  const [pageSize] = useState(6);

  // Función para formatear fecha a DD-MM-YY
  const formatearFecha = (fecha) => {
    if (!fecha) return '';
    const date = new Date(fecha);
    const dia = String(date.getDate()).padStart(2, '0');
    const mes = String(date.getMonth() + 1).padStart(2, '0');
    const anio = String(date.getFullYear()).slice(-2);
    return `${dia}-${mes}-${anio}`;
  };

  // Cargar solicitudes al inicio
  useEffect(() => {
    const fetchSolicitudes = async () => {
      setLoading(true);
      setError(null);
      try {
        const token = localStorage.getItem('access_token') || '';
        const response = await fetch(`http://localhost:4001/solicitudes/pendientes?page=${currentPage}&page_size=${pageSize}`, {
          headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' }
        });
        if (!response.ok) throw new Error('Error al cargar solicitudes');
        const data = await response.json();
        console.log('Datos recibidos:', data.data);  // Para debug
        setSolicitudes(data.data || []);
        setTotalRecords(data.total || 0);
        setTotalPages(data.total_pages || 0);
      } catch (e) {
        console.log('Error fetch:', e.message);
        setError('No se pudieron cargar las solicitudes.');
      } finally {
        setLoading(false);
      }
    };

    if (user && (user.id_rol === 2 || user.rol === 2 || user.id_rol === 3 || user.rol === 3)) {
      fetchSolicitudes();
    } else {
      setError('Solo directores y administradores pueden acceder a esta página.');
      setLoading(false);
    }
  }, [user, currentPage, pageSize]);  // Depend de user - recarga si cambia

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

      setSolicitudes(solicitudes.filter(s => s.id_registro !== id));
      
      // Si la página actual queda vacía, ir a la página anterior
      if (solicitudes.length === 1 && currentPage > 1) {
        setCurrentPage(currentPage - 1);
      }
      
      alert('Solicitud actualizada');
    } catch (e) {
      console.error('Excepción completa:', e);
      alert(`No se pudo actualizar: ${e.message}`);
    }
  };

  // Manejar cambio de página
  const handlePageChange = (newPage) => {
    setCurrentPage(newPage);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  if (loading) return <div>Cargando solicitudes...</div>;
  if (error) return <div>{error}</div>;

  // Calcular rango de registros
  const startRecord = (currentPage - 1) * pageSize + 1;
  const endRecord = Math.min(currentPage * pageSize, totalRecords);

  return (
    <HeaderLayout showBack title="Solicitudes Pendientes">
      <div className="p-6">
        <h2 className="text-2xl font-bold text-center text-gray-600 mb-4">Solicitudes de Estudiantes Pendientes</h2>
        {totalRecords > 0 && (
          <p className="text-center text-gray-600 mb-4">
            Mostrando {startRecord} - {endRecord} de {totalRecords} solicitudes
          </p>
        )}
        {solicitudes.length === 0 ? (
          <p className="text-center text-gray-600">No hay solicitudes pendientes.</p>
        ) : (
          <>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {solicitudes.map((solicitud) => (
              <div key={solicitud.id_registro} className="bg-white p-5 rounded-lg shadow-lg hover:shadow-xl transition-shadow duration-300 flex flex-col">
                <div className="flex-grow space-y-2">
                  <div className="border-b pb-2 mb-3">
                    <p className="text-sm text-gray-500">RUT Estudiante</p>
                    <p className="font-semibold text-gray-700">{solicitud.id_alumno}</p>
                  </div>
                  
                  <div>
                    <p className="text-sm text-gray-500">Actividad</p>
                    <p className="font-semibold text-gray-700">{solicitud.nombre_actividad}</p>
                  </div>
                  
                  <div>
                    <p className="text-sm text-gray-500">Fechas</p>
                    <p className="text-gray-700">{formatearFecha(solicitud.fecha_inicio_actividad)} a {formatearFecha(solicitud.fecha_termino_actividad)}</p>
                  </div>
                  
                  <div>
                    <p className="text-sm text-gray-500">Horas Totales</p>
                    <p className="font-semibold text-blue-600">{solicitud.horas_totales} hrs</p>
                  </div>
                  
                  <div>
                    <p className="text-sm text-gray-500">Comentario</p>
                    <p className="text-gray-700 text-sm line-clamp-3">{solicitud.comentario}</p>
                  </div>
                  
                  <div>
                    <p className="text-sm text-gray-500">Archivo</p>
                    <p className="text-gray-700 text-sm">{solicitud.archivo_nombre || 'Ninguno'}</p>
                  </div>
                </div>
                
                <div className="mt-4 flex gap-2 pt-3 border-t">
                  <Button variant="primary" onClick={() => handleUpdate(solicitud.id_registro, 1)} className="flex-1">Aprobar</Button>  
                  <Button variant="secondary" onClick={() => handleUpdate(solicitud.id_registro, 2)} className="flex-1">Rechazar</Button> 
                </div>
              </div>
            ))}
          </div>
          
          {/* Componente de paginación */}
          {totalPages > 1 && (
            <div className="mt-6">
              <Paginacion
                currentPage={currentPage}
                totalPages={totalPages}
                onPageChange={handlePageChange}
                loading={loading}
              />
            </div>
          )}
          </>
        )}
      </div>
    </HeaderLayout>
  );
};

export default SolicitudesPage;