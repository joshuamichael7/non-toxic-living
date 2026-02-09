import { NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import type { EmailOtpType } from '@supabase/supabase-js';

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const token_hash = searchParams.get('token_hash');
  const type = searchParams.get('type') as EmailOtpType | null;

  if (!token_hash || !type) {
    return new NextResponse(confirmPage('Invalid Link', 'This confirmation link is invalid or has expired.', false), {
      headers: { 'Content-Type': 'text/html' },
    });
  }

  const supabase = await createClient();
  const { error } = await supabase.auth.verifyOtp({ token_hash, type });

  if (error) {
    return new NextResponse(confirmPage('Confirmation Failed', error.message, false), {
      headers: { 'Content-Type': 'text/html' },
    });
  }

  const title = type === 'signup' || type === 'invite'
    ? 'Email Confirmed'
    : type === 'recovery'
      ? 'Password Reset Confirmed'
      : type === 'email_change'
        ? 'Email Changed'
        : 'Verified';

  const message = type === 'signup' || type === 'invite'
    ? 'Your email has been confirmed. You can now open the app and sign in.'
    : type === 'recovery'
      ? 'Your password reset has been confirmed. Open the app to set your new password.'
      : 'Your request has been verified. You can now return to the app.';

  return new NextResponse(confirmPage(title, message, true), {
    headers: { 'Content-Type': 'text/html' },
  });
}

function confirmPage(title: string, message: string, success: boolean): string {
  const iconColor = success ? '#10B981' : '#EF4444';
  const icon = success
    ? '<svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>'
    : '<svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>';

  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${title} — Non-Toxic Living</title>
</head>
<body style="margin: 0; padding: 0; background-color: #111111; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; min-height: 100vh; display: flex; align-items: center; justify-content: center;">
  <div style="max-width: 440px; margin: 0 auto; padding: 40px 20px; text-align: center;">
    <div style="margin-bottom: 32px;">
      <div style="display: inline-block; background: #0EA5E9; color: #ffffff; font-weight: 700; font-size: 13px; padding: 8px 12px; border-radius: 10px;">NTL</div>
    </div>
    <div style="background: #1A1A1A; border: 1px solid rgba(255,255,255,0.08); border-radius: 24px; padding: 40px 32px;">
      <div style="color: ${iconColor}; margin-bottom: 20px;">${icon}</div>
      <h1 style="margin: 0 0 12px 0; font-size: 24px; font-weight: 600; color: #ffffff;">${title}</h1>
      <p style="margin: 0; font-size: 16px; color: #a1a1aa; line-height: 1.6;">${message}</p>
    </div>
  </div>
</body>
</html>`;
}
