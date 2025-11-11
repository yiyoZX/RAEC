import HeaderLayout from '../layouts/HeaderLayout';
import ReporteForm from '../components/ReportesForm';

const ReportesEstudiantes = () => {
  return (
    <HeaderLayout showBack title='RAEC - Historial'>
      <ReporteForm tipoUsuario='estudiante' />
    </HeaderLayout>
  );
};

export default ReportesEstudiantes;