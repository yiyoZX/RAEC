import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './store/AuthContext';
import ProtectedRoute from './components/ProtectedRoute';
import LoginPage from './pages/LoginPage';
import LoginStudentPage from './pages/loginStudent';
import DashboardStudentPage from  './pages/dashboardStudent';
import DashboardPage from './pages/DashboardPage';
import DashboardAdmin from './pages/DashboardAdmin';
import RegistroFormularioAcademico from './pages/RegistroFormularioAcademico';
import RegistroFormularioEstudiante from './pages/RegistroFormularioEstudiantes';
import DashboardAdmin from './pages/DashboardAdmin';
import CrearActividad from './pages/CrearActividad';
import ReportesEstudiantes from './pages/ReportesEstudiantes';
import ReportesAcademicos from './pages/ReportesAcademicos';

function App() {
  return (
    <AuthProvider>
      <Router>
        <Routes>
          <Route path="/" element={<Navigate to="/login" replace />} />
          <Route path="/login" element={<LoginPage />} />
          <Route path="/loginStudent" element={<LoginStudentPage/>} />
          <Route path="/dashboardStudent" element={<ProtectedRoute><DashboardStudentPage /></ProtectedRoute>} />
          <Route path="/dashboard" element={<ProtectedRoute><DashboardPage /></ProtectedRoute>} />
          <Route path="/dashboardAdmin" element={<ProtectedRoute><DashboardAdmin /></ProtectedRoute>} />
          <Route path="/registrar" element={<ProtectedRoute><RegistroFormularioAcademico /></ProtectedRoute>} />
          <Route path="/registroEstudiantes" element= {<ProtectedRoute><RegistroFormularioEstudiante/></ProtectedRoute>} />
          <Route path="/crear" element={<ProtectedRoute><CrearActividad /></ProtectedRoute>} />
          <Route path="/reportesEstudiantes" element={<ProtectedRoute><ReportesEstudiantes /></ProtectedRoute>} />
          <Route path="/reportesAcademicos" element={<ProtectedRoute><ReportesAcademicos /></ProtectedRoute>} />
          <Route path="*" element={<Navigate to="/login" replace />} />
        </Routes>
      </Router>
    </AuthProvider>
  );
}

export default App;
