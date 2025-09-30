import { useEffect } from 'react';

function LoginRedirect() {
  useEffect(() => {
    // Redirigir al login HTML estático
    window.location.href = '/login.html';
  }, []);

  return (
    <div style={{ 
      display: 'flex', 
      justifyContent: 'center', 
      alignItems: 'center', 
      height: '100vh' 
    }}>
      <div>Redirigiendo al login...</div>
    </div>
  );
}

export default LoginRedirect;