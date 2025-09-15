document.querySelector("form").addEventListener("submit", async function(e) {
  e.preventDefault();

  const correo = document.getElementById("usuario").value; // usa 'correo'
  const password = document.getElementById("password").value;

  try {
    const response = await fetch("http://localhost:8000/login", { // puerto del backend
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ correo, password }) // usa 'correo'
    });

    const data = await response.json();

    if (response.ok && !data.detail) {
      window.location.href = "index.html";
    } else {
      alert("❌ Usuario o contraseña incorrectos");
    }
  } catch (err) {
    alert("⚠️ Error en la conexión con el servidor");
  }
});
