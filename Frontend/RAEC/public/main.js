document.addEventListener("DOMContentLoaded", () => {
  // Botón Reportes
  const btnReportes = document.getElementById("btn-reportes");
  if (btnReportes) {
    btnReportes.addEventListener("click", () => {
      window.location.href = "reportes.html";
    });
  }

  // Botón Registrar
  const btnRegistrar = document.getElementById("btn-registrar");
  if (btnRegistrar) {
    btnRegistrar.addEventListener("click", () => {
      window.location.href = "registrar";
    });
  }

  // Botón Solicitudes
  const btnSolicitudes = document.getElementById("btn-solicitudes");
  if (btnSolicitudes) {
    btnSolicitudes.addEventListener("click", () => {
      window.location.href = "solicitudes.html";
    });
  }
});