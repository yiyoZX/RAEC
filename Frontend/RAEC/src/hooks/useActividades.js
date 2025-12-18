import { useState, useEffect } from 'react';
import { authenticatedFetch } from '../services/api';

/**
 * Hook personalizado para cargar actividades desde el backend
 * @param {string} tipo - 'academica' o 'no_academica' (opcional)
 * @returns {Object} { actividades, loading, error }
 */

export const useTodasActividades = () => {
  const [academicas, setAcademicas] = useState([]);
  const [noAcademicas, setNoAcademicas] = useState([]);
  const [actividadesCompletas, setActividadesCompletas] = useState([]); // Guardar datos completos
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [refreshKey, setRefreshKey] = useState(0);

  // Función para forzar recarga de actividades
  const refetch = () => {
    setRefreshKey(prev => prev + 1);
  };

  useEffect(() => {
    // Escuchar evento personalizado cuando se crea una nueva actividad
    const handleActividadCreada = () => {
      console.log('🔔 Evento detectado: Nueva actividad creada, recargando...');
      refetch();
    };

    window.addEventListener('actividadCreada', handleActividadCreada);

    return () => {
      window.removeEventListener('actividadCreada', handleActividadCreada);
    };
  }, []);

  useEffect(() => {
    const cargarTodasActividades = async () => {
      try {
        setLoading(true);
        setError(null);
        
        console.log('🔄 Cargando actividades...');
        const response = await authenticatedFetch('/actividades/listar');
        
        if (!response.ok) {
          const errorData = await response.json().catch(() => ({}));
          console.error('❌ Error al cargar actividades:', response.status, errorData);
          throw new Error(errorData.detail || 'Error al cargar actividades');
        }
        
        const data = await response.json();
        const actividades = data.actividades || [];
        
        console.log('✅ Actividades cargadas:', actividades.length, actividades);
        
        // Guardar todas las actividades completas con sus datos adicionales
        setActividadesCompletas(actividades);
        
        // Separar por tipo usando el campo "tipo" que viene del backend
        const academicasArray = actividades
          .filter(act => act.tipo === 'academica')
          .map(act => ({
            value: String(act.id_actividad),
            label: act.nombre_actividad
          }));
        
        const noAcademicasArray = actividades
          .filter(act => act.tipo === 'no_academica')
          .map(act => ({
            value: String(act.id_actividad),
            label: act.nombre_actividad
          }));
        
        console.log('📚 Académicas:', academicasArray.length, '| No académicas:', noAcademicasArray.length);
        
        setAcademicas(academicasArray);
        setNoAcademicas(noAcademicasArray);
      } catch (err) {
        console.error('❌ Error cargando actividades:', err);
        setError(err.message);
        setAcademicas([]);
        setNoAcademicas([]);
      } finally {
        setLoading(false);
      }
    };

    cargarTodasActividades();
  }, [refreshKey]);

  return { academicas, noAcademicas, actividadesCompletas, loading, error, refetch };
};
