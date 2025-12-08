// src/config/navigationConfig.js

export const MENUS = {
  ESTUDIANTE: [
    { label: 'Inicio', path: '/dashboardStudent' },
    { label: 'Nueva Solicitud', path: '/registroEstudiantes'},
    { label: 'Mis Registros', path: '/reportesEstudiantes' },
  ],
  
  PROFESOR: [ // Rol 1
    { label: 'Inicio', path: '/dashboard' },
    { label: 'Registrar', path: '/registrar' },
    { label: 'Reportes', path: '/reportesAcademicos'},
  ],
  
  DIRECTOR: [ // Rol 2
    { label: 'Panel Director', path: '/dashboard' },
    { label: 'Registrar', path: '/registrar' },
    { label: 'Solicitudes', path: '/solicitudes' },
    { label: 'Reportes', path: '/reportesAcademicos'},
  ],
  
  ADMIN: [ // Rol 3
    { label: 'Panel Admin', path: '/dashboardAdmin' },
    { label: 'Registrar', path: '/registrar' },
    { label: 'Solicitudes', path: '/solicitudes' },
    { label: 'Reportes', path: '/reportesAcademicos'},
    { label: 'Crear categoria', path: '/crear'},
    { label: 'Activar periodos', path: '/periodos'},
  ],
};

/**
 * Función helper robusta para determinar el menú.
 */
export const getMenuForUser = (user, userType) => {
  if (!user) return []; 

  console.log("🔍 Debug Menu:", { userType, id_rol: user.id_rol, rol: user.rol });

  // --- CASO 1: ESTUDIANTES ---
  // A veces llega en mayúsculas o minúsculas, normalizamos a minúsculas para comparar
  const tipo = userType ? userType.toLowerCase() : '';

  if (tipo === 'estudiante') {
    return MENUS.ESTUDIANTE;
  }

  // --- CASO 2: PERSONAL (Académicos, Admin, Directores, Profesores) ---
  
  // Lista blanca: Si el userType es CUALQUIERA de estos, entramos a la lógica de roles
  const tiposPermitidos = ['admin', 'profesor', 'director'];

  if (tiposPermitidos.includes(tipo)) {
    
    // Prioridad: Usamos el ID numérico porque es lo más exacto (1, 2, 3)
    const rolId = Number(user.id_rol || user.rol); 

    switch (rolId) {
      case 1: return MENUS.PROFESOR;
      case 2: return MENUS.DIRECTOR;
      case 3: return MENUS.ADMIN;
      
      // FALLBACK INTELIGENTE:
      // Si por alguna razón no viene el ID (rolId es NaN), intentamos deducir por el nombre del tipo
      default: 
        if (tipo === 'admin' || tipo === 'administrador') return MENUS.ADMIN;
        if (tipo === 'director') return MENUS.DIRECTOR;
        // Por defecto para cualquier otro caso ('profesor', 'academico') devolvemos Profesor
        return MENUS.PROFESOR; 
    }
  }

  return [];
};