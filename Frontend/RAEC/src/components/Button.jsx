// Componente de botón reutilizable con variantes de estilo
// Uso: <Button variant="primary" onClick={...}>Texto</Button>
// Variantes: primary, secondary, danger, outline, pill, subtle


export default function Button({
  children,
  variant = 'pill',
  size = 'md',
  className = '',
  ...props
}) {
  const base =
    'inline-flex items-center justify-center font-medium transition focus:outline-none focus:ring-2 focus:ring-offset-2';

  const variants = {
    pill: 'rounded-full bg-blue-600 text-white hover:bg-blue-700 focus:ring-blue-600',
    primary: 'bg-blue-600 hover:bg-blue-700 text-white focus:ring-blue-500 rounded-lg px-4 py-2',
    secondary: 'bg-gray-200 hover:bg-gray-300 text-gray-800 rounded-lg px-4 py-2',
    danger: 'bg-red-600 hover:bg-red-700 text-white rounded-lg px-4 py-2',
    outline: 'border border-gray-400 text-gray-800 hover:bg-gray-100 rounded-lg px-4 py-2',
    subtle: 'bg-transparent text-blue-600 hover:underline px-2 py-1'
  };

  const sizes = {
    sm: 'text-sm px-3 py-2',
    md: 'text-base px-4 py-2.5',
    lg: 'text-lg px-6 py-4',
    xl: 'text-2xl px-10 py-6',
    '2xl': 'text-4xl px-16 py-10', // botones gigantes
  };

  return (
    <button
      className={`${base} ${variants[variant] ?? ''} ${sizes[size] ?? ''} ${className}`}
      {...props}
    >
      {children}
    </button>
  );
}
