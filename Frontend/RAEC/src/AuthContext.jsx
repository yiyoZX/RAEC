import { createContext, useContext, useState, useEffect } from 'react';

const AuthContext = createContext();

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth debe ser usado dentro de un AuthProvider');
  }
  return context;
};

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [token, setToken] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Cargar token desde localStorage al inicio
    const savedToken = localStorage.getItem('access_token');
    const savedUser = localStorage.getItem('user_data');
    const isAuthenticated = localStorage.getItem('isAuthenticated');
    
    if (savedToken && savedUser && isAuthenticated) {
      setToken(savedToken);
      setUser(JSON.parse(savedUser));
    }
    setLoading(false);
  }, []);

  const login = async (correo, password) => {
    try {
      const response = await fetch("http://localhost:8000/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ correo, password })
      });
      
      const data = await response.json();
      
      if (response.ok && data.access_token) {
        // Guardar token y datos del usuario
        localStorage.setItem('access_token', data.access_token);
        localStorage.setItem('user_data', JSON.stringify({
          id_profesor: data.id_profesor,
          rol: data.rol,
          instituto: data.instituto,
          message: data.message
        }));
        localStorage.setItem('isAuthenticated', 'true');
        
        setToken(data.access_token);
        setUser({
          id_profesor: data.id_profesor,
          rol: data.rol,
          instituto: data.instituto,
          message: data.message
        });
        
        return { success: true };
      } else {
        return { success: false, error: data.detail || "Credenciales incorrectas" };
      }
    } catch (err) {
      return { success: false, error: "Error en la conexión con el servidor" };
    }
  };

  const logout = () => {
    localStorage.removeItem('access_token');
    localStorage.removeItem('user_data');
    localStorage.removeItem('isAuthenticated');
    setToken(null);
    setUser(null);
  };

  const value = {
    user,
    token,
    login,
    logout,
    loading,
    isAuthenticated: !!token
  };

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
};