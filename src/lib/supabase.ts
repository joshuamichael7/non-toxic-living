import 'react-native-url-polyfill/auto';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { createClient } from '@supabase/supabase-js';

import type { Database } from '@/types/database';

const supabaseUrl = process.env.EXPO_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY!;

// Prevent Supabase auth calls (setSession, updateUser, etc.) from hanging
// indefinitely. The internal async lock means one hanging call blocks all
// subsequent auth operations. 15s is generous for any auth endpoint.
const fetchWithTimeout = (input: RequestInfo | URL, init: RequestInit = {}): Promise<Response> => {
  const controller = new AbortController();
  const id = setTimeout(() => controller.abort(), 15000);
  if (init.signal) {
    // If caller already passed a signal, abort ours when theirs aborts too
    (init.signal as AbortSignal).addEventListener('abort', () => controller.abort());
  }
  return fetch(input, { ...init, signal: controller.signal }).finally(() => clearTimeout(id));
};

export const supabase = createClient<Database>(supabaseUrl, supabaseAnonKey, {
  auth: {
    storage: AsyncStorage,
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: false,
    flowType: 'implicit',
  },
  global: {
    fetch: fetchWithTimeout,
  },
});
