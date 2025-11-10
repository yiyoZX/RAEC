import { useState, useEffect } from 'react';
import { BarChart, Bar, PieChart, Pie, Cell, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

const COLORS = ['#9333ea', '#c084fc', '#a855f7', '#d8b4fe', '#e9d5ff', '#f3e8ff', '#7c3aed', '#6b21a8'];

function ReportesGraficos({ tipoUsuario }) {
  const [mostrarGraficos, setMostrarGraficos] = useState(false);
  const [dataCarreras, setDataCarreras] = useState([]);
  const [dataActividades, setDataActividades] = useState([]);
  const [dataEstados, setDataEstados] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const cargarEstadisticas = async () => {
    setLoading(true);
    setError(null);
    const token = localStorage.getItem('access_token') || '';
    
    try {
      // Cargar estadísticas de carreras (solo para académicos)
      if (tipoUsuario === 'academico') {
        const responseCarreras = await fetch('http://localhost:4001/reportes/estadisticas/carreras', {
          headers: { 'Authorization': `Bearer ${token}` }
        });
        if (responseCarreras.ok) {
          const carreras = await responseCarreras.json();
          setDataCarreras(carreras);
        }

        // Cargar estadísticas de actividades
        const responseActividades = await fetch('http://localhost:4001/reportes/estadisticas/actividades', {
          headers: { 'Authorization': `Bearer ${token}` }
        });
        if (responseActividades.ok) {
          const actividades = await responseActividades.json();
          setDataActividades(actividades);
        }
      }

      // Cargar estadísticas de estados (para todos)
      const responseEstados = await fetch('http://localhost:4001/reportes/estadisticas/estados', {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      if (responseEstados.ok) {
        const estados = await responseEstados.json();
        setDataEstados(estados);
      }
    } catch (err) {
      setError('Error al cargar las estadísticas');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (mostrarGraficos) {
      cargarEstadisticas();
    }
  }, [mostrarGraficos]);

  const CustomTooltip = ({ active, payload }) => {
    if (active && payload && payload.length) {
      return (
        <div className="bg-white p-3 border border-purple-200 rounded-lg shadow-lg">
          <p className="font-semibold text-gray-800">{payload[0].name}</p>
          <p className="text-purple-600">Total: {payload[0].value}</p>
        </div>
      );
    }
    return null;
  };

  const CustomPieLabel = ({ cx, cy, midAngle, innerRadius, outerRadius, percent }) => {
    const RADIAN = Math.PI / 180;
    const radius = innerRadius + (outerRadius - innerRadius) * 0.5;
    const x = cx + radius * Math.cos(-midAngle * RADIAN);
    const y = cy + radius * Math.sin(-midAngle * RADIAN);

    return (
      <text 
        x={x} 
        y={y} 
        fill="white" 
        textAnchor={x > cx ? 'start' : 'end'} 
        dominantBaseline="central"
        className="text-xs font-semibold"
      >
        {`${(percent * 100).toFixed(0)}%`}
      </text>
    );
  };

  return (
    <div className="w-full max-w-6xl mx-auto mt-8">
      <button
        onClick={() => setMostrarGraficos(!mostrarGraficos)}
        className="w-full flex items-center justify-between px-6 py-4 bg-gradient-to-r from-purple-600 to-purple-700 text-white rounded-lg hover:from-purple-700 hover:to-purple-800 transition-all shadow-md"
      >
        <div className="flex items-center gap-3">
          <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
          </svg>
          <span className="text-lg font-semibold">
            {mostrarGraficos ? 'Ocultar' : 'Ver'} Estadísticas y Gráficos
          </span>
        </div>
        <svg 
          className={`w-6 h-6 transition-transform ${mostrarGraficos ? 'rotate-180' : ''}`}
          fill="none" 
          stroke="currentColor" 
          viewBox="0 0 24 24"
        >
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
        </svg>
      </button>

      {mostrarGraficos && (
        <div className="mt-6 space-y-6 animate-fadeIn">
          {loading && (
            <div className="text-center py-12">
              <div className="inline-block animate-spin rounded-full h-12 w-12 border-b-2 border-purple-600"></div>
              <p className="mt-4 text-gray-600">Cargando estadísticas...</p>
            </div>
          )}

          {error && (
            <div className="bg-red-50 border border-red-200 text-red-800 px-4 py-3 rounded-lg">
              {error}
            </div>
          )}

          {!loading && !error && (
            <>
              {/* Gráfico de Estados */}
              {dataEstados.length > 0 && (
                <div className="bg-white p-6 rounded-lg shadow-md border border-gray-200">
                  <h3 className="text-xl font-bold text-gray-800 mb-4 flex items-center gap-2">
                    <svg className="w-5 h-5 text-purple-600" fill="currentColor" viewBox="0 0 20 20">
                      <path d="M2 11a1 1 0 011-1h2a1 1 0 011 1v5a1 1 0 01-1 1H3a1 1 0 01-1-1v-5zM8 7a1 1 0 011-1h2a1 1 0 011 1v9a1 1 0 01-1 1H9a1 1 0 01-1-1V7zM14 4a1 1 0 011-1h2a1 1 0 011 1v12a1 1 0 01-1 1h-2a1 1 0 01-1-1V4z" />
                    </svg>
                    Distribución por Estado
                  </h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <PieChart>
                      <Pie
                        data={dataEstados}
                        dataKey="total"
                        nameKey="nombre"
                        cx="50%"
                        cy="50%"
                        outerRadius={100}
                        fill="#8884d8"
                        label={CustomPieLabel}
                        labelLine={false}
                      >
                        {dataEstados.map((entry, index) => (
                          <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                        ))}
                      </Pie>
                      <Tooltip content={<CustomTooltip />} />
                      <Legend />
                    </PieChart>
                  </ResponsiveContainer>
                </div>
              )}

              {/* Gráficos solo para académicos */}
              {tipoUsuario === 'academico' && (
                <>
                  {/* Gráfico de Carreras */}
                  {dataCarreras.length > 0 && (
                    <div className="bg-white p-6 rounded-lg shadow-md border border-gray-200">
                      <h3 className="text-xl font-bold text-gray-800 mb-4 flex items-center gap-2">
                        <svg className="w-5 h-5 text-purple-600" fill="currentColor" viewBox="0 0 20 20">
                          <path d="M10.394 2.08a1 1 0 00-.788 0l-7 3a1 1 0 000 1.84L5.25 8.051a.999.999 0 01.356-.257l4-1.714a1 1 0 11.788 1.838L7.667 9.088l1.94.831a1 1 0 00.787 0l7-3a1 1 0 000-1.838l-7-3zM3.31 9.397L5 10.12v4.102a8.969 8.969 0 00-1.05-.174 1 1 0 01-.89-.89 11.115 11.115 0 01.25-3.762zM9.3 16.573A9.026 9.026 0 007 14.935v-3.957l1.818.78a3 3 0 002.364 0l5.508-2.361a11.026 11.026 0 01.25 3.762 1 1 0 01-.89.89 8.968 8.968 0 00-5.35 2.524 1 1 0 01-1.4 0zM6 18a1 1 0 001-1v-2.065a8.935 8.935 0 00-2-.712V17a1 1 0 001 1z" />
                        </svg>
                        Distribución por Carrera
                      </h3>
                      <ResponsiveContainer width="100%" height={300}>
                        <BarChart data={dataCarreras}>
                          <CartesianGrid strokeDasharray="3 3" />
                          <XAxis dataKey="nombre" angle={-45} textAnchor="end" height={100} />
                          <YAxis />
                          <Tooltip content={<CustomTooltip />} />
                          <Bar dataKey="total" fill="#9333ea" />
                        </BarChart>
                      </ResponsiveContainer>
                    </div>
                  )}

                  {/* Gráfico de Actividades */}
                  {dataActividades.length > 0 && (
                    <div className="bg-white p-6 rounded-lg shadow-md border border-gray-200">
                      <h3 className="text-xl font-bold text-gray-800 mb-4 flex items-center gap-2">
                        <svg className="w-5 h-5 text-purple-600" fill="currentColor" viewBox="0 0 20 20">
                          <path fillRule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clipRule="evenodd" />
                        </svg>
                        Distribución por Actividad
                      </h3>
                      <ResponsiveContainer width="100%" height={400}>
                        <BarChart data={dataActividades} layout="vertical">
                          <CartesianGrid strokeDasharray="3 3" />
                          <XAxis type="number" />
                          <YAxis dataKey="nombre" type="category" width={150} />
                          <Tooltip content={<CustomTooltip />} />
                          <Bar dataKey="total" fill="#a855f7" />
                        </BarChart>
                      </ResponsiveContainer>
                    </div>
                  )}
                </>
              )}

              {/* Mensaje si no hay datos */}
              {dataEstados.length === 0 && dataCarreras.length === 0 && dataActividades.length === 0 && (
                <div className="text-center py-12 bg-gray-50 rounded-lg border border-gray-200">
                  <svg className="w-16 h-16 mx-auto text-gray-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                  </svg>
                  <p className="text-gray-600 text-lg">No hay datos para mostrar gráficos</p>
                </div>
              )}
            </>
          )}
        </div>
      )}
    </div>
  );
}

export default ReportesGraficos;
