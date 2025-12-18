import { useState, useEffect } from 'react';
import { authenticatedFetch } from '../services/api';

export const useListaOpciones = (endpoint, dataKey) => {
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {

    const fetchData = async () => {
      try {
        setLoading(true);
        
        const response = await authenticatedFetch(endpoint);
        if (!response.ok) throw new Error('Error status: ' + response.status);
        
        const json = await response.json();
        const resultadosCrudos = json[dataKey] || [];

        const opciones = resultadosCrudos.map(item => {
            return {
                value: item.value || item.rut || item.id, 
                label: item.label || item.nombre_completo || item.nombre,
                carreraIds: item.carreraIds || [] 
            };
        });

        setItems(opciones);
        
      } catch (e) {
        console.error("❌ ERROR EN HOOK:", e);
        setItems([]);
      } finally {
        setLoading(false);
      }
    };

    fetchData();

  }, [endpoint, dataKey]);

  return { items, loading };
};