import HeaderLayout from '../layouts/HeaderLayout';
import ReporteForm from '../components/ReportesForm';  //componente para Reportes

const ReportesAcademicos = () => {
  return (
    <HeaderLayout showBack title='RAEC - Reportes'>
      <ReporteForm tipoUsuario='academico' />
    </HeaderLayout>
  );
};

export default ReportesAcademicos;