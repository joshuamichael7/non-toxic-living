'use client';

import { useState, useRef, useCallback } from 'react';
import { toPng } from 'html-to-image';

/* ==========================================================
   CONSTANTS
   ========================================================== */

const C = {
  canvas: '#E8E8E8',
  glass: '#F0F0F0',
  glassBorder: 'rgba(255,255,255,0.6)',
  oxygen: '#0EA5E9',
  oxygenDeep: '#0284C7',
  oxygenGlow: 'rgba(14,165,233,0.15)',
  oxygenGlowStrong: 'rgba(14,165,233,0.3)',
  safe: '#10B981',
  safeLight: 'rgba(16,185,129,0.15)',
  caution: '#F59E0B',
  cautionLight: 'rgba(245,158,11,0.15)',
  toxic: '#EF4444',
  toxicLight: 'rgba(239,68,68,0.15)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  purple: '#8B5CF6',
  purpleLight: 'rgba(139,92,246,0.15)',
  white: '#FFFFFF',
};

const DEVICES: Record<string, { name: string; w: number; h: number; scale: number; pw: number; ph: number; type: 'phone' | 'tablet' }> = {
  'iphone-65': { name: 'iPhone 6.5"', w: 414, h: 896, scale: 3, pw: 1242, ph: 2688, type: 'phone' },
  'iphone-67': { name: 'iPhone 6.7"', w: 428, h: 926, scale: 3, pw: 1284, ph: 2778, type: 'phone' },
  'ipad-129': { name: 'iPad 12.9"', w: 1024, h: 1366, scale: 2, pw: 2048, ph: 2732, type: 'tablet' },
  'ipad-13': { name: 'iPad 13"', w: 1032, h: 1376, scale: 2, pw: 2064, ph: 2752, type: 'tablet' },
  'android-phone': { name: 'Android Phone', w: 360, h: 640, scale: 3, pw: 1080, ph: 1920, type: 'phone' },
  'android-tablet': { name: 'Android Tablet', w: 800, h: 1280, scale: 2, pw: 1600, ph: 2560, type: 'tablet' },
};

type ScreenDef = { id: string; name: string; tab: string | null };

const SCREENS: ScreenDef[] = [
  { id: 'home', name: 'Home', tab: 'home' },
  { id: 'scan', name: 'Scan', tab: 'scan' },
  { id: 'result-toxic', name: 'Result (Toxic)', tab: null },
  { id: 'result-safe', name: 'Result (Safe)', tab: null },
  { id: 'search', name: 'Search', tab: 'search' },
  { id: 'search-results', name: 'Search Results', tab: 'search' },
];

function verdictColor(score: number) {
  if (score <= 33) return C.toxic;
  if (score <= 66) return C.caution;
  return C.safe;
}

function verdictColorLight(score: number) {
  if (score <= 33) return C.toxicLight;
  if (score <= 66) return C.cautionLight;
  return C.safeLight;
}

function verdictLabel(score: number) {
  if (score <= 33) return 'TOXIC';
  if (score <= 66) return 'CAUTION';
  return 'SAFE';
}

/* ==========================================================
   SVG ICONS
   ========================================================== */

function IconHome({ color = C.inkMuted, size = 24 }: { color?: string; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round">
      <path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2V9z" />
      <path d="M9 22V12h6v10" />
    </svg>
  );
}

function IconScan({ color = C.inkMuted, size = 24 }: { color?: string; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round">
      <path d="M4 7V4h3" /><path d="M20 7V4h-3" /><path d="M4 17v3h3" /><path d="M20 17v3h-3" />
      <rect x="7" y="7" width="10" height="10" rx="1" />
    </svg>
  );
}

function IconSearch({ color = C.inkMuted, size = 24 }: { color?: string; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round">
      <circle cx="11" cy="11" r="8" /><path d="M21 21l-4.35-4.35" />
    </svg>
  );
}

function IconProfile({ color = C.inkMuted, size = 24 }: { color?: string; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round">
      <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2" /><circle cx="12" cy="7" r="4" />
    </svg>
  );
}

function IconCamera({ color = C.white, size = 20 }: { color?: string; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round">
      <path d="M23 19a2 2 0 01-2 2H3a2 2 0 01-2-2V8a2 2 0 012-2h4l2-3h6l2 3h4a2 2 0 012 2z" />
      <circle cx="12" cy="13" r="4" />
    </svg>
  );
}

function IconX({ color = C.ink, size = 20 }: { color?: string; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round">
      <path d="M18 6L6 18" /><path d="M6 6l12 12" />
    </svg>
  );
}

function IconShare({ color = C.ink, size = 20 }: { color?: string; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round">
      <path d="M4 12v8a2 2 0 002 2h12a2 2 0 002-2v-8" /><polyline points="16 6 12 2 8 6" /><line x1="12" y1="2" x2="12" y2="15" />
    </svg>
  );
}

function IconChevron({ color = C.inkMuted, size = 16 }: { color?: string; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round">
      <polyline points="9 18 15 12 9 6" />
    </svg>
  );
}

function IconCheck({ color = C.safe, size = 16 }: { color?: string; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={3} strokeLinecap="round" strokeLinejoin="round">
      <polyline points="20 6 9 17 4 12" />
    </svg>
  );
}

function IconAlert({ color = C.toxic, size = 16 }: { color?: string; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round">
      <path d="M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z" />
      <line x1="12" y1="9" x2="12" y2="13" /><line x1="12" y1="17" x2="12.01" y2="17" />
    </svg>
  );
}

function IconBell({ color = C.ink, size = 20 }: { color?: string; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round">
      <path d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9" /><path d="M13.73 21a2 2 0 01-3.46 0" />
    </svg>
  );
}

