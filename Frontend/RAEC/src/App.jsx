import { useState } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Login from "./Login";
import "./App.css";

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
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
        const maxSize = 5 * 1024 * 1024; // 2MB
        if (file.size > maxSize) {
          alert("El archivo excede el tamaño máximo de 2MB");
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
      const res = await fetch("http://127.0.0.1:8000/submit/", {
        method: "POST",
        body: formData,
      });

      if (!res.ok) throw new Error("Error en la conexión con el backend");

      const data = await res.json();
      console.log("Respuesta backend:", data);
      alert(data.msg || "Formulario enviado con éxito ✅");
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

  const opcionesAcademica = [
    { value: "docencia", label: "Docencia" },
    { value: "investigacion", label: "Investigación" },
    { value: "extension", label: "Extensión" },
  ];

  const opcionesNoAcademica = [
    { value: "dirigencias", label: "Dirigencias" },
    { value: "deportivos", label: "Deportivos" },
    { value: "social", label: "Social" },
  ];

  // Usar React Router para rutas
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Login onLoginSuccess={() => window.location.href = '/index.html'} />} />
        <Route path="/registrar" element={
          <div className="container">
            <h1>RAEC</h1>
            <form onSubmit={handleSubmit}>
              {/* ...existing code... */}
              <label htmlFor="nombres">Nombres</label>
              <input
                type="text"
                id="nombres"
                placeholder="Ingrese nombres"
                name="nombres"
                value={values.nombres}
                onChange={handleChanges}
              />
              {/* ...existing code... */}
              <label htmlFor="apellidos">Apellidos</label>
              <input
                type="text"
                id="apellidos"
                placeholder="Ingrese apellidos"
                name="apellidos"
                value={values.apellidos}
                onChange={handleChanges}
              />
              {/* ...existing code... */}
              <label htmlFor="rut">Rut</label>
              <input
                type="text"
                id="rut"
                placeholder="Ingrese rut"
                name="rut"
                value={values.rut}
                onChange={handleChanges}
              />
              {/* ...existing code... */}
              <label htmlFor="email">Email</label>
              <input
                type="email"
                id="email"
                placeholder="Ingrese correo electrónico"
                name="email"
                value={values.email}
                onChange={handleChanges}
              />
              {/* ...existing code... */}
              <label>Académica</label>
              <div>
                <input
                  type="radio"
                  id="academica-si"
                  name="academica"
                  value="si"
                  checked={values.academica === "si"}
                  onChange={handleChanges}
                />
                <label htmlFor="academica-si">Sí</label>
                <input
                  type="radio"
                  id="academica-no"
                  name="academica"
                  value="no"
                  checked={values.academica === "no"}
                  onChange={handleChanges}
                />
                <label htmlFor="academica-no">No</label>
              </div>
              {/* ...existing code... */}
              <label htmlFor="actividad">Actividad</label>
              <select
                name="actividad"
                id="actividad"
                value={values.actividad}
                onChange={handleChanges}
                disabled={!values.academica}
              >
                <option value="">Seleccione una actividad</option>
                {(values.academica === "si" ? opcionesAcademica : opcionesNoAcademica).map(
                  (op) => (
                    <option key={op.value} value={op.value}>
                      {op.label}
                    </option>
                  )
                )}
              </select>
              {/* ...existing code... */}
              <label htmlFor="archivos">Archivos</label>
              <input
                type="file"
                name="archivos"
                onChange={handleChanges}
                accept=".pdf,image/png,image/jpeg"
              />
              {/* ...existing code... */}
              <label htmlFor="about">About</label>
              <textarea
                name="about"
                id="about"
                cols="30"
                rows="10"
                placeholder="Descripcion"
                value={values.about}
                onChange={handleChanges}
              ></textarea>
              {/* ...existing code... */}
              <button type="button" onClick={ResetFun}>
                Reset
              </button>
              <button type="submit">Submit</button>
            </form>
          </div>
        } />
      </Routes>
    </Router>
  );
}

export default App;
