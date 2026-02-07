-- ============================================================================
-- Replace is_admin boolean with admin_role enum for role-based access
-- Roles: 'owner' (full access), 'manager' (swaps, ingredients, studies)
-- ============================================================================

-- Create the enum type
DO $$ BEGIN
  CREATE TYPE admin_role AS ENUM ('owner', 'manager');
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;

-- Add admin_role column
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS admin_role admin_role DEFAULT NULL;

-- Migrate existing is_admin = true users to 'owner' role
UPDATE public.profiles SET admin_role = 'owner' WHERE is_admin = true AND admin_role IS NULL;

-- Drop old RLS policies that reference is_admin (must drop before column)
DROP POLICY IF EXISTS "Admins can manage swaps" ON public.swaps;
DROP POLICY IF EXISTS "Admins can manage ingredients" ON public.ingredients;

-- Drop old is_admin column
ALTER TABLE public.profiles DROP COLUMN IF EXISTS is_admin;

-- Create new role-based RLS policies
-- Both owner and manager can manage swaps (affiliate products)
CREATE POLICY "Admin roles can manage swaps" ON public.swaps
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND admin_role IS NOT NULL
    )
  );

-- Both owner and manager can manage ingredients
CREATE POLICY "Admin roles can manage ingredients" ON public.ingredients
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND admin_role IS NOT NULL
    )
  );

-- Only owner can manage profiles (user management)
CREATE POLICY "Owner can manage profiles" ON public.profiles
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND admin_role = 'owner'
    )
  );
