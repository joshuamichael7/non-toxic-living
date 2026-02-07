import { SwapForm } from '@/components/swap-form';

export default function NewSwapPage() {
  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Add Affiliate Product</h1>
        <p className="text-sm text-gray-500 mt-1">Create a new swap recommendation with affiliate link</p>
      </div>
      <SwapForm />
    </div>
  );
}
