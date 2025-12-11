import { useState, useMemo} from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import Button from '../components/Button';
import { useTodasActividades } from '../hooks/useActividades';
import { authenticatedFetchFormData } from '../services/api';
import {useListaOpciones} from '../hooks/useListaOpciones';

function FormularioActividad({ userRol, onSubmitSuccess }) {  // Props: userRol para lógica, onSubmitSuccess para callback después de éxito
  // Cargar actividades dinámicamente desde el backend

  const userDataStr = localStorage.getItem('user_data'); // Leemos el texto
  const userDataObj = userDataStr ? JSON.parse(userDataStr) : {};
  const idCarreraUsuario = userRol=== 'estudiante' ? userDataObj.id_carrera : null;

  const { academicas, noAcademicas, actividadesCompletas, loading: loadingActividades } = useTodasActividades();
  const { items: carreras, loading: loadC } = useListaOpciones('/carreras/listar', 'carreras');
  const { items: profesores, loading: loadP } = useListaOpciones('/profesores/listar', 'profesores');

  const [filtroCarrera, setFiltroCarrera] = useState("");
  
  const [values, setValues] = useState({
    rut: '',
    academica: '',
    actividad: '', 
    fecha_inicio: new Date(),
    fecha_termino: new Date(),
    horas_totales: '',
    archivos: null,
    about: '',
    profesor:'',
    // Campos dinámicos
    dato1: '',
    dato2: '',
    dato3: '',
  });

  // Estado para almacenar los nombres de los campos adicionales de la actividad seleccionada
  const [camposAdicionales, setCamposAdicionales] = useState({
    dato1: null,
    dato2: null,
    dato3: null,
  });

  // Estado para rastrear campos tocados
  const [touched, setTouched] = useState({});

  // Función para verificar si un campo está vacío
  const isFieldEmpty = (fieldName) => {
    const value = values[fieldName];
    return !value || value === '';
  };

  // Función para obtener clase de borde (rojo si está vacío y tocado)
  const getInputClass = (fieldName, baseClass) => {
    const isEmpty = isFieldEmpty(fieldName);
    const isTouched = touched[fieldName];
    if (isEmpty && isTouched) {
      return baseClass.replace('border-gray-300', 'border-red-500');
    }
    return baseClass;
  };

  const profesoresFiltrados = useMemo(() => {
    if (loadP) return [];

    // A. Si el usuario NO ha seleccionado ninguna carrera en el filtro, mostramos TODOS
    if (!filtroCarrera) {
        return profesores;
    }

    // B. Si seleccionó una carrera, filtramos la lista
    return profesores.filter(profe => {
       // Verificamos si el ID del filtro está en la lista de carreras del profe
       if (profe.carreraIds && Array.isArray(profe.carreraIds)) {
           return profe.carreraIds.some(id => id.toString() === filtroCarrera.toString());
       }
       // Fallback por si el backend manda solo id_instituto
       if (profe.id_instituto) {
           return profe.id_instituto.toString() === filtroCarrera.toString();
       }
       return false;
    });
  }, [profesores, filtroCarrera, loadP]);

  // Manejar blur (cuando el usuario sale del campo)
  const handleBlur = (fieldName) => {
    setTouched({ ...touched, [fieldName]: true });
  };

  const ResetFun = () => { 
    setValues({
      rut: '',
      academica: '',
      actividad: '',
      fecha_inicio: new Date(),
      fecha_termino: new Date(),
      horas_totales: '',
      archivos: null,
      about: '',
      dato1: '',
      dato2: '',
      dato3: '',
    });
    setCamposAdicionales({
      dato1: null,
      dato2: null,
      dato3: null,
    });
  };

  const handleChanges = (e) => {
    const { name, value, type, files } = e.target;
    setTouched({ ...touched, [name]: true });
    if (type === 'file') {
      const file = files[0];
      if (file) {
        const allowedTypes = ['application/pdf', 'image/png', 'image/jpeg'];
        if (!allowedTypes.includes(file.type)) { alert('Solo PDF, PNG o JPG'); return; }
        const maxSize = 5 * 1024 * 1024;
        if (file.size > maxSize) { alert('Archivo > 5MB'); return; }
        setValues({ ...values, [name]: file });
      }
    } else if (name === 'horas_totales') {
      const numValue = parseInt(value);
      if (value !== '' && (isNaN(numValue) || numValue <= 0)) { alert('Horas inválidas'); return; }
      setValues({ ...values, [name]: value });
    } else if (name === 'actividad') {
      // Cuando cambia la actividad, actualizar los campos adicionales
      setValues({ ...values, [name]: value, dato1: '', dato2: '', dato3: '' });
      
      // Buscar la actividad seleccionada en actividadesCompletas
      const actividadSeleccionada = actividadesCompletas.find(
        act => String(act.id_actividad) === value
      );
      
      if (actividadSeleccionada) {
        setCamposAdicionales({
          dato1: actividadSeleccionada.dato1 || null,
          dato2: actividadSeleccionada.dato2 || null,
          dato3: actividadSeleccionada.dato3 || null,
        });
      } else {
        setCamposAdicionales({ dato1: null, dato2: null, dato3: null });
      }
    } else {
      setValues({ ...values, [name]: value });
    }
  };

  const handleFechaInicioChange = (date) => setValues({ ...values, fecha_inicio: date });
  const handleFechaTerminoChange = (date) => setValues({ ...values, fecha_termino: date });

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!values.horas_totales || parseInt(values.horas_totales) <= 0) { alert('Ingrese horas'); return; }

    if (userRol === 'estudiante' && !values.profesor) {
        alert('Debes seleccionar un Profesor Guía');
        return;
    }


    const formData = new FormData();
    Object.entries(values).forEach(([k,v]) => {
      if (!v) return;

      if (k === 'profesor') {
          formData.append('id_profesor', v);
      }

      else if ((k === 'fecha_inicio' || k === 'fecha_termino') && v instanceof Date) formData.append(k, v.toISOString().split('T')[0]);
      else formData.append(k, v);
    });
    
    console.log('Enviando FormData con:', Object.fromEntries(formData));
    
    try {
      const res = await authenticatedFetchFormData('/submit',{method: 'POST', body: formData});
      if (!res.ok) throw new Error('Error backend');
      const data = await res.json();
      alert(data.message || 'Formulario enviado ✅');
      ResetFun();  // Resetea local
      if (onSubmitSuccess) onSubmitSuccess();  // Llama callback para navegación u otro
    } catch (err) {
      console.error('Error completo:', err);
      alert(`No se pudo enviar ❌\n${err.message}`);
    }
  };

  const canNoAcademica = userRol === 2 || userRol === 3 || userRol === 'estudiante';  // Directores (2), Administradores (3) y Estudiantes

  // Usar actividades cargadas desde el backend
  const opcionesAcademica = academicas;
  const opcionesNoAcademica = noAcademicas;

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      {/* RUT y Tipo de Actividad en la misma fila (solo si no es estudiante) */}
      {userRol !== 'estudiante' && (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {/* RUT */}
          <div>
            <label htmlFor="rut" className="block text-sm font-semibold text-gray-700 mb-2">RUT*</label>
            <input 
              type="text" 
              id="rut" 
              name="rut" 
              placeholder="Ej: 12345678-9" 
              value={values.rut} 
              onChange={handleChanges}
              onBlur={() => handleBlur('rut')}
              className={getInputClass('rut', 'w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition')}
              required 
            />
            {touched.rut && isFieldEmpty('rut') && (
              <p className="text-red-500 text-xs mt-1">Este campo es obligatorio</p>
            )}
          </div>

          {/* Tipo de Actividad */}
          <div>
            <label className="block text-sm font-semibold text-gray-700 mb-2">Tipo de Actividad*</label>
            <div className="flex items-center gap-6 h-12">
              <label className="inline-flex items-center cursor-pointer">
                <input type="radio" name="academica" value="1" checked={values.academica === '1'} onChange={handleChanges} className="w-4 h-4 text-blue-600 focus:ring-blue-500" required />
                <span className="ml-2 text-gray-700">Académica</span>
              </label>
              {canNoAcademica && (
                <label className="inline-flex items-center cursor-pointer">
                  <input type="radio" name="academica" value="2" checked={values.academica === '2'} onChange={handleChanges} className="w-4 h-4 text-blue-600 focus:ring-blue-500" />
                  <span className="ml-2 text-gray-700">No Académica</span>
                </label>
              )}
            </div>
          </div>
        </div>
      )}

      {/* Tipo de Actividad solo para estudiantes */}
      {userRol === 'estudiante' && (
        <div>
          <label className="block text-sm font-semibold text-gray-700 mb-2">Tipo de Actividad*</label>
          <div className="flex items-center gap-6 h-12">
            <label className="inline-flex items-center cursor-pointer">
              <input type="radio" name="academica" value="1" checked={values.academica === '1'} onChange={handleChanges} className="w-4 h-4 text-blue-600 focus:ring-blue-500" required />
              <span className="ml-2 text-gray-700">Académica</span>
            </label>
            <label className="inline-flex items-center cursor-pointer">
              <input type="radio" name="academica" value="2" checked={values.academica === '2'} onChange={handleChanges} className="w-4 h-4 text-blue-600 focus:ring-blue-500" />
              <span className="ml-2 text-gray-700">No Académica</span>
            </label>
          </div>
        </div>
      )};
      {/* SECCIÓN ESTUDIANTE: Filtro Dinámico + Selección Profesor */}
      {userRol === 'estudiante' && (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          
          {/* 1. FILTRO DE CARRERA (Opcional) */}
          <div>
            <label className="block text-sm font-semibold text-gray-700 mb-2">
              Filtrar Profesores por Carrera (Opcional)
            </label>
            <select
              value={filtroCarrera}
              onChange={(e) => setFiltroCarrera(e.target.value)}
              className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 transition bg-gray-50"
            >
              <option value="">-- Ver Todas las Carreras --</option>
              {!loadC && carreras.map(c => (
                  <option key={c.value} value={c.value}>{c.label}</option>
              ))}
            </select>
          </div>

          {/* 2. SELECTOR DE PROFESOR (Filtrado) */}
          <div>
            <label htmlFor="profesor" className="block text-sm font-semibold text-gray-700 mb-2">
              Profesor Guía / Supervisor*
            </label>
            <select
              id="profesor"
              name="profesor"
              value={values.profesor}
              onChange={handleChanges}
              onBlur={() => handleBlur('profesor')}
              className={getInputClass('profesor', 'w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition')}
              required
            >
              <option value="">
                {loadP ? 'Cargando profesores...' : '-- Seleccione un Profesor --'}
              </option>
              
              {/* Aquí usamos la lista dinámica 'profesoresFiltrados' */}
              {profesoresFiltrados.map((profe) => (
                <option key={profe.value} value={profe.value}>
                  {profe.label}
                </option>
              ))}
            </select>
            
            {touched.profesor && isFieldEmpty('profesor') && (
              <p className="text-red-500 text-xs mt-1">Debe seleccionar un profesor</p>
            )}
            
            {/* Mensaje de ayuda visual */}
            <p className="text-xs text-gray-400 mt-1">
                Mostrando {profesoresFiltrados.length} profesores
                {filtroCarrera ? ' de la carrera seleccionada.' : ' (Total Facultad).'}
            </p>
          </div>

        </div>
      )}

      {/* Mensaje informativo para profesores */}
      {userRol === 1 && (
        <div className="px-4 py-2 bg-blue-50 border border-blue-200 rounded-lg text-sm text-blue-800">
          ℹ️ Los profesores solo pueden registrar actividades académicas. Los directores y administradores pueden registrar ambos tipos.
        </div>
      )}

      {/* Actividad */}
      <div>
        <label htmlFor="actividad" className="block text-sm font-semibold text-gray-700 mb-2">Actividad*</label>
        <select 
          id="actividad" 
          name="actividad" 
          value={values.actividad} 
          onChange={handleChanges}
          onBlur={() => handleBlur('actividad')}
          disabled={!values.academica || loadingActividades} 
          className={getInputClass('actividad', 'w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition disabled:bg-gray-100 disabled:cursor-not-allowed')}
          required
        >
          <option value="">{loadingActividades ? 'Cargando actividades...' : 'Seleccione una actividad'}</option>
          {(values.academica === '1' ? opcionesAcademica : values.academica === '2' ? opcionesNoAcademica : []).map(op => (
            <option key={op.value} value={op.value}>{op.label}</option>
          ))}
        </select>
        {touched.actividad && isFieldEmpty('actividad') && (
          <p className="text-red-500 text-xs mt-1">Este campo es obligatorio</p>
        )}
      </div>

      {/* Campos Adicionales Dinámicos */}
      {values.actividad && (camposAdicionales.dato1 || camposAdicionales.dato2 || camposAdicionales.dato3) && (
        <div className="bg-purple-50 border border-purple-200 rounded-lg p-4 space-y-4">
          <h3 className="text-sm font-semibold text-purple-800 mb-3">
            📋 Información Adicional de la Actividad
          </h3>
          
          {camposAdicionales.dato1 && (
            <div>
              <label htmlFor="dato1" className="block text-sm font-semibold text-gray-700 mb-2">
                {camposAdicionales.dato1}
              </label>
              <input
                type="text"
                id="dato1"
                name="dato1"
                value={values.dato1}
                onChange={handleChanges}
                placeholder={`Ingrese ${camposAdicionales.dato1.toLowerCase()}`}
                className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition"
                required
              />
            </div>
          )}
          
          {camposAdicionales.dato2 && (
            <div>
              <label htmlFor="dato2" className="block text-sm font-semibold text-gray-700 mb-2">
                {camposAdicionales.dato2}
              </label>
              <input
                type="text"
                id="dato2"
                name="dato2"
                value={values.dato2}
                onChange={handleChanges}
                placeholder={`Ingrese ${camposAdicionales.dato2.toLowerCase()}`}
                className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition"
                required
              />
            </div>
          )}
          
          {camposAdicionales.dato3 && (
            <div>
              <label htmlFor="dato3" className="block text-sm font-semibold text-gray-700 mb-2">
                {camposAdicionales.dato3}
              </label>
              <input
                type="text"
                id="dato3"
                name="dato3"
                value={values.dato3}
                onChange={handleChanges}
                placeholder={`Ingrese ${camposAdicionales.dato3.toLowerCase()}`}
                className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent transition"
                required
              />
            </div>
          )}
        </div>
      )}

      {/* Fechas y Horas Totales en la misma fila */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div>
          <label className="block text-sm font-semibold text-gray-700 mb-2">Fecha de Inicio*</label>
          <DatePicker selected={values.fecha_inicio} onChange={handleFechaInicioChange} dateFormat="dd/MM/yyyy" maxDate={new Date()} showYearDropdown showMonthDropdown dropdownMode="select" className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition" required />
        </div>
        <div>
          <label className="block text-sm font-semibold text-gray-700 mb-2">Fecha de Término*</label>
          <DatePicker selected={values.fecha_termino} onChange={handleFechaTerminoChange} dateFormat="dd/MM/yyyy" maxDate={new Date()} minDate={values.fecha_inicio} showYearDropdown showMonthDropdown dropdownMode="select" className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition" required />
        </div>
        <div>
          <label htmlFor="horas_totales" className="block text-sm font-semibold text-gray-700 mb-2">Horas Totales*</label>
          <input 
            type="number" 
            id="horas_totales" 
            name="horas_totales" 
            placeholder="Ej: 10" 
            value={values.horas_totales} 
            onChange={handleChanges}
            onBlur={() => handleBlur('horas_totales')}
            min="1" 
            max="9999" 
            className={getInputClass('horas_totales', 'w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition')}
            required 
          />
          {touched.horas_totales && isFieldEmpty('horas_totales') && (
            <p className="text-red-500 text-xs mt-1">Este campo es obligatorio</p>
          )}
        </div>
      </div>

      {/* Archivo */}
      <div>
        <label htmlFor="archivos" className="block text-sm font-semibold text-gray-700 mb-2">Archivo Adjunto (PDF, PNG, JPG - Máx 5MB)</label>
        <input type="file" name="archivos" onChange={handleChanges} accept=".pdf,image/png,image/jpeg" className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100" />
      </div>

      {/* Descripción */}
      <div>
        <label htmlFor="about" className="block text-sm font-semibold text-gray-700 mb-2">Descripción de la Actividad</label>
        <textarea id="about" name="about" rows="6" placeholder="Describa brevemente la actividad realizada..." value={values.about} onChange={handleChanges} className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition resize-none" />
      </div>

      {/* Botones */}
      <div className="flex gap-4 pt-4">
        <Button type="button" variant="secondary" className="flex-1" onClick={ResetFun}>Limpiar Formulario</Button>
        <Button type="submit" variant="primary" className="flex-1">Enviar Registro</Button>
      </div>
    </form>
  );
}

export default FormularioActividad;