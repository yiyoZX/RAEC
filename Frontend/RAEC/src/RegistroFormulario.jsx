import { useState } from "react";
import { useAuth } from "./AuthContext";
import { authenticatedFetchFormData } from "./utils/api";

function RegistroFormulario() {
  const { user, logout } = useAuth();
  const [values, setValues] = useState({
    nombres: "",
    apellidos: "",
    rut: "",
    email: "",
    academica: "", // "si" o "no"
    actividad: "", // select
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
    } else {
      setValues({ ...values, [name]: value });
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Construir formData
    const formData = new FormData();
    Object.entries(values).forEach(([key, value]) => {
      if (value) {
        formData.append(key, value);
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
      nombres: "",
      apellidos: "",
      rut: "",
      email: "",
      academica: "",
      actividad: "",
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
        <label htmlFor="nombres">Nombres</label>
        <input
          type="text"
          id="nombres"
          placeholder="Ingrese nombres"
          name="nombres"
          value={values.nombres}
          onChange={handleChanges}
          required
        />

        <label htmlFor="apellidos">Apellidos</label>
        <input
          type="text"
          id="apellidos"
          placeholder="Ingrese apellidos"
          name="apellidos"
          value={values.apellidos}
          onChange={handleChanges}
          required
        />

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

        <label htmlFor="email">Email</label>
        <input
          type="email"
          id="email"
          placeholder="Ingrese correo electrónico"
          name="email"
          value={values.email}
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