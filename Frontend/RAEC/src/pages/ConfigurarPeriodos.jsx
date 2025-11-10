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
      const res = await authenticatedFetchFormData('http://localhost:4001/periodos/', formData);

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
    <HeaderLayout showBack title="RAEC - Configuración de Períodos">
      <div className="w-full max-w-4xl mx-auto px-6 py-10">
        <div className="bg-white rounded-2xl shadow-lg p-8">
          <h2 className="text-3xl font-bold text-gray-900 mb-8 text-center">
            Configuración de Períodos de Inscripción
          </h2>

          <form onSubmit={handleSubmit} className="space-y-8">

            {/* Botón de período de inscripción regular */}
            <div className="text-center">
              <Button
                type="button"
                variant="warning"
                className="bg-yellow-500 hover:bg-yellow-600 text-white font-semibold px-6 py-3 rounded-xl shadow-lg transition transform hover:scale-105"
                onClick={() => setMostrarRegular(!mostrarRegular)}
              >
                {mostrarRegular ? 'Ocultar Período Regular' : 'Configurar Período Regular'}
              </Button>
            </div>

            {/* Período de inscripción regular */}
            {mostrarRegular&& (
              <section className="border-t border-gray-200 pt-6">
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
            )}

            {/* Botón de período de inscripción extraordinarios */}
            <div className="text-center">
              <Button
                type="button"
                variant="warning"
                className="bg-yellow-500 hover:bg-yellow-600 text-white font-semibold px-6 py-3 rounded-xl shadow-lg transition transform hover:scale-105"
                onClick={() => setMostrarExtra(!mostrarExtra)}
              >
                {mostrarExtra ? 'Ocultar Período Extraordinario' : 'Configurar Período Extraordinario'}
              </Button>
            </div>

            {/* Períodos extraordinarios de inscripción */}
            {mostrarExtra && (
              <section className="border-t border-gray-200 pt-6">
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
            )}

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