function IconLeaf({ color = C.safe, size = 16 }: { color?: string; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round">
      <path d="M11 20A7 7 0 019.8 6.9C15.5 4.9 20 2 20 2s-1.7 7.4-5 12c-1.1 1.5-2.5 3.2-4 6z" />
      <path d="M10.7 20.7a7 7 0 01-7.7-7.7" />
    </svg>
  );
}

function IconHeart({ color = C.inkMuted, size = 20 }: { color?: string; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round">
      <path d="M20.84 4.61a5.5 5.5 0 00-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 00-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 000-7.78z" />
    </svg>
  );
}

function IconArrowRight({ color = C.oxygen, size = 18 }: { color?: string; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round">
      <line x1="5" y1="12" x2="19" y2="12" /><polyline points="12 5 19 12 12 19" />
    </svg>
  );
}

/* ==========================================================
   SHARED UI COMPONENTS
   ========================================================== */

function StatusBar({ width }: { width: number }) {
  const isTablet = width > 700;
  const fs = isTablet ? 13 : 12;
  return (
    <div style={{
      display: 'flex', justifyContent: 'space-between', alignItems: 'center',
      padding: `${isTablet ? 12 : 14}px ${isTablet ? 24 : 20}px ${isTablet ? 8 : 6}px`,
      fontFamily: 'var(--font-manrope), system-ui', fontSize: fs, fontWeight: 600,
      color: C.ink,
    }}>
      <span>9:41</span>
      {!isTablet && (
        <div style={{
          width: 126, height: 34, background: C.ink, borderRadius: 20,
          position: 'absolute', left: '50%', transform: 'translateX(-50%)', top: 8,
        }} />
      )}
      <div style={{ display: 'flex', gap: 5, alignItems: 'center' }}>
        <svg width={16} height={fs} viewBox="0 0 18 12" fill={C.ink}><rect x="0" y="5" width="3" height="7" rx="0.5"/><rect x="5" y="3" width="3" height="9" rx="0.5"/><rect x="10" y="1" width="3" height="11" rx="0.5"/><rect x="15" y="0" width="3" height="12" rx="0.5"/></svg>
        <svg width={16} height={fs} viewBox="0 0 16 12" fill={C.ink}><path d="M1 5a7 7 0 0114 0" fill="none" stroke={C.ink} strokeWidth="1.5"/><path d="M4 8a4 4 0 018 0" fill="none" stroke={C.ink} strokeWidth="1.5"/><circle cx="8" cy="11" r="1.5"/></svg>
        <svg width={24} height={fs} viewBox="0 0 28 13" fill="none"><rect x="0" y="1" width="24" height="11" rx="2.5" stroke={C.ink} strokeWidth="1"/><rect x="1.5" y="2.5" width="18" height="8" rx="1.5" fill={C.ink}/><rect x="25.5" y="4" width="2" height="5" rx="1" fill={C.ink} opacity="0.4"/></svg>
      </div>
    </div>
  );
}

function TabBar({ activeTab, width }: { activeTab: string; width: number }) {
  const isTablet = width > 700;
  const tabs = [
    { id: 'home', label: 'Home', Icon: IconHome },
    { id: 'scan', label: 'Scan', Icon: IconScan },
    { id: 'search', label: 'Search', Icon: IconSearch },
    { id: 'profile', label: 'Profile', Icon: IconProfile },
  ];
  const iconSize = isTablet ? 26 : 22;
  return (
    <div style={{
      display: 'flex', justifyContent: 'space-around', alignItems: 'center',
      height: isTablet ? 80 : 82, background: C.glass,
      borderTop: `1px solid ${C.glassBorder}`,
      paddingBottom: isTablet ? 8 : 20,
    }}>
      {tabs.map(({ id, label, Icon }) => {
        const active = activeTab === id;
        return (
          <div key={id} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 4 }}>
            <div style={{
              padding: '6px 16px', borderRadius: 12,
              background: active ? C.oxygenGlowStrong : 'transparent',
            }}>
              <Icon color={active ? C.oxygen : C.inkMuted} size={iconSize} />
            </div>
            <span style={{
              fontSize: isTablet ? 11 : 10, fontWeight: 500,
              color: active ? C.oxygen : C.inkMuted,
              fontFamily: 'var(--font-manrope), system-ui',
            }}>{label}</span>
          </div>
        );
      })}
    </div>
  );
}

function ScoreBadge({ score, size = 52 }: { score: number; size?: number }) {
  const color = verdictColor(score);
  return (
    <div style={{
      width: size, height: size, borderRadius: size / 2,
      background: color, border: `${Math.max(2, size / 15)}px solid ${color}`,
      display: 'flex', alignItems: 'center', justifyContent: 'center',
      boxShadow: `0 4px 16px ${color}44`,
      flexShrink: 0,
    }}>
      <span style={{
        color: C.white, fontFamily: 'var(--font-manrope), system-ui',
        fontSize: size * 0.42, fontWeight: 800,
      }}>{score}</span>
    </div>
  );
}

function GlassCard({ children, style = {} }: { children: React.ReactNode; style?: React.CSSProperties }) {
  return (
    <div style={{
      background: C.glass, border: `1px solid ${C.glassBorder}`,
      borderRadius: 24, padding: 20,
      boxShadow: '0 4px 12px rgba(0,0,0,0.04)',
      ...style,
    }}>
      {children}
    </div>
  );
}

function VerdictPill({ score }: { score: number }) {
  return (
    <span style={{
      display: 'inline-flex', alignItems: 'center', gap: 4,
      background: verdictColorLight(score), color: verdictColor(score),
      fontSize: 10, fontWeight: 700, letterSpacing: 0.5,
      padding: '4px 10px', borderRadius: 8,
      fontFamily: 'var(--font-manrope), system-ui',
    }}>{verdictLabel(score)}</span>
  );
}

function IconBadge({ children, bg = C.oxygenGlow, size = 32 }: { children: React.ReactNode; bg?: string; size?: number }) {
  return (
    <div style={{
      width: size, height: size, borderRadius: size / 3,
      background: bg, display: 'flex', alignItems: 'center', justifyContent: 'center',
      flexShrink: 0,
    }}>{children}</div>
  );
}

