import { Manrope } from 'next/font/google';
import ScreenshotStudio from './ScreenshotStudio';

const manrope = Manrope({
  subsets: ['latin'],
  weight: ['400', '500', '600', '700', '800'],
  variable: '--font-manrope',
});

export const metadata = {
  title: 'Screenshot Studio - Non-Toxic Living',
};

export default function ScreenshotsPage() {
  return (
    <div className={manrope.variable}>
      <ScreenshotStudio />
    </div>
  );
}
