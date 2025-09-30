document.querySelector("form").addEventListener("submit", async function(e) {
  e.preventDefault();

  const correo = document.getElementById("usuario").value; // usa 'correo'
  const password = document.getElementById("password").value;

  try {
    const response = await fetch("http://localhost:4001/login", { // puerto del backend
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ correo, password }) // usa 'correo'
    });

    const data = await response.json();

    if (response.ok && data.access_token) {
      // Guardar tanto el token JWT como el flag de autenticación
      localStorage.setItem('access_token', data.access_token);
      localStorage.setItem('user_data', JSON.stringify({
        id_profesor: data.id_profesor,
        rol: data.rol,
        instituto: data.instituto,
        message: data.message
      }));
      localStorage.setItem('isAuthenticated', 'true');
      
      window.location.href = "dashboard.html";
    } else {
      alert("❌ Usuario o contraseña incorrectos");
    }
  } catch (err) {
    alert("⚠️ Error en la conexión con el servidor");
  }
});
