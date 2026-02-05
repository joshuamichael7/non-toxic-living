import { Pressable, Text, PressableProps, ActivityIndicator } from 'react-native';

interface ButtonProps extends PressableProps {
  children: React.ReactNode;
  variant?: 'primary' | 'secondary' | 'outline';
  size?: 'small' | 'medium' | 'large';
  isLoading?: boolean;
}

const variantStyles = {
  primary: {
    container: 'bg-primary active:bg-primary-dark',
    text: 'text-white',
  },
  secondary: {
    container: 'bg-stone-100 active:bg-stone-200',
    text: 'text-stone-700',
  },
  outline: {
    container: 'bg-transparent border border-primary active:bg-primary/10',
    text: 'text-primary',
  },
};

const sizeStyles = {
  small: { container: 'px-4 py-2 rounded-lg', text: 'text-sm' },
  medium: { container: 'px-6 py-3 rounded-xl', text: 'text-base' },
  large: { container: 'px-8 py-4 rounded-xl', text: 'text-lg' },
};

export function Button({
  children,
  variant = 'primary',
  size = 'medium',
  isLoading = false,
  disabled,
  ...props
}: ButtonProps) {
  const variantStyle = variantStyles[variant];
  const sizeStyle = sizeStyles[size];

  return (
    <Pressable
      className={`${variantStyle.container} ${sizeStyle.container} items-center justify-center flex-row ${
        disabled || isLoading ? 'opacity-50' : ''
      }`}
      disabled={disabled || isLoading}
      {...props}
    >
      {isLoading ? (
        <ActivityIndicator color={variant === 'primary' ? 'white' : '#059669'} />
      ) : (
        <Text className={`${variantStyle.text} ${sizeStyle.text} font-semibold`}>
          {children}
        </Text>
      )}
    </Pressable>
  );
}
