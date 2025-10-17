import HeaderLayout from '../layouts/HeaderLayout';
import ReporteForm from '../components/ReportesForm';

const ReportesEstudiantes = () => {
  return (
    <HeaderLayout showBack backTo="/dashboardStudent">
      <ReporteForm tipoUsuario='estudiante' />
    </HeaderLayout>
  );
};

export default ReportesEstudiantes;