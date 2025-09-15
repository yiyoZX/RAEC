import { useState } from "react";

function Login(props) {
  const [correo, setCorreo] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    try {
      const response = await fetch("http://localhost:8000/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ correo, password })
      });
      const data = await response.json();
      if (response.ok && !data.detail) {
        window.location.href = "/index.html";
      } else {
        setError("Usuario o contraseña incorrectos");
      }
    } catch (err) {
      setError("Error en la conexión con el servidor");
    }
  };

  return (
    <div className="login-container">
      <h2>Login</h2>
      <form onSubmit={handleSubmit}>
        <label htmlFor="correo">Correo</label>
        <input
          type="email"
          id="correo"
          value={correo}
          onChange={e => setCorreo(e.target.value)}
          required
        />
        <label htmlFor="password">Contraseña</label>
        <input
          type="password"
          id="password"
          value={password}
          onChange={e => setPassword(e.target.value)}
          required
        />
        <button type="submit">Iniciar sesión</button>
      </form>
      {error && <p style={{color: 'red'}}>{error}</p>}
    </div>
  );
}

export default Login;
