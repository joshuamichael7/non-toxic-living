import type { Metadata } from 'next';
import Link from 'next/link';

export const metadata: Metadata = {
  title: 'Delete Account — Non-Toxic Living',
  description: 'Request deletion of your Non-Toxic Living account and associated data.',
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

export default function DeleteAccountPage() {
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
          <h1 className="text-3xl font-bold">Delete Your Account</h1>
          <p className="mt-2 text-[--site-text-secondary]">
            We&apos;re sorry to see you go. Follow the steps below to request deletion of your
            Non-Toxic Living account and all associated data.
          </p>

          <div className="mt-12 space-y-10 text-[--site-text-secondary] leading-relaxed">
            <section>
              <h2 className="text-lg font-bold text-[--site-text]">How to Delete Your Account</h2>
              <ol className="mt-3 list-decimal space-y-3 pl-6">
                <li>
                  Send an email to{' '}
                  <a href="mailto:ntl@abrdn.co?subject=Account%20Deletion%20Request" style={{ color: 'var(--color-oxygen)' }} className="underline">
                    ntl@abrdn.co
                  </a>{' '}
                  with the subject line <strong className="text-[--site-text]">&quot;Account Deletion Request&quot;</strong>.
                </li>
                <li>
                  Include the <strong className="text-[--site-text]">email address</strong> associated with your Non-Toxic Living account in the body of the email.
                </li>
                <li>
                  We will verify your identity and process your request within <strong className="text-[--site-text]">30 days</strong>.
                </li>
                <li>
                  You will receive a confirmation email once your account and data have been permanently deleted.
                </li>
              </ol>
            </section>

            <section>
              <h2 className="text-lg font-bold text-[--site-text]">What Data Is Deleted</h2>
              <p className="mt-3">
                When your account is deleted, the following data is <strong className="text-[--site-text]">permanently removed</strong>:
              </p>
              <ul className="mt-3 list-disc space-y-2 pl-6">
                <li>Your account profile (email address, display name)</li>
                <li>Your entire scan history (product names, scores, ingredient analyses)</li>
                <li>Your app preferences and settings</li>
                <li>Your subscription status (your subscription itself must be cancelled separately through the App Store or Google Play)</li>
              </ul>
            </section>

            <section>
              <h2 className="text-lg font-bold text-[--site-text]">What Data May Be Retained</h2>
              <p className="mt-3">
                The following data may be retained for a limited period after account deletion:
              </p>
              <ul className="mt-3 list-disc space-y-2 pl-6">
                <li>
                  <strong className="text-[--site-text]">Anonymized usage statistics:</strong> Aggregated, non-identifiable data (e.g., total scan counts) may be retained for service improvement. This data cannot be linked back to you.
                </li>
                <li>
                  <strong className="text-[--site-text]">Legal obligations:</strong> Data required to comply with legal, tax, or regulatory requirements may be retained for the minimum period required by law.
                </li>
              </ul>
            </section>

            <section>
              <h2 className="text-lg font-bold text-[--site-text]">Cancel Your Subscription First</h2>
              <p className="mt-3">
                Deleting your account does not automatically cancel your subscription. To avoid being
                charged, please cancel your subscription before requesting account deletion:
              </p>
              <ul className="mt-3 list-disc space-y-2 pl-6">
                <li><strong className="text-[--site-text]">iOS:</strong> Settings &gt; Apple ID &gt; Subscriptions &gt; Non-Toxic Living &gt; Cancel</li>
                <li><strong className="text-[--site-text]">Android:</strong> Google Play Store &gt; Subscriptions &gt; Non-Toxic Living &gt; Cancel</li>
              </ul>
            </section>

            <section>
              <h2 className="text-lg font-bold text-[--site-text]">Contact Us</h2>
              <p className="mt-3">
                If you have any questions about account deletion, please contact us at{' '}
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
