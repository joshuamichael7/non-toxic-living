import { type ClassValue, clsx } from 'clsx';

/**
 * Combines class names with clsx
 */
export function cn(...inputs: ClassValue[]) {
  return clsx(inputs);
}

/**
 * Format a price in cents to a display string
 */
export function formatPrice(cents: number): string {
  return `$${(cents / 100).toFixed(2)}`;
}

/**
 * Get verdict from score
 */
export function getVerdict(score: number): 'safe' | 'caution' | 'toxic' {
  if (score >= 67) return 'safe';
  if (score >= 34) return 'caution';
  return 'toxic';
}

/**
 * Truncate text with ellipsis
 */
export function truncate(text: string, length: number): string {
  if (text.length <= length) return text;
  return text.slice(0, length) + '...';
}

/**
 * Generate a random ID
 */
export function generateId(): string {
  return Math.random().toString(36).substring(2, 15);
}
