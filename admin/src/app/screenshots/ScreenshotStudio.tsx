'use client';

import { useState, useRef, useCallback } from 'react';
import { toPng } from 'html-to-image';

/* ==========================================================
   COLORS — Exact Aerogel design system values
   ========================================================== */
const C = {
  canvas: '#E8E8E8',
  glass: '#F0F0F0',
  glassBorder: 'rgba(255,255,255,0.6)',
  oxygen: '#0EA5E9',
  oxygenDeep: '#0284C7',
  oxygenGlow: 'rgba(14,165,233,0.3)',
  oxygenGlowSubtle: 'rgba(14,165,233,0.15)',
  safe: '#10B981',
  safeLight: 'rgba(16,185,129,0.15)',
  safeSolid: '#D1FAE5',
  caution: '#F59E0B',
  cautionLight: 'rgba(245,158,11,0.15)',
  cautionSolid: '#FEF3C7',
  toxic: '#EF4444',
  toxicLight: 'rgba(239,68,68,0.15)',
  toxicSolid: '#FFE4E6',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
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
  { id: 'home-deals', name: 'Home (Deals)', tab: 'home' },
  { id: 'scan', name: 'Scan', tab: 'scan' },
  { id: 'search-food', name: 'Search', tab: 'search' },
  { id: 'result-safe', name: 'Result (Safe)', tab: null },
  { id: 'result-toxic', name: 'Result (Toxic)', tab: null },
  { id: 'swap-detail', name: 'Swap Detail', tab: null },
  { id: 'plan', name: 'Choose Plan', tab: null },
];

function verdictColor(score: number) { return score <= 33 ? C.toxic : score <= 66 ? C.caution : C.safe; }
function verdictBg(score: number) { return score <= 33 ? C.toxicSolid : score <= 66 ? C.cautionSolid : C.safeSolid; }
function verdictLabel(score: number) { return score <= 33 ? 'TOXIC' : score <= 66 ? 'CAUTION' : 'SAFE'; }

const font = 'var(--font-manrope), system-ui, -apple-system, sans-serif';

/* ==========================================================
   SVG ICONS
   ========================================================== */
