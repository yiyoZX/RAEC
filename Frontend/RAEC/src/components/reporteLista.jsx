import React, { useState } from 'react';
import Button from './Button';

function ReporteLista({ items, csvUrl, mensaje, onDownload, totalRecords, currentPage, pageSize, onDownloadCSV }) {
  const [expandedIndex, setExpandedIndex] = useState(null);
  const [downloadingCSV, setDownloadingCSV] = useState(false);

  // Calcular rango de registros mostrados
  const startRecord = items.length > 0 ? (currentPage - 1) * pageSize + 1 : 0;
  const endRecord = Math.min((currentPage - 1) * pageSize + items.length, totalRecords || items.length);

  const handleCSVDownload = async (e) => {
    e.preventDefault();
    setDownloadingCSV(true);
    try {
      await onDownloadCSV();
    } finally {
      setDownloadingCSV(false);
    }
  };

  return (
    <div>
      <div className="flex justify-between items-center mb-4">
          <div>
            <h3 className="font-bold text-gray-700 text-lg">
              Resultados {totalRecords > 0 && `(${totalRecords} total)`}
            </h3>
            {items.length > 0 && totalRecords > 0 && (
              <p className="text-sm text-gray-500 mt-1">
                Mostrando {startRecord} - {endRecord} de {totalRecords} registros
              </p>
            )}
          </div>
          {csvUrl && onDownloadCSV && (
              <button 
                onClick={handleCSVDownload}
                disabled={downloadingCSV}
                className="text-sm text-green-700 font-bold hover:underline flex items-center gap-1 disabled:opacity-50 disabled:cursor-not-allowed"
                title={`Descargar archivo CSV con TODOS los ${totalRecords || 0} registros filtrados (no solo la página actual)`}
              >
                  <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" /></svg>
                  {downloadingCSV ? 'Descargando todos los datos...' : `Descargar CSV Completo (${totalRecords || 0} registros)`}
              </button>
          )}
      </div>

      {mensaje ? (
        <div className="text-center py-10 border-2 border-dashed border-gray-300 rounded-lg text-gray-500 bg-gray-50">
            {mensaje}
        </div>
      ) : (
        <ul className="space-y-3">
          {items.map((item, i) => {
            // Normalización de datos
            const nombre = item.nombre_actividad ?? item.actividad ?? 'Sin nombre';
            const fecha = item.fecha_creacion ?? item.fecha ?? '';
            const titulo = (item.nombres && item.apellidos) ? `${item.apellidos}, ${item.nombres}` : nombre;
            const isExpanded = expandedIndex === i;

            return (
              <li key={i} className="bg-white border rounded-lg shadow-sm overflow-hidden hover:shadow-md transition-shadow">
                {/* Cabecera Clickable */}
                <div 
                  className="px-4 py-3 cursor-pointer hover:bg-purple-50 flex justify-between items-center transition-colors"
                  onClick={() => setExpandedIndex(isExpanded ? null : i)}
                >
                  <div>
                    <div className="font-bold text-gray-800 flex items-center gap-2">
                      {titulo}
                      {item.tiene_archivo && (
                        <span className="text-blue-600" title="Tiene archivo adjunto">📎</span>
                      )}
                    </div>
                    {item.rut && <div className="text-xs text-gray-500 font-mono">{item.rut}</div>}
                  </div>
                  <div className="flex items-center gap-3">
                     {item.estado && (
                        <span className={`text-xs px-2 py-1 rounded border font-medium uppercase ${
                           item.estado === 'Aprobada' ? 'bg-green-100 text-green-800 border-green-200' :
                           item.estado === 'Rechazada' ? 'bg-red-100 text-red-800 border-red-200' :
                           'bg-yellow-100 text-yellow-800 border-yellow-200'
                        }`}>
                           {item.estado}
                        </span>
                     )}
                     <svg className={`w-5 h-5 text-gray-400 transition-transform ${isExpanded ? 'rotate-180' : ''}`} fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" /></svg>
                  </div>
                </div>

                {/* Detalle Expandido */}
                {isExpanded && (
                  <div className="px-4 py-4 bg-gray-50 border-t border-gray-200 text-sm text-gray-700">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-y-2 gap-x-4 mb-3">
                       
                       {/* === AQUI ESTÁ EL CAMBIO: CAMPO ACTIVIDAD === */}
                       <p><strong className="text-gray-900">Actividad:</strong> {nombre}</p>
                       
                       {item.carrera && <p><strong className="text-gray-900">Carrera:</strong> {item.carrera}</p>}
                       {item.horas_totales && <p><strong className="text-gray-900">Horas:</strong> {item.horas_totales}</p>}
                       {fecha && <p><strong className="text-gray-900">Fecha Solicitud:</strong> {new Date(fecha).toLocaleDateString()}</p>}
                       {item.profesor_nombres && <p><strong className="text-gray-900">Profesor:</strong> {item.profesor_nombres} {item.profesor_apellidos}</p>}
                       {item.fecha_inicio_actividad && <p><strong className="text-gray-900">Inicio Actividad:</strong> {new Date(item.fecha_inicio_actividad).toLocaleDateString()}</p>}
                    </div>
                    
                    {/* Campos extras de la actividad (si existen) */}
                    {(item.campo_extra_1_label || item.campo_extra_2_label || item.campo_extra_3_label) && (
                      <div className="mb-3 p-3 bg-purple-50 border border-purple-200 rounded">
                        <p className="text-xs font-semibold text-purple-700 mb-2 uppercase">📋 Información Adicional</p>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-y-1 gap-x-4 text-sm">
                          {item.campo_extra_1_label && item.campo_extra_1_valor && (
                            <p><strong className="text-purple-900">{item.campo_extra_1_label}:</strong> <span className="text-gray-700">{item.campo_extra_1_valor}</span></p>
                          )}
                          {item.campo_extra_2_label && item.campo_extra_2_valor && (
                            <p><strong className="text-purple-900">{item.campo_extra_2_label}:</strong> <span className="text-gray-700">{item.campo_extra_2_valor}</span></p>
                          )}
                          {item.campo_extra_3_label && item.campo_extra_3_valor && (
                            <p><strong className="text-purple-900">{item.campo_extra_3_label}:</strong> <span className="text-gray-700">{item.campo_extra_3_valor}</span></p>
                          )}
                        </div>
                      </div>
                    )}
                    
                    {item.comentario && (
                       <div className="p-3 bg-white border border-gray-200 rounded italic text-gray-600 mb-3 relative">
                          <span className="absolute -top-2 left-2 bg-white px-1 text-xs text-gray-400">Decripcion</span>
                          "{item.comentario}"
                       </div>
                    )}

                    {/* Mostrar información de archivo adjunto */}
                    <div className="border-t border-gray-200 pt-3">
                      {item.tiene_archivo ? (
                        <div className="flex items-center justify-between">
                          <div className="flex items-center gap-2 text-sm text-gray-600">
                            <span>📎</span>
                            <span className="font-medium">{item.archivo_nombre || 'Archivo adjunto'}</span>
                          </div>
                          <Button variant="primary" size="sm" onClick={(e) => onDownload(item, e)}>
                             Descargar
                          </Button>
                        </div>
                      ) : (
                        <p className="text-xs text-gray-400 italic">Sin archivo adjunto</p>
                      )}
                    </div>
                  </div>
                )}
              </li>
            );
          })}
        </ul>
      )}
    </div>
  );
}

export default ReporteLista;