import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider } from "./AuthContext";
import LoginRedirect from "./LoginRedirect";
import RegistroFormulario from "./RegistroFormulario";
import ProtectedRoute from "./ProtectedRoute";
import DashboardRedirect from "./DashboardRedirect";
import "./App.css";

function App() {
  return (
    <AuthProvider>
      <Router>
        <Routes>
          {/* Ruta por defecto redirige al login */}
          <Route path="/" element={<Navigate to="/login" replace />} />
          
          {/* Ruta de login */}
          <Route path="/login" element={<LoginRedirect />} />
          
          {/* Ruta protegida para el formulario de registro */}
          <Route 
            path="/registrar" 
            element={
              <ProtectedRoute>
                <RegistroFormulario />
              </ProtectedRoute>
            } 
          />
          
          {/* Ruta para volver al sistema HTML */}
          <Route 
            path="/dashboard" 
            element={
              <ProtectedRoute>
                <DashboardRedirect />
              </ProtectedRoute>
            } 
          />
          
          {/* Ruta para cualquier path no encontrado */}
          <Route path="*" element={<Navigate to="/login" replace />} />
        </Routes>
      </Router>
    </AuthProvider>
  );
}

export default App;
