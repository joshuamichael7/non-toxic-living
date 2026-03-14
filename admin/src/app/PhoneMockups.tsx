'use client';

/* =====================================================================
   PhoneMockups — Landing page hero phones
   Uses the EXACT same design system as screenshots/ScreenshotStudio.tsx.
   Rendered at full iPhone logical dimensions then CSS-scaled down.
   ===================================================================== */

const C = {
  canvas: '#E8E8E8',
  glass: '#F0F0F0',
  glassBorder: 'rgba(255,255,255,0.6)',
  oxygen: '#0EA5E9',
  oxygenGlow: 'rgba(14,165,233,0.3)',
  oxygenGlowSubtle: 'rgba(14,165,233,0.15)',
  safe: '#10B981',
  safeLight: 'rgba(16,185,129,0.15)',
  okay: '#84CC16',
  okayLight: 'rgba(132,204,22,0.15)',
  caution: '#F59E0B',
  cautionLight: 'rgba(245,158,11,0.15)',
  toxic: '#EF4444',
  toxicLight: 'rgba(239,68,68,0.15)',
  ink: '#1A1A1A',
  inkSecondary: '#64748B',
  inkMuted: '#94A3B8',
  white: '#FFFFFF',
};

// Full iPhone 6.5" logical dimensions — same as ScreenshotStudio's iphone-65
const PHONE_W = 414;
const PHONE_H = 896;
// Display size on landing page
const DISPLAY_W = 230;
const SCALE = DISPLAY_W / PHONE_W;            // ~0.556
const DISPLAY_H = Math.round(PHONE_H * SCALE); // ~498

const font = 'var(--font-manrope), system-ui, -apple-system, sans-serif';

function verdictColor(score: number) {
  if (score <= 33) return C.toxic;
  if (score <= 66) return C.caution;
  if (score <= 79) return C.okay;
  return C.safe;
}
function verdictBg(score: number) {
  if (score <= 33) return C.toxicLight;
  if (score <= 66) return C.cautionLight;
  if (score <= 79) return C.okayLight;
  return C.safeLight;
}
function verdictLabel(score: number) {
  if (score <= 33) return 'Toxic';
  if (score <= 66) return 'Caution';
  if (score <= 79) return 'Okay';
  return 'Safe';
}

/* ── SVG Icons ── */
function IconX() {
  return <svg width={18} height={18} viewBox="0 0 24 24" fill="none" stroke={C.ink} strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round"><path d="M18 6L6 18"/><path d="M6 6l12 12"/></svg>;
}
function IconShare() {
  return <svg width={20} height={20} viewBox="0 0 24 24" fill="none" stroke={C.ink} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M4 12v8a2 2 0 002 2h12a2 2 0 002-2v-8"/><polyline points="16 6 12 2 8 6"/><line x1="12" y1="2" x2="12" y2="15"/></svg>;
}
function IconDoc() {
  return <svg width={16} height={16} viewBox="0 0 24 24" fill="none" stroke={C.oxygen} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/></svg>;
}
function IconChat() {
  return <svg width={16} height={16} viewBox="0 0 24 24" fill="none" stroke={C.white} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z"/></svg>;
}
function IconCheck({ color = C.safe }: { color?: string }) {
  return <svg width={14} height={14} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={3} strokeLinecap="round" strokeLinejoin="round"><polyline points="20 6 9 17 4 12"/></svg>;
}
function IconWarning({ color = C.caution }: { color?: string }) {
  return <svg width={16} height={16} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M10.29 3.86L1.82 18a2 2 0 001.71 3h16.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>;
}
function IconChevron() {
  return <svg width={16} height={16} viewBox="0 0 24 24" fill="none" stroke={C.oxygen} strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round"><polyline points="9 18 15 12 9 6"/></svg>;
}
function IconScan() {
  return <svg width={20} height={20} viewBox="0 0 24 24" fill="none" stroke={C.white} strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round"><path d="M4 8V4h4"/><path d="M20 8V4h-4"/><path d="M4 16v4h4"/><path d="M20 16v4h-4"/></svg>;
}
function IconHeart() {
  return <svg width={20} height={20} viewBox="0 0 24 24" fill="none" stroke={C.inkSecondary} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M20.84 4.61a5.5 5.5 0 00-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 00-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 000-7.78z"/></svg>;
}
function IconStore() {
  return <svg width={14} height={14} viewBox="0 0 24 24" fill="none" stroke={C.oxygen} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="M3 9l1-4h16l1 4"/><path d="M3 9v10a1 1 0 001 1h16a1 1 0 001-1V9"/><path d="M9 21V12h6v9"/></svg>;
}

