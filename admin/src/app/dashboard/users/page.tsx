import { createServiceClient } from '@/lib/supabase/server';
import { createClient } from '@/lib/supabase/server';
import { redirect } from 'next/navigation';

export default async function UsersPage() {
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
        Only the app owner can access user management.
      </div>
    );
  }

  // Fetch all profiles
  const { data: profiles, error } = await serviceClient
    .from('profiles')
    .select('id, display_name, admin_role, subscription, scans_this_month, created_at')
    .order('created_at', { ascending: false });

  if (error) {
    return <div className="text-red-500">Error loading users: {error.message}</div>;
  }

  // Fetch auth users for email mapping
  const { data: { users: authUsers } } = await supabase.auth.admin.listUsers();
  const emailMap = new Map(authUsers?.map((u) => [u.id, u.email]) || []);

  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Users</h1>
        <p className="text-sm text-gray-500 mt-1">{profiles?.length || 0} registered users</p>
      </div>

      <div className="bg-white rounded-xl border border-gray-200">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead>
              <tr className="border-b border-gray-100">
                <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">User</th>
                <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Role</th>
                <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Subscription</th>
                <th className="text-center px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Scans</th>
                <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Joined</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {profiles?.map((p) => (
                <tr key={p.id} className="hover:bg-gray-50 transition-colors">
                  <td className="px-4 py-3">
                    <div className="text-sm font-medium text-gray-900">{p.display_name || 'No name'}</div>
                    <div className="text-xs text-gray-400">{emailMap.get(p.id) || p.id}</div>
                  </td>
                  <td className="px-4 py-3">
                    {p.admin_role ? (
                      <span className={`inline-flex px-2 py-0.5 rounded-full text-xs font-medium ${
                        p.admin_role === 'owner' ? 'bg-violet-100 text-violet-700' : 'bg-sky-100 text-sky-700'
                      }`}>
                        {p.admin_role}
                      </span>
                    ) : (
                      <span className="text-xs text-gray-300">user</span>
                    )}
                  </td>
                  <td className="px-4 py-3">
                    <span className="inline-flex px-2 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-700">
                      {p.subscription}
                    </span>
                  </td>
                  <td className="px-4 py-3 text-center text-sm text-gray-600">
                    {p.scans_this_month}
                  </td>
                  <td className="px-4 py-3 text-xs text-gray-400">
                    {new Date(p.created_at).toLocaleDateString()}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