/* ==========================================================
   SCREEN WRAPPER
   ========================================================== */

function PhoneFrame({ children, activeTab, width, height }: {
  children: React.ReactNode; activeTab: string | null; width: number; height: number;
}) {
  return (
    <div style={{
      width, height, background: C.canvas,
      display: 'flex', flexDirection: 'column',
      fontFamily: 'var(--font-manrope), system-ui',
      position: 'relative', overflow: 'hidden',
    }}>
      <StatusBar width={width} />
      <div style={{ flex: 1, overflow: 'hidden', display: 'flex', flexDirection: 'column' }}>
        {children}
      </div>
      {activeTab && <TabBar activeTab={activeTab} width={width} />}
    </div>
  );
}

/* ==========================================================
   SCREEN: HOME
   ========================================================== */

function HomeScreen({ width }: { width: number }) {
  const pad = width > 700 ? 32 : 20;
  const isTablet = width > 700;
  const recentScans = [
    { name: 'Froot Loops', brand: "Kellogg's", score: 15 },
    { name: 'Castile Liquid Soap', brand: "Dr. Bronner's", score: 95 },
    { name: 'Tide PODS Laundry Detergent', brand: 'Tide', score: 12 },
  ];
  const categories = [
    { name: 'Food', emoji: '🍎' },
    { name: 'Body', emoji: '🧴' },
    { name: 'Home', emoji: '🏠' },
    { name: 'Baby', emoji: '👶' },
    { name: 'Clean', emoji: '🧹' },
  ];
  return (
    <div style={{ flex: 1, padding: `0 ${pad}px`, overflowY: 'hidden', display: 'flex', flexDirection: 'column', gap: isTablet ? 20 : 16 }}>
      {/* Header */}
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 4 }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
          <div style={{
            width: 48, height: 48, borderRadius: 24, background: C.oxygenGlow,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 20, fontWeight: 700, color: C.oxygen,
          }}>J</div>
          <div>
            <div style={{ fontSize: 13, color: C.inkSecondary, fontWeight: 500 }}>Welcome</div>
            <div style={{ fontSize: 22, fontWeight: 800, color: C.ink }}>Scan Anything</div>
          </div>
        </div>
        <div style={{
          width: 44, height: 44, borderRadius: 14, background: C.glass,
          border: `1px solid ${C.glassBorder}`,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
        }}>
          <IconBell size={20} />
        </div>
      </div>

      {/* Hero Card */}
      <GlassCard style={{ borderRadius: 28, padding: isTablet ? 32 : 24 }}>
        <IconBadge bg={C.oxygenGlow} size={36}>
          <IconSearch color={C.oxygen} size={18} />
        </IconBadge>
        <div style={{ fontSize: 10, fontWeight: 700, letterSpacing: 1.5, color: C.inkSecondary, marginTop: 12, textTransform: 'uppercase' as const }}>Toxin Scanner</div>
        <div style={{ fontSize: isTablet ? 22 : 20, fontWeight: 800, color: C.ink, marginTop: 4, lineHeight: 1.3 }}>
          Point &amp; Identify{'\n'}Toxic Ingredients
        </div>
        <div style={{ fontSize: 13, color: C.inkSecondary, marginTop: 8 }}>
          Scan any product label to instantly see what&apos;s safe and what&apos;s not.
        </div>
        <button style={{
          width: '100%', marginTop: 16, padding: '14px 0',
          background: C.oxygen, color: C.white, border: 'none',
          borderRadius: 18, fontSize: 14, fontWeight: 700,
          display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 8,
          fontFamily: 'var(--font-manrope), system-ui',
          boxShadow: `0 8px 24px ${C.oxygenGlowStrong}`,
          cursor: 'pointer', letterSpacing: 0.5,
        }}>
          <IconCamera size={18} /> START SCANNING
        </button>
      </GlassCard>

      {/* Stats */}
      <GlassCard style={{ padding: isTablet ? 24 : 16, borderRadius: 20 }}>
        <div style={{ display: 'flex', alignItems: 'center' }}>
          {[
            { value: '1,247', label: 'Products', color: C.oxygen },
            { value: '486', label: 'Toxins Found', color: C.caution },
            { value: '892', label: 'Safe Items', color: C.safe },
          ].map((stat, i) => (
            <div key={stat.label} style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 2, borderRight: i < 2 ? `1px solid ${C.glassBorder}` : 'none' }}>
              <span style={{ fontSize: isTablet ? 24 : 20, fontWeight: 800, color: stat.color }}>{stat.value}</span>
              <span style={{ fontSize: 10, fontWeight: 500, color: C.inkSecondary }}>{stat.label}</span>
            </div>
          ))}
        </div>
      </GlassCard>

      {/* Categories */}
      <div style={{ display: 'flex', gap: 8 }}>
        {categories.map((cat, i) => (
          <div key={cat.name} style={{
            flex: 1, padding: '10px 0', borderRadius: 14,
            background: i === 0 ? C.oxygenGlow : C.glass,
            border: `1px solid ${i === 0 ? C.oxygen + '33' : C.glassBorder}`,
            display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 4,
          }}>
            <span style={{ fontSize: isTablet ? 22 : 18 }}>{cat.emoji}</span>
            <span style={{ fontSize: 10, fontWeight: 600, color: i === 0 ? C.oxygen : C.inkSecondary }}>{cat.name}</span>
          </div>
        ))}
      </div>

      {/* Recent Scans */}
      <div>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 10 }}>
          <span style={{ fontSize: 15, fontWeight: 700, color: C.ink }}>Recent Scans</span>
          <span style={{ fontSize: 13, fontWeight: 600, color: C.oxygen }}>See All</span>
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
          {recentScans.map(scan => (
            <GlassCard key={scan.name} style={{ padding: 14, borderRadius: 18, display: 'flex', alignItems: 'center', gap: 12 }}>
              <ScoreBadge score={scan.score} size={48} />
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 14, fontWeight: 700, color: C.ink }}>{scan.name}</div>
                <div style={{ fontSize: 12, color: C.inkSecondary }}>{scan.brand}</div>
              </div>
              <VerdictPill score={scan.score} />
            </GlassCard>
          ))}
        </div>
      </div>
    </div>
  );
}

