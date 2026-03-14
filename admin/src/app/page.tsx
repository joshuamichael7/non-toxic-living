import type { Metadata } from 'next';
import Link from 'next/link';

export const metadata: Metadata = {
  title: 'NoTox — Know What\u2019s Really in Your Products',
  description:
    'Scan any ingredient label and get an instant safety score. Find hidden toxins in food, cosmetics, household items, and more.',
};

function Header() {
  return (
    <header className="fixed top-0 left-0 right-0 z-50 border-b border-[--site-border]" style={{ background: 'rgba(17, 17, 17, 0.85)', backdropFilter: 'blur(12px)', WebkitBackdropFilter: 'blur(12px)' }}>
      <div className="mx-auto flex max-w-5xl items-center justify-between px-6 py-4">
        <div className="flex items-center gap-2.5">
          <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-[--oxygen] text-white font-bold text-xs">
            NT
          </div>
          <span className="text-base font-bold text-[--site-text]">NoTox</span>
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
        <div className="flex items-center gap-2">
          <a
            href="https://apps.apple.com/us/app/notox-product-scanner/id6758887710"
            className="rounded-full px-5 py-2 text-sm font-semibold text-white transition-colors"
            style={{ background: 'var(--color-oxygen)' }}
          >
            iOS
          </a>
          <a
            href="https://play.google.com/store/apps/details?id=com.nontoxicliving.app"
            className="rounded-full px-5 py-2 text-sm font-semibold text-white transition-colors"
            style={{ background: 'var(--color-oxygen)' }}
          >
            Android
          </a>
        </div>
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
              NT
            </div>
            <span className="text-base font-bold text-[--site-text]">NoTox</span>
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
            NoTox scans ingredient labels and tells you what&apos;s safe, what&apos;s
            not, and what to use instead. Automatically.
          </p>
          <div className="mt-10 flex flex-col items-center gap-4 sm:flex-row sm:justify-center">
            <a
              href="https://apps.apple.com/us/app/notox-product-scanner/id6758887710"
              className="inline-flex items-center gap-2.5 rounded-full px-8 py-4 text-sm font-semibold text-white transition-colors"
              style={{ background: 'var(--color-oxygen)', boxShadow: '0 12px 40px -8px rgba(14, 165, 233, 0.35)' }}
            >
              <svg className="h-5 w-5" viewBox="0 0 24 24" fill="currentColor">
                <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z" />
              </svg>
              Download for iOS
            </a>
            <a
              href="https://play.google.com/store/apps/details?id=com.nontoxicliving.app"
              className="inline-flex items-center gap-2.5 rounded-full px-8 py-4 text-sm font-semibold text-white transition-colors"
              style={{ background: 'var(--color-oxygen)', boxShadow: '0 12px 40px -8px rgba(14, 165, 233, 0.35)' }}
            >
              <svg className="h-5 w-5" viewBox="0 0 24 24" fill="currentColor">
                <path d="M3.18 23.76c.3.17.65.19.97.07l13.2-7.62-2.82-2.82-11.35 10.37zm-1.9-20.3C1.1 3.8 1 4.18 1 4.59v14.82c0 .41.1.79.28 1.13l.07.06 8.3-8.3v-.19L1.35 3.4l-.07.06zM20.13 10.4l-2.82-1.63-3.17 3.17 3.17 3.17 2.85-1.65c.81-.47.81-1.23-.03-1.06zM4.15.24L17.35 7.86l-2.82 2.82L3.18.31C3.5.19 3.85.21 4.15.38z" />
              </svg>
              Download for Android
            </a>
          </div>

          {/* Phone mockups — 3 phones matching app screenshots exactly */}
          <div className="mt-16 flex items-center justify-center gap-3">

            {/* Reusable phone shell styles */}
            {/* ── Phone 1: Score 67 Okay + Summary (IMG_2364) ── */}
            <div className="hidden sm:block relative overflow-hidden" style={{ width: 190, height: 520, borderRadius: 32, border: '5px solid #2A2A2A', background: '#EBEBEB', flexShrink: 0 }}>
              <div className="absolute top-0 left-1/2 -translate-x-1/2 z-10" style={{ width: 80, height: 18, background: '#2A2A2A', borderRadius: '0 0 12px 12px' }} />
              <div style={{ height: '100%', background: '#EBEBEB', display: 'flex', flexDirection: 'column' }}>
                {/* Status bar */}
                <div style={{ height: 26 }} />
                {/* Header */}
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '5px 10px' }}>
                  <div style={{ width: 26, height: 26, borderRadius: 8, background: 'white', boxShadow: '0 1px 4px rgba(0,0,0,0.15)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <span style={{ fontSize: 10, fontWeight: 700, color: '#1A1A1A' }}>✕</span>
                  </div>
                  <span style={{ fontSize: 7, fontWeight: 600, color: '#94A3B8', textTransform: 'uppercase', letterSpacing: '0.1em' }}>Analysis Result</span>
                  <div style={{ width: 26, height: 26, borderRadius: 8, background: 'white', boxShadow: '0 1px 4px rgba(0,0,0,0.15)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <span style={{ fontSize: 10, color: '#1A1A1A' }}>⬆</span>
                  </div>
                </div>
                {/* Scrollable content */}
                <div style={{ flex: 1, overflow: 'hidden', paddingBottom: 2 }}>
                  {/* Score card */}
                  <div style={{ margin: '6px 8px 0', borderRadius: 20, padding: '14px 10px 12px', background: 'white', boxShadow: '0 2px 10px rgba(0,0,0,0.08)', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                    <div style={{ width: 62, height: 62, borderRadius: 17, background: 'rgba(132,204,22,0.18)', border: '3px solid #84CC16', display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: 8 }}>
                      <span style={{ fontSize: 26, fontWeight: 900, color: '#84CC16' }}>67</span>
                    </div>
                    <p style={{ fontSize: 10, fontWeight: 800, color: '#111', textAlign: 'center', marginBottom: 2 }}>Fluoride-Free Whitening Toothpaste</p>
                    <p style={{ fontSize: 8, color: '#64748B', marginBottom: 7 }}>Tom&apos;s of Maine</p>
                    <div style={{ display: 'flex', alignItems: 'center', gap: 4, borderRadius: 50, paddingLeft: 10, paddingRight: 10, paddingTop: 4, paddingBottom: 4, border: '1.5px solid #84CC16', background: 'rgba(132,204,22,0.1)' }}>
                      <div style={{ width: 12, height: 12, borderRadius: '50%', background: '#84CC16', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                        <span style={{ fontSize: 7, color: 'white', fontWeight: 700 }}>✓</span>
                      </div>
                      <span style={{ fontSize: 8, fontWeight: 700, color: '#84CC16' }}>Okay</span>
                    </div>
                  </div>
                  {/* Summary card */}
                  <div style={{ margin: '6px 8px 0', borderRadius: 18, padding: '10px 10px', background: 'white', boxShadow: '0 2px 10px rgba(0,0,0,0.08)' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginBottom: 6 }}>
                      <div style={{ width: 20, height: 20, borderRadius: 6, background: '#BAE6FD', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                        <span style={{ fontSize: 9 }}>📋</span>
                      </div>
                      <span style={{ fontSize: 7, fontWeight: 600, color: '#94A3B8', textTransform: 'uppercase', letterSpacing: '0.08em' }}>Summary</span>
                    </div>
                    <p style={{ fontSize: 7, lineHeight: '11px', color: '#1A1A1A' }}>This toothpaste has a clean ingredient list with no harmful additives. It avoids fluoride, which some consumers prefer, and uses natural flavors. However, it contains sodium lauryl sulfate, which may be a concern for some.</p>
                  </div>
                </div>
                {/* Bottom bar */}
                <div style={{ padding: '8px 10px', background: '#F0F0F0', borderTop: '1px solid rgba(0,0,0,0.06)', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 4 }}>
                    <span style={{ fontSize: 13, color: '#1A1A1A' }}>♡</span>
                    <span style={{ fontSize: 9, fontWeight: 600, color: '#1A1A1A' }}>Save</span>
                  </div>
                  <div style={{ background: '#0EA5E9', borderRadius: 16, paddingLeft: 12, paddingRight: 12, paddingTop: 6, paddingBottom: 6, display: 'flex', alignItems: 'center', gap: 4 }}>
                    <span style={{ fontSize: 8, color: 'white' }}>⌾</span>
                    <span style={{ fontSize: 8, fontWeight: 700, color: 'white' }}>Scan Again</span>
                  </div>
                </div>
              </div>
            </div>

            {/* ── Phone 2: Score 34 Caution + Summary (IMG_2362) ── */}
            <div className="relative overflow-hidden" style={{ width: 190, height: 520, borderRadius: 32, border: '5px solid #2A2A2A', background: '#EBEBEB', flexShrink: 0 }}>
              <div className="absolute top-0 left-1/2 -translate-x-1/2 z-10" style={{ width: 80, height: 18, background: '#2A2A2A', borderRadius: '0 0 12px 12px' }} />
              <div style={{ height: '100%', background: '#EBEBEB', display: 'flex', flexDirection: 'column' }}>
                <div style={{ height: 26 }} />
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '5px 10px' }}>
                  <div style={{ width: 26, height: 26, borderRadius: 8, background: 'white', boxShadow: '0 1px 4px rgba(0,0,0,0.15)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <span style={{ fontSize: 10, fontWeight: 700, color: '#1A1A1A' }}>✕</span>
                  </div>
                  <span style={{ fontSize: 7, fontWeight: 600, color: '#94A3B8', textTransform: 'uppercase', letterSpacing: '0.1em' }}>Analysis Result</span>
                  <div style={{ width: 26, height: 26, borderRadius: 8, background: 'white', boxShadow: '0 1px 4px rgba(0,0,0,0.15)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <span style={{ fontSize: 10, color: '#1A1A1A' }}>⬆</span>
                  </div>
                </div>
                <div style={{ flex: 1, overflow: 'hidden' }}>
                  {/* Score card */}
                  <div style={{ margin: '6px 8px 0', borderRadius: 20, padding: '14px 10px 12px', background: 'white', boxShadow: '0 2px 10px rgba(0,0,0,0.08)', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                    <div style={{ width: 62, height: 62, borderRadius: 17, background: 'rgba(245,158,11,0.18)', border: '3px solid #F59E0B', display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: 8 }}>
                      <span style={{ fontSize: 26, fontWeight: 900, color: '#F59E0B' }}>34</span>
                    </div>
                    <p style={{ fontSize: 10, fontWeight: 800, color: '#111', textAlign: 'center', marginBottom: 2 }}>Fried Noodle</p>
                    <p style={{ fontSize: 8, color: '#64748B', marginBottom: 7 }}>Unknown</p>
                    <div style={{ display: 'flex', alignItems: 'center', gap: 4, borderRadius: 50, paddingLeft: 10, paddingRight: 10, paddingTop: 4, paddingBottom: 4, border: '1.5px solid #F59E0B', background: 'rgba(245,158,11,0.1)' }}>
                      <div style={{ width: 12, height: 12, borderRadius: '50%', background: '#F59E0B', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                        <span style={{ fontSize: 7, color: 'white', fontWeight: 700 }}>!</span>
                      </div>
                      <span style={{ fontSize: 8, fontWeight: 700, color: '#F59E0B' }}>Caution</span>
                    </div>
                  </div>
                  {/* Summary card */}
                  <div style={{ margin: '6px 8px 0', borderRadius: 18, padding: '10px 10px', background: 'white', boxShadow: '0 2px 10px rgba(0,0,0,0.08)' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginBottom: 6 }}>
                      <div style={{ width: 20, height: 20, borderRadius: 6, background: '#BAE6FD', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                        <span style={{ fontSize: 9 }}>📋</span>
                      </div>
                      <span style={{ fontSize: 7, fontWeight: 600, color: '#94A3B8', textTransform: 'uppercase', letterSpacing: '0.08em' }}>Summary</span>
                    </div>
                    <p style={{ fontSize: 7, lineHeight: '11px', color: '#1A1A1A' }}>This product contains several additives and flavor enhancers that may raise concerns, particularly for children. The presence of monosodium glutamate (MSG) and various flavoring agents could be problematic for sensitive individuals.</p>
                  </div>
                  {/* Peeking blue button edge */}
                  <div style={{ margin: '6px 8px 0', borderRadius: 14, height: 12, background: '#0EA5E9' }} />
                </div>
                {/* Bottom bar */}
                <div style={{ padding: '8px 10px', background: '#F0F0F0', borderTop: '1px solid rgba(0,0,0,0.06)', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 4 }}>
                    <span style={{ fontSize: 13, color: '#1A1A1A' }}>♡</span>
                    <span style={{ fontSize: 9, fontWeight: 600, color: '#1A1A1A' }}>Save</span>
                  </div>
                  <div style={{ background: '#0EA5E9', borderRadius: 16, paddingLeft: 12, paddingRight: 12, paddingTop: 6, paddingBottom: 6, display: 'flex', alignItems: 'center', gap: 4 }}>
                    <span style={{ fontSize: 8, color: 'white' }}>⌾</span>
                    <span style={{ fontSize: 8, fontWeight: 700, color: 'white' }}>Scan Again</span>
                  </div>
                </div>
              </div>
            </div>

            {/* ── Phone 3: Positives + Better Alternatives scrolled (IMG_2366) ── */}
            <div className="hidden sm:block relative overflow-hidden" style={{ width: 190, height: 520, borderRadius: 32, border: '5px solid #2A2A2A', background: '#EBEBEB', flexShrink: 0 }}>
              <div className="absolute top-0 left-1/2 -translate-x-1/2 z-10" style={{ width: 80, height: 18, background: '#2A2A2A', borderRadius: '0 0 12px 12px' }} />
              <div style={{ height: '100%', background: '#EBEBEB', display: 'flex', flexDirection: 'column' }}>
                <div style={{ height: 26 }} />
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '5px 10px' }}>
                  <div style={{ width: 26, height: 26, borderRadius: 8, background: 'white', boxShadow: '0 1px 4px rgba(0,0,0,0.15)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <span style={{ fontSize: 10, fontWeight: 700, color: '#1A1A1A' }}>✕</span>
                  </div>
                  <span style={{ fontSize: 7, fontWeight: 600, color: '#94A3B8', textTransform: 'uppercase', letterSpacing: '0.1em' }}>Analysis Result</span>
                  <div style={{ width: 26, height: 26, borderRadius: 8, background: 'white', boxShadow: '0 1px 4px rgba(0,0,0,0.15)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <span style={{ fontSize: 10, color: '#1A1A1A' }}>⬆</span>
                  </div>
                </div>
                <div style={{ flex: 1, overflow: 'hidden' }}>
                  {/* POSITIVES label */}
                  <div style={{ padding: '6px 10px 4px' }}>
                    <span style={{ fontSize: 7, fontWeight: 600, color: '#94A3B8', textTransform: 'uppercase', letterSpacing: '0.1em' }}>Positives</span>
                  </div>
                  {/* Positive pills */}
                  {[
                    'Fluoride-free formula caters to diverse customer preferences',
                    'Natural flavor from peppermint oil',
                    'No artificial flavors, sweeteners, or dyes',
                    'BPA-free tube and recyclable packaging',
                  ].map((item) => (
                    <div key={item} style={{ margin: '0 8px 4px', borderRadius: 10, padding: '6px 8px', border: '1.5px solid #10B981', background: 'rgba(16,185,129,0.1)', display: 'flex', alignItems: 'center', gap: 5 }}>
                      <div style={{ width: 13, height: 13, borderRadius: '50%', background: '#10B981', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                        <span style={{ fontSize: 7, color: 'white', fontWeight: 700 }}>✓</span>
                      </div>
                      <span style={{ fontSize: 7, color: '#10B981', fontWeight: 500, lineHeight: '10px' }}>{item}</span>
                    </div>
                  ))}
                  {/* BETTER ALTERNATIVES header */}
                  <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '6px 10px 4px' }}>
                    <span style={{ fontSize: 7, fontWeight: 600, color: '#94A3B8', textTransform: 'uppercase', letterSpacing: '0.1em' }}>Better Alternatives</span>
                    <div style={{ display: 'flex', alignItems: 'center', gap: 3, borderRadius: 50, paddingLeft: 6, paddingRight: 6, paddingTop: 3, paddingBottom: 3, background: 'rgba(14,165,233,0.15)' }}>
                      <span style={{ fontSize: 7 }}>🏪</span>
                      <span style={{ fontSize: 6, fontWeight: 600, color: '#0EA5E9' }}>Find at a store</span>
                    </div>
                  </div>
                  {/* Swap cards */}
                  {[
                    { score: 85, name: 'Antiplaque & Whitening Fluoride-Free Toothpaste', brand: "Tom's of Maine" },
                    { score: 75, name: 'Fluoride-Free Antiplaque Toothpaste', brand: "Tom's of Maine" },
                    { score: 84, name: 'Silly Strawberry Kids Fluoride-Free Toothpaste', brand: "Tom's of Maine" },
                  ].map((swap) => (
                    <div key={swap.name} style={{ margin: '0 8px 5px', borderRadius: 14, padding: '7px 8px', background: 'white', boxShadow: '0 2px 8px rgba(0,0,0,0.07)', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                      <div style={{ display: 'flex', alignItems: 'center', gap: 7 }}>
                        <div style={{ width: 32, height: 32, borderRadius: 9, background: 'rgba(16,185,129,0.15)', border: '2px solid #10B981', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                          <span style={{ fontSize: 11, fontWeight: 800, color: '#10B981' }}>{swap.score}</span>
                        </div>
                        <div>
                          <p style={{ fontSize: 7, fontWeight: 700, color: '#111', lineHeight: '10px' }}>{swap.name}</p>
                          <p style={{ fontSize: 6, color: '#64748B', marginTop: 1 }}>{swap.brand}</p>
                        </div>
                      </div>
                      <div style={{ width: 22, height: 22, borderRadius: 7, background: '#DBEAFE', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                        <span style={{ fontSize: 10, color: '#0EA5E9', fontWeight: 700 }}>→</span>
                      </div>
                    </div>
                  ))}
                </div>
                {/* Bottom bar */}
                <div style={{ padding: '8px 10px', background: '#F0F0F0', borderTop: '1px solid rgba(0,0,0,0.06)', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 4 }}>
                    <span style={{ fontSize: 13, color: '#1A1A1A' }}>♡</span>
                    <span style={{ fontSize: 9, fontWeight: 600, color: '#1A1A1A' }}>Save</span>
                  </div>
                  <div style={{ background: '#0EA5E9', borderRadius: 16, paddingLeft: 12, paddingRight: 12, paddingTop: 6, paddingBottom: 6, display: 'flex', alignItems: 'center', gap: 4 }}>
                    <span style={{ fontSize: 8, color: 'white' }}>⌾</span>
                    <span style={{ fontSize: 8, fontWeight: 700, color: 'white' }}>Scan Again</span>
                  </div>
                </div>
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
            NoTox doesn&apos;t just read labels. It understands them.
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
          <div className="mt-14 grid gap-6 sm:grid-cols-4">
            <div className="rounded-2xl p-8 text-center border" style={{ borderColor: 'rgba(16, 185, 129, 0.2)', background: 'rgba(16, 185, 129, 0.06)' }}>
              <div className="text-4xl font-extrabold" style={{ color: 'var(--color-safe)' }}>80–100</div>
              <div className="mt-2 text-sm font-semibold" style={{ color: 'var(--color-safe)' }}>Safe</div>
              <p className="mt-3 text-sm text-[--site-text-secondary]">No significant concerns. Use with confidence.</p>
            </div>
            <div className="rounded-2xl p-8 text-center border" style={{ borderColor: 'rgba(132, 204, 22, 0.2)', background: 'rgba(132, 204, 22, 0.06)' }}>
              <div className="text-4xl font-extrabold" style={{ color: '#84CC16' }}>67–79</div>
              <div className="mt-2 text-sm font-semibold" style={{ color: '#84CC16' }}>Okay</div>
              <p className="mt-3 text-sm text-[--site-text-secondary]">Generally fine, with minor things to note.</p>
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

            {/* With NoTox */}
            <div
              className="rounded-2xl border-2 p-8 text-left"
              style={{ borderColor: 'var(--color-oxygen)', background: 'var(--color-site-surface)', boxShadow: '0 10px 40px -10px rgba(14, 165, 233, 0.15)' }}
            >
              <h3 className="text-sm font-semibold uppercase tracking-wider" style={{ color: 'var(--color-oxygen)' }}>With NoTox</h3>
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
            Pay once. Scan forever.
          </h2>
          <p className="mt-4 text-lg text-[--site-text-secondary]">
            10 free scans to get started. Buy more whenever you need them — credits never expire.
          </p>
          <div className="mt-14 grid gap-6 sm:grid-cols-3 text-left">
            {/* Free trial */}
            <div
              className="rounded-2xl border p-7"
              style={{ borderColor: 'var(--color-site-border-light)', background: 'var(--color-site-surface)' }}
            >
              <h3 className="font-bold text-[--site-text]">Free Trial</h3>
              <div className="mt-3 text-3xl font-extrabold text-[--site-text]">$0</div>
              <p className="mt-1 text-sm text-[--site-text-muted]">No credit card required</p>
              <ul className="mt-6 space-y-3 text-sm text-[--site-text-secondary]">
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> 10 scans included
                </li>
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> Full ingredient analysis
                </li>
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> Swap recommendations
                </li>
              </ul>
            </div>
            {/* 200 pack */}
            <div
              className="rounded-2xl border p-7"
              style={{ borderColor: 'var(--color-site-border-light)', background: 'var(--color-site-surface)' }}
            >
              <h3 className="font-bold text-[--site-text]">200 Scans</h3>
              <div className="mt-3 text-3xl font-extrabold text-[--site-text]">$3.99</div>
              <p className="mt-1 text-sm text-[--site-text-muted]">One-time purchase</p>
              <ul className="mt-6 space-y-3 text-sm text-[--site-text-secondary]">
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> 200 scan credits
                </li>
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> Credits never expire
                </li>
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> Full ingredient analysis
                </li>
              </ul>
            </div>
            {/* 500 pack */}
            <div
              className="rounded-2xl border-2 p-7 relative"
              style={{ borderColor: 'var(--color-oxygen)', background: 'var(--color-site-surface)', boxShadow: '0 10px 40px -10px rgba(14, 165, 233, 0.2)' }}
            >
              <div
                className="absolute -top-3 left-1/2 -translate-x-1/2 rounded-full px-4 py-1 text-xs font-semibold text-white"
                style={{ background: 'var(--color-oxygen)' }}
              >
                Best value
              </div>
              <h3 className="font-bold text-[--site-text]">500 Scans</h3>
              <div className="mt-3 text-3xl font-extrabold text-[--site-text]">$7.99</div>
              <p className="mt-1 text-sm text-[--site-text-muted]">One-time purchase · 20% savings</p>
              <ul className="mt-6 space-y-3 text-sm text-[--site-text-secondary]">
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> 500 scan credits
                </li>
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> Credits never expire
                </li>
                <li className="flex items-center gap-2">
                  <span style={{ color: 'var(--color-safe)' }}>✓</span> Full ingredient analysis
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
          <div className="mt-10 flex flex-col items-center gap-4 sm:flex-row sm:justify-center">
            <a
              href="https://apps.apple.com/us/app/notox-product-scanner/id6758887710"
              className="inline-flex items-center gap-2.5 rounded-full px-8 py-4 text-sm font-semibold text-white transition-colors"
              style={{ background: 'var(--color-oxygen)', boxShadow: '0 12px 40px -8px rgba(14, 165, 233, 0.35)' }}
            >
              <svg className="h-5 w-5" viewBox="0 0 24 24" fill="currentColor">
                <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z" />
              </svg>
              Download for iOS
            </a>
            <a
              href="https://play.google.com/store/apps/details?id=com.nontoxicliving.app"
              className="inline-flex items-center gap-2.5 rounded-full px-8 py-4 text-sm font-semibold text-white transition-colors"
              style={{ background: 'var(--color-oxygen)', boxShadow: '0 12px 40px -8px rgba(14, 165, 233, 0.35)' }}
            >
              <svg className="h-5 w-5" viewBox="0 0 24 24" fill="currentColor">
                <path d="M3.18 23.76c.3.17.65.19.97.07l13.2-7.62-2.82-2.82-11.35 10.37zm-1.9-20.3C1.1 3.8 1 4.18 1 4.59v14.82c0 .41.1.79.28 1.13l.07.06 8.3-8.3v-.19L1.35 3.4l-.07.06zM20.13 10.4l-2.82-1.63-3.17 3.17 3.17 3.17 2.85-1.65c.81-.47.81-1.23-.03-1.06zM4.15.24L17.35 7.86l-2.82 2.82L3.18.31C3.5.19 3.85.21 4.15.38z" />
              </svg>
              Download for Android
            </a>
          </div>
          <p className="mt-6 text-sm text-[--site-text-muted]">
            10 free scans included. No credit card required.
          </p>
        </div>
      </section>

      <Footer />
    </div>
  );
}
