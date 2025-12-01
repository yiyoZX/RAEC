import React from 'react';

function Paginacion({ currentPage, totalPages, onPageChange, loading }) {
  const getPageNumbers = () => {
    const pages = [];
    const maxVisible = 5;
    
    if (totalPages <= maxVisible) {
      // Mostrar todas las páginas si son pocas
      for (let i = 1; i <= totalPages; i++) {
        pages.push(i);
      }
    } else {
      // Mostrar páginas con ellipsis
      if (currentPage <= 3) {
        pages.push(1, 2, 3, 4, '...', totalPages);
      } else if (currentPage >= totalPages - 2) {
        pages.push(1, '...', totalPages - 3, totalPages - 2, totalPages - 1, totalPages);
      } else {
        pages.push(1, '...', currentPage - 1, currentPage, currentPage + 1, '...', totalPages);
      }
    }
    
    return pages;
  };

  if (totalPages <= 1) return null;

  return (
    <div className="flex justify-center items-center gap-2 mt-6">
      {/* Botón Anterior */}
      <button
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1 || loading}
        className={`px-3 py-2 rounded border ${
          currentPage === 1 || loading
            ? 'bg-gray-100 text-gray-400 cursor-not-allowed'
            : 'bg-white text-gray-700 hover:bg-gray-50 hover:border-purple-500'
        } transition-colors`}
      >
        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
        </svg>
      </button>

      {/* Números de página */}
      {getPageNumbers().map((page, idx) => {
        if (page === '...') {
          return (
            <span key={`ellipsis-${idx}`} className="px-3 py-2 text-gray-500">
              ...
            </span>
          );
        }

        return (
          <button
            key={page}
            onClick={() => onPageChange(page)}
            disabled={loading}
            className={`px-4 py-2 rounded border font-medium transition-colors ${
              currentPage === page
                ? 'bg-purple-600 text-white border-purple-600'
                : 'bg-white text-gray-700 hover:bg-gray-50 hover:border-purple-500'
            } ${loading ? 'cursor-not-allowed opacity-50' : ''}`}
          >
            {page}
          </button>
        );
      })}

      {/* Botón Siguiente */}
      <button
        onClick={() => onPageChange(currentPage + 1)}
        disabled={currentPage === totalPages || loading}
        className={`px-3 py-2 rounded border ${
          currentPage === totalPages || loading
            ? 'bg-gray-100 text-gray-400 cursor-not-allowed'
            : 'bg-white text-gray-700 hover:bg-gray-50 hover:border-purple-500'
        } transition-colors`}
      >
        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
        </svg>
      </button>

      {/* Información de página */}
      <div className="ml-4 text-sm text-gray-600">
        Página <span className="font-semibold">{currentPage}</span> de{' '}
        <span className="font-semibold">{totalPages}</span>
      </div>
    </div>
  );
}

export default Paginacion;
