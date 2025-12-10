import { useState } from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import HeaderLayout from '../layouts/HeaderLayout';
import Button from '../components/Button';
import '../styles/App.css';
import { authenticatedFetchFormData } from '../services/api';

function ConfigurarPeriodos() {
  const [regular, setRegular] = useState({
    inicio: new Date(),
    termino: new Date(),
  });

  const [extra, setExtra] = useState({
    inicio: new Date(),
    termino: new Date(),
  });

  const [mostrarExtra, setMostrarExtra] = useState(false);
  const [mostrarRegular, setMostrarRegular] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Validar que al menos un período esté activado
    if (!mostrarRegular && !mostrarExtra) {
      alert('⚠️ Debe activar al menos un período (Regular o Extraordinario) para guardar cambios');
      return;
    }

    const formData = new FormData();
    
    if (mostrarRegular) {
      formData.append('regular_inicio', regular.inicio.toISOString().split('T')[0]);
      formData.append('regular_termino', regular.termino.toISOString().split('T')[0]);
    }
    if (mostrarExtra) {
      formData.append('extra_inicio', extra.inicio.toISOString().split('T')[0]);
      formData.append('extra_termino', extra.termino.toISOString().split('T')[0]);
    }

    try {
      const res = await authenticatedFetchFormData('/periodos/', {
        method: 'POST',
        body: formData
      });

      const text = await res.clone().text();
      console.log('Response body:', text);

      if (!res.ok) {
        console.error('Backend returned error:', text);
        throw new Error(text || 'Error backend');
      }
      alert('Períodos guardados correctamente ✅');
    } catch (err) {
      console.error('Error enviando periodos:', err);
      alert('No se pudo guardar los períodos ❌');
    }
  };

  return (
    <HeaderLayout showBack backTo="/dashboard" title="RAEC - Configuración de Períodos">
      <div className="w-full max-w-4xl mx-auto px-6 py-10">
        <div className="bg-white rounded-2xl shadow-lg p-8">
          <h2 className="text-3xl font-bold text-gray-900 mb-8 text-center">
            Configuración de Períodos de Inscripción
          </h2>

          <form onSubmit={handleSubmit} className="space-y-8">

            {/* Switch para el periodo regular */}
            <div className="flex items-center justify-start">
              <div className="flex items-center gap-3">
                <span className="text-sm font-medium text-gray-700">Período Regular</span>
                <label className="relative inline-flex items-center cursor-pointer">
                  <input type="checkbox" className="sr-only" checked={mostrarRegular} onChange={() => setMostrarRegular(!mostrarRegular)} />
                  <div
                    className="w-11 h-6 rounded-full transition"
                    // usar el color de la variante `primary` definido en Button.jsx (bg-blue-600)
                    style={{ backgroundColor: mostrarRegular ? '#2563eb' : '#e5e7eb' }}
                  />
                  <div className={`absolute left-1 top-1 bg-white w-4 h-4 rounded-full transform transition ${mostrarRegular ? 'translate-x-5' : ''}`} />
                </label>
              </div>
            </div>

            {/* Período de inscripción regular (kept in DOM but visually collapsed/disabled when off) */}
            <section className={`border-t border-gray-200 pt-6 transition-all duration-300 overflow-hidden ${mostrarRegular ? 'max-h-[1000px] opacity-100' : 'max-h-0 opacity-40 pointer-events-none'}`}>
              <h3 className="text-xl font-semibold text-gray-800 mb-4">Período Regular</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                  <label className="block text-sm font-semibold text-gray-700 mb-2">Inicio</label>
                  <DatePicker
                    selected={regular.inicio}
                    onChange={(date) => setRegular({ ...regular, inicio: date })}
                    dateFormat="dd/MM/yyyy"
                    showYearDropdown
                    showMonthDropdown
                    className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition"
                  />
                </div>

                <div>
                  <label className="block text-sm font-semibold text-gray-700 mb-2">Término</label>
                  <DatePicker
                    selected={regular.termino}
                    onChange={(date) => setRegular({ ...regular, termino: date })}
                    dateFormat="dd/MM/yyyy"
                    showYearDropdown
                    showMonthDropdown
                    minDate={regular.inicio}
                    className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition"
                  />
                </div>
              </div>
            </section>
            {/* Switch para periodo extraordinario */}
            <div className="flex items-center justify-start">
              <div className="flex items-center gap-3">
                <span className="text-sm font-medium text-gray-700">Período Extraordinario</span>
                <label className="relative inline-flex items-center cursor-pointer">
                  <input type="checkbox" className="sr-only" checked={mostrarExtra} onChange={() => setMostrarExtra(!mostrarExtra)} />
                  <div
                    className="w-11 h-6 rounded-full transition"
                    // usar el color de la variante `primary` definido en Button.jsx (bg-blue-600)
                    style={{ backgroundColor: mostrarExtra ? '#2563eb' : '#e5e7eb' }}
                  />
                  <div className={`absolute left-1 top-1 bg-white w-4 h-4 rounded-full transform transition ${mostrarExtra ? 'translate-x-5' : ''}`} />
                </label>
              </div>
            </div>

            {/* Períodos extraordinarios de inscripción */}
            <section className={`border-t border-gray-200 pt-6 transition-all duration-300 overflow-hidden ${mostrarExtra ? 'max-h-[1000px] opacity-100' : 'max-h-0 opacity-40 pointer-events-none'}`}>
                <h3 className="text-xl font-semibold text-gray-800 mb-4">Período Extraordinario</h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div>
                    <label className="block text-sm font-semibold text-gray-700 mb-2">Inicio</label>
                    <DatePicker
                      selected={extra.inicio}
                      onChange={(date) => setExtra({ ...extra, inicio: date })}
                      dateFormat="dd/MM/yyyy"
                      showYearDropdown
                      showMonthDropdown
                      className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-yellow-500 focus:border-transparent transition"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold text-gray-700 mb-2">Término</label>
                    <DatePicker
                      selected={extra.termino}
                      onChange={(date) => setExtra({ ...extra, termino: date })}
                      dateFormat="dd/MM/yyyy"
                      showYearDropdown
                      showMonthDropdown
                      minDate={extra.inicio}
                      className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-yellow-500 focus:border-transparent transition"
                    />
                  </div>
                </div>
              </section>

            {/* Botones */}
            <div className="flex gap-4 pt-6">
              <Button
                type="reset"
                variant="secondary"
                className="flex-1"
                onClick={() => {
                  setRegular({ inicio: new Date(), termino: new Date() });
                  setExtra({ inicio: new Date(), termino: new Date() });
                  setMostrarExtra(false);
                  setMostrarRegular(false);
                }}
              >
                Restablecer
              </Button>
              <Button
                type="submit"
                variant="primary"
                className="flex-1"
              >
                Guardar Cambios
              </Button>
            </div>
          </form>
        </div>
      </div>
    </HeaderLayout>
  );
}

export default ConfigurarPeriodos;