/* ── Shared UI ── */
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

function ScoreBadge({ score, size = 96 }: { score: number; size?: number }) {
  const col = verdictColor(score);
  const bg = verdictBg(score);
  const radius = size * 0.31;
  const border = size >= 80 ? 4 : 3;
  return (
    <div style={{ width:size, height:size, borderRadius:radius, background:bg, border:`${border}px solid ${col}`, display:'flex', alignItems:'center', justifyContent:'center', boxShadow:`0 4px 14px ${col}40`, flexShrink:0 }}>
      <span style={{ color:col, fontFamily:font, fontSize:size*0.35, fontWeight:800 }}>{score}</span>
    </div>
  );
}

function GlassCard({ children, style = {} }: { children: React.ReactNode; style?: React.CSSProperties }) {
  return (
    <div style={{ background:C.glass, border:`1px solid ${C.glassBorder}`, borderRadius:24, padding:20, boxShadow:'0 4px 12px rgba(0,0,0,0.04)', ...style }}>
      {children}
    </div>
  );
}

function VerdictPill({ score }: { score: number }) {
  const col = verdictColor(score);
  const bg = verdictBg(score);
  const label = verdictLabel(score);
  const isBad = score <= 66;
  return (
    <div style={{ display:'inline-flex', alignItems:'center', gap:6, padding:'8px 16px', borderRadius:12, background:bg, border:`1px solid ${col}` }}>
      {isBad ? <IconWarning color={col} /> : <IconCheck color={col} />}
      <span style={{ fontSize:14, fontWeight:700, color:col, fontFamily:font }}>{label}</span>
    </div>
  );
}

function ResultHeader() {
  return (
    <div style={{ display:'flex', alignItems:'center', padding:'12px 20px', borderBottom:`1px solid ${C.glassBorder}`, flexShrink:0 }}>
      <div style={{ width:44, height:44, borderRadius:14, background:C.glass, border:`1px solid ${C.glassBorder}`, display:'flex', alignItems:'center', justifyContent:'center' }}>
        <IconX />
      </div>
      <span style={{ flex:1, textAlign:'center' as const, fontSize:16, fontWeight:700, color:C.ink, fontFamily:font }}>Scan Result</span>
      <div style={{ width:44, height:44, borderRadius:14, background:C.glass, border:`1px solid ${C.glassBorder}`, display:'flex', alignItems:'center', justifyContent:'center' }}>
        <IconShare />
      </div>
    </div>
  );
}

/* Equal-width Save / Scan Again buttons — matching the actual app */
function BottomBar() {
  return (
    <div style={{ padding:'14px 20px 36px', background:C.glass, borderTop:`1px solid ${C.glassBorder}`, display:'flex', gap:12, flexShrink:0 }}>
      {/* Save — equal width */}
      <div style={{ flex:1, display:'flex', alignItems:'center', justifyContent:'center', gap:8, padding:'16px 0', borderRadius:16, background:C.glass, border:`1.5px solid ${C.glassBorder}`, boxShadow:'0 2px 8px rgba(0,0,0,0.06)' }}>
        <IconHeart />
        <span style={{ fontSize:16, fontWeight:700, color:C.inkSecondary, fontFamily:font }}>Save</span>
      </div>
      {/* Scan Again — equal width */}
      <div style={{ flex:1, display:'flex', alignItems:'center', justifyContent:'center', gap:8, padding:'16px 0', borderRadius:16, background:C.oxygen, boxShadow:`0 6px 12px ${C.oxygenGlow}` }}>
        <IconScan />
        <span style={{ fontSize:16, fontWeight:700, color:C.white, fontFamily:font }}>Scan Again</span>
      </div>
    </div>
  );
}

