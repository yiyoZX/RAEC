// Estado y referencias
const selReporte = document.getElementById("reportes");
const inputRut = document.getElementById("rut-input");
const selTipo = document.getElementById("actividad-tipo");
const selActividad = document.getElementById("actividad-selector");
const btnConsultar = document.getElementById("consultar-btn");
const preview = document.getElementById("preview-reporte");

const BASE_URL = "http://localhost:4001/reportes";

const actividadesAcademicas = [
  { value: "1", label: "Curso optativo completo" },
  { value: "2", label: "Curso optativo parcial" },
  { value: "3", label: "Trabajo en proyecto investigacion" },
  { value: "4", label: "Trabajo en proyecto de I+D" },
  { value: "5", label: "Asistencia a congresos" },
  { value: "6", label: "Publicaciones" },
];

const actividadesNoAcademicas = [
  { value: "7", label: "Dirigencias" },
  { value: "8", label: "Deportivo destacado" },
  { value: "9", label: "Artístico destacado" },
  { value: "10", label: "Trabajo social destacado" },
  { value: "11", label: "Compromiso ambiental" },
  { value: "12", label: "Inclusion" },
];

function setPlaceholder(msg) {
  preview.innerHTML = `<div class="text-gray-600">${msg}</div>`;
}
setPlaceholder("Aquí se mostrará una vista previa del informe seleccionado.");

// UI helpers
function hideAllInputs() {
  inputRut.classList.add("hidden");
  selTipo.classList.add("hidden");
  selActividad.classList.add("hidden");
  btnConsultar.classList.add("hidden");
}

function fillActividadSelect(list) {
  selActividad.innerHTML = `<option value="">Seleccione una actividad</option>`;
  list.forEach(o => {
    const opt = document.createElement("option");
    opt.value = o.value;
    opt.textContent = o.label;
    selActividad.appendChild(opt);
  });
}

// Eventos
selReporte.addEventListener("change", () => {
  hideAllInputs();
  setPlaceholder("Aquí se mostrará una vista previa del informe seleccionado.");

  if (selReporte.value === "alumno") {
    inputRut.value = "";
    inputRut.classList.remove("hidden");
    btnConsultar.classList.remove("hidden");
  } else if (selReporte.value === "actividad") {
    selTipo.value = "";
    selActividad.innerHTML = `<option value="">Seleccione una actividad</option>`;
    selTipo.classList.remove("hidden");
    selActividad.classList.remove("hidden");
    btnConsultar.classList.remove("hidden");
  } else if (selReporte.value === "general") {
    btnConsultar.classList.remove("hidden");
  }
});

selTipo.addEventListener("change", () => {
  selActividad.value = "";
  if (selTipo.value === "academica") {
    fillActividadSelect(actividadesAcademicas);
  } else if (selTipo.value === "no_academica") {
    fillActividadSelect(actividadesNoAcademicas);
  } else {
    selActividad.innerHTML = `<option value="">Seleccione una actividad</option>`;
  }
});

// Fetch
btnConsultar.addEventListener("click", async () => {
  let url = BASE_URL;
  let params = {};

  if (selReporte.value === "alumno") {
    const rut = inputRut.value.trim();
    if (!rut) { setPlaceholder("Ingrese el RUT del alumno."); return; }
    url += "/alumno";
    params.rut = rut;
  } else if (selReporte.value === "actividad") {
    if (!selActividad.value) { setPlaceholder("Seleccione una actividad."); return; }
    url += "/actividad";
    params.actividad_id = selActividad.value;
  } else if (selReporte.value === "general") {
    url += "/general";
  } else {
    setPlaceholder("Seleccione un tipo de reporte.");
    return;
  }

  setPlaceholder("Cargando...");
  btnConsultar.disabled = true;
  btnConsultar.classList.add("opacity-60", "cursor-not-allowed");

  try {
    const token = localStorage.getItem("access_token") || "";
    const response = await fetch(url + "?" + new URLSearchParams(params), {
      headers: {
        "Authorization": `Bearer ${token}`,
        "Accept": "application/json"
      }
    });

    if (response.status === 401) { setPlaceholder("No autorizado."); return; }
    if (response.status === 403) { setPlaceholder("Acceso denegado."); return; }
    if (!response.ok) { setPlaceholder("Error HTTP " + response.status); return; }

    const json = await response.json();
    const items = Array.isArray(json) ? json : (json.data || []);
    renderList(items);

    // Mostrar info del CSV generado
 if (json.csv_url) {
      const wrap = document.createElement("div");
      wrap.className = "mt-3 text-sm";
      const nombre = json.csv_url.split("/").pop();
      const a = document.createElement("a");
      a.href = "http://localhost:4001" + json.csv_url;
      a.textContent = "Descargar CSV (" + nombre + ")";
      a.className = "text-purple-700 underline hover:text-purple-900";
      a.download = nombre; // hint
      wrap.appendChild(a);
      preview.prepend(wrap);
    }

  } catch (e) {
    console.error(e);
    setPlaceholder("Error de conexión.");
  } finally {
    btnConsultar.disabled = false;
    btnConsultar.classList.remove("opacity-60", "cursor-not-allowed");
  }
});

// Render
function renderList(items) {
  preview.innerHTML = "";
  if (!items.length) {
    setPlaceholder("No hay datos para este reporte.");
    return;
  }
  const ul = document.createElement("ul");
  ul.className = "space-y-3";

  items.forEach(item => {
    const actividad = item.actividad ?? item.nombre_actividad ?? "Sin actividad";
    const fechaISO = item.fecha_creacion ?? item.fecha ?? null;
    const fechaTxt = fechaISO ? formatDate(fechaISO) : "—";

    const nombres = (item.nombres || "").trim();
    const apellidos = (item.apellidos || "").trim();
    const rut = item.rut || "";
    let titulo = "";
    if (apellidos && nombres) {
      titulo = `${apellidos}, ${nombres}`;
    } else if (nombres) {
      titulo = nombres;
    } else if (apellidos) {
      titulo = apellidos;
    } else {
      titulo = rut || "Registro";
    }

    const li = document.createElement("li");
    li.className = "border rounded-lg bg-white/70 px-4 py-3 shadow-sm";

    // Cabecera (nombre + fecha)
    const top = document.createElement("div");
    top.className = "flex items-center justify-between";
    const title = document.createElement("div");
    title.className = "font-semibold";
    title.textContent = titulo;
    const date = document.createElement("div");
    date.className = "text-sm text-gray-500";
    date.textContent = fechaTxt;
    top.appendChild(title);
    top.appendChild(date);

    // Línea RUT (si existe)
    if (rut) {
      const rutLine = document.createElement("div");
      rutLine.className = "text-sm text-gray-600 mt-1";
      rutLine.textContent = `RUT: ${rut}`;
      li.appendChild(top);
      li.appendChild(rutLine);
    } else {
      li.appendChild(top);
    }

    // Actividad
    const bottom = document.createElement("div");
    bottom.className = "mt-2";
    const chip = document.createElement("span");
    chip.className = "inline-block text-xs px-2 py-1 rounded bg-purple-100 text-purple-800 border border-purple-200";
    chip.textContent = actividad;
    bottom.appendChild(chip);

    li.appendChild(bottom);
    ul.appendChild(li);
  });

  preview.replaceChildren(ul);
}

function formatDate(d) {
  try { return new Date(d).toLocaleString(); } catch { return String(d); }
}