/* ==========================================================
   SCREEN: SCAN
   ========================================================== */

function ScanScreen({ width }: { width: number }) {
  const pad = width > 700 ? 48 : 24;
  const isTablet = width > 700;
  return (
    <div style={{
      flex: 1, display: 'flex', flexDirection: 'column',
      alignItems: 'center', justifyContent: 'center',
      padding: `0 ${pad}px`, gap: 16, textAlign: 'center' as const,
    }}>
      <div style={{
        width: isTablet ? 140 : 120, height: isTablet ? 140 : 120,
        borderRadius: isTablet ? 46 : 40, background: C.oxygenGlow,
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        boxShadow: `0 12px 40px ${C.oxygenGlowStrong}`,
      }}>
        <IconScan color={C.oxygen} size={isTablet ? 64 : 56} />
      </div>
      <div style={{ fontSize: isTablet ? 30 : 28, fontWeight: 800, color: C.ink, lineHeight: 1.2, marginTop: 8 }}>
        Scan Product Labels
      </div>
      <div style={{ fontSize: isTablet ? 16 : 14, color: C.inkSecondary, lineHeight: 1.5, maxWidth: 320 }}>
        Point your camera at any product label to instantly analyze ingredients and get a safety score.
      </div>
      <button style={{
        width: '100%', maxWidth: isTablet ? 400 : 340, marginTop: 12, padding: '16px 0',
        background: C.oxygen, color: C.white, border: 'none',
        borderRadius: 20, fontSize: 15, fontWeight: 700,
        display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 10,
        fontFamily: 'var(--font-manrope), system-ui',
        boxShadow: `0 8px 24px ${C.oxygenGlowStrong}`,
        cursor: 'pointer', letterSpacing: 0.5,
      }}>
        <IconCamera size={20} /> OPEN CAMERA
      </button>
      <button style={{
        width: '100%', maxWidth: isTablet ? 400 : 340, padding: '14px 0',
        background: 'transparent', color: C.inkSecondary,
        border: `1.5px solid ${C.glassBorder}`, borderRadius: 20,
        fontSize: 14, fontWeight: 600,
        fontFamily: 'var(--font-manrope), system-ui',
        cursor: 'pointer',
      }}>
        No Label? Describe Instead
      </button>
      <div style={{ fontSize: 12, color: C.inkMuted, marginTop: 8 }}>
        Tip: Hold steady, make sure the ingredient list is clearly visible
      </div>
    </div>
  );
}

/* ==========================================================
   SCREEN: RESULT (TOXIC)
   ========================================================== */

