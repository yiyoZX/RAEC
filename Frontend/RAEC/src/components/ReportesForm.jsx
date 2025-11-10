import { useState } from 'react';
import Button from '../components/Button';
import { useTodasActividades } from '../hooks/useActividades';
import ReportesGraficos from '../components/ReportesGraficos';

function ReporteForm({ tipoUsuario }) {  // Prop: 'academico' o 'estudiante' para ajustar
  // Cargar actividades dinámicamente desde el backend
  const { academicas, noAcademicas, loading: loadingActividades } = useTodasActividades();
  
  const [tipoReporte, setTipoReporte] = useState('');
  const [rut, setRut] = useState('');
  const [tipoActividad, setTipoActividad] = useState('');
  const [actividad, setActividad] = useState('');
  const [estado, setEstado] = useState('');  // Nuevo para estudiantes
  const [expandedIndex, setExpandedIndex] = useState(null);  // Para controlar dropdown
  const [loading, setLoading] = useState(false);
  const [items, setItems] = useState([]);
  const [csvUrl, setCsvUrl] = useState(null);
  const [mensaje, setMensaje] = useState('Aquí se mostrará una vista previa del informe seleccionado.');

  const resetPreview = (msg = 'Aquí se mostrará una vista previa del informe seleccionado.') => {
    setItems([]); setCsvUrl(null); setMensaje(msg); setExpandedIndex(null);
  };

  const handleConsultar = async () => {
    let url = 'http://localhost:4001/reportes';
    const params = new URLSearchParams();
    if (tipoUsuario === 'academico') {
      if (tipoReporte === 'alumno') {
        if (!rut.trim()) return resetPreview('Ingrese el RUT del alumno.');
        url += '/alumno';
        params.append('rut', rut.trim());
      } else if (tipoReporte === 'actividad') {
        if (!actividad) return resetPreview('Seleccione una actividad.');
        url += '/actividad';
        params.append('actividad_id', actividad);
      } else if (tipoReporte === 'general') {
        url += '/general';
      } else {
        return resetPreview('Seleccione un tipo de reporte.');
      }
    } else if (tipoUsuario === 'estudiante') {
      if (!estado) return resetPreview('Seleccione un estado.');
      url += '/estudiante';  // Ruta backend para estudiantes
      params.append('estado', estado);  // Param para aprobadas/rechazadas/pendientes
    }
    setLoading(true);
    setMensaje('Cargando...');
    try {
      const token = localStorage.getItem('access_token') || '';
      const response = await fetch(url + '?' + params.toString(), {
        headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' }
      });
      if (response.status === 401) return resetPreview('No autorizado.');
      if (response.status === 403) return resetPreview('Acceso denegado.');
      if (!response.ok) return resetPreview('Error HTTP ' + response.status);
      const json = await response.json();
      const arr = Array.isArray(json) ? json : (json.data || []);
      setItems(arr);
      setCsvUrl(json.csv_url ? 'http://localhost:4001' + json.csv_url : null);
      if (!arr.length) setMensaje('No hay datos para este reporte.'); else setMensaje(null);
    } catch (e) {
      resetPreview('Error de conexión.');
    } finally { setLoading(false); }
  };

  // Usar actividades cargadas desde el backend
  const listaActividades = tipoActividad === 'academica' ? academicas : tipoActividad === 'no_academica' ? noAcademicas : [];

  return (
    <div className="w-full max-w-6xl mx-auto px-8 py-12 md:flex-row">
      {/* Componente de gráficos - arriba de todo */}
      <ReportesGraficos tipoUsuario={tipoUsuario} />

      <div className="flex-1 w-full mt-8">
        <label className="block text-lg font-semibold text-gray-700 mb-2 text-center">Selecciona un tipo de reporte</label>

        {tipoUsuario === 'academico' ? (
          <>
            <select value={tipoReporte} onChange={e=>{setTipoReporte(e.target.value); setRut(''); setTipoActividad(''); setActividad(''); resetPreview();}} className="w-full border border-gray-400 rounded-lg px-4 py-2 shadow">
              <option value="" disabled>-- Elige una opción --</option>
              <option value="alumno">Por alumno</option>
              <option value="actividad">Por actividad</option>
              <option value="general">General</option>
            </select>

            {tipoReporte === 'alumno' && (
              <input value={rut} onChange={e=>setRut(e.target.value)} type="text" placeholder="Ingrese RUT del alumno" className="w-full mt-4 border border-gray-400 rounded-lg px-4 py-2 shadow" />
            )}

            {tipoReporte === 'actividad' && (
              <>
                <select value={tipoActividad} onChange={e=>{setTipoActividad(e.target.value); setActividad('');}} className="w-full mt-4 border border-gray-400 rounded-lg px-4 py-2 shadow">
                  <option value="">Seleccione tipo de actividad</option>
                  <option value="academica">Académica</option>
                  <option value="no_academica">No Académica</option>
                </select>
                <select value={actividad} onChange={e=>setActividad(e.target.value)} className="w-full mt-4 border border-gray-400 rounded-lg px-4 py-2 shadow" disabled={loadingActividades}>
                  <option value="">{loadingActividades ? 'Cargando actividades...' : 'Seleccione una actividad'}</option>
                  {listaActividades.map(a=> <option key={a.value} value={a.value}>{a.label}</option>)}
                </select>
              </>
            )}
          </>
        ) : tipoUsuario === 'estudiante' ? (
          <select value={estado} onChange={e=>{setEstado(e.target.value); resetPreview();}} className="w-full border border-gray-400 rounded-lg px-4 py-2 shadow">
            <option value="" disabled>-- Elige un estado --</option>
            <option value="aprobadas">Aprobadas</option>
            <option value="rechazadas">Rechazadas</option>
            <option value="pendientes">Pendientes</option>
          </select>
        ) : null}

        <Button variant="primary" className="mt-4 w-full" isLoading={loading} onClick={handleConsultar}>
          {loading ? 'Consultando...' : 'Consultar'}
        </Button>
      </div>

      {/* Preview común - con dropdown expandible */}
      <div className="max-w-2xl mx-auto mt-8 p-6 border border-gray-300 rounded-lg shadow-md text-center" style={{backgroundColor:'#f1e1f1'}}>
        <h2 className="text-xl font-bold text-gray-800 mb-4">Preview del reporte</h2>
        {mensaje && <div className="text-gray-600">{mensaje}</div>}
        {!mensaje && (
          <ul className="space-y-3">
            {items.map((item,i)=>{
              const actividadNombre = item.actividad ?? item.nombre_actividad ?? 'Sin actividad';
              const fechaISO = item.fecha_creacion ?? item.fecha ?? null;
              const fechaTxt = fechaISO ? new Date(fechaISO).toLocaleString() : '—';
              const nombres = (item.nombres || '').trim();
              const apellidos = (item.apellidos || '').trim();
              const rutVal = item.rut || '';
              let titulo='';
              if (apellidos && nombres) titulo = `${apellidos}, ${nombres}`; else if (nombres) titulo=nombres; else if (apellidos) titulo=apellidos; else titulo=rutVal || 'Registro';
              
              const isExpanded = expandedIndex === i;
              
              return (
                <li key={i} className="border rounded-lg bg-white/70 shadow-sm overflow-hidden">
                  <div 
                    className="px-4 py-3 cursor-pointer hover:bg-purple-50 transition-colors"
                    onClick={() => setExpandedIndex(isExpanded ? null : i)}
                  >
                    <div className="flex items-center justify-between">
                      <div className="font-semibold text-gray-800">{titulo}</div>
                      <div className="flex items-center gap-2">
                        <div className="text-sm text-gray-600">{fechaTxt}</div>
                        <svg 
                          className={`w-5 h-5 text-gray-600 transition-transform ${isExpanded ? 'rotate-180' : ''}`}
                          fill="none" 
                          stroke="currentColor" 
                          viewBox="0 0 24 24"
                        >
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                        </svg>
                      </div>
                    </div>
                    {rutVal && <div className="text-sm text-gray-600 mt-1">RUT: {rutVal}</div>}
                    <div className="mt-2">
                      <span className="inline-block text-xs px-2 py-1 rounded bg-purple-100 text-purple-800 border border-purple-200">{actividadNombre}</span>
                    </div>
                  </div>
                  
                  {/* Dropdown expandible con detalles */}
                  {isExpanded && (
                    <div className="px-4 py-4 bg-gray-50 border-t border-gray-200 text-left">
                      <div className="grid grid-cols-1 md:grid-cols-2 gap-3 text-sm">
                        {item.estado && (
                          <div>
                            <span className="font-semibold text-gray-700">Estado:</span>
                            <span className={`ml-2 px-2 py-1 rounded text-xs ${
                              item.estado === 'Aprobada' ? 'bg-green-100 text-green-800' :
                              item.estado === 'Rechazada' ? 'bg-red-100 text-red-800' :
                              'bg-yellow-100 text-yellow-800'
                            }`}>
                              {item.estado}
                            </span>
                          </div>
                        )}
                        {item.carrera && (
                          <div>
                            <span className="font-semibold text-gray-700">Carrera:</span>
                            <span className="ml-2 text-gray-600">{item.carrera}</span>
                          </div>
                        )}
                        {item.fecha_inicio_actividad && (
                          <div>
                            <span className="font-semibold text-gray-700">Fecha inicio:</span>
                            <span className="ml-2 text-gray-600">{new Date(item.fecha_inicio_actividad).toLocaleDateString()}</span>
                          </div>
                        )}
                        {item.fecha_termino_actividad && (
                          <div>
                            <span className="font-semibold text-gray-700">Fecha término:</span>
                            <span className="ml-2 text-gray-600">{new Date(item.fecha_termino_actividad).toLocaleDateString()}</span>
                          </div>
                        )}
                        {item.horas_totales && (
                          <div>
                            <span className="font-semibold text-gray-700">Horas totales:</span>
                            <span className="ml-2 text-gray-600">{item.horas_totales}h</span>
                          </div>
                        )}
                        {(item.profesor_nombres || item.profesor_apellidos) && (
                          <div>
                            <span className="font-semibold text-gray-700">Profesor:</span>
                            <span className="ml-2 text-gray-600">
                              {item.profesor_apellidos && item.profesor_nombres 
                                ? `${item.profesor_apellidos}, ${item.profesor_nombres}`
                                : item.profesor_nombres || item.profesor_apellidos
                              }
                            </span>
                          </div>
                        )}
                      </div>
                      {item.comentario && (
                        <div className="mt-3 pt-3 border-t border-gray-200">
                          <span className="font-semibold text-gray-700 block mb-1">Comentario:</span>
                          <p className="text-gray-600 text-sm italic">{item.comentario}</p>
                        </div>
                      )}
                      {item.tiene_archivo && item.id_registro && (
                        <div className="mt-3 pt-3 border-t border-gray-200">
                          <button
                            onClick={(e) => {
                              e.stopPropagation();
                              const token = localStorage.getItem('access_token') || '';
                              fetch(`http://localhost:4001/reportes/download/${item.id_registro}`, {
                                headers: { 'Authorization': `Bearer ${token}` }
                              })
                              .then(response => {
                                if (!response.ok) throw new Error('Error al descargar');
                                return response.blob();
                              })
                              .then(blob => {
                                const url = window.URL.createObjectURL(blob);
                                const a = document.createElement('a');
                                a.href = url;
                                a.download = item.archivo_nombre || 'documento';
                                document.body.appendChild(a);
                                a.click();
                                window.URL.revokeObjectURL(url);
                                document.body.removeChild(a);
                              })
                              .catch(err => alert('Error al descargar el archivo'));
                            }}
                            className="flex items-center gap-2 px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 transition-colors text-sm font-medium"
                          >
                            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                            </svg>
                            Descargar {item.archivo_nombre || 'documento'}
                          </button>
                        </div>
                      )}
                    </div>
                  )}
                </li>
              );
            })}
          </ul>
        )}
        {csvUrl && (
          <div className="mt-4 text-sm">
            <a href={csvUrl} download className="text-purple-700 underline hover:text-purple-900">Descargar CSV ({csvUrl.split('/').pop()})</a>
          </div>
        )}
      </div>
    </div>
  );
}

export default ReporteForm;