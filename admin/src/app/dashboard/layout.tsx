import { createClient, createServiceClient } from '@/lib/supabase/server';
import { redirect } from 'next/navigation';
import { Sidebar } from '@/components/sidebar';
import { SignOutButton } from '@/components/sign-out-button';

export type AdminRole = 'owner' | 'manager';

export default async function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect('/login');
  }

  // Use service client to bypass RLS for admin role check
  const serviceClient = await createServiceClient();
  const { data: profile, error } = await serviceClient
    .from('profiles')
    .select('admin_role, display_name')
    .eq('id', user.id)
    .single();

  if (!profile?.admin_role) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center p-4">
        <div className="bg-white rounded-2xl shadow-sm border border-gray-200 p-8 max-w-md text-center">
          <div className="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <svg className="w-8 h-8 text-red-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L4.082 16.5c-.77.833.192 2.5 1.732 2.5z" />
            </svg>
          </div>
          <h2 className="text-xl font-bold text-gray-900 mb-2">Access Denied</h2>
          <p className="text-gray-500 text-sm">
            You don&apos;t have admin privileges. Contact the app owner to get access.
          </p>
          <p className="text-gray-400 text-xs mt-4">{user.email}</p>
          {error && (
            <p className="text-red-400 text-xs mt-2">Debug: {error.message}</p>
          )}
          <SignOutButton />
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 flex">
      <Sidebar
        userName={profile.display_name || user.email || 'Admin'}
        role={profile.admin_role as AdminRole}
      />
      <main className="flex-1 ml-64 p-8">
        {children}
      </main>
    </div>
  );
}
