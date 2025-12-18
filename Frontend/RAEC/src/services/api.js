// Servicio de peticiones autenticadas al backend

// Determina API base dinámicamente (coincide con la lógica de AuthContext)
const getApiBase = () => {
  if (typeof window === 'undefined') return 'http://localhost:4001/api';
  const host = window.location.hostname;
  if (host === 'localhost' || host === '127.0.0.1') {
    return 'http://localhost:4001/api';
  }
  // En producción (raec.inf.uach.cl), usar /api porque Caddy hace el proxy
  return `${window.location.protocol}//${window.location.host}/api`;
};

export const API_BASE = getApiBase();

const getToken = () => localStorage.getItem('access_token');

export const authenticatedFetch = async (url, options = {}) => {
  const token = getToken();
  const headers = { 'Content-Type': 'application/json', ...(options.headers || {}) };
  if (token) headers['Authorization'] = `Bearer ${token}`;
  try {
    const response = await fetch(`${API_BASE}${url}`, { ...options, headers });
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
    const response = await fetch(`${API_BASE}${url}`, { ...options, headers });
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