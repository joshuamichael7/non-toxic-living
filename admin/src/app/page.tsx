import type { Metadata } from 'next';
import Link from 'next/link';

export const metadata: Metadata = {
  title: 'Non-Toxic Living — Know What\u2019s Really in Your Products',
  description:
    'Scan any ingredient label and get an instant safety score. Find hidden toxins in food, cosmetics, household items, and more.',
};

function Header() {
  return (
    <header className="fixed top-0 left-0 right-0 z-50 border-b border-[--site-border]" style={{ background: 'rgba(17, 17, 17, 0.85)', backdropFilter: 'blur(12px)', WebkitBackdropFilter: 'blur(12px)' }}>
      <div className="mx-auto flex max-w-5xl items-center justify-between px-6 py-4">
        <div className="flex items-center gap-2.5">
          <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-[--oxygen] text-white font-bold text-xs">
            NTL
          </div>
          <span className="text-base font-bold text-[--site-text]">Non-Toxic Living</span>
        </div>
        <nav className="hidden sm:flex items-center gap-6 text-sm">
          <a href="#how-it-works" className="text-[--site-text-secondary] hover:text-[--site-text] transition-colors">
            How It Works
          </a>
          <a href="#scoring" className="text-[--site-text-secondary] hover:text-[--site-text] transition-colors">
            Scoring
          </a>
          <a href="#pricing" className="text-[--site-text-secondary] hover:text-[--site-text] transition-colors">
            Pricing
          </a>
          <Link href="/support" className="text-[--site-text-secondary] hover:text-[--site-text] transition-colors">
            Support
          </Link>
        </nav>
        <a
          href="https://apps.apple.com/app/non-toxic-living/id000000000"
          className="rounded-full px-5 py-2 text-sm font-semibold text-white transition-colors"
          style={{ background: 'var(--color-oxygen)' }}
        >
          Get the App
        </a>
      </div>
    </header>
  );
}

