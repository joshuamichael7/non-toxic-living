import type { Metadata } from 'next';
import Link from 'next/link';

export const metadata: Metadata = {
  title: 'Non-Toxic Living — Scan Any Product for Hidden Toxins',
  description:
    'Point your camera at any product label and get an instant safety score. Find harmful ingredients in food, cosmetics, household items, and more.',
};

function Header() {
  return (
    <header className="border-b border-[--site-border] bg-[--site-surface]">
      <div className="mx-auto flex max-w-5xl items-center justify-between px-6 py-4">
        <div className="flex items-center gap-2.5">
          <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-[--oxygen] text-white font-bold text-xs">
            NTL
          </div>
          <span className="text-base font-bold text-[--site-text]">Non-Toxic Living</span>
        </div>
        <nav className="flex items-center gap-5 text-sm">
          <Link href="/support" className="text-[--site-text-secondary] hover:text-[--site-text] transition-colors">
            Support
          </Link>
          <Link href="/privacy" className="text-[--site-text-secondary] hover:text-[--site-text] transition-colors">
            Privacy
          </Link>
          <Link href="/terms" className="text-[--site-text-secondary] hover:text-[--site-text] transition-colors">
            Terms
          </Link>
        </nav>
      </div>
    </header>
  );
}

function Footer() {
  return (
    <footer className="border-t border-[--site-border] bg-[--site-surface] py-8 px-6">
      <div className="mx-auto flex max-w-5xl flex-col items-center gap-4 text-sm text-[--site-text-muted] sm:flex-row sm:justify-between">
        <span>&copy; {new Date().getFullYear()} Non-Toxic Living. All rights reserved.</span>
        <div className="flex gap-6">
          <Link href="/support" className="hover:text-[--site-text] transition-colors">Support</Link>
          <Link href="/privacy" className="hover:text-[--site-text] transition-colors">Privacy</Link>
          <Link href="/terms" className="hover:text-[--site-text] transition-colors">Terms</Link>
        </div>
      </div>
    </footer>
  );
}