function ResultToxicScreen({ width }: { width: number }) {
  const pad = width > 700 ? 32 : 20;
  const isTablet = width > 700;
  const score = 15;
  const concerns = [
    { name: 'Red 40 (Allura Red)', severity: 'HIGH', desc: 'Petroleum-derived dye linked to hyperactivity in children. Banned or requires warning labels in EU.' },
    { name: 'Yellow 5 & Yellow 6', severity: 'HIGH', desc: 'Artificial colors linked to behavioral issues and allergic reactions. Derived from petroleum.' },
    { name: 'BHT (Butylated Hydroxytoluene)', severity: 'MEDIUM', desc: 'Synthetic preservative classified as a possible human carcinogen by some agencies.' },
    { name: 'Hydrogenated Vegetable Oil', severity: 'MEDIUM', desc: 'Trans fat source linked to heart disease, inflammation, and metabolic disruption.' },
  ];
  const swaps = [
    { name: 'Organic Sunrise Crunchy Maple', brand: "Nature's Path", score: 88 },
    { name: 'Almond Flour Crackers', brand: 'Simple Mills', score: 90 },
  ];

  return (
    <div style={{ flex: 1, overflowY: 'hidden', display: 'flex', flexDirection: 'column' }}>
      {/* Header */}
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: `4px ${pad}px 8px` }}>
        <div style={{
          width: 40, height: 40, borderRadius: 14, background: C.glass,
          border: `1px solid ${C.glassBorder}`,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
        }}><IconX size={18} /></div>
        <span style={{ fontSize: 12, fontWeight: 700, letterSpacing: 1.5, color: C.inkSecondary }}>RESULT</span>
        <div style={{
          width: 40, height: 40, borderRadius: 14, background: C.glass,
          border: `1px solid ${C.glassBorder}`,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
        }}><IconShare size={18} /></div>
      </div>

      <div style={{ flex: 1, overflowY: 'hidden', padding: `0 ${pad}px`, display: 'flex', flexDirection: 'column', gap: 14 }}>
        {/* Score Hero */}
        <GlassCard style={{ borderRadius: 28, padding: isTablet ? 32 : 24, textAlign: 'center' as const }}>
          <div style={{ display: 'flex', justifyContent: 'center', marginBottom: 12 }}>
            <ScoreBadge score={score} size={isTablet ? 110 : 100} />
          </div>
          <div style={{ fontSize: isTablet ? 24 : 22, fontWeight: 800, color: C.ink }}>Froot Loops</div>
          <div style={{ fontSize: 13, color: C.inkSecondary, marginTop: 2 }}>Kellogg&apos;s</div>
          <div style={{ marginTop: 8 }}>
            <VerdictPill score={score} />
          </div>
        </GlassCard>

        {/* Summary */}
        <GlassCard style={{ padding: 16, borderRadius: 20 }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 8 }}>
            <IconBadge bg={C.oxygenGlow} size={28}>
              <IconAlert color={C.toxic} size={14} />
            </IconBadge>
            <span style={{ fontSize: 10, fontWeight: 700, letterSpacing: 1, color: C.inkSecondary }}>SUMMARY</span>
          </div>
          <div style={{ fontSize: 13, color: C.inkSecondary, lineHeight: 1.5 }}>
            Loaded with artificial colors (Red 40, Blue 1, Yellow 5 &amp; 6), BHT preservative, and hydrogenated vegetable oil. Every bowl exposes children to multiple petroleum-derived dyes linked to hyperactivity.
          </div>
        </GlassCard>

        {/* Dad's Take */}
        <div style={{
          background: C.oxygen, borderRadius: 20, padding: 16,
          boxShadow: `0 8px 24px ${C.oxygenGlowStrong}`,
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 8 }}>
            <div style={{
              width: 28, height: 28, borderRadius: 10,
              background: 'rgba(255,255,255,0.2)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontSize: 14,
            }}>&#x1F468;</div>
            <span style={{ fontSize: 10, fontWeight: 700, letterSpacing: 1, color: 'rgba(255,255,255,0.8)' }}>DAD&apos;S TAKE</span>
          </div>
          <div style={{ fontSize: 13, color: C.white, lineHeight: 1.5 }}>
            One of the worst offenders in the cereal aisle. These petroleum-derived dyes are banned in Europe but freely marketed to kids in the US. Switch to organic cereal immediately.
          </div>
        </div>

        {/* Key Concerns */}
        <div>
          <div style={{ fontSize: 13, fontWeight: 700, color: C.ink, marginBottom: 8 }}>Key Concerns</div>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
            {concerns.map(c => (
              <GlassCard key={c.name} style={{ padding: 12, borderRadius: 16 }}>
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 4 }}>
                  <span style={{ fontSize: 13, fontWeight: 700, color: C.ink }}>{c.name}</span>
                  <span style={{
                    fontSize: 9, fontWeight: 700, letterSpacing: 0.5,
                    padding: '3px 8px', borderRadius: 6,
                    background: c.severity === 'HIGH' ? C.toxicLight : C.cautionLight,
                    color: c.severity === 'HIGH' ? C.toxic : C.caution,
                  }}>{c.severity}</span>
                </div>
                <div style={{ fontSize: 11, color: C.inkSecondary, lineHeight: 1.4 }}>{c.desc}</div>
              </GlassCard>
            ))}
          </div>
        </div>

        {/* Better Alternatives */}
        <div>
          <div style={{ fontSize: 13, fontWeight: 700, color: C.ink, marginBottom: 8 }}>Better Alternatives</div>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
            {swaps.map(s => (
              <GlassCard key={s.name} style={{ padding: 14, borderRadius: 18, display: 'flex', alignItems: 'center', gap: 12 }}>
                <ScoreBadge score={s.score} size={48} />
                <div style={{ flex: 1 }}>
                  <div style={{ fontSize: 14, fontWeight: 700, color: C.ink }}>{s.name}</div>
                  <div style={{ fontSize: 12, color: C.inkSecondary }}>{s.brand}</div>
                </div>
                <div style={{
                  width: 36, height: 36, borderRadius: 12, background: C.oxygenGlow,
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                }}>
                  <IconArrowRight size={16} />
                </div>
              </GlassCard>
            ))}
          </div>
        </div>
      </div>

      {/* Bottom Actions */}
      <div style={{
        display: 'flex', gap: 12, padding: `12px ${pad}px ${pad}px`,
        background: C.glass, borderTop: `1px solid ${C.glassBorder}`,
      }}>
        <button style={{
          flex: 1, padding: '14px 0', borderRadius: 16,
          background: C.glass, border: `1.5px solid ${C.glassBorder}`,
          display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 6,
          fontSize: 13, fontWeight: 700, color: C.ink, cursor: 'pointer',
          fontFamily: 'var(--font-manrope), system-ui',
        }}>
          <IconHeart size={16} /> Save
        </button>
        <button style={{
          flex: 2, padding: '14px 0', borderRadius: 16,
          background: C.oxygen, border: 'none',
          display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 6,
          fontSize: 13, fontWeight: 700, color: C.white, cursor: 'pointer',
          fontFamily: 'var(--font-manrope), system-ui',
          boxShadow: `0 6px 20px ${C.oxygenGlowStrong}`,
        }}>
          <IconScan color={C.white} size={16} /> Scan Again
        </button>
      </div>
    </div>
  );
}

/* ==========================================================
   SCREEN: RESULT (SAFE)
   ========================================================== */

