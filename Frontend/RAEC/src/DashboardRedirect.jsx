import { useEffect } from 'react';

function DashboardRedirect() {
  useEffect(() => {
    // Redirigir al dashboard HTML estático
    window.location.href = '/dashboard.html';
  }, []);

  return (
    <div style={{ 
      display: 'flex', 
      justifyContent: 'center', 
      alignItems: 'center', 
      height: '100vh' 
    }}>
      <div>Redirigiendo al dashboard...</div>
    </div>
  );
}

export default DashboardRedirect;