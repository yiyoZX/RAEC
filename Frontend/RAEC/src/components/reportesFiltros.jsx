import React from 'react';
import Button from './Button';

function ReporteFiltros({ 
  tipoUsuario,
  idRol, 
  filtros, 
  setFiltros, 
  listas, 
  loading, 
  onConsultar, 
  onLimpiar 
}) {
  // Desestructuramos para facilitar lectura
  const { rut, tipoActividad, actividad, fechaInicio, fechaFin, estado, carrera, horas, profesor, fechaActInicio, fechaActFin } = filtros;
  const { actividadesDisponibles, loadingActividades, carreras, loadingCarreras, profesores, loadingProfesores } = listas;

  const esProfesor = idRol === 1;
  const esDirector = idRol === 2;

  const handleChange = (field, value) => {
    setFiltros(prev => ({ ...prev, [field]: value }));
  };

  const handleActividadChange = (idActividad) => {
    setFiltros(prev => {
        const seleccionActual = prev.actividad || []; 
        
        if (seleccionActual.includes(idActividad)) {
            return { ...prev, actividad: seleccionActual.filter(id => id !== idActividad) };
        } else {
            return { ...prev, actividad: [...seleccionActual, idActividad] };
        }
    });
  };

  const handleCarreraChange = (codigoCarrera) => {
    setFiltros(prev => {
        const seleccionActual = prev.carrera || []; 
        
        if (seleccionActual.includes(codigoCarrera)) {
            return { 
                ...prev, carrera: seleccionActual.filter(c => c !== codigoCarrera) };
        } else {
            return { ...prev, carrera: [...seleccionActual, codigoCarrera] };
        }
    });
  };

  const handleProfesorChange = (codigoProfesor) => {
    setFiltros(prev => {
        const seleccionActual = prev.profesor || []; 
        
        if (seleccionActual.includes(codigoProfesor)) {
            return { 
                ...prev, profesor: seleccionActual.filter(p => p !== codigoProfesor) };
        } else {
            return { ...prev, profesor: [...seleccionActual, codigoProfesor] };
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
              onChange={e => { handleChange('tipoActividad', e.target.value); handleChange('actividad', []); }} 
              className="border border-gray-300 rounded px-3 py-2 bg-white outline-none focus:ring-2 focus:ring-purple-500"
            >
              <option value="">Todas</option>
              <option value="academica">Académica</option>
              <option value="no_academica">No Académica</option>
            </select>
          </div>

          <div className="flex flex-col">
            <label className="text-sm font-semibold text-gray-600 mb-1">Actividad Específica</label>
            
            <div className="border border-gray-300 rounded p-2 h-32 overflow-y-auto bg-white disabled:bg-gray-100">
                {loadingActividades ? (
                    <p className="text-xs text-gray-500">Cargando...</p>
                ) : (
                    actividadesDisponibles.map(a => (
                        <label key={a.value} className="flex items-center space-x-2 mb-1 cursor-pointer hover:bg-gray-50 p-1 rounded">
                            <input 
                                type="checkbox" 
                                value={a.value}
                                // Verificamos si el ID está en el array
                                checked={actividad.includes(a.value)}
                                onChange={() => handleActividadChange(a.value)}
                                className="rounded text-purple-600 focus:ring-purple-500"
                            />
                            <span className="text-sm text-gray-700">{a.label}</span>
                        </label>
                    ))
                )}
                
                {/* Mensaje si no hay datos */}
                {!loadingActividades && actividadesDisponibles.length === 0 && (
                    <p className="text-xs text-gray-400 italic">Sin actividades disponibles</p>
                )}
            </div>
            <p className="text-xs text-gray-400 mt-1">
                {actividad.length} seleccionadas
            </p>
        </div>

        {!esProfesor && !esDirector &&(          
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
        )}

          <div className="flex flex-col">
            <label className="text-sm font-semibold text-gray-600 mb-1">Horas realizadas</label>
            <input 
              value={horas} 
              onChange={e => handleChange('horas', e.target.value)} 
              type="text" placeholder="Ej: 10"
              className="border border-gray-300 rounded px-3 py-2 outline-none focus:ring-2 focus:ring-purple-500" 
            />
          </div>

        {!esProfesor && (  
          <div className="flex flex-col">
            <label className="text-sm font-semibold text-gray-600 mb-1">Profesor (Selección Múltiple)</label>
            
            {/* Contenedor con scroll para que no ocupe tanto espacio */}
            <div className="border border-gray-300 rounded p-2 h-32 overflow-y-auto bg-white">
                
                {loadingCarreras && <p className="text-xs text-gray-500">Cargando profesores...</p>}
                
                {!loadingProfesores && profesores.map(p => (
                    <label key={p.value} className="flex items-center space-x-2 mb-1 cursor-pointer hover:bg-gray-50 p-1 rounded">
                        <input 
                            type="checkbox" 
                            value={p.value}
                            checked={profesor.includes(p.value)}
                            onChange={() => handleProfesorChange(p.value)}
                            className="rounded text-purple-600 focus:ring-purple-500"
                        />
                        <span className="text-sm text-gray-700">{p.label}</span>
                    </label>
                ))}
            </div>
            <p className="text-xs text-gray-400 mt-1">
                {profesor.length} seleccionadas
            </p>
          </div>
        )}
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