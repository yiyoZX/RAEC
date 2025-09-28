const reportes = document.getElementById("reportes");
const rutInput = document.getElementById("rut-input");
const actividadSelector = document.getElementById("actividad-selector");
const consultarBtn = document.getElementById("consultar-btn");
const preview = document.getElementById("preview-reporte");

setPlaceholder("Aquí se mostrará una vista previa del informe seleccionado.");

reportes.addEventListener("change", function () {
  rutInput.classList.add("hidden");
  actividadSelector.classList.add("hidden");
  consultarBtn.classList.add("hidden");
  setPlaceholder("Aquí se mostrará una vista previa del informe seleccionado.");

  if (this.value === "alumno") {
    rutInput.classList.remove("hidden");
    consultarBtn.classList.remove("hidden");
  } else if (this.value === "actividad") {
    actividadSelector.classList.remove("hidden");
    consultarBtn.classList.remove("hidden");
  } else if (this.value === "general") {
    consultarBtn.classList.remove("hidden");
  }
});

consultarBtn.addEventListener("click", async function () {
  let url = "http://localhost:4001/reportes/";
  let params = {};

  if (reportes.value === "alumno") {
    const rut = rutInput.value.trim();
    if (!rut) { setPlaceholder("Ingrese el RUT del alumno."); return; }
    url += "alumno";
    params.rut = rut;
  } else if (reportes.value === "actividad") {
    const tipoActividad = actividadSelector.value;
    if (!tipoActividad) { setPlaceholder("Seleccione el tipo de actividad."); return; }
    url += "actividad";
    params.tipo = tipoActividad; // academico | no_academico
  } else if (reportes.value === "general") {
    url += "general";
  } else {
    setPlaceholder("Seleccione un tipo de reporte.");
    return;
  }

  setPlaceholder("Cargando...");
  consultarBtn.disabled = true;
  consultarBtn.classList.add("opacity-60", "cursor-not-allowed");

  try {
    const token = localStorage.getItem("access_token") || "";
    const response = await fetch(url + "?" + new URLSearchParams(params), {
      headers: {
        "Authorization": `Bearer ${token}`,
        "Accept": "application/json"
      }
    });

    if (response.status === 401) {
      setPlaceholder("No autorizado. Inicie sesión.");
      return;
    }
    if (response.status === 403) {
      setPlaceholder("Acceso denegado (403). Verifique permisos.");
      return;
    }
    if (!response.ok) throw new Error("Respuesta no OK");

    const data = await response.json();
    renderList(Array.isArray(data) ? data : []);
  } catch (err) {
    setPlaceholder("Error al cargar los datos.");
  } finally {
    consultarBtn.disabled = false;
    consultarBtn.classList.remove("opacity-60", "cursor-not-allowed");
  }
});

function renderList(items) {
  preview.innerHTML = "";
  if (!items.length) {
    setPlaceholder("No hay datos para este reporte.");
    return;
  }

  const ul = document.createElement("ul");
  ul.className = "space-y-3";

  items.forEach((item) => {
    const nombre = item.nombres_alumno ?? item.nombres ?? "";
    const apellido = item.apellidos_alumno ?? item.apellidos ?? "";
    const actividad = item.actividad ?? item.nombre_actividad ?? "";
    const fechaISO = item.fecha_creacion ?? item.fecha ?? null;
    const fechaTxt = fechaISO ? formatDate(fechaISO) : "—";

    const li = document.createElement("li");
    li.className = "border rounded-lg bg-white/70 px-4 py-3 shadow-sm";

    const top = document.createElement("div");
    top.className = "flex items-center justify-between";
    const title = document.createElement("div");
    title.className = "font-semibold";
    title.textContent = `${apellido}, ${nombre}`;
    const date = document.createElement("div");
    date.className = "text-sm text-gray-500";
    date.textContent = fechaTxt;
    top.appendChild(title);
    top.appendChild(date);

    const bottom = document.createElement("div");
    bottom.className = "mt-1";
    const chip = document.createElement("span");
    chip.className = "inline-block text-xs px-2 py-1 rounded bg-purple-100 text-purple-800 border border-purple-200";
    chip.textContent = actividad || "Sin actividad";
    bottom.appendChild(chip);

    li.appendChild(top);
    li.appendChild(bottom);
    ul.appendChild(li);
  });

  preview.replaceChildren(ul);
}

function setPlaceholder(text) {
  preview.innerHTML = `<div class="text-gray-600">${text}</div>`;
}

function formatDate(d) {
  try {
    const date = new Date(d);
    return date.toLocaleString();
  } catch {
    return String(d);
  }
}