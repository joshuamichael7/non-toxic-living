import { FeaturedForm } from '@/components/featured-form';

export default function NewFeaturedPage() {
  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Add Featured Item</h1>
        <p className="text-sm text-gray-500 mt-1">Create a coupon, affiliate product, or sponsored post</p>
      </div>
      <FeaturedForm />
    </div>
  );
}