export default function LandingPage() {
  return (
    <div
      className="min-h-screen font-[family-name:var(--font-space-grotesk)]"
      style={
        {
          background: 'var(--color-site-bg)',
          color: 'var(--color-site-text)',
          '--site-border': 'var(--color-site-border)',
          '--site-surface': 'var(--color-site-surface)',
          '--site-text': 'var(--color-site-text)',
          '--site-text-secondary': 'var(--color-site-text-secondary)',
          '--site-text-muted': 'var(--color-site-text-muted)',
          '--oxygen': 'var(--color-oxygen)',
          '--oxygen-deep': 'var(--color-oxygen-deep)',
        } as React.CSSProperties
      }
    >
      <Header />

      {/* Hero */}
      <section className="py-24 px-6">
        <div className="mx-auto max-w-3xl text-center">
          <h1 className="text-4xl font-bold tracking-tight sm:text-5xl leading-tight">
            Is that product{' '}
            <span className="text-[--oxygen]">safe</span>?
          </h1>
          <p className="mt-6 text-lg text-[--site-text-secondary] leading-relaxed max-w-2xl mx-auto">
            Point your camera at any ingredient label and get an instant safety score.
            Non-Toxic Living analyzes food, cosmetics, household cleaners, baby products,
            cookware, and more — so you can make healthier choices for your family.
          </p>
          <div className="mt-10 flex flex-col items-center gap-4 sm:flex-row sm:justify-center">
            <a
              href="https://apps.apple.com/app/non-toxic-living/id000000000"
              className="inline-flex items-center gap-2.5 rounded-2xl bg-[--oxygen] px-7 py-3.5 text-sm font-semibold text-white hover:bg-[--oxygen-deep] transition-colors shadow-[0_10px_30px_-5px_rgba(14,165,233,0.3)]"
            >
              <svg className="h-5 w-5" viewBox="0 0 24 24" fill="currentColor">
                <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z" />
              </svg>
              Download on the App Store
            </a>
          </div>
        </div>
      </section>

      {/* How It Works */}
      <section className="border-t border-[--site-border] py-24 px-6">
        <div className="mx-auto max-w-4xl">
          <h2 className="text-center text-2xl font-bold">How it works</h2>
          <div className="mt-14 grid gap-8 sm:grid-cols-3">
            {[
              {
                step: '1',
                title: 'Scan',
                desc: 'Point your camera at any product ingredient label, or type a product description.',
                color: 'var(--color-oxygen)',
                bg: 'rgba(14, 165, 233, 0.12)',
              },
              {
                step: '2',
                title: 'Analyze',
                desc: 'AI analyzes every ingredient for toxicity, allergens, and health concerns.',
                color: 'var(--color-caution)',
                bg: 'rgba(245, 158, 11, 0.12)',
              },
              {
                step: '3',
                title: 'Swap',
                desc: 'Get a safety score and find safer alternatives for any flagged products.',
                color: 'var(--color-safe)',
                bg: 'rgba(16, 185, 129, 0.12)',
              },
            ].map((item) => (
              <div key={item.step} className="text-center">
                <div
                  className="mx-auto flex h-14 w-14 items-center justify-center rounded-2xl text-xl font-bold"
                  style={{ background: item.bg, color: item.color }}
                >
                  {item.step}
                </div>
                <h3 className="mt-5 font-semibold text-[--site-text]">{item.title}</h3>
                <p className="mt-2 text-sm text-[--site-text-secondary] leading-relaxed">{item.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Scoring */}
      <section className="border-t border-[--site-border] py-24 px-6">
        <div className="mx-auto max-w-4xl">
          <h2 className="text-center text-2xl font-bold">Safety scoring</h2>
          <p className="mt-4 text-center text-[--site-text-secondary]">
            Every product gets a clear score from 0 to 100.
          </p>
          <div className="mt-14 grid gap-6 sm:grid-cols-3">
            <div className="rounded-2xl p-6 text-center border" style={{ borderColor: 'rgba(16, 185, 129, 0.2)', background: 'rgba(16, 185, 129, 0.06)' }}>
              <div className="text-3xl font-bold" style={{ color: 'var(--color-safe)' }}>67–100</div>
              <div className="mt-2 font-semibold" style={{ color: 'var(--color-safe)' }}>Safe</div>
              <p className="mt-2 text-sm text-[--site-text-secondary]">No significant concerns found.</p>
            </div>
            <div className="rounded-2xl p-6 text-center border" style={{ borderColor: 'rgba(245, 158, 11, 0.2)', background: 'rgba(245, 158, 11, 0.06)' }}>
              <div className="text-3xl font-bold" style={{ color: 'var(--color-caution)' }}>34–66</div>
              <div className="mt-2 font-semibold" style={{ color: 'var(--color-caution)' }}>Caution</div>
              <p className="mt-2 text-sm text-[--site-text-secondary]">Some ingredients worth noting.</p>
            </div>
            <div className="rounded-2xl p-6 text-center border" style={{ borderColor: 'rgba(239, 68, 68, 0.2)', background: 'rgba(239, 68, 68, 0.06)' }}>
              <div className="text-3xl font-bold" style={{ color: 'var(--color-toxic)' }}>0–33</div>
              <div className="mt-2 font-semibold" style={{ color: 'var(--color-toxic)' }}>Toxic</div>
              <p className="mt-2 text-sm text-[--site-text-secondary]">Contains ingredients linked to health concerns.</p>
            </div>
          </div>
        </div>
      </section>

      {/* Categories */}
      <section className="border-t border-[--site-border] py-24 px-6">
        <div className="mx-auto max-w-4xl">
          <h2 className="text-center text-2xl font-bold">What you can scan</h2>
          <div className="mt-14 grid grid-cols-2 gap-4 sm:grid-cols-3">
            {[
              { label: 'Food & Beverages', icon: '🍎' },
              { label: 'Skincare & Cosmetics', icon: '🧴' },
              { label: 'Household Cleaners', icon: '🧹' },
              { label: 'Baby Products', icon: '🍼' },
              { label: 'Cookware', icon: '🍳' },
              { label: 'Supplements', icon: '💊' },
            ].map((item) => (
              <div
                key={item.label}
                className="flex items-center gap-3 rounded-2xl border p-5"
                style={{ borderColor: 'var(--color-site-border-light)', background: 'var(--color-site-surface)' }}
              >
                <span className="text-2xl">{item.icon}</span>
                <span className="text-sm font-medium text-[--site-text]">{item.label}</span>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Plans */}
      <section className="border-t border-[--site-border] py-24 px-6">
        <div className="mx-auto max-w-4xl">
          <h2 className="text-center text-2xl font-bold">Simple pricing</h2>
          <p className="mt-4 text-center text-[--site-text-secondary]">
            Start free. Upgrade when you need more scans.
          </p>
          <div className="mt-14 grid gap-6 sm:grid-cols-3">
            {/* Free */}
            <div className="rounded-2xl border p-6" style={{ borderColor: 'var(--color-site-border-light)', background: 'var(--color-site-surface)' }}>
              <h3 className="font-semibold text-[--site-text]">Free</h3>
              <div className="mt-2 text-3xl font-bold text-[--site-text]">$0</div>
              <ul className="mt-6 space-y-2.5 text-sm text-[--site-text-secondary]">
                <li>5 scans per month</li>
                <li>Basic ingredient analysis</li>
              </ul>
            </div>
            {/* Pro */}
            <div
              className="rounded-2xl border-2 p-6 relative"
              style={{ borderColor: 'var(--color-oxygen)', background: 'var(--color-site-surface)', boxShadow: '0 10px 40px -10px rgba(14, 165, 233, 0.2)' }}
            >
              <div
                className="absolute -top-3 left-1/2 -translate-x-1/2 rounded-full px-3 py-0.5 text-xs font-semibold text-white"
                style={{ background: 'var(--color-oxygen)' }}
              >
                Most popular
              </div>
              <h3 className="font-semibold text-[--site-text]">Pro</h3>
              <div className="mt-2 text-3xl font-bold text-[--site-text]">
                $7.99<span className="text-base font-normal text-[--site-text-muted]">/mo</span>
              </div>
              <ul className="mt-6 space-y-2.5 text-sm text-[--site-text-secondary]">
                <li>200 scans per month</li>
                <li>Detailed safety reports</li>
                <li>Priority support</li>
              </ul>
            </div>
            {/* Power */}
            <div className="rounded-2xl border p-6" style={{ borderColor: 'var(--color-site-border-light)', background: 'var(--color-site-surface)' }}>
              <h3 className="font-semibold text-[--site-text]">Power</h3>
              <div className="mt-2 text-3xl font-bold text-[--site-text]">
                $14.99<span className="text-base font-normal text-[--site-text-muted]">/mo</span>
              </div>
              <ul className="mt-6 space-y-2.5 text-sm text-[--site-text-secondary]">
                <li>500 scans per month</li>
                <li>Everything in Pro</li>
                <li>Family sharing</li>
                <li>Export reports</li>
              </ul>
            </div>
          </div>
          <p className="mt-8 text-center text-sm text-[--site-text-muted]">
            Annual plans available with 1 month free.
          </p>
        </div>
      </section>

      <Footer />
    </div>
  );
}