function IconHome({ color = C.inkMuted, size = 22 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"/><path d="M9 22V12h6v10"/></svg>;
}
function IconScanCorners({ color = C.inkMuted, size = 22 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round"><path d="M4 8V4h4"/><path d="M20 8V4h-4"/><path d="M4 16v4h4"/><path d="M20 16v4h-4"/></svg>;
}
function IconSearch({ color = C.inkMuted, size = 22 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><circle cx="11" cy="11" r="8"/><path d="M21 21l-4.35-4.35"/></svg>;
}
function IconPerson({ color = C.inkMuted, size = 22 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>;
}
function IconBell({ color = C.ink, size = 22 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 01-3.46 0"/></svg>;
}
function IconCamera({ color = C.white, size = 22 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M23 19a2 2 0 01-2 2H3a2 2 0 01-2-2V8a2 2 0 012-2h4l2-3h6l2 3h4a2 2 0 012 2z"/><circle cx="12" cy="13" r="4"/></svg>;
}
function IconX({ color = C.ink, size = 20 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round"><path d="M18 6L6 18"/><path d="M6 6l12 12"/></svg>;
}
function IconChevron({ color = C.inkMuted, size = 18 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round"><polyline points="9 18 15 12 9 6"/></svg>;
}
function IconCheck({ color = C.safe, size = 16 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={3} strokeLinecap="round" strokeLinejoin="round"><polyline points="20 6 9 17 4 12"/></svg>;
}
function IconWarning({ color = C.caution, size = 20 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>;
}
function IconShieldCheck({ color = C.safe, size = 20 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/><polyline points="9 12 11 14 15 10"/></svg>;
}
function IconLeaf({ color = C.safe, size = 18 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M11 20A7 7 0 019.8 6.9C15.5 4.9 20 2 20 2s-1.7 7.4-5 12c-1.1 1.5-2.5 3.2-4 6z"/><path d="M10.7 20.7a7 7 0 01-7.7-7.7"/></svg>;
}
function IconStore({ color = C.oxygen, size = 18 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M3 9l1-4h16l1 4"/><path d="M3 9v10a1 1 0 001 1h16a1 1 0 001-1V9"/><path d="M9 21V12h6v9"/></svg>;
}
function IconDoc({ color = C.inkSecondary, size = 20 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></svg>;
}
function IconCart({ color = C.white, size = 16 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 002 1.61h9.72a2 2 0 002-1.61L23 6H6"/></svg>;
}
function IconNutrition({ color = C.ink, size = 18 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={1.8} strokeLinecap="round" strokeLinejoin="round"><ellipse cx="12" cy="14" rx="7" ry="8"/><path d="M12 6V3"/><path d="M12 3c2 0 3.5 1.5 3.5 2.5"/></svg>;
}
function IconBody({ color = C.ink, size = 18 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="4" r="2.5"/><path d="M12 7v7"/><path d="M8 10l4 1 4-1"/><path d="M9 22l3-8 3 8"/></svg>;
}
function IconArrowRight({ color = C.oxygen, size = 18 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>;
}
function IconShare({ color = C.ink, size = 22 }: { color?: string; size?: number }) {
  return <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M4 12v8a2 2 0 002 2h12a2 2 0 002-2v-8"/><polyline points="16 6 12 2 8 6"/><line x1="12" y1="2" x2="12" y2="15"/></svg>;
}

/* ==========================================================
   SHARED COMPONENTS
   ========================================================== */

function StatusBar() {
  return (
    <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', padding:'14px 24px 6px', fontFamily:font, fontSize:15, fontWeight:600, color:C.ink }}>
      <span>9:41</span>
      <div style={{ display:'flex', gap:6, alignItems:'center' }}>
        <svg width={17} height={12} viewBox="0 0 17 12"><rect x="0" y="6" width="3" height="6" rx=".5" fill={C.ink}/><rect x="4.5" y="4" width="3" height="8" rx=".5" fill={C.ink}/><rect x="9" y="2" width="3" height="10" rx=".5" fill={C.ink}/><rect x="13.5" y="0" width="3" height="12" rx=".5" fill={C.ink}/></svg>
        <svg width={16} height={12} viewBox="0 0 16 12"><path d="M1 4.5a7 7 0 0114 0" fill="none" stroke={C.ink} strokeWidth="1.5"/><path d="M4 7.5a4 4 0 018 0" fill="none" stroke={C.ink} strokeWidth="1.5"/><circle cx="8" cy="10.5" r="1.5" fill={C.ink}/></svg>
        <svg width={26} height={12} viewBox="0 0 28 13"><rect x="0" y="1" width="24" height="11" rx="2.5" stroke={C.ink} strokeWidth="1" fill="none"/><rect x="1.5" y="2.5" width="18" height="8" rx="1.5" fill={C.ink}/><rect x="25.5" y="4" width="2" height="5" rx="1" fill={C.ink} opacity="0.3"/></svg>
      </div>
    </div>
  );
}

function TabBar({ activeTab, width }: { activeTab: string; width: number }) {
  const tabs = [
    { id: 'home', label: 'Home', Icon: IconHome },
    { id: 'scan', label: 'Scan', Icon: IconScanCorners },
    { id: 'search', label: 'Search', Icon: IconSearch },
    { id: 'profile', label: 'Profile', Icon: IconPerson },
  ];
  const isTablet = width > 700;
  return (
    <div style={{
      display:'flex', justifyContent:'space-around', alignItems:'flex-start',
      height: isTablet ? 76 : 88, paddingTop:12, paddingBottom: isTablet ? 8 : 28,
      background:C.glass, borderTop:`1px solid ${C.glassBorder}`,
    }}>
      {tabs.map(({ id, label, Icon }) => {
        const active = activeTab === id;
        return (
          <div key={id} style={{ display:'flex', flexDirection:'column', alignItems:'center', gap:4 }}>
            <div style={{
              width:48, height:32, borderRadius:12,
              background: active ? C.oxygenGlow : 'transparent',
              display:'flex', alignItems:'center', justifyContent:'center',
            }}>
              <Icon color={active ? C.oxygen : C.inkMuted} size={22} />
            </div>
            <span style={{ fontSize:11, fontWeight:600, letterSpacing:0.2, color: active ? C.oxygen : C.inkMuted, fontFamily:font }}>{label}</span>
          </div>
        );
      })}
    </div>
  );
}

function ScoreBadge({ score, size = 52 }: { score: number; size?: number }) {
  const color = verdictColor(score);
  const bg = verdictBg(score);
  const radius = size * 0.31;
  const border = size >= 80 ? 4 : 2;
  return (
    <div style={{
      width:size, height:size, borderRadius:radius,
      background:bg, border:`${border}px solid ${color}`,
      display:'flex', alignItems:'center', justifyContent:'center',
      boxShadow:`0 4px 14px ${color}40`,
      flexShrink:0,
    }}>
      <span style={{ color, fontFamily:font, fontSize:size*0.35, fontWeight:800 }}>{score}</span>
    </div>
  );
}

function GlassCard({ children, style = {} }: { children: React.ReactNode; style?: React.CSSProperties }) {
  return (
    <div style={{
      background:C.glass, border:`1px solid ${C.glassBorder}`,
      borderRadius:24, padding:20,
      boxShadow:'0 4px 12px rgba(0,0,0,0.04)',
      ...style,
    }}>{children}</div>
  );
}

function SafePickBadge() {
  return (
    <span style={{
      fontSize:10, fontWeight:700, color:C.safe,
      background:C.safeLight, border:`1px solid ${C.safe}`,
      borderRadius:6, padding:'2px 6px',
      fontFamily:font, letterSpacing:0.3, whiteSpace:'nowrap' as const,
    }}>SAFE PICK</span>
  );
}

function PhoneFrame({ children, activeTab, width, height }: {
  children: React.ReactNode; activeTab: string | null; width: number; height: number;
}) {
  return (
    <div style={{ width, height, background:C.canvas, display:'flex', flexDirection:'column', fontFamily:font, position:'relative', overflow:'hidden' }}>
      <StatusBar />
      <div style={{ flex:1, overflow:'hidden', display:'flex', flexDirection:'column' }}>{children}</div>
      {activeTab && <TabBar activeTab={activeTab} width={width} />}
    </div>
  );
}

/* ==========================================================
   SCREEN: HOME
   ========================================================== */
function HomeScreen({ width }: { width: number }) {
  const pad = width > 700 ? 32 : 24;
  const isTab = width > 700;
  return (
    <div style={{ flex:1, padding:`0 ${pad}px`, display:'flex', flexDirection:'column', gap: isTab ? 24 : 20, overflowY:'hidden' }}>
      {/* Header */}
      <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', marginTop:8 }}>
        <div style={{ display:'flex', alignItems:'center', gap:12 }}>
          <div style={{ width:48, height:48, borderRadius:24, background:C.oxygen, display:'flex', alignItems:'center', justifyContent:'center', boxShadow:`0 4px 8px ${C.oxygenGlow}` }}>
            <IconPerson color={C.white} size={24} />
          </div>
          <div>
            <div style={{ fontSize:14, color:C.inkSecondary, fontWeight:500 }}>Welcome back</div>
            <div style={{ fontSize:20, fontWeight:700, color:C.ink }}>Scan Anything</div>
          </div>
        </div>
        <div style={{ width:44, height:44, borderRadius:22, background:C.glass, border:`1px solid ${C.glassBorder}`, display:'flex', alignItems:'center', justifyContent:'center' }}>
          <IconBell size={20} />
        </div>
      </div>

      {/* Hero Card */}
      <GlassCard style={{ borderRadius:32, padding:28 }}>
        <div style={{ display:'flex', alignItems:'center', gap:10, marginBottom:12 }}>
          <div style={{ width:32, height:32, borderRadius:10, background:C.oxygenGlowSubtle, display:'flex', alignItems:'center', justifyContent:'center' }}>
            <IconScanCorners color={C.oxygen} size={18} />
          </div>
          <span style={{ fontSize:13, fontWeight:600, color:C.inkSecondary, letterSpacing:0.5 }}>TOXIN SCANNER</span>
        </div>
        <div style={{ fontSize: isTab ? 34 : 32, fontWeight:800, color:C.ink, lineHeight:1.2, marginBottom:8 }}>
          What&apos;s in your products?
        </div>
        <div style={{ fontSize:15, color:C.inkSecondary, lineHeight:1.5, marginBottom:20 }}>
          Point your camera at any ingredient label for instant analysis
        </div>
        <button style={{
          display:'inline-flex', alignItems:'center', gap:10,
          padding:'16px 24px', borderRadius:16,
          background:C.oxygen, color:C.white, border:'none',
          fontSize:15, fontWeight:700, fontFamily:font, cursor:'pointer',
          boxShadow:`0 8px 16px ${C.oxygenGlow}`,
        }}>
          <IconScanCorners color={C.white} size={18} /> Start Scanning
        </button>
      </GlassCard>

      {/* Stats */}
      <GlassCard style={{ padding:20, borderRadius:24 }}>
        <div style={{ display:'flex', alignItems:'center' }}>
          {[
            { icon: <IconScanCorners color={C.oxygen} size={22} />, bg: C.oxygenGlowSubtle, val: '237', label: 'Scans' },
            { icon: <IconWarning color={C.caution} size={22} />, bg: C.cautionLight, val: '86', label: 'Concerns' },
            { icon: <IconShieldCheck color={C.safe} size={22} />, bg: C.safeLight, val: '151', label: 'Safe' },
          ].map((s, i) => (
            <div key={s.label} style={{ flex:1, display:'flex', flexDirection:'column', alignItems:'center', gap:6, borderRight: i < 2 ? `1px solid ${C.glassBorder}` : 'none' }}>
              <div style={{ width:48, height:48, borderRadius:16, background:s.bg, display:'flex', alignItems:'center', justifyContent:'center' }}>{s.icon}</div>
              <span style={{ fontSize:24, fontWeight:800, color:C.ink }}>{s.val}</span>
              <span style={{ fontSize:11, fontWeight:500, color:C.inkSecondary }}>{s.label}</span>
            </div>
          ))}
        </div>
      </GlassCard>

      {/* Categories */}
      <div>
        <div style={{ fontSize:13, fontWeight:600, color:C.inkSecondary, letterSpacing:0.5, textTransform:'uppercase' as const, marginBottom:14 }}>Categories</div>
        <div style={{ display:'flex', gap:10, overflow:'hidden' }}>
          {[
            { name: 'Food', Icon: IconNutrition, active: true },
            { name: 'Personal Care', Icon: IconBody, active: false },
            { name: 'Household', Icon: IconHome, active: false },
          ].map(cat => (
            <div key={cat.name} style={{
              display:'flex', alignItems:'center', gap:8,
              padding:'12px 16px', borderRadius:16, whiteSpace:'nowrap' as const,
              background: cat.active ? C.oxygen : C.glass,
              border: `1px solid ${cat.active ? C.oxygen : C.glassBorder}`,
              boxShadow: cat.active ? `0 4px 12px ${C.oxygenGlow}` : '0 2px 8px rgba(0,0,0,0.04)',
            }}>
              <cat.Icon color={cat.active ? C.white : C.ink} size={18} />
              <span style={{ fontSize:14, fontWeight:600, color: cat.active ? C.white : C.inkSecondary }}>{cat.name}</span>
            </div>
          ))}
        </div>
      </div>

      {/* Featured peek — naturally clipped by overflow */}
      <div>
        <div style={{ fontSize:13, fontWeight:600, color:C.inkSecondary, letterSpacing:0.5, textTransform:'uppercase' as const, marginBottom:12 }}>Featured</div>
        <div style={{ display:'flex', gap:12, overflow:'hidden' }}>
          <GlassCard style={{ width:260, minWidth:260, padding:20, borderRadius:24 }}>
            <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', marginBottom:12 }}>
              <span style={{ fontSize:10, fontWeight:700, letterSpacing:0.5, color:C.safe, background:C.safeLight, padding:'4px 8px', borderRadius:8 }}>FEATURED</span>
              <span style={{ fontSize:12, fontWeight:700, color:C.oxygen }}>25% OFF</span>
            </div>
            <div style={{ width:'100%', height:120, borderRadius:12, marginBottom:12, background:'#F5F5F5', display:'flex', alignItems:'center', justifyContent:'center', overflow:'hidden' }}>
              <img src="/screenshots/lodge-skillet.jpg" alt="" style={{ width:'100%', height:'100%', objectFit:'contain' }} />
            </div>
            <div style={{ fontSize:11, fontWeight:600, letterSpacing:0.5, color:C.inkSecondary, textTransform:'uppercase' as const, marginBottom:4 }}>AMAZON</div>
            <div style={{ fontSize:15, fontWeight:700, color:C.ink, lineHeight:'1.3', marginBottom:4 }}>12-Inch Cast Iron Skillet</div>
            <div style={{ display:'flex', alignItems:'center', gap:8, marginBottom:14 }}>
              <span style={{ fontSize:16, fontWeight:800, color:C.oxygen }}>$29.99</span>
              <span style={{ fontSize:13, color:C.inkMuted, textDecoration:'line-through' as const }}>$39.99</span>
            </div>
            <button style={{ width:'100%', padding:'12px 0', borderRadius:14, background:C.oxygen, color:C.white, border:'none', fontSize:14, fontWeight:700, fontFamily:font, display:'flex', alignItems:'center', justifyContent:'center', gap:6, boxShadow:`0 4px 8px ${C.oxygenGlow}` }}>
              <IconCart size={16} /> Shop Now
            </button>
          </GlassCard>
          <GlassCard style={{ width:260, minWidth:260, padding:20, borderRadius:24 }}>
            <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', marginBottom:12 }}>
              <span style={{ fontSize:10, fontWeight:700, letterSpacing:0.5, color:C.safe, background:C.safeLight, padding:'4px 8px', borderRadius:8 }}>FEATURED</span>
              <span style={{ fontSize:12, fontWeight:700, color:C.oxygen }}>20% OFF</span>
            </div>
            <div style={{ width:'100%', height:120, borderRadius:12, background:'#F5F5F5', display:'flex', alignItems:'center', justifyContent:'center', overflow:'hidden' }}>
              <img src="/screenshots/dr-bronners-soap.png" alt="" style={{ height:'100%', objectFit:'contain' }} />
            </div>
          </GlassCard>
        </div>
      </div>
    </div>
  );
}

/* ==========================================================
   SCREEN: HOME (SCROLLED — Featured & Recent Scans)
   ========================================================== */
function HomeDealsScreen({ width }: { width: number }) {
  const pad = width > 700 ? 32 : 24;
  const isTab = width > 700;
  const cardW = isTab ? 320 : 260;
  return (
    <div style={{ flex:1, padding:`0 ${pad}px`, display:'flex', flexDirection:'column', gap: isTab ? 18 : 16, overflowY:'hidden' }}>
      {/* Categories */}
      <div style={{ marginTop:8 }}>
        <div style={{ fontSize:13, fontWeight:600, color:C.inkSecondary, letterSpacing:0.5, textTransform:'uppercase' as const, marginBottom:12 }}>Categories</div>
        <div style={{ display:'flex', gap:10, overflow:'hidden' }}>
          {[
            { name: 'Food', Icon: IconNutrition, active: true },
            { name: 'Personal Care', Icon: IconBody, active: false },
            { name: 'Household', Icon: IconHome, active: false },
          ].map(cat => (
            <div key={cat.name} style={{
              display:'flex', alignItems:'center', gap:8,
              padding:'12px 16px', borderRadius:16, whiteSpace:'nowrap' as const,
              background: cat.active ? C.oxygen : C.glass,
              border: `1px solid ${cat.active ? C.oxygen : C.glassBorder}`,
              boxShadow: cat.active ? `0 4px 12px ${C.oxygenGlow}` : '0 2px 8px rgba(0,0,0,0.04)',
            }}>
              <cat.Icon color={cat.active ? C.white : C.ink} size={18} />
              <span style={{ fontSize:14, fontWeight:600, color: cat.active ? C.white : C.inkSecondary }}>{cat.name}</span>
            </div>
          ))}
        </div>
      </div>

      {/* Featured */}
      <div>
        <div style={{ fontSize:13, fontWeight:600, color:C.inkSecondary, letterSpacing:0.5, textTransform:'uppercase' as const, marginBottom:12 }}>Featured</div>
        <div style={{ display:'flex', gap:12, overflow:'hidden' }}>
          {[
            { store: 'Amazon', title: '12-Inch Cast Iron Skillet', price: '$29.99', oldPrice: '$39.99', off: '25% OFF', img: '/screenshots/lodge-skillet.jpg' },
            { store: 'Thrive Market', title: "Dr. Bronner\u2019s Castile Soap", price: '$14.99', oldPrice: '$18.99', off: '20% OFF', img: '/screenshots/dr-bronners-soap.png' },
          ].map((item, i) => (
            <GlassCard key={i} style={{ width:cardW, minWidth:cardW, padding:20, borderRadius:24 }}>
              <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', marginBottom:12 }}>
                <span style={{ fontSize:10, fontWeight:700, letterSpacing:0.5, color:C.safe, background:C.safeLight, padding:'4px 8px', borderRadius:8 }}>FEATURED</span>
                <span style={{ fontSize:12, fontWeight:700, color:C.oxygen }}>{item.off}</span>
              </div>
              <div style={{
                width:'100%', height:120, borderRadius:12, marginBottom:12,
                background:'#F5F5F5', display:'flex', alignItems:'center', justifyContent:'center', overflow:'hidden',
              }}>
                <img src={item.img} alt="" style={{ height:'100%', objectFit:'contain' }} />
              </div>
              <div style={{ fontSize:11, fontWeight:600, letterSpacing:0.5, color:C.inkSecondary, textTransform:'uppercase' as const, marginBottom:4 }}>{item.store}</div>
              <div style={{ fontSize:15, fontWeight:700, color:C.ink, lineHeight:'1.3', marginBottom:4 }}>{item.title}</div>
              <div style={{ display:'flex', alignItems:'center', gap:8, marginBottom:14 }}>
                <span style={{ fontSize:16, fontWeight:800, color:C.oxygen }}>{item.price}</span>
                <span style={{ fontSize:13, color:C.inkMuted, textDecoration:'line-through' as const }}>{item.oldPrice}</span>
              </div>
              <button style={{
                width:'100%', padding:'12px 0', borderRadius:14,
                background:C.oxygen, color:C.white, border:'none',
                fontSize:14, fontWeight:700, fontFamily:font,
                display:'flex', alignItems:'center', justifyContent:'center', gap:6,
                boxShadow:`0 4px 8px ${C.oxygenGlow}`,
              }}>
                <IconCart size={16} /> Shop Now
              </button>
            </GlassCard>
          ))}
        </div>
      </div>

      {/* Recent Scans */}
      <div>
        <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', marginBottom:12 }}>
          <span style={{ fontSize:13, fontWeight:600, color:C.inkSecondary, letterSpacing:0.5, textTransform:'uppercase' as const }}>Recent Scans</span>
          <span style={{ fontSize:14, fontWeight:600, color:C.oxygen }}>See all</span>
        </div>
        <div style={{ display:'flex', flexDirection:'column', gap:8 }}>
          {[
            { name: 'Tide Original Detergent', brand: 'Tide', score: 22 },
            { name: 'Seventh Generation Dish Soap', brand: 'Seventh Generation', score: 88 },
            { name: 'Crest 3D White Toothpaste', brand: 'Crest', score: 38 },
          ].map((scan, i) => (
            <GlassCard key={i} style={{ padding:16, borderRadius:20, display:'flex', alignItems:'center', gap:14 }}>
              <ScoreBadge score={scan.score} size={52} />
              <div style={{ flex:1, minWidth:0 }}>
                <div style={{ fontSize:15, fontWeight:600, color:C.ink, overflow:'hidden', textOverflow:'ellipsis', whiteSpace:'nowrap' as const }}>{scan.name}</div>
                <div style={{ fontSize:13, color:C.inkSecondary, marginTop:2 }}>{scan.brand}</div>
              </div>
              <span style={{
                fontSize:12, fontWeight:600,
                color: verdictColor(scan.score),
                background: scan.score <= 33 ? C.toxicLight : scan.score <= 66 ? C.cautionLight : C.safeLight,
                border: `1px solid ${verdictColor(scan.score)}`,
                borderRadius:10, padding:'6px 12px',
              }}>{verdictLabel(scan.score)}</span>
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
  const isTab = width > 700;
  return (
    <div style={{ flex:1, display:'flex', flexDirection:'column', alignItems:'center', justifyContent:'center', padding:`0 ${pad}px`, textAlign:'center' as const }}>
      {/* Large scan icon */}
      <div style={{
        width: isTab ? 160 : 120, height: isTab ? 160 : 120, borderRadius: isTab ? 52 : 40,
        background: C.oxygenGlowSubtle, display:'flex', alignItems:'center', justifyContent:'center',
        marginBottom:32,
      }}>
        <IconScanCorners color={C.oxygen} size={isTab ? 72 : 56} />
      </div>

      <div style={{ fontSize: isTab ? 32 : 28, fontWeight:800, color:C.ink, marginBottom:12 }}>Scan a Product</div>
      <div style={{ fontSize:15, color:C.inkSecondary, lineHeight:1.6, maxWidth:320, marginBottom:32 }}>
        Take a photo of the ingredient label and we&apos;ll analyze it for toxins
      </div>

      {/* Open Camera button */}
      <button style={{
        width:'100%', maxWidth: isTab ? 400 : 340, padding:'20px 0',
        background:C.oxygen, color:C.white, border:'none', borderRadius:20,
        fontSize:17, fontWeight:700, fontFamily:font, cursor:'pointer',
        display:'flex', alignItems:'center', justifyContent:'center', gap:12,
        boxShadow:`0 10px 20px ${C.oxygenGlow}`,
        marginBottom:12,
      }}>
        <IconCamera size={22} /> Open Camera
      </button>

      {/* No label button */}
      <button style={{
        width:'100%', maxWidth: isTab ? 400 : 340, padding:'14px 0',
        background:C.glass, color:C.inkSecondary, border:`1.5px solid ${C.inkSecondary}`,
        borderRadius:16, fontSize:14, fontWeight:600, fontFamily:font, cursor:'pointer',
        display:'flex', alignItems:'center', justifyContent:'center', gap:8,
      }}>
        <IconDoc size={18} /> No label? Describe it <IconChevron color={C.inkSecondary} size={14} />
      </button>

      <div style={{ fontSize:13, color:C.inkMuted, marginTop:24, lineHeight:1.5 }}>
        Tip: Focus on the ingredient list for the most accurate results
      </div>
    </div>
  );
}

/* ==========================================================
   SCREEN: SEARCH RESULTS
   ========================================================== */
function SearchResultsScreen({ width, query, count, results }: {
  width: number;
  query: string;
  count: number;
  results: { name: string; brand: string; score: number }[];
}) {
  const pad = width > 700 ? 32 : 24;
  const isTab = width > 700;
  return (
    <div style={{ flex:1, padding:`0 ${pad}px`, display:'flex', flexDirection:'column', gap:12, overflowY:'hidden' }}>
      {/* Header */}
      <div style={{ marginTop:8 }}>
        <div style={{ fontSize: isTab ? 32 : 28, fontWeight:800, color:C.ink }}>Search</div>
        <div style={{ fontSize:14, color:C.inkSecondary, marginTop:4 }}>Find safe alternatives for any product</div>
      </div>

      {/* Search bar */}
      <div style={{
        display:'flex', alignItems:'center', gap:12, padding:'16px 16px',
        borderRadius:16, background:C.glass, border:`1px solid ${C.glassBorder}`,
        boxShadow:'0 4px 12px rgba(0,0,0,0.04)',
      }}>
        <IconSearch color={C.inkMuted} size={18} />
        <span style={{ flex:1, fontSize:16, fontWeight:500, color:C.ink }}>{query}</span>
        <div style={{ width:24, height:24, borderRadius:12, background:C.canvas, display:'flex', alignItems:'center', justifyContent:'center' }}>
          <IconX color={C.inkMuted} size={10} />
        </div>
      </div>

      {/* Results label */}
      <div style={{ fontSize:13, fontWeight:600, color:C.inkSecondary, letterSpacing:0.5, textTransform:'uppercase' as const }}>
        Results ({count})
      </div>

      {/* Result cards */}
      <div style={{ display:'flex', flexDirection:'column', gap:8, flex:1 }}>
        {results.map((r, i) => (
          <GlassCard key={i} style={{ padding:16, borderRadius:20, display:'flex', alignItems:'center', gap:14 }}>
            <ScoreBadge score={r.score} size={52} />
            <div style={{ flex:1, minWidth:0 }}>
              <div style={{ fontSize:15, fontWeight:600, color:C.ink, overflow:'hidden', textOverflow:'ellipsis', whiteSpace:'nowrap' as const }}>{r.name}</div>
              <div style={{ display:'flex', alignItems:'center', gap:8, marginTop:2 }}>
                <span style={{ fontSize:13, color:C.inkSecondary }}>{r.brand}</span>
                {r.score >= 80 && <SafePickBadge />}
              </div>
            </div>
            <IconChevron size={18} />
          </GlassCard>
        ))}
      </div>
    </div>
  );
}

/* ==========================================================
   SCREEN: SWAP DETAIL
   ========================================================== */
function SwapDetailScreen({ width }: { width: number }) {
  const pad = width > 700 ? 32 : 20;
  const isTab = width > 700;
  return (
    <div style={{ flex:1, display:'flex', flexDirection:'column', background:C.canvas }}>
      {/* Modal header */}
      <div style={{ display:'flex', alignItems:'center', padding:`16px ${pad}px`, borderBottom:`1px solid ${C.glassBorder}` }}>
        <div style={{ width:44, height:44, borderRadius:14, background:C.glass, border:`1px solid ${C.glassBorder}`, display:'flex', alignItems:'center', justifyContent:'center' }}>
          <IconX size={18} />
        </div>
        <span style={{ flex:1, textAlign:'center' as const, fontSize:13, fontWeight:600, letterSpacing:0.5, color:C.inkSecondary, textTransform:'uppercase' as const }}>Better Alternatives</span>
        <div style={{ width:44 }} />
      </div>

      <div style={{ flex:1, padding:`16px ${pad}px`, display:'flex', flexDirection:'column', gap:20, overflowY:'hidden' }}>
        {/* Score Hero */}
        <GlassCard style={{ borderRadius:32, padding:28, textAlign:'center' as const }}>
          <div style={{ display:'flex', justifyContent:'center', marginBottom:16 }}>
            <ScoreBadge score={95} size={isTab ? 120 : 100} />
          </div>
          <div style={{ fontSize: isTab ? 26 : 22, fontWeight:800, color:C.ink, lineHeight:1.3 }}>
            Reusable Silicone Storage Bag
          </div>
          <div style={{ fontSize:15, color:C.inkSecondary, marginTop:4 }}>Stasher</div>
          <div style={{ marginTop:12, display:'inline-flex', alignItems:'center', gap:6, padding:'8px 16px', borderRadius:12, background:C.safeLight, border:`1px solid ${C.safe}33` }}>
            <IconCheck color={C.safe} size={16} />
            <span style={{ fontSize:14, fontWeight:600, color:C.safe }}>Safety Score: 95/100</span>
          </div>
        </GlassCard>

        {/* Why This Is Better */}
        <GlassCard style={{ borderRadius:24, padding:20 }}>
          <div style={{ display:'flex', alignItems:'center', gap:10, marginBottom:12 }}>
            <div style={{ width:32, height:32, borderRadius:10, background:C.safeLight, display:'flex', alignItems:'center', justifyContent:'center' }}>
              <IconLeaf color={C.safe} size={18} />
            </div>
            <span style={{ fontSize:13, fontWeight:600, letterSpacing:0.3, color:C.inkSecondary, textTransform:'uppercase' as const }}>Why This Is Better</span>
          </div>
          <div style={{ fontSize:15, color:C.ink, lineHeight:1.6, fontWeight:500 }}>
            Eliminates BPA, BPS, phthalates, and plasticizers that leach from plastic bags into food, especially when heated.
          </div>
        </GlassCard>

        {/* Available At */}
        <GlassCard style={{ borderRadius:24, padding:20 }}>
          <div style={{ display:'flex', alignItems:'center', gap:10, marginBottom:12 }}>
            <div style={{ width:32, height:32, borderRadius:10, background:C.oxygenGlowSubtle, display:'flex', alignItems:'center', justifyContent:'center' }}>
              <IconStore color={C.oxygen} size={18} />
            </div>
            <span style={{ fontSize:13, fontWeight:600, letterSpacing:0.3, color:C.inkSecondary, textTransform:'uppercase' as const }}>Available At</span>
          </div>
          <div style={{ display:'flex', flexWrap:'wrap' as const, gap:8 }}>
            {['Amazon', 'Target', 'Whole Foods', 'Thrive Market'].map(s => (
              <span key={s} style={{ padding:'8px 14px', borderRadius:12, background:C.canvas, border:`1px solid ${C.glassBorder}`, fontSize:13, fontWeight:500, color:C.ink }}>{s}</span>
            ))}
          </div>
        </GlassCard>
      </div>

      {/* Bottom button */}
      <div style={{ padding:`12px ${pad}px 34px` }}>
        <button style={{
          width:'100%', padding:'18px 0', borderRadius:16,
          background:C.oxygen, color:C.white, border:'none',
          fontSize:16, fontWeight:700, fontFamily:font, cursor:'pointer',
          boxShadow:`0 8px 16px ${C.oxygenGlow}`,
        }}>Close</button>
      </div>
    </div>
  );
}

/* ==========================================================
   SCREEN: PLAN SELECTION
   ========================================================== */
function PlanScreen({ width }: { width: number }) {
  const pad = width > 700 ? 32 : 20;
  return (
    <div style={{ flex:1, display:'flex', flexDirection:'column', background:C.canvas }}>
      {/* Header */}
      <div style={{ display:'flex', alignItems:'center', padding:`16px ${pad}px` }}>
        <div style={{ width:44, height:44, borderRadius:14, background:C.glass, border:`1px solid ${C.glassBorder}`, display:'flex', alignItems:'center', justifyContent:'center' }}>
          <IconX size={18} />
        </div>
        <span style={{ flex:1, textAlign:'center' as const, fontSize:18, fontWeight:700, color:C.ink }}>Choose Your Plan</span>
        <div style={{ width:44 }} />
      </div>

      <div style={{ flex:1, padding:`0 ${pad}px`, display:'flex', flexDirection:'column', overflowY:'hidden' }}>
        <div style={{ fontSize:15, color:C.inkSecondary, textAlign:'center' as const, marginBottom:24, lineHeight:1.5 }}>
          Unlock more scans and premium features
        </div>

        {/* Toggle */}
        <div style={{ display:'flex', borderRadius:16, background:C.glass, padding:4, marginBottom:24 }}>
          <div style={{ flex:1, padding:'12px 0', borderRadius:12, background:C.white, textAlign:'center' as const, fontSize:14, fontWeight:600, color:C.ink, boxShadow:'0 2px 8px rgba(0,0,0,0.06)' }}>Monthly</div>
          <div style={{ flex:1, padding:'12px 0', borderRadius:12, textAlign:'center' as const, fontSize:14, fontWeight:600, color:C.inkMuted }}>Annual</div>
        </div>

        {/* Free Tier */}
        <div style={{ borderRadius:24, padding:20, marginBottom:12, border:`1.5px solid ${C.safe}`, background:C.glass }}>
          <div style={{ display:'flex', justifyContent:'space-between', alignItems:'flex-start', marginBottom:16 }}>
            <div style={{ display:'flex', alignItems:'center', gap:10 }}>
              <span style={{ fontSize:20, fontWeight:800, color:C.ink }}>Free</span>
              <span style={{ fontSize:11, fontWeight:700, color:C.safe, background:C.safeLight, padding:'3px 8px', borderRadius:8 }}>Current</span>
            </div>
            <span style={{ fontSize:24, fontWeight:800, color:C.ink }}>Free</span>
          </div>
          {['5 scans per month', 'Basic ingredient analysis'].map(f => (
            <div key={f} style={{ display:'flex', alignItems:'center', gap:10, marginBottom:8 }}>
              <div style={{ width:22, height:22, borderRadius:11, background:C.safeLight, display:'flex', alignItems:'center', justifyContent:'center' }}>
                <IconCheck color={C.safe} size={12} />
              </div>
              <span style={{ fontSize:14, fontWeight:500, color:C.inkSecondary }}>{f}</span>
            </div>
          ))}
        </div>

        {/* Pro Tier */}
        <div style={{ borderRadius:24, padding:20, marginBottom:12, border:`1.5px solid ${C.oxygen}`, background:C.glass }}>
          <div style={{ display:'flex', justifyContent:'space-between', alignItems:'flex-start', marginBottom:16 }}>
            <div style={{ display:'flex', alignItems:'center', gap:10 }}>
              <span style={{ fontSize:20, fontWeight:800, color:C.oxygen }}>Pro</span>
              <span style={{ fontSize:11, fontWeight:700, color:C.safe, background:C.safeLight, padding:'3px 8px', borderRadius:8 }}>Most popular</span>
            </div>
            <div style={{ textAlign:'right' as const }}>
              <div style={{ fontSize:24, fontWeight:800, color:C.oxygen }}>$7.99</div>
              <div style={{ fontSize:13, color:C.inkSecondary, marginTop:2 }}>/month</div>
            </div>
          </div>
          {['200 scans per month', 'Detailed safety reports', 'Priority support'].map(f => (
            <div key={f} style={{ display:'flex', alignItems:'center', gap:10, marginBottom:8 }}>
              <div style={{ width:22, height:22, borderRadius:11, background:C.oxygenGlowSubtle, display:'flex', alignItems:'center', justifyContent:'center' }}>
                <IconCheck color={C.oxygen} size={12} />
              </div>
              <span style={{ fontSize:14, fontWeight:500, color:C.inkSecondary }}>{f}</span>
            </div>
          ))}
          <button style={{
            width:'100%', padding:'14px 0', borderRadius:16, marginTop:8,
            background:C.oxygen, color:C.white, border:'none',
            fontSize:15, fontWeight:700, fontFamily:font, cursor:'pointer',
            boxShadow:`0 6px 12px ${C.oxygenGlow}`,
          }}>Subscribe</button>
        </div>

        {/* Power Tier */}
        <div style={{ borderRadius:24, padding:20, border:`1.5px solid ${C.glassBorder}`, background:C.glass }}>
          <div style={{ display:'flex', justifyContent:'space-between', alignItems:'flex-start', marginBottom:16 }}>
            <span style={{ fontSize:20, fontWeight:800, color:C.ink }}>Power</span>
            <div style={{ textAlign:'right' as const }}>
              <div style={{ fontSize:24, fontWeight:800, color:C.ink }}>$14.99</div>
              <div style={{ fontSize:13, color:C.inkSecondary, marginTop:2 }}>/month</div>
            </div>
          </div>
          {['500 scans per month', 'Everything in Pro'].map(f => (
            <div key={f} style={{ display:'flex', alignItems:'center', gap:10, marginBottom:8 }}>
              <div style={{ width:22, height:22, borderRadius:11, background:C.safeLight, display:'flex', alignItems:'center', justifyContent:'center' }}>
                <IconCheck color={C.safe} size={12} />
              </div>
              <span style={{ fontSize:14, fontWeight:500, color:C.inkSecondary }}>{f}</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

/* ==========================================================
   SCREEN: RESULT (SAFE)
   ========================================================== */
function ResultSafeScreen({ width }: { width: number }) {
  const pad = width > 700 ? 32 : 20;
  const isTab = width > 700;
  return (
    <div style={{ flex:1, display:'flex', flexDirection:'column', background:C.canvas }}>
      {/* Header */}
      <div style={{ display:'flex', alignItems:'center', padding:`12px ${pad}px`, borderBottom:`1px solid ${C.glassBorder}` }}>
        <div style={{ width:44, height:44, borderRadius:14, background:C.glass, border:`1px solid ${C.glassBorder}`, display:'flex', alignItems:'center', justifyContent:'center' }}>
          <IconX size={18} />
        </div>
        <span style={{ flex:1, textAlign:'center' as const, fontSize:16, fontWeight:700, color:C.ink }}>Scan Result</span>
        <div style={{ width:44, height:44, borderRadius:14, background:C.glass, border:`1px solid ${C.glassBorder}`, display:'flex', alignItems:'center', justifyContent:'center' }}>
          <IconShare size={20} />
        </div>
      </div>

      <div style={{ flex:1, padding:`16px ${pad}px`, display:'flex', flexDirection:'column', gap:16, overflowY:'hidden' }}>
        {/* Score Hero */}
        <GlassCard style={{ borderRadius:32, padding:24, textAlign:'center' as const }}>
          <div style={{ display:'flex', justifyContent:'center', marginBottom:14 }}>
            <ScoreBadge score={92} size={isTab ? 120 : 100} />
          </div>
          <div style={{ fontSize: isTab ? 24 : 22, fontWeight:800, color:C.ink, marginBottom:4, lineHeight:1.3 }}>
            Dr. Bronner&apos;s Pure Castile Soap
          </div>
          <div style={{ fontSize:14, color:C.inkSecondary, fontWeight:500, marginBottom:12 }}>Dr. Bronner&apos;s</div>
          <div style={{ display:'inline-flex', alignItems:'center', gap:6, padding:'8px 16px', borderRadius:12, background:C.safeLight, border:`1px solid ${C.safe}33` }}>
            <IconShieldCheck color={C.safe} size={16} />
            <span style={{ fontSize:14, fontWeight:700, color:C.safe }}>Safe</span>
          </div>
        </GlassCard>

        {/* Summary */}
        <GlassCard style={{ borderRadius:24, padding:20 }}>
          <div style={{ display:'flex', alignItems:'center', gap:10, marginBottom:12 }}>
            <div style={{ width:32, height:32, borderRadius:10, background:C.oxygenGlowSubtle, display:'flex', alignItems:'center', justifyContent:'center' }}>
              <IconDoc color={C.oxygen} size={16} />
            </div>
            <span style={{ fontSize:13, fontWeight:600, letterSpacing:0.3, color:C.inkSecondary, textTransform:'uppercase' as const }}>Analysis</span>
          </div>
          <div style={{ fontSize:15, color:C.ink, lineHeight:1.6, fontWeight:500 }}>
            Pure plant-based formula with organic oils. No synthetic detergents, preservatives, or foaming agents.
          </div>
        </GlassCard>

        {/* Dad's Take */}
        <div style={{ borderRadius:24, padding:20, background:C.oxygen, boxShadow:`0 8px 16px ${C.oxygenGlow}` }}>
          <div style={{ display:'flex', alignItems:'center', gap:10, marginBottom:12 }}>
            <div style={{ width:32, height:32, borderRadius:10, background:'rgba(255,255,255,0.2)', display:'flex', alignItems:'center', justifyContent:'center' }}>
              <svg width={16} height={16} viewBox="0 0 24 24" fill="none" stroke={C.white} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z"/></svg>
            </div>
            <span style={{ fontSize:13, fontWeight:700, letterSpacing:0.3, color:C.white, textTransform:'uppercase' as const }}>Dad&apos;s Take</span>
          </div>
          <div style={{ fontSize:15, color:C.white, lineHeight:1.6, fontWeight:500 }}>
            &ldquo;This is what clean really looks like &mdash; organic oils, simple ingredients, nothing to hide. A gold standard for soap.&rdquo;
          </div>
        </div>

        {/* Positives */}
        <div style={{ display:'flex', flexDirection:'column', gap:8 }}>
          {['Organic coconut oil base', 'Fair trade certified ingredients', 'No synthetic preservatives', 'Fully biodegradable formula'].map(p => (
            <div key={p} style={{ display:'flex', alignItems:'center', gap:10, padding:'10px 14px', borderRadius:12, background:C.safeLight, border:`1px solid ${C.safe}` }}>
              <IconCheck color={C.safe} size={14} />
              <span style={{ fontSize:14, fontWeight:600, color:C.safe }}>{p}</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

/* ==========================================================
   SCREEN: RESULT (TOXIC)
   ========================================================== */
function ResultToxicScreen({ width }: { width: number }) {
  const pad = width > 700 ? 32 : 20;
  const isTab = width > 700;
  return (
    <div style={{ flex:1, display:'flex', flexDirection:'column', background:C.canvas }}>
      {/* Header */}
      <div style={{ display:'flex', alignItems:'center', padding:`12px ${pad}px`, borderBottom:`1px solid ${C.glassBorder}` }}>
        <div style={{ width:44, height:44, borderRadius:14, background:C.glass, border:`1px solid ${C.glassBorder}`, display:'flex', alignItems:'center', justifyContent:'center' }}>
          <IconX size={18} />
        </div>
        <span style={{ flex:1, textAlign:'center' as const, fontSize:16, fontWeight:700, color:C.ink }}>Scan Result</span>
        <div style={{ width:44, height:44, borderRadius:14, background:C.glass, border:`1px solid ${C.glassBorder}`, display:'flex', alignItems:'center', justifyContent:'center' }}>
          <IconShare size={20} />
        </div>
      </div>

      <div style={{ flex:1, padding:`16px ${pad}px`, display:'flex', flexDirection:'column', gap:14, overflowY:'hidden' }}>
        {/* Score Hero */}
        <GlassCard style={{ borderRadius:32, padding:22, textAlign:'center' as const }}>
          <div style={{ display:'flex', justifyContent:'center', marginBottom:12 }}>
            <ScoreBadge score={22} size={isTab ? 120 : 96} />
          </div>
          <div style={{ fontSize: isTab ? 24 : 20, fontWeight:800, color:C.ink, marginBottom:4, lineHeight:1.3 }}>
            Tide Original Detergent
          </div>
          <div style={{ fontSize:14, color:C.inkSecondary, fontWeight:500, marginBottom:10 }}>Procter &amp; Gamble</div>
          <div style={{ display:'inline-flex', alignItems:'center', gap:6, padding:'8px 16px', borderRadius:12, background:C.toxicLight, border:`1px solid ${C.toxic}33` }}>
            <IconWarning color={C.toxic} size={16} />
            <span style={{ fontSize:14, fontWeight:700, color:C.toxic }}>Avoid</span>
          </div>
        </GlassCard>

        {/* Concerns */}
        <div>
          <div style={{ fontSize:13, fontWeight:600, color:C.inkSecondary, letterSpacing:0.5, textTransform:'uppercase' as const, marginBottom:10 }}>Concerns (3)</div>
          <div style={{ display:'flex', flexDirection:'column', gap:8 }}>
            {[
              { name: 'Synthetic Fragrance', severity: 'High' as const, desc: 'Undisclosed blend of chemicals linked to hormone disruption and allergies' },
              { name: '1,4-Dioxane Risk', severity: 'High' as const, desc: 'Probable carcinogen, byproduct of the ethoxylation manufacturing process' },
              { name: 'Optical Brighteners', severity: 'Medium' as const, desc: 'UV-reactive chemicals that remain on clothing and contact skin continuously' },
            ].map(c => (
              <GlassCard key={c.name} style={{ padding:12, borderRadius:18 }}>
                <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', marginBottom:4 }}>
                  <span style={{ fontSize:14, fontWeight:700, color:C.ink }}>{c.name}</span>
                  <span style={{
                    fontSize:11, fontWeight:600,
                    color: c.severity === 'High' ? C.toxic : C.caution,
                    background: c.severity === 'High' ? C.toxicLight : C.cautionLight,
                    border: `1px solid ${c.severity === 'High' ? C.toxic : C.caution}`,
                    borderRadius:8, padding:'3px 8px',
                  }}>{c.severity}</span>
                </div>
                <div style={{ fontSize:13, color:C.inkSecondary, lineHeight:1.4 }}>{c.desc}</div>
              </GlassCard>
            ))}
          </div>
        </div>

        {/* Better Alternatives */}
        <div>
          <div style={{ fontSize:13, fontWeight:600, color:C.inkSecondary, letterSpacing:0.5, textTransform:'uppercase' as const, marginBottom:10 }}>Better Alternatives</div>
          <div style={{ display:'flex', flexDirection:'column', gap:8 }}>
            {[
              { name: 'Free & Clear Detergent', brand: 'Seventh Generation', score: 88 },
              { name: 'Concentrate Cleaner', brand: 'Branch Basics', score: 95 },
              { name: 'Laundry Powder', brand: "Molly\u2019s Suds", score: 90 },
            ].map((swap, i) => (
              <GlassCard key={i} style={{ padding:12, borderRadius:18, display:'flex', alignItems:'center', gap:12 }}>
                <ScoreBadge score={swap.score} size={46} />
                <div style={{ flex:1, minWidth:0 }}>
                  <div style={{ fontSize:14, fontWeight:600, color:C.ink }}>{swap.name}</div>
                  <div style={{ fontSize:12, color:C.inkSecondary, marginTop:2 }}>{swap.brand}</div>
                </div>
                <div style={{ width:34, height:34, borderRadius:11, background:C.oxygenGlowSubtle, display:'flex', alignItems:'center', justifyContent:'center', flexShrink:0 }}>
                  <IconArrowRight color={C.oxygen} size={16} />
                </div>
              </GlassCard>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}

/* ==========================================================
   RENDER SCREEN BY ID
   ========================================================== */
const foodResults = [
  { name: 'Doritos Nacho Cheese', brand: 'Frito-Lay', score: 18 },
  { name: 'Organic Ketchup', brand: "Annie's Homegrown", score: 92 },
  { name: 'Almond Flour Crackers', brand: 'Simple Mills', score: 90 },
  { name: 'Jade Cloud Green Tea', brand: 'Rishi Tea', score: 95 },
  { name: 'Avocado Oil Mayo', brand: 'Primal Kitchen', score: 88 },
];

function renderScreen(id: string, width: number) {
  switch (id) {
    case 'home': return <HomeScreen width={width} />;
    case 'home-deals': return <HomeDealsScreen width={width} />;
    case 'scan': return <ScanScreen width={width} />;
    case 'search-food': return <SearchResultsScreen width={width} query="Food & Drinks" count={17} results={foodResults} />;
    case 'result-safe': return <ResultSafeScreen width={width} />;
    case 'result-toxic': return <ResultToxicScreen width={width} />;
    case 'swap-detail': return <SwapDetailScreen width={width} />;
    case 'plan': return <PlanScreen width={width} />;
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
      const dataUrl = await toPng(el, { pixelRatio: d.scale, width: d.w, height: d.h, cacheBust: true, style: { transform: 'none', transformOrigin: 'top left' } });
      const link = document.createElement('a');
      link.download = `nontoxic_${screenId}_${d.pw}x${d.ph}.png`;
      link.href = dataUrl;
      link.click();
    } catch (err) { console.error('Download failed:', err); }
    setDownloading(null);
  }, [d]);

  const downloadAll = useCallback(async () => {
    setDownloading('all');
    for (const screen of SCREENS) {
      const el = screenRefs.current[screen.id];
      if (!el) continue;
      try {
        const dataUrl = await toPng(el, { pixelRatio: d.scale, width: d.w, height: d.h, cacheBust: true, style: { transform: 'none', transformOrigin: 'top left' } });
        const link = document.createElement('a');
        link.download = `nontoxic_${screen.id}_${d.pw}x${d.ph}.png`;
        link.href = dataUrl;
        link.click();
      } catch (err) { console.error(`Failed: ${screen.id}`, err); }
      await new Promise(r => setTimeout(r, 800));
    }
    setDownloading(null);
  }, [d]);

  return (
    <div style={{ minHeight:'100vh', background:'#0a0a0a', fontFamily:font, color:'#f0f0f0' }}>
      {/* Top bar */}
      <div style={{ padding:'24px 32px', borderBottom:'1px solid #222', display:'flex', justifyContent:'space-between', alignItems:'center', flexWrap:'wrap' as const, gap:16 }}>
        <div>
          <h1 style={{ fontSize:24, fontWeight:800, margin:0 }}>Screenshot Studio</h1>
          <p style={{ fontSize:13, color:'#888', margin:'4px 0 0' }}>Generate app store screenshots at exact pixel dimensions</p>
        </div>
        <button onClick={downloadAll} disabled={downloading !== null} style={{ padding:'12px 24px', borderRadius:12, background: downloading === 'all' ? '#333' : C.oxygen, color:C.white, border:'none', fontSize:14, fontWeight:700, cursor: downloading !== null ? 'wait' : 'pointer', fontFamily:font }}>
          {downloading === 'all' ? 'Downloading...' : `Download All (${d.pw} x ${d.ph})`}
        </button>
      </div>

      {/* Device selector */}
      <div style={{ padding:'16px 32px', borderBottom:'1px solid #222', display:'flex', gap:8, flexWrap:'wrap' as const }}>
        {Object.entries(DEVICES).map(([key, dev]) => (
          <button key={key} onClick={() => setDevice(key)} style={{
            padding:'8px 16px', borderRadius:10,
            background: device === key ? C.oxygen : '#1a1a1a',
            color: device === key ? C.white : '#aaa',
            border: `1px solid ${device === key ? C.oxygen : '#333'}`,
            fontSize:12, fontWeight:600, cursor:'pointer', fontFamily:font,
          }}>
            {dev.name} <span style={{ opacity:0.6, marginLeft:6 }}>{dev.pw}x{dev.ph}</span>
          </button>
        ))}
      </div>

      {/* Screen grid */}
      <div style={{ padding:32, display:'grid', gridTemplateColumns: d.type === 'tablet' ? 'repeat(auto-fill, minmax(400px, 1fr))' : 'repeat(auto-fill, minmax(280px, 1fr))', gap:32 }}>
        {SCREENS.map(screen => (
          <div key={screen.id} style={{ display:'flex', flexDirection:'column', gap:12 }}>
            <div style={{ width: d.w * previewScale, height: d.h * previewScale, overflow:'hidden', borderRadius:16, border:'2px solid #333', background:'#222', position:'relative' }}>
              <div ref={el => { screenRefs.current[screen.id] = el; }} style={{ width: d.w, height: d.h, transform: `scale(${previewScale})`, transformOrigin: 'top left' }}>
                <PhoneFrame activeTab={screen.tab} width={d.w} height={d.h}>
                  {renderScreen(screen.id, d.w)}
                </PhoneFrame>
              </div>
            </div>
            <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center' }}>
              <span style={{ fontSize:14, fontWeight:600 }}>{screen.name}</span>
              <button onClick={() => downloadOne(screen.id)} disabled={downloading !== null} style={{ padding:'6px 14px', borderRadius:8, background: downloading === screen.id ? '#333' : '#1a1a1a', color:'#ccc', border:'1px solid #333', fontSize:12, fontWeight:500, cursor: downloading !== null ? 'wait' : 'pointer', fontFamily:font }}>
                {downloading === screen.id ? 'Saving...' : 'Download PNG'}
              </button>
            </div>
          </div>
        ))}
      </div>

      {/* Footer */}
      <div style={{ padding:'24px 32px', borderTop:'1px solid #222', display:'flex', justifyContent:'space-between', flexWrap:'wrap' as const, gap:16, fontSize:12, color:'#666' }}>
        <span>Current: {d.name} &mdash; {d.pw} x {d.ph}px @ {d.scale}x</span>
        <span>iPhone: 1242x2688 or 1284x2778 &bull; iPad: 2048x2732 or 2064x2752 &bull; Android: 1080x1920+</span>
      </div>
    </div>
  );
}
