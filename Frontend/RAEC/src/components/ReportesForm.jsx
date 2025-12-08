import { useState } from 'react';
import { useTodasActividades } from '../hooks/useActividades';
import { useTodasCarreras } from '../hooks/useCarreras';
import ReportesGraficos from '../components/ReportesGraficos';
import ReporteFiltros from '../components/reportesFiltros';
import ReporteLista from '../components/reporteLista';
import Paginacion from '../components/Paginacion';

function ReporteForm({ tipoUsuario }) { // 'academico' o 'estudiante'
  
  const { academicas, noAcademicas, loading: loadingActividades } = useTodasActividades();
  const { carreras, loading: loadingCarreras} = useTodasCarreras();

  // --- ESTADO UNIFICADO DE FILTROS ---
  // Agrupamos todos los inputs en un solo objeto para pasarlo a ReporteFiltros
  const [filtros, setFiltros] = useState({
    rut: '',
    tipoActividad: '',
    actividad: '',
    fechaInicio: '',
    fechaFin: '',
    estado: '',
    carrera:[],
    horas:'',
    fechaActInicio:'',
    fechaActFin:''
  });

  // --- ESTADOS DE PAGINACIÓN ---
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(0);
  const [totalRecords, setTotalRecords] = useState(0);
  const [pageSize] = useState(10); // 20 registros por página

  // --- ESTADOS UI ---
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(false);
  const [csvUrl, setCsvUrl] = useState(null);
  const [mensaje, setMensaje] = useState(
    tipoUsuario === 'academico' 
      ? 'Configure los filtros y presione Consultar.' 
      : 'Seleccione un estado para ver sus solicitudes.'
  );

  const resetPreview = (msg) => {
    setItems([]); 
    setCsvUrl(null); 
    setMensaje(msg || null);
    setCurrentPage(1);
    setTotalPages(0);
    setTotalRecords(0);
  };

 
  const handleDownload = (item, e) => {
    e.stopPropagation();
    const token = localStorage.getItem('access_token') || '';
    
    fetch(`http://localhost:4001/reportes/download/${item.id_registro}`, {
        headers: { 'Authorization': `Bearer ${token}` }
    })
    .then(res => { 
        if(!res.ok) throw new Error('Error en la descarga'); 
        return res.blob(); 
    })
    .then(blob => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = item.archivo_nombre || 'documento_adjunto';
        document.body.appendChild(a);
        a.click();
        window.URL.revokeObjectURL(url);
        document.body.removeChild(a);
    })
    .catch(() => alert('No se pudo descargar el archivo.'));
  };

  // Lógica de Limpieza (Pasa como prop a ReporteFiltros)
  const handleLimpiar = () => {
    setFiltros({
        rut: '',
        tipoActividad: '',
        actividad: '',
        fechaInicio: '',
        fechaFin: '',
        estado: '',
        carrera:[],
        horas:'',
        fechaActInicio:'',
        fechaActFin:''

    });
    setCurrentPage(1);
    resetPreview('Filtros limpiados.');
  };

  // Lógica de Consulta con paginación
  const fetchReportes = async (page = 1) => {
    let url = 'http://localhost:4001/reportes';
    const params = new URLSearchParams();
    // Desestructuramos del estado de objetos
    const { rut, tipoActividad, actividad, fechaInicio, fechaFin, estado, carrera, horas, fechaActInicio, fechaActFin  } = filtros;

    // Agregar parámetros de paginación
    params.append('page', page);
    params.append('page_size', pageSize);

    // Lógica Académico: Filtros simultáneos
    if (tipoUsuario === 'academico') {
      url += '/general'; 
      if (rut.trim()) params.append('rut', rut.trim());
      if (tipoActividad) params.append('tipo_actividad', tipoActividad);
      if (actividad) params.append('actividad_id', actividad);
      if (fechaInicio) params.append('fecha_inicio', fechaInicio);
      if (fechaFin) params.append('fecha_fin', fechaFin);
      if (carrera.length > 0){ params.append('carrera', carrera.join(','));}
      if (horas) params.append('horas', horas);
      if (fechaActInicio) params.append('fechaActInicio', fechaActInicio);
      if (fechaActFin) params.append('fechaActFin', fechaActFin);
    
    // Lógica Estudiante: Filtro único
    } else {
      if (!estado) return resetPreview('Seleccione un estado.');
      url += '/estudiante';
      params.append('estado', estado);
    }

    setLoading(true);
    setMensaje('Buscando registros...');

    try {
      const token = localStorage.getItem('access_token') || '';
      const response = await fetch(`${url}?${params.toString()}`, {
        headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' }
      });

      if (!response.ok) {
        if (response.status === 401) return resetPreview('No autorizado.');
        if (response.status === 403) return resetPreview('Acceso denegado.');
        return resetPreview('Error al consultar datos.');
      }

      const json = await response.json();
      const data = Array.isArray(json) ? json : (json.data || []);

      setItems(data);
      setCsvUrl(json.csv_url ? `http://localhost:4001${json.csv_url}` : null);
      
      // Actualizar información de paginación
      if (json.total !== undefined) setTotalRecords(json.total);
      if (json.total_pages !== undefined) setTotalPages(json.total_pages);
      if (json.page !== undefined) setCurrentPage(json.page);
      
      if (!data.length) setMensaje('No se encontraron resultados.'); 
      else setMensaje(null);

    } catch (e) {
      console.error(e);
      resetPreview('Error de conexión.');
    } finally { 
      setLoading(false); 
    }
  };

  const handleConsultar = () => {
    setCurrentPage(1);
    fetchReportes(1);
  };

  const handlePageChange = (newPage) => {
    setCurrentPage(newPage);
    fetchReportes(newPage);
    // Scroll al inicio de la lista
    window.scrollTo({ top: 300, behavior: 'smooth' });
  };

  // Calculamos la lista dinámica para pasarla a ReporteFiltros
  const actividadesDisponibles = filtros.tipoActividad === 'academica' 
      ? academicas 
      : filtros.tipoActividad === 'no_academica' 
          ? noAcademicas 
          : [...academicas, ...noAcademicas];

  return (
    <div className="w-full max-w-6xl mx-auto px-4 py-8">
      
      {/* Gráficos solo para académicos (Se mantiene igual) */}
      {tipoUsuario === 'academico' && (
        <div className="mb-8">
          <ReportesGraficos tipoUsuario={tipoUsuario} />
        </div>
      )}

      {/* COMPONENTE DE FILTROS */}
      <ReporteFiltros 
        tipoUsuario={tipoUsuario}
        filtros={filtros}
        setFiltros={setFiltros}
        loading={loading}
        onConsultar={handleConsultar}
        onLimpiar={handleLimpiar}
        listas={{
            actividadesDisponibles,
            loadingActividades,
            carreras,
            loadingCarreras
        }}
      />

      {/* COMPONENTE DE LISTADO */}
      <ReporteLista 
        items={items}
        csvUrl={csvUrl}
        mensaje={mensaje}
        onDownload={handleDownload}
        totalRecords={totalRecords}
        currentPage={currentPage}
        pageSize={pageSize}
      />

      {/* COMPONENTE DE PAGINACIÓN */}
      {items.length > 0 && (
        <Paginacion
          currentPage={currentPage}
          totalPages={totalPages}
          onPageChange={handlePageChange}
          loading={loading}
        />
      )}

    </div>
  );
}

export default ReporteForm;