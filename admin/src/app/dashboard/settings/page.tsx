import { createClient, createServiceClient } from '@/lib/supabase/server';
import { redirect } from 'next/navigation';

export default async function SettingsPage() {
  // Owner-only gate
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect('/login');

  const serviceClient = await createServiceClient();
  const { data: currentProfile } = await serviceClient
    .from('profiles')
    .select('admin_role')
    .eq('id', user.id)
    .single();

  if (currentProfile?.admin_role !== 'owner') {
    return (
      <div className="bg-red-50 border border-red-200 text-red-700 rounded-lg px-4 py-3 text-sm">
        Only the app owner can access settings.
      </div>
    );
  }

  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Settings</h1>
        <p className="text-sm text-gray-500 mt-1">App configuration and system settings</p>
      </div>

      <div className="space-y-6">
        <div className="bg-white rounded-xl border border-gray-200 p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">General</h2>
          <div className="space-y-4">
            <div className="flex items-center justify-between py-3 border-b border-gray-50">
              <div>
                <p className="text-sm font-medium text-gray-900">Supabase Project</p>
                <p className="text-xs text-gray-400 mt-0.5">{process.env.NEXT_PUBLIC_SUPABASE_URL}</p>
              </div>
              <span className="inline-flex px-2 py-0.5 rounded-full text-xs font-medium bg-emerald-100 text-emerald-700">Connected</span>
            </div>
            <div className="flex items-center justify-between py-3 border-b border-gray-50">
              <div>
                <p className="text-sm font-medium text-gray-900">Free Scan Limit</p>
                <p className="text-xs text-gray-400 mt-0.5">Monthly scans for free tier users</p>
              </div>
              <span className="text-sm text-gray-600">10 / month</span>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-xl border border-gray-200 p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Danger Zone</h2>
          <p className="text-sm text-gray-500 mb-4">These actions are irreversible. Be careful.</p>
          <div className="flex flex-wrap gap-3">
            <button disabled className="px-4 py-2 bg-gray-100 text-gray-400 rounded-lg text-sm font-medium cursor-not-allowed">
              Reset All Embeddings (coming soon)
            </button>
            <button disabled className="px-4 py-2 bg-gray-100 text-gray-400 rounded-lg text-sm font-medium cursor-not-allowed">
              Clear Product Cache (coming soon)
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