function Footer() {
  return (
    <footer className="border-t border-[--site-border] py-10 px-6" style={{ background: 'var(--color-site-surface)' }}>
      <div className="mx-auto max-w-5xl">
        <div className="flex flex-col items-center gap-6 sm:flex-row sm:justify-between">
          <div className="flex items-center gap-2.5">
            <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-[--oxygen] text-white font-bold text-xs">
              NTL
            </div>
            <span className="text-base font-bold text-[--site-text]">Non-Toxic Living</span>
          </div>
          <div className="flex gap-6 text-sm text-[--site-text-muted]">
            <Link href="/support" className="hover:text-[--site-text] transition-colors">Support</Link>
            <Link href="/privacy" className="hover:text-[--site-text] transition-colors">Privacy Policy</Link>
            <Link href="/terms" className="hover:text-[--site-text] transition-colors">Terms of Use</Link>
          </div>
        </div>
        <div className="mt-8 text-center text-sm text-[--site-text-muted]">
          &copy; {new Date().getFullYear()} Aberdeen Co. All rights reserved.
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

      {/* ── Hero ── */}
      <section className="pt-36 pb-24 px-6 sm:pt-44 sm:pb-32">
        <div className="mx-auto max-w-3xl text-center">
          <h1 className="text-4xl font-extrabold tracking-tight sm:text-6xl leading-[1.1]">
            You don&apos;t know what&apos;s<br />in your products.
          </h1>
          <p className="mt-6 text-lg sm:text-xl text-[--site-text-secondary] leading-relaxed max-w-2xl mx-auto">
            Non-Toxic Living scans ingredient labels and tells you what&apos;s safe, what&apos;s
            not, and what to use instead. Automatically.
          </p>
          <div className="mt-10 flex flex-col items-center gap-4 sm:flex-row sm:justify-center">
            <a
              href="https://apps.apple.com/app/non-toxic-living/id000000000"
              className="inline-flex items-center gap-2.5 rounded-full px-8 py-4 text-sm font-semibold text-white transition-colors"
              style={{ background: 'var(--color-oxygen)', boxShadow: '0 12px 40px -8px rgba(14, 165, 233, 0.35)' }}
            >
              <svg className="h-5 w-5" viewBox="0 0 24 24" fill="currentColor">
                <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z" />
              </svg>
              Download for iOS
            </a>
          </div>

          {/* Hero example interaction */}
          <div
            className="mt-16 mx-auto max-w-md rounded-3xl border p-6 text-left"
            style={{ borderColor: 'var(--color-site-border-light)', background: 'var(--color-site-surface)' }}
          >
            <div className="flex items-start gap-3">
              <div className="mt-0.5 flex h-8 w-8 shrink-0 items-center justify-center rounded-full text-sm" style={{ background: 'rgba(14, 165, 233, 0.12)', color: 'var(--color-oxygen)' }}>
                📷
              </div>
              <div>
                <p className="text-sm text-[--site-text-muted]">You scanned:</p>
                <p className="mt-1 text-sm font-medium text-[--site-text]">&quot;Sodium Lauryl Sulfate, Parabens, Fragrance, Triclosan...&quot;</p>
              </div>
            </div>
            <div className="mt-4 flex items-start gap-3">
              <div className="mt-0.5 flex h-8 w-8 shrink-0 items-center justify-center rounded-full text-sm" style={{ background: 'rgba(239, 68, 68, 0.12)', color: 'var(--color-toxic)' }}>
                ⚠️
              </div>
              <div>
                <p className="text-sm font-medium" style={{ color: 'var(--color-toxic)' }}>Score: 23/100 — Toxic</p>
                <p className="mt-1 text-sm text-[--site-text-secondary]">4 ingredients flagged. 2 safer alternatives found.</p>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* ── Problem Statement ── */}
      <section className="py-24 px-6 sm:py-32">
        <div className="mx-auto max-w-3xl text-center">
          <h2 className="text-3xl font-extrabold sm:text-4xl leading-tight">
            Labels aren&apos;t designed<br />for you to understand.
          </h2>
          <div className="mt-16 grid gap-12 sm:grid-cols-2 text-left">
            <div>
              <h3 className="text-lg font-bold text-[--site-text]">The Hidden Ingredients</h3>
              <p className="mt-3 text-[--site-text-secondary] leading-relaxed">
                Parabens, phthalates, artificial dyes, &quot;fragrance.&quot; Harmful chemicals hide behind
                names you can&apos;t pronounce on labels you don&apos;t have time to research.
              </p>
            </div>
            <div>
              <h3 className="text-lg font-bold text-[--site-text]">The Overwhelm</h3>
              <p className="mt-3 text-[--site-text-secondary] leading-relaxed">
                Googling every ingredient on every product you buy? Nobody has time for that.
                You need answers in the aisle, not after an hour of research.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* ── How It Works (features) ── */}
      <section id="how-it-works" className="py-24 px-6 sm:py-32">
        <div className="mx-auto max-w-3xl">
          <h2 className="text-center text-3xl font-extrabold sm:text-4xl leading-tight">
            Intelligent. Instant.
          </h2>
          <p className="mt-4 text-center text-lg text-[--site-text-secondary]">
            Non-Toxic Living doesn&apos;t just read labels. It understands them.
          </p>

          <div className="mt-20 space-y-20">
            {/* Feature 1 */}
            <div className="flex flex-col gap-6 sm:flex-row sm:items-start sm:gap-8">
              <div className="flex h-14 w-14 shrink-0 items-center justify-center rounded-2xl text-2xl" style={{ background: 'rgba(14, 165, 233, 0.12)' }}>
                📷
              </div>
              <div>
                <h3 className="text-xl font-bold text-[--site-text]">Just scan.</h3>
                <p className="mt-2 text-[--site-text-secondary] leading-relaxed">
                  No typing. No searching databases. Point your camera at any ingredient label —
                  food, shampoo, cleaning spray, baby lotion — and get a full analysis in seconds.
                </p>
              </div>
            </div>

            {/* Feature 2 */}
            <div className="flex flex-col gap-6 sm:flex-row sm:items-start sm:gap-8">
              <div className="flex h-14 w-14 shrink-0 items-center justify-center rounded-2xl text-2xl" style={{ background: 'rgba(16, 185, 129, 0.12)' }}>
                🧠
              </div>
              <div>
                <h3 className="text-xl font-bold text-[--site-text]">AI that knows chemistry.</h3>
                <p className="mt-2 text-[--site-text-secondary] leading-relaxed">
                  Every ingredient is cross-referenced against toxicity research, regulatory databases,
                  and health studies. You get a clear safety score — not a vague &quot;maybe.&quot;
                </p>
              </div>
            </div>

            {/* Feature 3 */}
            <div className="flex flex-col gap-6 sm:flex-row sm:items-start sm:gap-8">
              <div className="flex h-14 w-14 shrink-0 items-center justify-center rounded-2xl text-2xl" style={{ background: 'rgba(245, 158, 11, 0.12)' }}>
                🔄
              </div>
              <div>
                <h3 className="text-xl font-bold text-[--site-text]">Swaps, not just scores.</h3>
                <p className="mt-2 text-[--site-text-secondary] leading-relaxed">
                  When a product gets flagged, we don&apos;t just tell you it&apos;s bad. We show you
                  safer alternatives you can actually buy — so you leave the store with something better.
                </p>
              </div>
            </div>

            {/* Feature 4 */}
            <div className="flex flex-col gap-6 sm:flex-row sm:items-start sm:gap-8">
              <div className="flex h-14 w-14 shrink-0 items-center justify-center rounded-2xl text-2xl" style={{ background: 'rgba(239, 68, 68, 0.12)' }}>
                🌍
              </div>
              <div>
                <h3 className="text-xl font-bold text-[--site-text]">Works everywhere.</h3>
                <p className="mt-2 text-[--site-text-secondary] leading-relaxed">
                  Reads labels in English, Korean, Japanese, Chinese, Spanish, French, Arabic, and Hindi.
                  Use it at home or abroad — the ingredients don&apos;t change, and neither does our analysis.
                </p>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* ── Scoring ── */}
      <section id="scoring" className="py-24 px-6 sm:py-32">
        <div className="mx-auto max-w-3xl text-center">
          <h2 className="text-3xl font-extrabold sm:text-4xl leading-tight">
            A score you can trust.
          </h2>
          <p className="mt-4 text-lg text-[--site-text-secondary]">
            Every product gets a clear safety score from 0 to 100. No guesswork.
          </p>
          <div className="mt-14 grid gap-6 sm:grid-cols-3">
            <div className="rounded-2xl p-8 text-center border" style={{ borderColor: 'rgba(16, 185, 129, 0.2)', background: 'rgba(16, 185, 129, 0.06)' }}>
              <div className="text-4xl font-extrabold" style={{ color: 'var(--color-safe)' }}>67–100</div>
              <div className="mt-2 text-sm font-semibold" style={{ color: 'var(--color-safe)' }}>Safe</div>
              <p className="mt-3 text-sm text-[--site-text-secondary]">No significant concerns. Use with confidence.</p>
            </div>
            <div className="rounded-2xl p-8 text-center border" style={{ borderColor: 'rgba(245, 158, 11, 0.2)', background: 'rgba(245, 158, 11, 0.06)' }}>
              <div className="text-4xl font-extrabold" style={{ color: 'var(--color-caution)' }}>34–66</div>
              <div className="mt-2 text-sm font-semibold" style={{ color: 'var(--color-caution)' }}>Caution</div>
              <p className="mt-3 text-sm text-[--site-text-secondary]">Some ingredients to be aware of. Review the details.</p>
            </div>
            <div className="rounded-2xl p-8 text-center border" style={{ borderColor: 'rgba(239, 68, 68, 0.2)', background: 'rgba(239, 68, 68, 0.06)' }}>
              <div className="text-4xl font-extrabold" style={{ color: 'var(--color-toxic)' }}>0–33</div>
              <div className="mt-2 text-sm font-semibold" style={{ color: 'var(--color-toxic)' }}>Toxic</div>
              <p className="mt-3 text-sm text-[--site-text-secondary]">Contains ingredients linked to health concerns. Consider a swap.</p>
            </div>
          </div>
        </div>
      </section>

      {/* ── Comparison ── */}
      <section className="py-24 px-6 sm:py-32">
        <div className="mx-auto max-w-3xl text-center">
          <h2 className="text-3xl font-extrabold sm:text-4xl leading-tight">
            A new way to shop.
          </h2>

          <div className="mt-14 grid gap-6 sm:grid-cols-2">
            {/* The Old Way */}
            <div
              className="rounded-2xl border p-8 text-left"
              style={{ borderColor: 'var(--color-site-border-light)', background: 'var(--color-site-surface)' }}
            >
              <h3 className="text-sm font-semibold uppercase tracking-wider text-[--site-text-muted]">The Old Way</h3>
              <ul className="mt-6 space-y-4 text-[--site-text-secondary]">
                <li className="flex items-start gap-3">
                  <span className="mt-0.5 text-[--site-text-muted]">✕</span>
                  <span>Google every ingredient</span>
                </li>
                <li className="flex items-start gap-3">
                  <span className="mt-0.5 text-[--site-text-muted]">✕</span>
                  <span>Read conflicting blog posts</span>
                </li>
                <li className="flex items-start gap-3">
                  <span className="mt-0.5 text-[--site-text-muted]">✕</span>
                  <span>Still not sure what&apos;s safe</span>
                </li>
                <li className="flex items-start gap-3">
                  <span className="mt-0.5 text-[--site-text-muted]">✕</span>
                  <span>Give up and buy it anyway</span>
                </li>
              </ul>
            </div>

            {/* With Non-Toxic Living */}
            <div
              className="rounded-2xl border-2 p-8 text-left"
              style={{ borderColor: 'var(--color-oxygen)', background: 'var(--color-site-surface)', boxShadow: '0 10px 40px -10px rgba(14, 165, 233, 0.15)' }}
            >
              <h3 className="text-sm font-semibold uppercase tracking-wider" style={{ color: 'var(--color-oxygen)' }}>With Non-Toxic Living</h3>
              <ul className="mt-6 space-y-4 text-[--site-text-secondary]">
                <li className="flex items-start gap-3">
                  <span className="mt-0.5" style={{ color: 'var(--color-safe)' }}>✓</span>
                  <span>Scan the label in 2 seconds</span>
                </li>
                <li className="flex items-start gap-3">
                  <span className="mt-0.5" style={{ color: 'var(--color-safe)' }}>✓</span>
                  <span>Get a clear safety score instantly</span>
                </li>
                <li className="flex items-start gap-3">
                  <span className="mt-0.5" style={{ color: 'var(--color-safe)' }}>✓</span>
                  <span>See exactly which ingredients are flagged</span>
                </li>
                <li className="flex items-start gap-3">
                  <span className="mt-0.5" style={{ color: 'var(--color-safe)' }}>✓</span>
                  <span>Find a safer alternative on the spot</span>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      {/* ── What You Can Scan ── */}
      <section className="py-24 px-6 sm:py-32">
        <div className="mx-auto max-w-3xl text-center">
          <h2 className="text-3xl font-extrabold sm:text-4xl leading-tight">
            If it has a label, scan it.
          </h2>
          <p className="mt-4 text-lg text-[--site-text-secondary]">
            Food, skincare, cleaning products, baby gear — everything in your home.
          </p>
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

      {/* ── Pricing ── */}
      <section id="pricing" className="py-24 px-6 sm:py-32">
        <div className="mx-auto max-w-3xl text-center">
          <h2 className="text-3xl font-extrabold sm:text-4xl leading-tight">
            Start free. Upgrade anytime.
          </h2>
          <p className="mt-4 text-lg text-[--site-text-secondary]">
            5 free scans every month. No credit card required.
          </p>
          <div className="mt-14 grid gap-6 sm:grid-cols-3 text-left">
            {/* Free */}
            <div
              className="rounded-2xl border p-7"
              style={{ borderColor: 'var(--color-site-border-light)', background: 'var(--color-site-surface)' }}
            >
              <h3 className="font-bold text-[--site-text]">Free</h3>
              <div className="mt-3 text-3xl font-extrabold text-[--site-text]">$0</div>
              <p className="mt-1 text-sm text-[--site-text-muted]">Forever</p>
              <ul className="mt-6 space-y-3 text-sm text-[--site-text-secondary]">
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> 5 scans per month
                </li>
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> Basic analysis
                </li>
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> Swap recommendations
                </li>
              </ul>
            </div>
            {/* Pro */}
            <div
              className="rounded-2xl border-2 p-7 relative"
              style={{ borderColor: 'var(--color-oxygen)', background: 'var(--color-site-surface)', boxShadow: '0 10px 40px -10px rgba(14, 165, 233, 0.2)' }}
            >
              <div
                className="absolute -top-3 left-1/2 -translate-x-1/2 rounded-full px-4 py-1 text-xs font-semibold text-white"
                style={{ background: 'var(--color-oxygen)' }}
              >
                Most popular
              </div>
              <h3 className="font-bold text-[--site-text]">Pro</h3>
              <div className="mt-3 text-3xl font-extrabold text-[--site-text]">
                $7.99<span className="text-base font-normal text-[--site-text-muted]">/mo</span>
              </div>
              <p className="mt-1 text-sm text-[--site-text-muted]">or $87.99/year (1 month free)</p>
              <ul className="mt-6 space-y-3 text-sm text-[--site-text-secondary]">
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> 200 scans per month
                </li>
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> Detailed safety reports
                </li>
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> Priority support
                </li>
              </ul>
            </div>
            {/* Power */}
            <div
              className="rounded-2xl border p-7"
              style={{ borderColor: 'var(--color-site-border-light)', background: 'var(--color-site-surface)' }}
            >
              <h3 className="font-bold text-[--site-text]">Power</h3>
              <div className="mt-3 text-3xl font-extrabold text-[--site-text]">
                $14.99<span className="text-base font-normal text-[--site-text-muted]">/mo</span>
              </div>
              <p className="mt-1 text-sm text-[--site-text-muted]">or $164.99/year (1 month free)</p>
              <ul className="mt-6 space-y-3 text-sm text-[--site-text-secondary]">
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> 500 scans per month
                </li>
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> Everything in Pro
                </li>
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> Family sharing
                </li>
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> Export reports
                </li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      {/* ── Final CTA ── */}
      <section className="py-24 px-6 sm:py-32">
        <div className="mx-auto max-w-2xl text-center">
          <h2 className="text-3xl font-extrabold sm:text-4xl leading-tight">
            Know what&apos;s in your products.<br />
            <span style={{ color: 'var(--color-oxygen)' }}>Before</span> they&apos;re in your home.
          </h2>
          <div className="mt-10">
            <a
              href="https://apps.apple.com/app/non-toxic-living/id000000000"
              className="inline-flex items-center gap-2.5 rounded-full px-8 py-4 text-sm font-semibold text-white transition-colors"
              style={{ background: 'var(--color-oxygen)', boxShadow: '0 12px 40px -8px rgba(14, 165, 233, 0.35)' }}
            >
              <svg className="h-5 w-5" viewBox="0 0 24 24" fill="currentColor">
                <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z" />
              </svg>
              Download for iOS
            </a>
          </div>
          <p className="mt-6 text-sm text-[--site-text-muted]">
            Free to try. No credit card required.
          </p>
        </div>
      </section>

      <Footer />
    </div>
  );
}
