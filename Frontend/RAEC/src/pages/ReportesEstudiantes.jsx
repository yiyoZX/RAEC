import HeaderLayout from '../layouts/HeaderLayout';
import ReporteForm from '../components/ReportesForm';

const ReportesEstudiantes = () => {
  return (
    <HeaderLayout showBack title='RAEC - Reportes estudiantes'>
      <ReporteForm tipoUsuario='estudiante' />
    </HeaderLayout>
  );
};

export default ReportesEstudiantes;