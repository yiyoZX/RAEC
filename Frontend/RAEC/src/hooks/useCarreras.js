import { useState, useEffect } from 'react';
import { authenticatedFetch } from '../services/api';

/**
 * Hook personalizado para cargar actividades desde el backend
 * @returns {Object} { carreras loading, error }
 */

export const useTodasCarreras = () => {
  const [carreras, setCarreras] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

    useEffect(() => {
        const cargarTodasCarreras = async () => {
        try {
            setLoading(true);
            setError(null);
            
            const response = await authenticatedFetch('http://localhost:4001/actividades/listar');
            
            if (!response.ok) {
            throw new Error('Error al cargar actividades');
            }

            const data = await response.json();

            setCarreras(data.carreras || []);


        } catch(err){
            console.error('Error cargando carreras:', err);
            setError(err.message);
            setCarreras([]);

        } finally {
            setLoading(false);
        }
    };
        cargarTodasCarreras();
    },[]);

    return {carreras, loading, error}; }