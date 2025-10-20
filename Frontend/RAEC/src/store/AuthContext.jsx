import { createContext, useContext, useState, useEffect } from 'react';

const API_BASE = 'http://localhost:4001'; // Ajusta si cambia el puerto

// Contexto de autenticación centralizado
const AuthContext = createContext();

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) throw new Error('useAuth debe ser usado dentro de un AuthProvider');
  return context;
};

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);      // Datos del usuario (académico o estudiante)
  const [token, setToken] = useState(null);    // JWT
  const [userType, setUserType] = useState(null); // 'profesor' | 'estudiante'
  const [loading, setLoading] = useState(true);

  // Cargar sesión previa
  useEffect(() => {
    const savedToken = localStorage.getItem('access_token');
    const savedUser = localStorage.getItem('user_data');
    const savedType = localStorage.getItem('user_type');
    const isAuthenticated = localStorage.getItem('isAuthenticated');
    if (savedToken && savedUser && isAuthenticated) {
      setToken(savedToken);
      setUserType(savedType || null);
      try { setUser(JSON.parse(savedUser)); } catch (_) {}
    }
    setLoading(false);
  }, []);

  // Login académicos (profesor)
  const login = async (correo, password) => {
    try {
      const response = await fetch(`${API_BASE}/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ correo, password }),
      });
      const data = await response.json();
      if (response.ok && data.access_token) {
          const userPayload = {
          id_profesor: data.id_profesor,
          rol: data.id_rol,  // Backend envía id_rol
          id_rol: data.id_rol,  // También guardamos id_rol por compatibilidad
          instituto: data.id_instituto,  // Backend envía id_instituto
          id_instituto: data.id_instituto,  // También guardamos id_instituto por compatibilidad
          message: data.message,
          isAdmin: data.id_rol === 3,  // Añadimos un flag para identificar admins fácilmente
        };
        localStorage.setItem('access_token', data.access_token);
        localStorage.setItem('user_data', JSON.stringify(userPayload));
        localStorage.setItem('user_type', data.rol === 1 ? (data.rol === 1 ? 'profesor' : 'director') : 'academico');
        localStorage.setItem('isAuthenticated', 'true');
        setToken(data.access_token);
        setUser(userPayload);
        setUserType('profesor');
        return { success: true };
      }
      return { success: false, error: data.detail || 'Credenciales incorrectas' };
    } catch (err) {
      return { success: false, error: 'Error en la conexión con el servidor' };
    }
  };

  // Login estudiantes
  // Nota: ajusta la ruta y campos al endpoint real (p.ej., /login-student, /estudiantes/login)
  // Si usas RUT en vez de correo, cambia { correo } -> { rut }.
  const loginStudent = async (correoORrut, password) => {
    try {
      const response = await fetch(`${API_BASE}/loginStudent`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        // Ajusta el payload al backend real (correoORrut puede ser 'correo' o 'rut')
        body: JSON.stringify({ correo: correoORrut, password }),
      });
      const data = await response.json();
      if (response.ok && data.access_token) {
        // Mapea los campos que entregue tu backend de estudiantes
        const userPayload = {
          id_estudiante: data.id_estudiante ?? data.id, // ajusta si es distinto
          rut: data.rut ?? null,
          carrera: data.carrera ?? null,
          message: data.message,
          rol: data.rol || null
        };
        localStorage.setItem('access_token', data.access_token);
        localStorage.setItem('user_data', JSON.stringify(userPayload));
        localStorage.setItem('user_type', 'estudiante');
        localStorage.setItem('isAuthenticated', 'true');
        setToken(data.access_token);
        setUser(userPayload);
        setUserType('estudiante');
        return { success: true };
      }
      return { success: false, error: data.detail || 'Credenciales incorrectas' };
    } catch (err) {
      return { success: false, error: 'Error en la conexión con el servidor' };
    }
  };

  const logout = () => {
    localStorage.removeItem('access_token');
    localStorage.removeItem('user_data');
    localStorage.removeItem('user_type');
    localStorage.removeItem('isAuthenticated');
    setToken(null);
    setUser(null);
    setUserType(null);
  };

  return (
    <AuthContext.Provider
      value={{
        user,
        token,
        userType,
        isStudent: userType === 'estudiante',
        isProfessor: userType === 'profesor',
        login,          // académicos
        loginStudent,   // estudiantes
        logout,
        loading,
        isAuthenticated: !!token
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export default AuthContext;