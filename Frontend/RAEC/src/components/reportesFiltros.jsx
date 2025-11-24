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
  const { rut, tipoActividad, actividad, fechaInicio, fechaFin, estado } = filtros;
  const { actividadesDisponibles, loadingActividades } = listas;

  const handleChange = (field, value) => {
    setFiltros(prev => ({ ...prev, [field]: value }));
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
            <label className="text-sm font-semibold text-gray-600 mb-1">Desde</label>
            <input type="date" value={fechaInicio} onChange={e => handleChange('fechaInicio', e.target.value)} className="border border-gray-300 rounded px-3 py-2 outline-none" />
          </div>

          <div className="flex flex-col">
            <label className="text-sm font-semibold text-gray-600 mb-1">Hasta</label>
            <input type="date" value={fechaFin} onChange={e => handleChange('fechaFin', e.target.value)} className="border border-gray-300 rounded px-3 py-2 outline-none" />
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