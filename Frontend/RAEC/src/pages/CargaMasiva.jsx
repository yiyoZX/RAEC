import { useState } from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import HeaderLayout from '../layouts/HeaderLayout';
import Button from '../components/Button';
import '../styles/App.css';
import { authenticatedFetchFormData } from '../services/api';

function CargaMasiva() {
  const [tipoEntidad, setTipoEntidad] = useState('');
  const [archivo, setArchivo] = useState(null);
  const [nombreArchivo, setNombreArchivo] = useState('');
  const [loading, setLoading] = useState(false);
  const [mensaje, setMensaje] = useState({ tipo: '', texto: '' });

  // Instrucciones según el tipo de entidad
  const instrucciones = {
    alumnos: {
      titulo: 'Carga Masiva de Alumnos',
      descripcion: 'Sube un archivo CSV con la información de los alumnos a registrar.',
      columnas: [
        'rut_alumno (sin puntos, con guión. Ej: 12345678-9)',
        'nombres',
        'apellidos',
        'correo',
        'ano_egreso (año en formato numérico)',
        'id_carrera (número del 1 al 7)',
        'password (contraseña en texto plano, se encriptará automáticamente)'
      ],
      ejemplo: '12345678-9,Juan,Pérez González,juan.perez@alumnos.uach.cl,2024,1,password123'
    },
    profesores: {
      titulo: 'Carga Masiva de Profesores',
      descripcion: 'Sube un archivo CSV con la información de los profesores a registrar.',
      columnas: [
        'id_profesor (RUT sin puntos, con guión. Ej: 12345678-9)',
        'nombres',
        'apellidos',
        'correo',
        'id_instituto (número del 1 al 7)',
        'id_rol (1=profesor, 2=director, 3=admin)',
        'password (contraseña en texto plano, se encriptará automáticamente)'
      ],
      ejemplo: '98765432-1,María,González López,maria.gonzalez@uach.cl,1,1,password123'
    }
  };

  // Generar plantilla CSV según el tipo de entidad
  const descargarPlantilla = () => {
    if (!tipoEntidad) {
      setMensaje({ tipo: 'error', texto: 'Selecciona primero el tipo de entidad' });
      return;
    }

    const info = instrucciones[tipoEntidad];
    let csv = '';

    // Crear header
    if (tipoEntidad === 'alumnos') {
      csv = 'rut_alumno,nombres,apellidos,correo,ano_egreso,id_carrera,password\n';
      csv += '12345678-9,Juan,Pérez González,juan.perez@alumnos.uach.cl,2024,1,password123\n';
      csv += '23456789-0,María,López Silva,maria.lopez@alumnos.uach.cl,2025,2,password123\n';
    } else if (tipoEntidad === 'profesores') {
      csv = 'id_profesor,nombres,apellidos,correo,id_instituto,id_rol,password\n';
      csv += '98765432-1,María,González López,maria.gonzalez@uach.cl,1,1,password123\n';
      csv += '87654321-2,Pedro,Ramírez Torres,pedro.ramirez@uach.cl,2,2,password123\n';
    }

    // Crear elemento para descargar
    const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
    const link = document.createElement('a');
    const url = URL.createObjectURL(blob);
    link.setAttribute('href', url);
    link.setAttribute('download', `plantilla_${tipoEntidad}.csv`);
    link.style.visibility = 'hidden';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);

    setMensaje({ tipo: 'success', texto: 'Plantilla descargada exitosamente' });
  };

  // Manejar selección de archivo
  const handleArchivoChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      if (!file.name.endsWith('.csv')) {
        setMensaje({ tipo: 'error', texto: 'Por favor selecciona un archivo CSV' });
        return;
      }
      setArchivo(file);
      setNombreArchivo(file.name);
      setMensaje({ tipo: '', texto: '' });
    }
  };

  // Enviar archivo al backend
  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!tipoEntidad) {
      setMensaje({ tipo: 'error', texto: 'Selecciona el tipo de entidad' });
      return;
    }

    if (!archivo) {
      setMensaje({ tipo: 'error', texto: 'Selecciona un archivo CSV' });
      return;
    }

    setLoading(true);
    setMensaje({ tipo: '', texto: '' });

    try {
      const formData = new FormData();
      formData.append('file', archivo);
      formData.append('tipo_entidad', tipoEntidad);

      const response = await authenticatedFetchFormData(
        '/carga-masiva',
        {
          method: 'POST',
          body: formData
        }
      );

      if (response.ok) {
        const data = await response.json();
        setMensaje({ 
          tipo: 'success', 
          texto: `Carga exitosa: ${data.insertados || 0} registros insertados` 
        });
        setArchivo(null);
        setNombreArchivo('');
        // Limpiar input file
        document.getElementById('file-input').value = '';
      } else {
        const error = await response.json();
        setMensaje({ 
          tipo: 'error', 
          texto: error.detail || 'Error al procesar el archivo' 
        });
      }
    } catch (error) {
      console.error('Error:', error);
      setMensaje({ 
        tipo: 'error', 
        texto: 'Error de conexión. Verifica que el servidor esté activo.' 
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <HeaderLayout>
      <div className="container mx-auto px-4 py-8 max-w-4xl">
        <h1 className="text-3xl font-bold text-gray-800 mb-6">Carga Masiva de Datos</h1>
        
        <div className="bg-white rounded-lg shadow-md p-6 mb-6">
          {/* Selector de tipo de entidad */}
          <div className="mb-6">
            <label className="block text-gray-700 text-sm font-bold mb-2">
              Tipo de Entidad *
            </label>
            <select
              value={tipoEntidad}
              onChange={(e) => {
                setTipoEntidad(e.target.value);
                setArchivo(null);
                setNombreArchivo('');
                setMensaje({ tipo: '', texto: '' });
              }}
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <option value="">Selecciona una opción</option>
              <option value="alumnos">Alumnos</option>
              <option value="profesores">Profesores</option>
            </select>
          </div>

          {/* Instrucciones */}
          {tipoEntidad && instrucciones[tipoEntidad] && (
            <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
              <h3 className="text-lg font-semibold text-blue-800 mb-2">
                {instrucciones[tipoEntidad].titulo}
              </h3>
              <p className="text-gray-700 mb-3">
                {instrucciones[tipoEntidad].descripcion}
              </p>
              
              <div className="mb-3">
                <p className="font-semibold text-gray-800 mb-2">Columnas requeridas:</p>
                <ul className="list-disc list-inside text-sm text-gray-700 space-y-1">
                  {instrucciones[tipoEntidad].columnas.map((col, idx) => (
                    <li key={idx}>{col}</li>
                  ))}
                </ul>
              </div>

              <div className="bg-white rounded p-3 mt-3">
                <p className="font-semibold text-gray-800 text-sm mb-1">Ejemplo de fila:</p>
                <code className="text-xs text-gray-600 break-all">
                  {instrucciones[tipoEntidad].ejemplo}
                </code>
              </div>
            </div>
          )}

          {/* Botón descargar plantilla */}
          {tipoEntidad && (
            <div className="mb-6">
              <Button
                onClick={descargarPlantilla}
                className="w-full md:w-auto bg-green-600 hover:bg-green-700 text-white"
              >
                📥 Descargar Plantilla CSV
              </Button>
            </div>
          )}

          {/* Selector de archivo */}
          <form onSubmit={handleSubmit}>
            <div className="mb-6">
              <label className="block text-gray-700 text-sm font-bold mb-2">
                Archivo CSV *
              </label>
              <div className="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center hover:border-blue-500 transition-colors">
                <input
                  id="file-input"
                  type="file"
                  accept=".csv"
                  onChange={handleArchivoChange}
                  className="hidden"
                  disabled={!tipoEntidad}
                />
                <label
                  htmlFor="file-input"
                  className={`cursor-pointer ${!tipoEntidad ? 'opacity-50 cursor-not-allowed' : ''}`}
                >
                  <div className="flex flex-col items-center">
                    <svg
                      className="w-12 h-12 text-gray-400 mb-2"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth="2"
                        d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
                      />
                    </svg>
                    <p className="text-gray-600 font-medium">
                      {nombreArchivo || 'Haz clic para seleccionar un archivo CSV'}
                    </p>
                    <p className="text-gray-400 text-sm mt-1">
                      o arrastra y suelta aquí
                    </p>
                  </div>
                </label>
              </div>
            </div>

            {/* Mensajes */}
            {mensaje.texto && (
              <div
                className={`mb-6 p-4 rounded-lg ${
                  mensaje.tipo === 'success'
                    ? 'bg-green-100 border border-green-400 text-green-700'
                    : 'bg-red-100 border border-red-400 text-red-700'
                }`}
              >
                {mensaje.texto}
              </div>
            )}

            {/* Botón enviar */}
            <div className="flex justify-end">
              <Button
                type="submit"
                disabled={!tipoEntidad || !archivo || loading}
                className={`${
                  loading || !tipoEntidad || !archivo
                    ? 'bg-gray-400 cursor-not-allowed'
                    : 'bg-blue-600 hover:bg-blue-700'
                } text-white px-8 py-2`}
              >
                {loading ? '⏳ Procesando...' : '📤 Cargar Datos'}
              </Button>
            </div>
          </form>
        </div>

        {/* Información adicional */}
        <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-4">
          <h4 className="font-semibold text-yellow-800 mb-2">⚠️ Importante:</h4>
          <ul className="text-sm text-yellow-700 space-y-1 list-disc list-inside">
            <li>El archivo debe estar en formato CSV con codificación UTF-8</li>
            <li>La primera fila debe contener los nombres de las columnas</li>
            <li>Los RUTs deben incluir el guión pero no puntos (Ej: 12345678-9)</li>
            <li>Las fechas deben estar en formato YYYY-MM-DD</li>
            <li>Asegúrate de que los IDs de referencias existan en la base de datos</li>
          </ul>
        </div>
      </div>
    </HeaderLayout>
  );
}

export default CargaMasiva;