function ResultSafeScreen({ width }: { width: number }) {
  const pad = width > 700 ? 32 : 20;
  const isTablet = width > 700;
  const score = 95;
  const positives = [
    'Organic coconut, olive & hemp oils',
    'Fair Trade certified ingredients',
    'No synthetic preservatives or detergents',
    'No artificial fragrance or foaming agents',
    'Biodegradable formula',
    'Simple, transparent ingredient list',
  ];

  return (
    <div style={{ flex: 1, overflowY: 'hidden', display: 'flex', flexDirection: 'column' }}>
      {/* Header */}
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: `4px ${pad}px 8px` }}>
        <div style={{
          width: 40, height: 40, borderRadius: 14, background: C.glass,
          border: `1px solid ${C.glassBorder}`,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
        }}><IconX size={18} /></div>
        <span style={{ fontSize: 12, fontWeight: 700, letterSpacing: 1.5, color: C.inkSecondary }}>RESULT</span>
        <div style={{
          width: 40, height: 40, borderRadius: 14, background: C.glass,
          border: `1px solid ${C.glassBorder}`,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
        }}><IconShare size={18} /></div>
      </div>

      <div style={{ flex: 1, overflowY: 'hidden', padding: `0 ${pad}px`, display: 'flex', flexDirection: 'column', gap: 14 }}>
        {/* Score Hero */}
        <GlassCard style={{ borderRadius: 28, padding: isTablet ? 32 : 24, textAlign: 'center' as const }}>
          <div style={{ display: 'flex', justifyContent: 'center', marginBottom: 12 }}>
            <ScoreBadge score={score} size={isTablet ? 110 : 100} />
          </div>
          <div style={{ fontSize: isTablet ? 24 : 22, fontWeight: 800, color: C.ink }}>Pure Castile Liquid Soap</div>
          <div style={{ fontSize: 13, color: C.inkSecondary, marginTop: 2 }}>Dr. Bronner&apos;s</div>
          <div style={{ marginTop: 8 }}>
            <VerdictPill score={score} />
          </div>
        </GlassCard>

        {/* Summary */}
        <GlassCard style={{ padding: 16, borderRadius: 20 }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 8 }}>
            <IconBadge bg={C.safeLight} size={28}>
              <IconCheck color={C.safe} size={14} />
            </IconBadge>
            <span style={{ fontSize: 10, fontWeight: 700, letterSpacing: 1, color: C.inkSecondary }}>SUMMARY</span>
          </div>
          <div style={{ fontSize: 13, color: C.inkSecondary, lineHeight: 1.5 }}>
            Versatile 18-in-1 soap made from organic oils with no synthetic preservatives, detergents, or foaming agents. One of the cleanest personal care products available.
          </div>
        </GlassCard>

        {/* Dad's Take */}
        <div style={{
          background: C.oxygen, borderRadius: 20, padding: 16,
          boxShadow: `0 8px 24px ${C.oxygenGlowStrong}`,
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 8 }}>
            <div style={{
              width: 28, height: 28, borderRadius: 10,
              background: 'rgba(255,255,255,0.2)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontSize: 14,
            }}>&#x1F468;</div>
            <span style={{ fontSize: 10, fontWeight: 700, letterSpacing: 1, color: 'rgba(255,255,255,0.8)' }}>DAD&apos;S TAKE</span>
          </div>
          <div style={{ fontSize: 13, color: C.white, lineHeight: 1.5 }}>
            This is the gold standard for soap. Fair trade organic oils, completely transparent ingredient list, and it replaces a dozen products under your sink. This is what every soap should aspire to be.
          </div>
        </div>

        {/* Positives */}
        <div>
          <div style={{ fontSize: 13, fontWeight: 700, color: C.ink, marginBottom: 8 }}>What&apos;s Good</div>
          <div style={{ display: 'flex', flexWrap: 'wrap' as const, gap: 8 }}>
            {positives.map(p => (
              <div key={p} style={{
                display: 'flex', alignItems: 'center', gap: 6,
                padding: '8px 12px', borderRadius: 12,
                background: C.safeLight, border: `1px solid ${C.safe}22`,
              }}>
                <IconCheck color={C.safe} size={14} />
                <span style={{ fontSize: 12, fontWeight: 600, color: C.safe }}>{p}</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Bottom Actions */}
      <div style={{
        display: 'flex', gap: 12, padding: `12px ${pad}px ${pad}px`,
        background: C.glass, borderTop: `1px solid ${C.glassBorder}`,
      }}>
        <button style={{
          flex: 1, padding: '14px 0', borderRadius: 16,
          background: C.safeLight, border: `1.5px solid ${C.safe}33`,
          display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 6,
          fontSize: 13, fontWeight: 700, color: C.safe, cursor: 'pointer',
          fontFamily: 'var(--font-manrope), system-ui',
        }}>
          <IconHeart color={C.safe} size={16} /> Saved
        </button>
        <button style={{
          flex: 2, padding: '14px 0', borderRadius: 16,
          background: C.oxygen, border: 'none',
          display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 6,
          fontSize: 13, fontWeight: 700, color: C.white, cursor: 'pointer',
          fontFamily: 'var(--font-manrope), system-ui',
          boxShadow: `0 6px 20px ${C.oxygenGlowStrong}`,
        }}>
          <IconScan color={C.white} size={16} /> Scan Again
        </button>
      </div>
    </div>
  );
}

/* ==========================================================
   SCREEN: SEARCH (BROWSE)
   ========================================================== */

