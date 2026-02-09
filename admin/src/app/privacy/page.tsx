import type { Metadata } from 'next';
import Link from 'next/link';

export const metadata: Metadata = {
  title: 'Privacy Policy — Non-Toxic Living',
  description: 'Privacy Policy for the Non-Toxic Living app.',
};

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
          <Link href="/support" className="text-[--site-text-secondary] hover:text-[--site-text] transition-colors">
            Support
          </Link>
          <Link href="/privacy" className="font-medium text-[--site-text]">
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

export default function PrivacyPage() {
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
          <h1 className="text-3xl font-bold">Privacy Policy</h1>
          <p className="mt-2 text-sm text-[--site-text-muted]">Last updated: February 9, 2026</p>

          <div className="mt-12 space-y-10 text-[--site-text-secondary] leading-relaxed">
            <section>
              <h2 className="text-lg font-bold text-[--site-text]">Overview</h2>
              <p className="mt-3">
                Non-Toxic Living (&quot;we&quot;, &quot;our&quot;, or &quot;the app&quot;) is committed to protecting
                your privacy. This policy explains what data we collect, how we use it, and your rights.
              </p>
            </section>

            <section>
              <h2 className="text-lg font-bold text-[--site-text]">Data We Collect</h2>
              <ul className="mt-3 list-disc space-y-2 pl-6">
                <li>
                  <strong className="text-[--site-text]">Account information:</strong> Email address and display name when you create an account.
                </li>
                <li>
                  <strong className="text-[--site-text]">Scan data:</strong> Photos of product labels are processed for ingredient
                  text extraction. Images are used only for analysis and are not stored permanently on our servers.
                </li>
                <li>
                  <strong className="text-[--site-text]">Scan history:</strong> Product names, safety scores, and ingredient lists from
                  your scans are stored to provide your scan history feature.
                </li>
                <li>
                  <strong className="text-[--site-text]">Usage data:</strong> Anonymous usage statistics such as scan counts to enforce
                  plan quotas and improve the service.
                </li>
                <li>
                  <strong className="text-[--site-text]">Subscription data:</strong> Subscription status is managed through Apple App
                  Store or Google Play. We do not process or store payment card information.
                </li>
              </ul>
            </section>

            <section>
              <h2 className="text-lg font-bold text-[--site-text]">How We Use Your Data</h2>
              <ul className="mt-3 list-disc space-y-2 pl-6">
                <li>To provide ingredient analysis and safety scoring for scanned products.</li>
                <li>To maintain your scan history so you can review past results.</li>
                <li>To enforce scan quotas based on your subscription plan.</li>
                <li>To suggest safer product alternatives.</li>
                <li>To improve the accuracy of our analysis over time.</li>
              </ul>
            </section>

            <section>
              <h2 className="text-lg font-bold text-[--site-text]">Third-Party Services</h2>
              <p className="mt-3">We use the following third-party services:</p>
              <ul className="mt-3 list-disc space-y-2 pl-6">
                <li>
                  <strong className="text-[--site-text]">Supabase:</strong> Cloud database and authentication. Data is stored securely
                  with row-level security policies.
                </li>
                <li>
                  <strong className="text-[--site-text]">OpenAI:</strong> AI-powered ingredient analysis. Text extracted from labels
                  is sent to OpenAI for analysis. No images are stored by OpenAI beyond the processing window.
                </li>
                <li>
                  <strong className="text-[--site-text]">RevenueCat:</strong> Subscription management. Manages in-app purchase
                  verification and subscription status.
                </li>
                <li>
                  <strong className="text-[--site-text]">Google Cloud Vision:</strong> Used as a fallback for text extraction from
                  product label images when on-device OCR is insufficient.
                </li>
              </ul>
            </section>

            <section>
              <h2 className="text-lg font-bold text-[--site-text]">Data Retention</h2>
              <p className="mt-3">
                Your scan history is retained as long as your account is active. You can delete
                individual scan records from within the app. If you delete your account, all associated
                data will be permanently removed within 30 days.
              </p>
            </section>

            <section>
              <h2 className="text-lg font-bold text-[--site-text]">Your Rights</h2>
              <p className="mt-3">You have the right to:</p>
              <ul className="mt-3 list-disc space-y-2 pl-6">
                <li>Access the personal data we hold about you.</li>
                <li>Request correction of inaccurate data.</li>
                <li>Request deletion of your account and associated data.</li>
                <li>Export your scan history.</li>
              </ul>
              <p className="mt-3">
                To exercise any of these rights, contact us at{' '}
                <a href="mailto:ntl@abrdn.co" style={{ color: 'var(--color-oxygen)' }} className="underline">
                  ntl@abrdn.co
                </a>.
              </p>
            </section>

            <section>
              <h2 className="text-lg font-bold text-[--site-text]">Children&apos;s Privacy</h2>
              <p className="mt-3">
                Non-Toxic Living is not directed at children under 13. We do not knowingly collect
                personal information from children under 13. If you believe a child has provided us
                with personal data, please contact us and we will delete it promptly.
              </p>
            </section>

            <section>
              <h2 className="text-lg font-bold text-[--site-text]">Changes to This Policy</h2>
              <p className="mt-3">
                We may update this privacy policy from time to time. We will notify you of any
                material changes by posting the new policy on this page and updating the &quot;Last
                updated&quot; date.
              </p>
            </section>

            <section>
              <h2 className="text-lg font-bold text-[--site-text]">Contact Us</h2>
              <p className="mt-3">
                If you have any questions about this privacy policy, please contact us at{' '}
                <a href="mailto:ntl@abrdn.co" style={{ color: 'var(--color-oxygen)' }} className="underline">
                  ntl@abrdn.co
                </a>.
              </p>
            </section>
          </div>
        </div>
      </main>

      <Footer />
    </div>
  );
}
