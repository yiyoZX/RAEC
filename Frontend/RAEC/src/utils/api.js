// Función para obtener el token desde localStorage
const getToken = () => {
  return localStorage.getItem('access_token');
};

// Función para hacer peticiones autenticadas
export const authenticatedFetch = async (url, options = {}) => {
  const token = getToken();
  
  const defaultHeaders = {
    'Content-Type': 'application/json',
    ...(options.headers || {})
  };

  // Agregar Authorization header si tenemos token
  if (token) {
    defaultHeaders['Authorization'] = `Bearer ${token}`;
  }

  const config = {
    ...options,
    headers: defaultHeaders
  };

  try {
    const response = await fetch(url, config);
    
    // Si el token ha expirado (401), redirigir al login
    if (response.status === 401) {
      localStorage.removeItem('access_token');
      localStorage.removeItem('user_data');
      localStorage.removeItem('isAuthenticated');
      window.location.href = '/login.html';
      return;
    }
    
    return response;
  } catch (error) {
    console.error('Error en petición autenticada:', error);
    throw error;
  }
};

// Función específica para envío de FormData (formularios con archivos)
export const authenticatedFetchFormData = async (url, formData, options = {}) => {
  const token = getToken();
  
  const defaultHeaders = {
    ...(options.headers || {})
    // No incluir Content-Type para FormData - el navegador lo establece automáticamente
  };

  // Agregar Authorization header si tenemos token
  if (token) {
    defaultHeaders['Authorization'] = `Bearer ${token}`;
  }

  const config = {
    method: 'POST',
    ...options,
    headers: defaultHeaders,
    body: formData
  };

  try {
    const response = await fetch(url, config);
    
    // Si el token ha expirado (401), redirigir al login
    if (response.status === 401) {
      localStorage.removeItem('access_token');
      localStorage.removeItem('user_data');
      localStorage.removeItem('isAuthenticated');
      window.location.href = '/login.html';
      return;
    }
    
    return response;
  } catch (error) {
    console.error('Error en petición autenticada con FormData:', error);
    throw error;
  }
};