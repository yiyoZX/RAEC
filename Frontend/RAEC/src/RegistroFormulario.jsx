import { useState } from "react";
import { useAuth } from "./AuthContext";
import { authenticatedFetchFormData } from "./utils/api";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

function RegistroFormulario() {
  const { user, logout } = useAuth();
  const [values, setValues] = useState({
    rut: "",
    academica: "", // "si" o "no"
    actividad: "", // select
    fecha_inicio: new Date(), // Fecha de inicio de la actividad
    fecha_termino: new Date(), // Fecha de término de la actividad
    horas_totales: "", // campo numérico para horas totales
    archivos: null, // file input
    about: "", // textarea
  });

  const handleChanges = (e) => {
    const { name, value, type, files } = e.target;

    if (type === "file") {
      const file = files[0];
      if (file) {
        // Validar tipo
        const allowedTypes = ["application/pdf", "image/png", "image/jpeg"];
        if (!allowedTypes.includes(file.type)) {
          alert("Solo se permiten archivos PDF, PNG o JPG");
          return;
        }
        // Validar tamaño (máx 5 MB)
        const maxSize = 5 * 1024 * 1024; // 5MB
        if (file.size > maxSize) {
          alert("El archivo excede el tamaño máximo de 5MB");
          return;
        }
        setValues({ ...values, [name]: file });
      }
    } else if (name === "horas_totales") {
      // Validar que las horas totales sean un número positivo
      const numValue = parseInt(value);
      if (value !== "" && (isNaN(numValue) || numValue <= 0)) {
        alert("Las horas totales deben ser un número positivo");
        return;
      }
      setValues({ ...values, [name]: value });
    } else {
      setValues({ ...values, [name]: value });
    }
  };

  // Funciones separadas para manejar cambios de fecha
  const handleFechaInicioChange = (date) => {
    setValues({ ...values, fecha_inicio: date });
  };

  const handleFechaTerminoChange = (date) => {
    setValues({ ...values, fecha_termino: date });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Validar horas totales antes del envío
    if (!values.horas_totales || parseInt(values.horas_totales) <= 0) {
      alert("Por favor, ingrese un número válido de horas totales");
      return;
    }

    // Construir formData
    const formData = new FormData();
    Object.entries(values).forEach(([key, value]) => {
      if (value) {
        if ((key === 'fecha_inicio' || key === 'fecha_termino') && value instanceof Date) {
          // Convertir fecha a formato ISO string
          formData.append(key, value.toISOString().split('T')[0]);
        } else {
          formData.append(key, value);
        }
      }
    });

    try {
      const res = await authenticatedFetchFormData("http://127.0.0.1:8000/submit/", formData);

      if (!res) {
        // La función ya manejó el error 401 y redirección
        return;
      }

      if (!res.ok) throw new Error("Error en la conexión con el backend");

      const data = await res.json();
      console.log("Respuesta backend:", data);
      alert(data.message || "Formulario enviado con éxito ✅");
      
      // Limpiar formulario después del envío exitoso
      ResetFun();
    } catch (err) {
      console.error(err);
      alert("No se pudo enviar el formulario ❌");
    }
  };

  const ResetFun = () => {
    setValues({
      rut: "",
      academica: "",
      actividad: "",
      fecha_inicio: new Date(),
      fecha_termino: new Date(),
      horas_totales: "",
      archivos: null,
      about: "",
    });
  };

  const handleLogout = () => {
    logout();
    // Redirigir al HTML estático
    window.location.href = '/login.html';
  };

  const opcionesAcademica = [
    { value: "1", label: "Docencia" },
    { value: "2", label: "Investigación" },
    { value: "3", label: "Extensión" },
  ];

  const opcionesNoAcademica = [
    { value: "4", label: "Dirigencias" },
    { value: "5", label: "Deportivos" },
    { value: "6", label: "Social" },
  ];

  return (
    <div className="container">
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
        <h1>RAEC - Registro de Actividades</h1>
        <div>
          <span>Bienvenido, {user?.message || 'Usuario'}</span>
          <button onClick={() => window.location.href = '/dashboard.html'} style={{ marginLeft: '10px', marginRight: '10px' }}>
            Volver al Dashboard
          </button>
          <button onClick={handleLogout} style={{ marginLeft: '10px' }}>Cerrar Sesión</button>
        </div>
      </div>
      
      <form onSubmit={handleSubmit}>
        <label htmlFor="rut">Rut</label>
        <input
          type="text"
          id="rut"
          placeholder="Ingrese rut"
          name="rut"
          value={values.rut}
          onChange={handleChanges}
          required
        />

        <label>Académica</label>
        <div>
          <input
            type="radio"
            id="academica-si"
            name="academica"
            value="1"
            checked={values.academica === "1"}
            onChange={handleChanges}
            required
          />
          <label htmlFor="academica-si">Sí</label>
          <input
            type="radio"
            id="academica-no"
            name="academica"
            value="2"
            checked={values.academica === "2"}
            onChange={handleChanges}
            required
          />
          <label htmlFor="academica-no">No</label>
        </div>

        <label htmlFor="actividad">Actividad</label>
        <select
          name="actividad"
          id="actividad"
          value={values.actividad}
          onChange={handleChanges}
          disabled={!values.academica}
          required
        >
          <option value="">Seleccione una actividad</option>
          {(values.academica === "1" ? opcionesAcademica : values.academica === "2" ? opcionesNoAcademica : []).map(
            (op) => (
              <option key={op.value} value={op.value}>
                {op.label}
              </option>
            )
          )}
        </select>

        <label htmlFor="fecha_inicio">Fecha de Inicio de la Actividad</label>
        <DatePicker
          selected={values.fecha_inicio}
          onChange={handleFechaInicioChange}
          dateFormat="dd/MM/yyyy"
          placeholderText="Seleccione una fecha"
          maxDate={new Date()}
          showYearDropdown
          showMonthDropdown
          dropdownMode="select"
          className="date-picker-input"
          required
        />

        <label htmlFor="fecha_termino">Fecha de Término de la Actividad</label>
        <DatePicker
          selected={values.fecha_termino}
          onChange={handleFechaTerminoChange}
          dateFormat="dd/MM/yyyy"
          placeholderText="Seleccione una fecha"
          maxDate={new Date()}
          minDate={values.fecha_inicio} // La fecha de término debe ser posterior a la de inicio
          showYearDropdown
          showMonthDropdown
          dropdownMode="select"
          className="date-picker-input"
          required
        />

        <label htmlFor="horas_totales">Horas Totales</label>
        <input
          type="number"
          id="horas_totales"
          placeholder="Ingrese el número total de horas"
          name="horas_totales"
          value={values.horas_totales}
          onChange={handleChanges}
          min="1"
          max="9999"
          required
        />

        <label htmlFor="archivos">Archivos</label>
        <input
          type="file"
          name="archivos"
          onChange={handleChanges}
          accept=".pdf,image/png,image/jpeg"
        />

        <label htmlFor="about">Descripción</label>
        <textarea
          name="about"
          id="about"
          cols="30"
          rows="10"
          placeholder="Descripción de la actividad"
          value={values.about}
          onChange={handleChanges}
        ></textarea>

        <div style={{ display: 'flex', gap: '10px' }}>
          <button type="button" onClick={ResetFun}>
            Limpiar
          </button>
          <button type="submit">
            Enviar
          </button>
        </div>
      </form>
    </div>
  );
}

export default RegistroFormulario;