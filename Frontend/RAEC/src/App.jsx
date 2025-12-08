import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './store/AuthContext';
import ProtectedRoute from './components/ProtectedRoute';
import RouteGuard from './components/RouteGuard';
import LoginPage from './pages/LoginPage';
import LoginStudentPage from './pages/loginStudent';
import Dashboard from './pages/Dashboard';
import RegistroFormularioAcademico from './pages/RegistroFormularioAcademico';
import RegistroFormularioEstudiante from './pages/RegistroFormularioEstudiantes';
import CrearActividad from './pages/CrearActividad';
import ReportesEstudiantes from './pages/ReportesEstudiantes';
import ReportesAcademicos from './pages/ReportesAcademicos';
import SolicitudesPage from './pages/Solicitudes';
import ConfigurarPeriodos from './pages/ConfigurarPeriodos';
import ChangeUserRole from './pages/CambiarRol';
import CargaMasiva from './pages/CargaMasiva';

function App() {
  return (
    <AuthProvider>
      <Router>
        <RouteGuard>
          <Routes>
            {/* Rutas públicas */}
            <Route path="/" element={<Navigate to="/login" replace />} />
            <Route path="/login" element={<LoginPage />} />
            <Route path="/loginStudent" element={<LoginStudentPage/>} />
            
            {/* Rutas protegidas para ESTUDIANTES */}
            <Route 
              path="/dashboardStudent" 
              element={
                <ProtectedRoute allowedRoles="estudiante">
                  <Dashboard />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/registroEstudiantes" 
              element={
                <ProtectedRoute allowedRoles="estudiante">
                  <RegistroFormularioEstudiante/>
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/reportesEstudiantes" 
              element={
                <ProtectedRoute allowedRoles="estudiante">
                  <ReportesEstudiantes />
                </ProtectedRoute>
              } 
            />
            
            {/* Rutas protegidas para ACADÉMICOS (profesor/director/admin) */}
            <Route 
              path="/dashboard" 
              element={
                <ProtectedRoute allowedRoles={['academico', 'director', 'admin']}>
                  <Dashboard />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/crear" 
              element={
                <ProtectedRoute allowedRoles={['academico', 'director', 'admin']}>
                  <CrearActividad />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/reportesAcademicos" 
              element={
                <ProtectedRoute allowedRoles={['academico', 'director', 'admin']}>
                  <ReportesAcademicos />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/registrar" 
              element={
                <ProtectedRoute allowedRoles={['academico', 'director', 'admin']}>
                  <RegistroFormularioAcademico />
                </ProtectedRoute>
              } 
            />
            
            {/* Rutas protegidas para ADMINISTRADORES y DIRECTORES */}
            <Route 
              path="/CambiarRol" 
              element={
                <ProtectedRoute requireAdminOrDirector>
                  <ChangeUserRole />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/solicitudes" 
              element={
                <ProtectedRoute allowedRoles={['academico', 'director', 'admin']}>
                  <SolicitudesPage />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/periodos" 
              element={
                <ProtectedRoute>
                  <ConfigurarPeriodos />
                </ProtectedRoute>
              } 
            />
            <Route 
              path="/carga-masiva" 
              element={
                <ProtectedRoute>
                  <CargaMasiva />
                </ProtectedRoute>
              } 
            />
            {/* Ruta por defecto - redirige al login */}
            <Route path="*" element={<Navigate to="/login" replace />} />
          </Routes>
        </RouteGuard>
      </Router>
    </AuthProvider>
  );
}

export default App;
