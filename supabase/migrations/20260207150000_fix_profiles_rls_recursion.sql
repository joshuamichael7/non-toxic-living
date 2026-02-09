-- Fix infinite recursion in profiles RLS policy
-- The "Owner can manage profiles" policy queried profiles from within a profiles policy

-- Drop the recursive policy
DROP POLICY IF EXISTS "Owner can manage profiles" ON public.profiles;

-- Create a security definer function to check admin role without triggering RLS
CREATE OR REPLACE FUNCTION public.is_admin_owner()
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND admin_role = 'owner'
  );
$$;

-- Recreate the policy using the security definer function (bypasses RLS on the inner query)
CREATE POLICY "Owner can manage all profiles" ON public.profiles
  FOR ALL USING (
    auth.uid() = id OR public.is_admin_owner()
  );

-- Also fix the admin policies on swaps and ingredients to use the helper function
-- (these work but are cleaner with the function)
DROP POLICY IF EXISTS "Admin roles can manage swaps" ON public.swaps;
CREATE POLICY "Admin roles can manage swaps" ON public.swaps
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND admin_role IS NOT NULL
    )
  );

DROP POLICY IF EXISTS "Admin roles can manage ingredients" ON public.ingredients;
CREATE POLICY "Admin roles can manage ingredients" ON public.ingredients
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND admin_role IS NOT NULL
    )
  );
