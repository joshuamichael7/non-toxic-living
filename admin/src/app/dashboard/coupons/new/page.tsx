import { CouponForm } from '@/components/coupon-form';

export default function NewCouponPage() {
  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Add Coupon</h1>
        <p className="text-sm text-gray-500 mt-1">Create a new partner coupon deal</p>
      </div>
      <CouponForm />
    </div>
  );
}
