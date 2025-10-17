import { useState } from 'react';
import Button from '../components/Button';
import { ACTIVIDADES_ACADEMICAS, ACTIVIDADES_NO_ACADEMICAS } from '../utils/constants';

function ReporteForm({ tipoUsuario }) {  // Prop: 'academico' o 'estudiante' para ajustar
  const [tipoReporte, setTipoReporte] = useState('');
  const [rut, setRut] = useState('');
  const [tipoActividad, setTipoActividad] = useState('');
  const [actividad, setActividad] = useState('');
  const [estado, setEstado] = useState('');  // Nuevo para estudiantes
  const [loading, setLoading] = useState(false);
  const [items, setItems] = useState([]);
  const [csvUrl, setCsvUrl] = useState(null);
  const [mensaje, setMensaje] = useState('Aquí se mostrará una vista previa del informe seleccionado.');

  const resetPreview = (msg = 'Aquí se mostrará una vista previa del informe seleccionado.') => {
    setItems([]); setCsvUrl(null); setMensaje(msg);
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

  const listaActividades = tipoActividad === 'academica' ? ACTIVIDADES_ACADEMICAS : tipoActividad === 'no_academica' ? ACTIVIDADES_NO_ACADEMICAS : [];

  return (
    <div className="max-w-3xl mx-auto mt-6 flex items-start gap-6 flex-col md:flex-row">
      <div className="flex-1 w-full">
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
                <select value={actividad} onChange={e=>setActividad(e.target.value)} className="w-full mt-4 border border-gray-400 rounded-lg px-4 py-2 shadow">
                  <option value="">Seleccione una actividad</option>
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

      {/* Preview común - no cambia */}
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
              return (
                <li key={i} className="border rounded-lg bg-white/70 px-4 py-3 shadow-sm">
                  <div className="flex items-center justify-between">
                    <div className="font-semibold">{titulo}</div>
                    <div className="text-sm text-gray-500">{fechaTxt}</div>
                  </div>
                  {rutVal && <div className="text-sm text-gray-600 mt-1">RUT: {rutVal}</div>}
                  <div className="mt-2">
                    <span className="inline-block text-xs px-2 py-1 rounded bg-purple-100 text-purple-800 border border-purple-200">{actividadNombre}</span>
                  </div>
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