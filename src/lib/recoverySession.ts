/** Stores the recovery access token set by handleAuthDeepLink in _layout.tsx
 *  so the reset-password screen can consume it on warm-start (the URL event
 *  fires before the screen mounts, so addEventListener in the screen would miss it).
 */
let _token: string | null = null;

export const storeRecoveryToken = (token: string): void => {
  _token = token;
};

/** Returns the stored token and clears it (one-time use). */
export const consumeRecoveryToken = (): string | null => {
  const t = _token;
  _token = null;
  return t;
};