function SearchScreen({ width }: { width: number }) {
  const pad = width > 700 ? 32 : 20;
  const isTablet = width > 700;
  const categories = [
    { name: 'Deals', emoji: '🏷️', special: true },
    { name: 'Food', emoji: '🍎' },
    { name: 'Body Care', emoji: '🧴' },
    { name: 'Home', emoji: '🏠' },
    { name: 'Baby', emoji: '👶' },
    { name: 'Cleaning', emoji: '🧹' },
    { name: 'Cookware', emoji: '🍳' },
    { name: 'Supplements', emoji: '💊' },
    { name: 'Pet Care', emoji: '🐾' },
  ];
  const popularSearches = ['sunscreen', 'baby food', 'shampoo', 'deodorant', 'toothpaste', 'laundry'];

  return (
    <div style={{ flex: 1, padding: `0 ${pad}px`, display: 'flex', flexDirection: 'column', gap: 16 }}>
      {/* Header */}
      <div style={{ marginTop: 4 }}>
        <div style={{ fontSize: isTablet ? 30 : 28, fontWeight: 800, color: C.ink }}>Search Products</div>
        <div style={{ fontSize: 13, color: C.inkSecondary, marginTop: 4 }}>Find products, brands, and categories</div>
      </div>

      {/* Search Bar */}
      <div style={{
        display: 'flex', alignItems: 'center', gap: 10,
        padding: '14px 16px', borderRadius: 16,
        background: C.glass, border: `1px solid ${C.glassBorder}`,
      }}>
        <IconSearch color={C.inkMuted} size={18} />
        <span style={{ fontSize: 15, color: C.inkMuted, flex: 1 }}>Search products...</span>
      </div>

      {/* Category Grid */}
      <div>
        <div style={{ fontSize: 13, fontWeight: 700, color: C.ink, marginBottom: 10 }}>Browse Categories</div>
        <div style={{
          display: 'grid',
          gridTemplateColumns: `repeat(3, 1fr)`,
          gap: 10,
        }}>
          {categories.map(cat => (
            <div key={cat.name} style={{
              padding: '16px 8px', borderRadius: 18,
              background: cat.special ? C.oxygenGlow : C.glass,
              border: `1px solid ${cat.special ? C.oxygen + '33' : C.glassBorder}`,
              display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 6,
              boxShadow: '0 2px 8px rgba(0,0,0,0.03)',
            }}>
              <span style={{ fontSize: isTablet ? 28 : 24 }}>{cat.emoji}</span>
              <span style={{
                fontSize: 11, fontWeight: 600,
                color: cat.special ? C.oxygen : C.inkSecondary,
              }}>{cat.name}</span>
            </div>
          ))}
        </div>
      </div>

      {/* Popular Searches */}
      <div>
        <div style={{ fontSize: 13, fontWeight: 700, color: C.ink, marginBottom: 10 }}>Popular Searches</div>
        <div style={{ display: 'flex', flexWrap: 'wrap' as const, gap: 8 }}>
          {popularSearches.map(s => (
            <div key={s} style={{
              padding: '8px 16px', borderRadius: 12,
              background: C.glass, border: `1px solid ${C.glassBorder}`,
            }}>
              <span style={{ fontSize: 13, fontWeight: 500, color: C.inkSecondary }}>{s}</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

/* ==========================================================
   SCREEN: SEARCH RESULTS
   ========================================================== */

function SearchResultsScreen({ width }: { width: number }) {
  const pad = width > 700 ? 32 : 20;
  const isTablet = width > 700;
  const results = [
    { name: 'Body Spray', brand: 'Axe', score: 15, isSwap: false },
    { name: 'Classic Antiperspirant', brand: 'Old Spice', score: 22, isSwap: false },
    { name: 'Classic Deodorant', brand: 'Native', score: 68, isSwap: true },
    { name: 'Natural Deodorant', brand: 'Primally Pure', score: 93, isSwap: true },
    { name: 'Super Leaves Deodorant', brand: 'ATTITUDE', score: 91, isSwap: true },
    { name: 'Deodorant Coconut & Vanilla', brand: 'Each & Every', score: 90, isSwap: true },
  ];

  return (
    <div style={{ flex: 1, padding: `0 ${pad}px`, display: 'flex', flexDirection: 'column', gap: 12 }}>
      {/* Header */}
      <div style={{ marginTop: 4 }}>
        <div style={{ fontSize: isTablet ? 30 : 28, fontWeight: 800, color: C.ink }}>Search Products</div>
      </div>

      {/* Search Bar with query */}
      <div style={{
        display: 'flex', alignItems: 'center', gap: 10,
        padding: '14px 16px', borderRadius: 16,
        background: C.glass, border: `1.5px solid ${C.oxygen}`,
      }}>
        <IconSearch color={C.oxygen} size={18} />
        <span style={{ fontSize: 15, color: C.ink, flex: 1, fontWeight: 500 }}>deodorant</span>
        <div style={{
          width: 24, height: 24, borderRadius: 12, background: C.canvas,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
        }}>
          <IconX color={C.inkMuted} size={12} />
        </div>
      </div>

      {/* Results count */}
      <div style={{ fontSize: 12, color: C.inkSecondary }}>
        <span style={{ fontWeight: 700 }}>6</span> results for &quot;deodorant&quot;
      </div>

      {/* Results List */}
      <div style={{ display: 'flex', flexDirection: 'column', gap: 8, flex: 1 }}>
        {results.map(r => (
          <GlassCard key={r.name + r.brand} style={{ padding: 14, borderRadius: 18, display: 'flex', alignItems: 'center', gap: 12 }}>
            <ScoreBadge score={r.score} size={48} />
            <div style={{ flex: 1 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                <span style={{ fontSize: 14, fontWeight: 700, color: C.ink }}>{r.name}</span>
                {r.isSwap && r.score >= 85 && (
                  <span style={{
                    fontSize: 8, fontWeight: 700, letterSpacing: 0.5,
                    padding: '2px 6px', borderRadius: 4,
                    background: C.safeLight, color: C.safe,
                  }}>SAFE PICK</span>
                )}
              </div>
              <div style={{ fontSize: 12, color: C.inkSecondary }}>{r.brand}</div>
            </div>
            <IconChevron size={14} />
          </GlassCard>
        ))}
      </div>
    </div>
  );
}

/* ==========================================================
   RENDER SCREEN BY ID
   ========================================================== */

function renderScreen(id: string, width: number) {
  switch (id) {
    case 'home': return <HomeScreen width={width} />;
    case 'scan': return <ScanScreen width={width} />;
    case 'result-toxic': return <ResultToxicScreen width={width} />;
    case 'result-safe': return <ResultSafeScreen width={width} />;
    case 'search': return <SearchScreen width={width} />;
    case 'search-results': return <SearchResultsScreen width={width} />;
    default: return null;
  }
}

/* ==========================================================
   MAIN: SCREENSHOT STUDIO
   ========================================================== */

export default function ScreenshotStudio() {
  const [device, setDevice] = useState('iphone-67');
  const [downloading, setDownloading] = useState<string | null>(null);
  const screenRefs = useRef<Record<string, HTMLDivElement | null>>({});

  const d = DEVICES[device];
  const previewScale = Math.min(260 / d.w, 500 / d.h);

  const downloadOne = useCallback(async (screenId: string) => {
    const el = screenRefs.current[screenId];
    if (!el) return;
    setDownloading(screenId);
    try {
      const dataUrl = await toPng(el, {
        pixelRatio: d.scale,
        width: d.w,
        height: d.h,
        cacheBust: true,
        style: {
          transform: 'none',
          transformOrigin: 'top left',
        },
      });
      const link = document.createElement('a');
      link.download = `nontoxic_${screenId}_${d.pw}x${d.ph}.png`;
      link.href = dataUrl;
      link.click();
    } catch (err) {
      console.error('Download failed:', err);
    }
    setDownloading(null);
  }, [d]);

  const downloadAll = useCallback(async () => {
    setDownloading('all');
    for (const screen of SCREENS) {
      const el = screenRefs.current[screen.id];
      if (!el) continue;
      try {
        const dataUrl = await toPng(el, {
          pixelRatio: d.scale,
          width: d.w,
          height: d.h,
          cacheBust: true,
          style: { transform: 'none', transformOrigin: 'top left' },
        });
        const link = document.createElement('a');
        link.download = `nontoxic_${screen.id}_${d.pw}x${d.ph}.png`;
        link.href = dataUrl;
        link.click();
      } catch (err) {
        console.error(`Failed: ${screen.id}`, err);
      }
      await new Promise(r => setTimeout(r, 800));
    }
    setDownloading(null);
  }, [d]);

  return (
    <div style={{
      minHeight: '100vh', background: '#0a0a0a',
      fontFamily: 'var(--font-manrope), system-ui', color: '#f0f0f0',
    }}>
      {/* Top Bar */}
      <div style={{
        padding: '24px 32px', borderBottom: '1px solid #222',
        display: 'flex', justifyContent: 'space-between', alignItems: 'center',
        flexWrap: 'wrap' as const, gap: 16,
      }}>
        <div>
          <h1 style={{ fontSize: 24, fontWeight: 800, margin: 0 }}>Screenshot Studio</h1>
          <p style={{ fontSize: 13, color: '#888', margin: '4px 0 0' }}>
            Generate app store screenshots at exact pixel dimensions
          </p>
        </div>
        <button
          onClick={downloadAll}
          disabled={downloading !== null}
          style={{
            padding: '12px 24px', borderRadius: 12,
            background: downloading === 'all' ? '#333' : C.oxygen,
            color: C.white, border: 'none', fontSize: 14, fontWeight: 700,
            cursor: downloading !== null ? 'wait' : 'pointer',
            fontFamily: 'var(--font-manrope), system-ui',
          }}
        >
          {downloading === 'all' ? 'Downloading...' : `Download All (${d.pw} x ${d.ph})`}
        </button>
      </div>

      {/* Device Selector */}
      <div style={{
        padding: '16px 32px', borderBottom: '1px solid #222',
        display: 'flex', gap: 8, flexWrap: 'wrap' as const,
      }}>
        {Object.entries(DEVICES).map(([key, dev]) => (
          <button
            key={key}
            onClick={() => setDevice(key)}
            style={{
              padding: '8px 16px', borderRadius: 10,
              background: device === key ? C.oxygen : '#1a1a1a',
              color: device === key ? C.white : '#aaa',
              border: `1px solid ${device === key ? C.oxygen : '#333'}`,
              fontSize: 12, fontWeight: 600, cursor: 'pointer',
              fontFamily: 'var(--font-manrope), system-ui',
            }}
          >
            {dev.name}
            <span style={{ opacity: 0.6, marginLeft: 6 }}>{dev.pw}x{dev.ph}</span>
          </button>
        ))}
      </div>

      {/* Screen Grid */}
      <div style={{
        padding: 32,
        display: 'grid',
        gridTemplateColumns: d.type === 'tablet'
          ? 'repeat(auto-fill, minmax(400px, 1fr))'
          : 'repeat(auto-fill, minmax(280px, 1fr))',
        gap: 32,
      }}>
        {SCREENS.map(screen => (
          <div key={screen.id} style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
            {/* Preview */}
            <div style={{
              width: d.w * previewScale,
              height: d.h * previewScale,
              overflow: 'hidden',
              borderRadius: 16,
              border: '2px solid #333',
              background: '#222',
              position: 'relative',
            }}>
              <div
                ref={el => { screenRefs.current[screen.id] = el; }}
                style={{
                  width: d.w,
                  height: d.h,
                  transform: `scale(${previewScale})`,
                  transformOrigin: 'top left',
                }}
              >
                <PhoneFrame activeTab={screen.tab} width={d.w} height={d.h}>
                  {renderScreen(screen.id, d.w)}
                </PhoneFrame>
              </div>
            </div>

            {/* Label + Download */}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <span style={{ fontSize: 14, fontWeight: 600 }}>{screen.name}</span>
              <button
                onClick={() => downloadOne(screen.id)}
                disabled={downloading !== null}
                style={{
                  padding: '6px 14px', borderRadius: 8,
                  background: downloading === screen.id ? '#333' : '#1a1a1a',
                  color: '#ccc', border: '1px solid #333',
                  fontSize: 12, fontWeight: 500, cursor: downloading !== null ? 'wait' : 'pointer',
                  fontFamily: 'var(--font-manrope), system-ui',
                }}
              >
                {downloading === screen.id ? 'Saving...' : 'Download PNG'}
              </button>
            </div>
          </div>
        ))}
      </div>

      {/* Info Footer */}
      <div style={{
        padding: '24px 32px', borderTop: '1px solid #222',
        display: 'flex', justifyContent: 'space-between', flexWrap: 'wrap' as const, gap: 16,
        fontSize: 12, color: '#666',
      }}>
        <span>Current: {d.name} &mdash; {d.pw} x {d.ph}px @ {d.scale}x</span>
        <span>
          iPhone: 1242x2688 or 1284x2778 &bull; iPad: 2048x2732 or 2064x2752 &bull; Android: 1080x1920+
        </span>
      </div>
    </div>
  );
}
