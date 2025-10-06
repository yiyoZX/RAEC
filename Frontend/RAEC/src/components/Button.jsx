// Componente de botón reutilizable con variantes de estilo
// Uso: <Button variant="primary" onClick={...}>Texto</Button>
// Variantes: primary, secondary, danger, outline, pill, subtle
import clsx from 'clsx';

const base = 'inline-flex items-center justify-center font-semibold transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2 disabled:opacity-60 disabled:cursor-not-allowed text-sm';

const variants = {
  primary: 'bg-blue-600 hover:bg-blue-700 text-white focus:ring-blue-500 rounded-lg px-4 py-2',
  secondary: 'bg-gray-200 hover:bg-gray-300 text-gray-800 rounded-lg px-4 py-2',
  danger: 'bg-red-600 hover:bg-red-700 text-white rounded-lg px-4 py-2',
  outline: 'border border-gray-400 text-gray-800 hover:bg-gray-100 rounded-lg px-4 py-2',
  pill: 'bg-purple-300 hover:bg-purple-400 text-black rounded-r-full shadow border border-black px-12 py-6 font-bold',
  subtle: 'bg-transparent text-blue-600 hover:underline px-2 py-1'
};

export default function Button({ variant = 'primary', className, isLoading = false, children, ...props }) {
  return (
    <button
      className={clsx(base, variants[variant] || variants.primary, className)}
      disabled={isLoading || props.disabled}
      {...props}
    >
      {isLoading ? '...' : children}
    </button>
  );
}
