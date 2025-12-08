import React from 'react';
import Button from './Button';

function ReporteFiltros({ 
  tipoUsuario, 
  filtros, 
  setFiltros, 
  listas, 
  loading, 
  onConsultar, 
  onLimpiar 
}) {
  // Desestructuramos para facilitar lectura
  const { rut, tipoActividad, actividad, fechaInicio, fechaFin, estado, carrera, horas, fechaActInicio, fechaActFin } = filtros;
  const { actividadesDisponibles, loadingActividades, carreras, loadingCarreras } = listas;

  const handleChange = (field, value) => {
    setFiltros(prev => ({ ...prev, [field]: value }));
  };

  const handleCarreraChange = (codigoCarrera) => {
    setFiltros(prev => {
        const seleccionActual = prev.carrera || []; // Aseguramos que sea array
        
        // Verificamos si ya está seleccionado
        if (seleccionActual.includes(codigoCarrera)) {
            // SI YA ESTÁ: Lo sacamos (filtramos todos MENOS ese)
            return { 
                ...prev, 
                carrera: seleccionActual.filter(c => c !== codigoCarrera) 
            };
        } else {
            // SI NO ESTÁ: Lo agregamos al final
            return { 
                ...prev, 
                carrera: [...seleccionActual, codigoCarrera] 
            };
        }
    });
  };

  return (
    <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-200 mb-8">
      <h2 className="text-xl font-bold text-gray-800 mb-4 border-b pb-2">
        {tipoUsuario === 'academico' ? 'Buscador Avanzado' : 'Mis Registros'}
      </h2>

      {/* --- VISTA ACADÉMICO --- */}
      {tipoUsuario === 'academico' && (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          <div className="flex flex-col">
            <label className="text-sm font-semibold text-gray-600 mb-1">RUT Estudiante</label>
            <input 
              value={rut} 
              onChange={e => handleChange('rut', e.target.value)} 
              type="text" placeholder="Ej: 12.345.678-9" 
              className="border border-gray-300 rounded px-3 py-2 outline-none focus:ring-2 focus:ring-purple-500" 
            />
          </div>

          <div className="flex flex-col">
            <label className="text-sm font-semibold text-gray-600 mb-1">Tipo Actividad</label>
            <select 
              value={tipoActividad} 
              onChange={e => { handleChange('tipoActividad', e.target.value); handleChange('actividad', ''); }} 
              className="border border-gray-300 rounded px-3 py-2 bg-white outline-none focus:ring-2 focus:ring-purple-500"
            >
              <option value="">Todas</option>
              <option value="academica">Académica</option>
              <option value="no_academica">No Académica</option>
            </select>
          </div>

          <div className="flex flex-col">
            <label className="text-sm font-semibold text-gray-600 mb-1">Actividad Específica</label>
            <select 
              value={actividad} 
              onChange={e => handleChange('actividad', e.target.value)} 
              className="border border-gray-300 rounded px-3 py-2 bg-white outline-none disabled:bg-gray-100" 
              disabled={loadingActividades}
            >
              <option value="">Todas</option>
              {actividadesDisponibles.map(a => <option key={a.value} value={a.value}>{a.label}</option>)}
            </select>
          </div>

          <div className="flex flex-col">
            <label className="text-sm font-semibold text-gray-600 mb-1">Carreras (Selección Múltiple)</label>
            
            {/* Contenedor con scroll para que no ocupe tanto espacio */}
            <div className="border border-gray-300 rounded p-2 h-32 overflow-y-auto bg-white">
                
                {loadingCarreras && <p className="text-xs text-gray-500">Cargando carreras...</p>}
                
                {!loadingCarreras && carreras.map(c => (
                    <label key={c.value} className="flex items-center space-x-2 mb-1 cursor-pointer hover:bg-gray-50 p-1 rounded">
                        <input 
                            type="checkbox" 
                            value={c.value}
                            // Checked es true si el código está incluido en nuestro array 'carrera'
                            checked={carrera.includes(c.value)}
                            onChange={() => handleCarreraChange(c.value)}
                            className="rounded text-purple-600 focus:ring-purple-500"
                        />
                        <span className="text-sm text-gray-700">{c.label}</span>
                    </label>
                ))}
            </div>
            <p className="text-xs text-gray-400 mt-1">
                {carrera.length} seleccionadas
            </p>
          </div>

          <div className="flex flex-col">
            <label className="text-sm font-semibold text-gray-600 mb-1">Horas realizadas</label>
            <input 
              value={horas} 
              onChange={e => handleChange('horas', e.target.value)} 
              type="text" placeholder="Ej: 10"
              className="border border-gray-300 rounded px-3 py-2 outline-none focus:ring-2 focus:ring-purple-500" 
            />
          </div>

          <div className="flex flex-col">
            <label className="text-sm font-semibold text-gray-600 mb-1">Desde</label>
            <input type="date" value={fechaInicio} onChange={e => handleChange('fechaInicio', e.target.value)} className="border border-gray-300 rounded px-3 py-2 outline-none" />
          </div>

          <div className="flex flex-col">
            <label className="text-sm font-semibold text-gray-600 mb-1">Hasta</label>
            <input type="date" value={fechaFin} onChange={e => handleChange('fechaFin', e.target.value)} className="border border-gray-300 rounded px-3 py-2 outline-none" />
          </div>

          <div className="flex flex-col">
            <label className="text-sm font-semibold text-gray-600 mb-1">Inicio Actividad</label>
            <input type="date" value={fechaActInicio} onChange={e => handleChange('fechaActInicio', e.target.value)} className="border border-gray-300 rounded px-3 py-2 outline-none" />
          </div>

          <div className="flex flex-col">
            <label className="text-sm font-semibold text-gray-600 mb-1">Hasta</label>
            <input type="date" value={fechaActFin} onChange={e => handleChange('fechaActFin', e.target.value)} className="border border-gray-300 rounded px-3 py-2 outline-none" />
          </div>
        </div>
      )}

      {/* --- VISTA ESTUDIANTE --- */}
      {tipoUsuario === 'estudiante' && (
        <div className="max-w-md">
           <label className="text-sm font-semibold text-gray-600 mb-1 block">Estado de Solicitud</label>
           <select 
              value={estado} 
              onChange={e => handleChange('estado', e.target.value)} 
              className="w-full border border-gray-300 rounded px-3 py-2 bg-white outline-none focus:ring-2 focus:ring-purple-500"
           >
            <option value="" disabled>-- Elige un estado --</option>
            <option value="pendientes">Pendientes</option>
            <option value="aprobadas">Aprobadas</option>
            <option value="rechazadas">Rechazadas</option>
          </select>
        </div>
      )}

      {/* BOTONES DE ACCIÓN */}
      <div className="mt-6 flex justify-end gap-3 border-t pt-4">
          {tipoUsuario === 'academico' && (
              <button 
                  onClick={onLimpiar}
                  className="px-4 py-2 text-gray-500 hover:text-gray-800 text-sm font-medium underline"
              >
                  Limpiar Filtros
              </button>
          )}
          <Button variant="primary" isLoading={loading} onClick={onConsultar}>
             {loading ? 'Consultando...' : 'Consultar'}
          </Button>
      </div>
    </div>
  );
}

export default ReporteFiltros;