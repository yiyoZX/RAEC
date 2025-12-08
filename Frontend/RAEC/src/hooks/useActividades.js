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

  useEffect(() => {
    const cargarTodasActividades = async () => {
      try {
        setLoading(true);
        setError(null);
        
        const response = await authenticatedFetch('http://localhost:4001/actividades/listar');
        
        if (!response.ok) {
          throw new Error('Error al cargar actividades');
        }
        
        const data = await response.json();
        const actividades = data.actividades || [];
        
        // Guardar todas las actividades completas con sus datos adicionales
        setActividadesCompletas(actividades);
        
        // Separar por subcategoría (1 = académica, 2 = no académica)
        const academicasArray = actividades
          .filter(act => act.id_subcategoria === 1 || act.id_subcategoria === 2 || act.id_subcategoria === 3)
          .map(act => ({
            value: String(act.id_actividad),
            label: act.nombre_actividad
          }));
        
        const noAcademicasArray = actividades
          .filter(act => act.id_subcategoria === 4)
          .map(act => ({
            value: String(act.id_actividad),
            label: act.nombre_actividad
          }));
        
        setAcademicas(academicasArray);
        setNoAcademicas(noAcademicasArray);
      } catch (err) {
        console.error('Error cargando actividades:', err);
        setError(err.message);
        setAcademicas([]);
        setNoAcademicas([]);
      } finally {
        setLoading(false);
      }
    };

    cargarTodasActividades();
  }, []);

  return { academicas, noAcademicas, actividadesCompletas, loading, error };
};