/* ── Phone 1: Score 67 Okay — Tom's of Maine Toothpaste ── */
function OkayScreen() {
  const score = 67;
  return (
    <div style={{ flex:1, display:'flex', flexDirection:'column', overflow:'hidden' }}>
      <ResultHeader />
      <div style={{ flex:1, padding:'16px 20px', display:'flex', flexDirection:'column', gap:14, overflowY:'hidden' }}>
        {/* Score Hero */}
        <GlassCard style={{ borderRadius:32, padding:24, textAlign:'center' as const }}>
          <div style={{ display:'flex', justifyContent:'center', marginBottom:14 }}>
            <ScoreBadge score={score} size={100} />
          </div>
          <div style={{ fontSize:20, fontWeight:800, color:C.ink, marginBottom:4, lineHeight:1.3, fontFamily:font }}>
            Fluoride-Free Whitening Toothpaste
          </div>
          <div style={{ fontSize:14, color:C.inkSecondary, fontWeight:500, marginBottom:14, fontFamily:font }}>Tom&apos;s of Maine</div>
          <VerdictPill score={score} />
        </GlassCard>

        {/* Summary */}
        <GlassCard style={{ borderRadius:24, padding:20 }}>
          <div style={{ display:'flex', alignItems:'center', gap:10, marginBottom:12 }}>
            <div style={{ width:32, height:32, borderRadius:10, background:C.oxygenGlowSubtle, display:'flex', alignItems:'center', justifyContent:'center' }}>
              <IconDoc />
            </div>
            <span style={{ fontSize:13, fontWeight:600, letterSpacing:0.3, color:C.inkSecondary, textTransform:'uppercase' as const, fontFamily:font }}>Summary</span>
          </div>
          <div style={{ fontSize:15, color:C.ink, lineHeight:1.6, fontWeight:500, fontFamily:font }}>
            Clean ingredient list with no harmful additives. Avoids fluoride and uses natural flavors. Contains sodium lauryl sulfate, which may be a concern for sensitive users.
          </div>
        </GlassCard>

        {/* Our Take (blue card) */}
        <div style={{ borderRadius:24, padding:20, background:C.oxygen, boxShadow:`0 8px 16px ${C.oxygenGlow}` }}>
          <div style={{ display:'flex', alignItems:'center', gap:10, marginBottom:12 }}>
            <div style={{ width:32, height:32, borderRadius:10, background:'rgba(255,255,255,0.2)', display:'flex', alignItems:'center', justifyContent:'center' }}>
              <IconChat />
            </div>
            <span style={{ fontSize:13, fontWeight:700, letterSpacing:0.3, color:C.white, textTransform:'uppercase' as const, fontFamily:font }}>Our Take</span>
          </div>
          <div style={{ fontSize:15, color:C.white, lineHeight:1.6, fontWeight:500, fontFamily:font }}>
            &ldquo;A solid choice for fluoride-free oral care. Clean formula, honest label — no nasty surprises.&rdquo;
          </div>
        </div>

        {/* Positives */}
        <div style={{ display:'flex', flexDirection:'column', gap:8 }}>
          {[
            'Fluoride-free formula',
            'No artificial sweeteners or dyes',
            'Natural peppermint oil flavor',
            'BPA-free, recyclable packaging',
          ].map(p => (
            <div key={p} style={{ display:'flex', alignItems:'center', gap:10, padding:'10px 14px', borderRadius:12, background:C.safeLight, border:`1px solid ${C.safe}` }}>
              <IconCheck color={C.safe} />
              <span style={{ fontSize:14, fontWeight:600, color:C.safe, fontFamily:font }}>{p}</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

/* ── Phone 2: Score 34 Caution — Fried Noodle ── */
function CautionScreen() {
  const score = 34;
  const concerns = [
    { name: 'MSG (Monosodium Glutamate)', severity: 'Medium', desc: 'Flavor enhancer linked to headaches and sensitivity reactions in some individuals.' },
    { name: 'Artificial Flavoring Agents', severity: 'Medium', desc: 'Broad category of synthetic chemicals; specific compounds not disclosed on label.' },
    { name: 'TBHQ Preservative', severity: 'High', desc: 'Synthetic antioxidant; high doses linked to negative health effects in animal studies.' },
  ];
  return (
    <div style={{ flex:1, display:'flex', flexDirection:'column', overflow:'hidden' }}>
      <ResultHeader />
      <div style={{ flex:1, padding:'16px 20px', display:'flex', flexDirection:'column', gap:14, overflowY:'hidden' }}>
        {/* Score Hero */}
        <GlassCard style={{ borderRadius:32, padding:22, textAlign:'center' as const }}>
          <div style={{ display:'flex', justifyContent:'center', marginBottom:12 }}>
            <ScoreBadge score={score} size={96} />
          </div>
          <div style={{ fontSize:22, fontWeight:800, color:C.ink, marginBottom:4, lineHeight:1.3, fontFamily:font }}>
            Fried Noodle
          </div>
          <div style={{ fontSize:14, color:C.inkSecondary, fontWeight:500, marginBottom:12, fontFamily:font }}>Unknown</div>
          <VerdictPill score={score} />
        </GlassCard>

        {/* Summary */}
        <GlassCard style={{ borderRadius:24, padding:20 }}>
          <div style={{ display:'flex', alignItems:'center', gap:10, marginBottom:12 }}>
            <div style={{ width:32, height:32, borderRadius:10, background:C.oxygenGlowSubtle, display:'flex', alignItems:'center', justifyContent:'center' }}>
              <IconDoc />
            </div>
            <span style={{ fontSize:13, fontWeight:600, letterSpacing:0.3, color:C.inkSecondary, textTransform:'uppercase' as const, fontFamily:font }}>Summary</span>
          </div>
          <div style={{ fontSize:15, color:C.ink, lineHeight:1.6, fontWeight:500, fontFamily:font }}>
            Contains several additives and flavor enhancers that may raise concerns, particularly for children and sensitive individuals.
          </div>
        </GlassCard>

        {/* Concerns */}
        <div>
          <div style={{ fontSize:13, fontWeight:600, color:C.inkSecondary, letterSpacing:0.5, textTransform:'uppercase' as const, marginBottom:10, fontFamily:font }}>
            Concerns ({concerns.length})
          </div>
          <div style={{ display:'flex', flexDirection:'column', gap:8 }}>
            {concerns.map(c => (
              <GlassCard key={c.name} style={{ padding:14, borderRadius:18 }}>
                <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', marginBottom:6 }}>
                  <span style={{ fontSize:14, fontWeight:700, color:C.ink, fontFamily:font }}>{c.name}</span>
                  <span style={{ fontSize:11, fontWeight:600, color: c.severity === 'High' ? C.toxic : C.caution, background: c.severity === 'High' ? C.toxicLight : C.cautionLight, border:`1px solid ${c.severity === 'High' ? C.toxic : C.caution}`, borderRadius:8, padding:'3px 8px', whiteSpace:'nowrap' as const, fontFamily:font }}>{c.severity}</span>
                </div>
                <div style={{ fontSize:13, color:C.inkSecondary, lineHeight:1.4, fontFamily:font }}>{c.desc}</div>
              </GlassCard>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}

/* ── Phone 3: Positives + Better Alternatives ── */
function PositivesSwapsScreen() {
  const positives = [
    'Fluoride-free formula caters to diverse preferences',
    'Natural flavor from peppermint oil',
    'No artificial flavors, sweeteners, or dyes',
    'BPA-free tube and recyclable packaging',
  ];
  const swaps = [
    { score: 85, name: 'Antiplaque & Whitening Fluoride-Free Toothpaste', brand: "Tom's of Maine" },
    { score: 84, name: 'Silly Strawberry Kids Fluoride-Free Toothpaste', brand: "Tom's of Maine" },
    { score: 75, name: 'Fluoride-Free Antiplaque Toothpaste', brand: "Tom's of Maine" },
  ];

  return (
    <div style={{ flex:1, display:'flex', flexDirection:'column', overflow:'hidden' }}>
      <ResultHeader />
      <div style={{ flex:1, padding:'16px 20px', display:'flex', flexDirection:'column', gap:10, overflowY:'hidden' }}>
        {/* Positives */}
        <div style={{ fontSize:13, fontWeight:600, color:C.inkSecondary, letterSpacing:0.5, textTransform:'uppercase' as const, fontFamily:font }}>Positives</div>
        <div style={{ display:'flex', flexDirection:'column', gap:8 }}>
          {positives.map(p => (
            <div key={p} style={{ display:'flex', alignItems:'center', gap:10, padding:'10px 14px', borderRadius:12, background:C.safeLight, border:`1px solid ${C.safe}` }}>
              <IconCheck color={C.safe} />
              <span style={{ fontSize:14, fontWeight:600, color:C.safe, fontFamily:font, lineHeight:1.4 }}>{p}</span>
            </div>
          ))}
        </div>

        {/* Better Alternatives header */}
        <div style={{ display:'flex', alignItems:'center', justifyContent:'space-between', marginTop:6 }}>
          <div style={{ fontSize:13, fontWeight:600, color:C.inkSecondary, letterSpacing:0.5, textTransform:'uppercase' as const, fontFamily:font }}>Better Alternatives</div>
          <div style={{ display:'flex', alignItems:'center', gap:6, padding:'6px 12px', borderRadius:20, background:C.oxygenGlowSubtle }}>
            <IconStore />
            <span style={{ fontSize:12, fontWeight:600, color:C.oxygen, fontFamily:font }}>Find at a store</span>
          </div>
        </div>

        {/* Swap cards */}
        <div style={{ display:'flex', flexDirection:'column', gap:8 }}>
          {swaps.map(swap => (
            <GlassCard key={swap.name} style={{ padding:14, borderRadius:18, display:'flex', alignItems:'center', gap:12 }}>
              <ScoreBadge score={swap.score} size={52} />
              <div style={{ flex:1, minWidth:0 }}>
                <div style={{ fontSize:14, fontWeight:700, color:C.ink, lineHeight:1.3, fontFamily:font }}>{swap.name}</div>
                <div style={{ fontSize:12, color:C.inkSecondary, marginTop:2, fontFamily:font }}>{swap.brand}</div>
              </div>
              <div style={{ width:34, height:34, borderRadius:11, background:C.oxygenGlowSubtle, display:'flex', alignItems:'center', justifyContent:'center', flexShrink:0 }}>
                <IconChevron />
              </div>
            </GlassCard>
          ))}
        </div>
      </div>
    </div>
  );
}

/* ── Phone wrapper: device frame + CSS scale ── */
function Phone({ children, className = '' }: { children: React.ReactNode; className?: string }) {
  return (
    <div
      className={className}
      style={{
        position: 'relative',
        width: DISPLAY_W,
        height: DISPLAY_H,
        borderRadius: Math.round(DISPLAY_W * 0.14),
        border: '4px solid #1C1C1E',
        background: '#1C1C1E',
        overflow: 'hidden',
        flexShrink: 0,
        boxShadow: '0 24px 56px rgba(0,0,0,0.40), 0 0 0 1px rgba(255,255,255,0.07)',
      }}
    >
      {/* Dynamic Island */}
      <div style={{
        position: 'absolute',
        top: Math.round(DISPLAY_H * 0.016),
        left: '50%',
        transform: 'translateX(-50%)',
        width: Math.round(DISPLAY_W * 0.30),
        height: Math.round(DISPLAY_W * 0.065),
        background: '#1C1C1E',
        borderRadius: 99,
        zIndex: 10,
      }} />
      {/* Full-size screen content scaled down */}
      <div style={{
        width: PHONE_W,
        height: PHONE_H,
        transform: `scale(${SCALE})`,
        transformOrigin: 'top left',
        display: 'flex',
        flexDirection: 'column',
        background: C.canvas,
      }}>
        <StatusBar />
        {children}
        <BottomBar />
      </div>
    </div>
  );
}

/* ── Exported component ── */
export function PhoneMockups() {
  return (
    <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'center', gap: 16 }}>
      <Phone className="hidden sm:block">
        <CautionScreen />
      </Phone>
      <Phone>
        <OkayScreen />
      </Phone>
      <Phone className="hidden sm:block">
        <PositivesSwapsScreen />
      </Phone>
    </div>
  );
}
