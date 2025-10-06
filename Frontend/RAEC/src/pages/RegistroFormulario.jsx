import { useState, useEffect } from 'react';
import { useAuth } from '../store/AuthContext';
import { authenticatedFetchFormData } from '../services/api';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import '../styles/App.css';
import { useNavigate } from 'react-router-dom';
import HeaderLayout from '../layouts/HeaderLayout';
import Button from '../components/Button';
import { ACTIVIDADES_ACADEMICAS, ACTIVIDADES_NO_ACADEMICAS } from '../utils/constants';

function RegistroFormulario() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();
  const [values, setValues] = useState({
    rut: '',
    academica: '',
    actividad: '',
    fecha_inicio: new Date(),
    fecha_termino: new Date(),
    horas_totales: '',
    archivos: null,
    about: '',
  });

  useEffect(() => {
    if (user && user.rol !== 2 && values.academica === '2') {
      setValues(prev => ({ ...prev, academica: '', actividad: '' }));
    }
  }, [user, values.academica]);

  const handleChanges = (e) => {
    const { name, value, type, files } = e.target;
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
    } else {
      setValues({ ...values, [name]: value });
    }
  };

  const handleFechaInicioChange = (date) => setValues({ ...values, fecha_inicio: date });
  const handleFechaTerminoChange = (date) => setValues({ ...values, fecha_termino: date });

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!values.horas_totales || parseInt(values.horas_totales) <= 0) { alert('Ingrese horas'); return; }
    const formData = new FormData();
    Object.entries(values).forEach(([k,v]) => {
      if (!v) return;
      if ((k === 'fecha_inicio' || k === 'fecha_termino') && v instanceof Date) formData.append(k, v.toISOString().split('T')[0]);
      else formData.append(k, v);
    });
    try {
      const res = await authenticatedFetchFormData('http://localhost:4001/submit/', formData);
      if (!res) return; // 401 manejado
      if (!res.ok) throw new Error('Error backend');
      const data = await res.json();
      alert(data.message || 'Formulario enviado ✅');
      ResetFun();
    } catch (err) {
      alert('No se pudo enviar ❌');
    }
  };

  const ResetFun = () => setValues({
    rut: '', academica: '', actividad: '', fecha_inicio: new Date(), fecha_termino: new Date(), horas_totales: '', archivos: null, about: ''
  });

  const handleLogout = () => { logout(); navigate('/login'); };

  const opcionesAcademica = ACTIVIDADES_ACADEMICAS;
  const opcionesNoAcademica = ACTIVIDADES_NO_ACADEMICAS;

  return (
    <HeaderLayout showBack backTo="/dashboard" title="RAEC - Registro de Actividades">
      <div className="container">
      <form onSubmit={handleSubmit}>
        <label htmlFor="rut">Rut</label>
        <input type="text" id="rut" name="rut" placeholder="Ingrese rut" value={values.rut} onChange={handleChanges} required />

        <label>Académica</label>
        <div>
          <input type="radio" id="academica-si" name="academica" value="1" checked={values.academica === '1'} onChange={handleChanges} required />
          <label htmlFor="academica-si">Sí</label>
          {user?.rol === 2 && (
            <>
              <input type="radio" id="academica-no" name="academica" value="2" checked={values.academica === '2'} onChange={handleChanges} />
              <label htmlFor="academica-no">No</label>
            </>
          )}
        </div>
        {user?.rol === 1 && (
          <div style={{ marginTop:'5px', padding:'8px 12px', backgroundColor:'#e8f4f8', border:'1px solid #bee5eb', borderRadius:'4px', fontSize:'0.9em', color:'#0c5460' }}>
            ℹ️ Solo los directores pueden registrar actividades no académicas.
          </div>
        )}

        <label htmlFor="actividad">Actividad</label>
        <select id="actividad" name="actividad" value={values.actividad} onChange={handleChanges} disabled={!values.academica} required>
          <option value="">Seleccione una actividad</option>
          {(values.academica === '1' ? opcionesAcademica : values.academica === '2' ? opcionesNoAcademica : []).map(op => (
            <option key={op.value} value={op.value}>{op.label}</option>
          ))}
        </select>

        <label>Fecha de Inicio de la Actividad</label>
        <DatePicker selected={values.fecha_inicio} onChange={handleFechaInicioChange} dateFormat="dd/MM/yyyy" maxDate={new Date()} showYearDropdown showMonthDropdown dropdownMode="select" className="date-picker-input" required />

        <label>Fecha de Término de la Actividad</label>
        <DatePicker selected={values.fecha_termino} onChange={handleFechaTerminoChange} dateFormat="dd/MM/yyyy" maxDate={new Date()} minDate={values.fecha_inicio} showYearDropdown showMonthDropdown dropdownMode="select" className="date-picker-input" required />

        <label htmlFor="horas_totales">Horas Totales</label>
        <input type="number" id="horas_totales" name="horas_totales" placeholder="Ingrese el número total de horas" value={values.horas_totales} onChange={handleChanges} min="1" max="9999" required />

        <label htmlFor="archivos">Archivos</label>
        <input type="file" name="archivos" onChange={handleChanges} accept=".pdf,image/png,image/jpeg" />

        <label htmlFor="about">Descripción</label>
        <textarea id="about" name="about" rows="6" placeholder="Descripción de la actividad" value={values.about} onChange={handleChanges} />

        <div className="flex gap-3">
          <Button type="button" variant="secondary" onClick={ResetFun}>Limpiar</Button>
          <Button type="submit" variant="primary">Enviar</Button>
        </div>
      </form>
      </div>
    </HeaderLayout>
  );
}

export default RegistroFormulario;