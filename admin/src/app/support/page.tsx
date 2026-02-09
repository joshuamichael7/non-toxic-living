import type { Metadata } from 'next';
import Link from 'next/link';

export const metadata: Metadata = {
  title: 'Support — Non-Toxic Living',
  description: 'Get help with Non-Toxic Living. Find answers to common questions or contact our support team.',
};

const faqs = [
  {
    q: 'How does Non-Toxic Living analyze products?',
    a: 'Point your camera at any ingredient label. Our app uses on-device text recognition to read the label, then AI analyzes each ingredient for known health concerns, toxicity data, and regulatory warnings. You get an instant safety score from 0 to 100.',
  },
  {
    q: 'What do the safety scores mean?',
    a: 'Scores range from 0 to 100. Products scoring 67–100 are considered Safe with no significant concerns. Scores of 34–66 indicate Caution — some ingredients are worth noting. Scores of 0–33 mean the product contains ingredients linked to health concerns.',
  },
  {
    q: 'What types of products can I scan?',
    a: 'You can scan food and beverages, skincare and cosmetics, household cleaners, baby products, cookware, supplements, and more. If it has an ingredient label, you can scan it.',
  },
  {
    q: 'What languages are supported?',
    a: 'The app reads ingredient labels in many languages including English, Korean, Japanese, Chinese, Spanish, French, Arabic, and Hindi. The app interface is also available in all of these languages.',
  },
  {
    q: 'How do I upgrade or manage my subscription?',
    a: "Go to Profile in the app and tap \"Go Premium\" (or \"Manage Subscription\" if you already have a plan). You can also manage your subscription through your device's Settings app under Subscriptions.",
  },
  {
    q: 'How do I restore my purchases on a new device?',
    a: "Open the app, go to Profile, tap \"Go Premium\" or \"Manage Subscription\", then scroll down and tap \"Restore Purchases\". Make sure you're signed in with the same Apple ID or Google account used for the original purchase.",
  },
  {
    q: 'How do I cancel my subscription?',
    a: "You can cancel anytime through your device's subscription settings. On iPhone, go to Settings → your name → Subscriptions → Non-Toxic Living → Cancel. On Android, go to Google Play Store → your profile → Payments & subscriptions → Subscriptions.",
  },
  {
    q: 'Is my data private?',
    a: 'Yes. Scans are processed securely and we do not sell your personal data. See our Privacy Policy for full details.',
  },
];

function Header() {
  return (
    <header className="border-b border-[--site-border] bg-[--site-surface]">
      <div className="mx-auto flex max-w-5xl items-center justify-between px-6 py-4">
        <Link href="/" className="flex items-center gap-2.5">
          <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-[--oxygen] text-white font-bold text-xs">
            NTL
          </div>
          <span className="text-base font-bold text-[--site-text]">Non-Toxic Living</span>
        </Link>
        <nav className="flex items-center gap-5 text-sm">
          <Link href="/support" className="font-medium text-[--site-text]">
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

export default function SupportPage() {
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
        } as React.CSSProperties
      }
    >
      <Header />

      <main className="py-20 px-6">
        <div className="mx-auto max-w-3xl">
          <h1 className="text-3xl font-bold">Support</h1>
          <p className="mt-4 text-[--site-text-secondary]">
            Find answers to common questions below. If you need further help, contact us at the bottom of this page.
          </p>

          {/* FAQ */}
          <section className="mt-14">
            <h2 className="text-xl font-bold">Frequently asked questions</h2>
            <div className="mt-8 space-y-4">
              {faqs.map((faq) => (
                <div
                  key={faq.q}
                  className="rounded-2xl border p-6"
                  style={{ borderColor: 'var(--color-site-border-light)', background: 'var(--color-site-surface)' }}
                >
                  <h3 className="font-semibold text-[--site-text]">{faq.q}</h3>
                  <p className="mt-3 text-sm text-[--site-text-secondary] leading-relaxed">{faq.a}</p>
                </div>
              ))}
            </div>
          </section>

          {/* Contact */}
          <section
            className="mt-20 rounded-2xl border p-10 text-center"
            style={{ borderColor: 'var(--color-site-border-light)', background: 'var(--color-site-surface)' }}
          >
            <h2 className="text-xl font-bold">Still need help?</h2>
            <p className="mt-3 text-[--site-text-secondary]">
              We typically respond within 24 hours.
            </p>
            <a
              href="mailto:ntl@abrdn.co"
              className="mt-8 inline-flex items-center gap-2 rounded-2xl px-7 py-3.5 text-sm font-semibold text-white transition-colors"
              style={{ background: 'var(--color-oxygen)', boxShadow: '0 10px 30px -5px rgba(14, 165, 233, 0.3)' }}
            >
              Contact Support
            </a>
            <p className="mt-5 text-sm text-[--site-text-muted]">
              ntl@abrdn.co
            </p>
          </section>
        </div>
      </main>

      <Footer />
    </div>
  );
}
