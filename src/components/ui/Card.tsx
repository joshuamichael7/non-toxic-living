import { View, ViewProps } from 'react-native';

interface CardProps extends ViewProps {
  children: React.ReactNode;
  variant?: 'default' | 'elevated';
}

export function Card({ children, variant = 'default', className = '', ...props }: CardProps) {
  const baseStyles = 'bg-white rounded-xl';
  const variantStyles = {
    default: 'shadow-sm',
    elevated: 'shadow-md',
  };

  return (
    <View className={`${baseStyles} ${variantStyles[variant]} ${className}`} {...props}>
      {children}
    </View>
  );
}
