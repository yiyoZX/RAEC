import { useNavigate } from 'react-router-dom';
import HeaderLayout from '../layouts/HeaderLayout';
import Button from '../components/Button';

const DashboardPage = () => {
  const navigate = useNavigate();
  return (
    <HeaderLayout>
      <div className="flex items-center justify-start px-10 py-10">
        <div className="flex flex-col space-y-4">
          <Button variant="pill" onClick={() => navigate('/registrar')}>✔️ Registrar</Button>
          <Button variant="pill" onClick={() => navigate('/reportes')}>✔️ Reportes</Button>
        </div>
      </div>
    </HeaderLayout>
  );
};

export default DashboardPage;