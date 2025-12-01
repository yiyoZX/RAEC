// Servicio de peticiones autenticadas al backend

const API_BASE_URL = 'http://localhost:4001';

const getToken = () => localStorage.getItem('access_token');

export const authenticatedFetch = async (url, options = {}) => {
  const token = getToken();
  const headers = { 'Content-Type': 'application/json', ...(options.headers || {}) };
  if (token) headers['Authorization'] = `Bearer ${token}`;
  try {
    const response = await fetch(`${API_BASE_URL}${url}`, { ...options, headers });
    if (response.status === 401) {
      localStorage.removeItem('access_token');
      localStorage.removeItem('user_data');
      localStorage.removeItem('isAuthenticated');
      window.location.href = '/login';
      return null;
    }
    return response;
  } catch (e) {
    console.error('Error en petición autenticada:', e);
    throw e;
  }
};

export const authenticatedFetchFormData = async (url, options = {}) => {
  const token = getToken();
  const headers = { ...(options.headers || {}) }; // No establecer Content-Type manualmente
  if (token) headers['Authorization'] = `Bearer ${token}`;
  try {
    const response = await fetch(`${API_BASE_URL}${url}`, { ...options, headers });
    if (response.status === 401) {
      localStorage.removeItem('access_token');
      localStorage.removeItem('user_data');
      localStorage.removeItem('isAuthenticated');
      window.location.href = '/login';
      return null;
    }
    return response;
  } catch (e) {
    console.error('Error en petición autenticada con FormData:', e);
    throw e;
  }
};

export default { authenticatedFetch, authenticatedFetchFormData };