import { useState, useEffect } from 'react';
import { useAuth } from '../store/AuthContext';
import { useNavigate } from 'react-router-dom';
import HeaderLayout from '../layouts/HeaderLayout';
import FormularioActividad from '../components/FormularioActividad';  // Reutiliza

function RegistroFormularioEstudiante() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  const handleSuccess = () => {
    navigate('/dashboardStudent');
  };

  return (
    <HeaderLayout showBack backTo="/dashboardStudent" title="RAEC - Registro de Actividades para Estudiantes">
      <div className="w-full max-w-7xl mx-auto px-6 py-8">
        <div className="bg-white rounded-2xl shadow-lg p-8">
          <h2 className="text-3xl font-bold text-gray-900 mb-8 text-center">Registrar Nueva Solicitud</h2>
          <FormularioActividad userRol='estudiante' onSubmitSuccess={handleSuccess} />
        </div>
      </div>
    </HeaderLayout>
  );
}

export default RegistroFormularioEstudiante;