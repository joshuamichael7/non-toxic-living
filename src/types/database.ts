// Database types - will be auto-generated from Supabase
// Run: npx supabase gen types typescript --project-id YOUR_PROJECT_ID > src/types/database.ts

export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[];

export interface Database {
  public: {
    Tables: {
      profiles: {
        Row: {
          id: string;
          display_name: string | null;
          avatar_url: string | null;
          subscription: 'free' | 'premium';
          preferences: Json;
          stats: Json;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id: string;
          display_name?: string | null;
          avatar_url?: string | null;
          subscription?: 'free' | 'premium';
          preferences?: Json;
          stats?: Json;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          display_name?: string | null;
          avatar_url?: string | null;
          subscription?: 'free' | 'premium';
          preferences?: Json;
          stats?: Json;
          updated_at?: string;
        };
      };
      scans: {
        Row: {
          id: string;
          user_id: string;
          product_id: string | null;
          score: number;
          verdict: 'safe' | 'caution' | 'toxic';
          analysis: Json;
          ocr_source: 'device' | 'ai-mini' | 'ai-vision';
          image_path: string | null;
          saved_to_list: 'favorites' | 'avoid' | null;
          created_at: string;
        };
        Insert: {
          id?: string;
          user_id: string;
          product_id?: string | null;
          score: number;
          verdict: 'safe' | 'caution' | 'toxic';
          analysis: Json;
          ocr_source: 'device' | 'ai-mini' | 'ai-vision';
          image_path?: string | null;
          saved_to_list?: 'favorites' | 'avoid' | null;
          created_at?: string;
        };
        Update: {
          product_id?: string | null;
          score?: number;
          verdict?: 'safe' | 'caution' | 'toxic';
          analysis?: Json;
          saved_to_list?: 'favorites' | 'avoid' | null;
        };
      };
      products: {
        Row: {
          id: string;
          name: string;
          brand: string | null;
          category: string;
          barcode: string | null;
          score: number;
          verdict: 'safe' | 'caution' | 'toxic';
          analysis: Json | null;
          image_url: string | null;
          scan_count: number;
          last_scanned: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          brand?: string | null;
          category: string;
          barcode?: string | null;
          score: number;
          verdict: 'safe' | 'caution' | 'toxic';
          analysis?: Json | null;
          image_url?: string | null;
          scan_count?: number;
          last_scanned?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          name?: string;
          brand?: string | null;
          category?: string;
          barcode?: string | null;
          score?: number;
          verdict?: 'safe' | 'caution' | 'toxic';
          analysis?: Json | null;
          image_url?: string | null;
          scan_count?: number;
          last_scanned?: string | null;
          updated_at?: string;
        };
      };
      ingredients: {
        Row: {
          id: string;
          name: string;
          slug: string;
          aliases: string[];
          category: string;
          toxicity_score: number;
          concerns: string[];
          health_effects: Json | null;
          sources: string[];
          safe_alternatives: string[];
          common_products: string[];
          updated_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          slug: string;
          aliases?: string[];
          category: string;
          toxicity_score: number;
          concerns?: string[];
          health_effects?: Json | null;
          sources?: string[];
          safe_alternatives?: string[];
          common_products?: string[];
          updated_at?: string;
        };
        Update: {
          name?: string;
          slug?: string;
          aliases?: string[];
          category?: string;
          toxicity_score?: number;
          concerns?: string[];
          health_effects?: Json | null;
          sources?: string[];
          safe_alternatives?: string[];
          common_products?: string[];
          updated_at?: string;
        };
      };
      swaps: {
        Row: {
          id: string;
          name: string;
          brand: string;
          category: string;
          score: number;
          price_cents: number | null;
          image_url: string | null;
          affiliate_url: string | null;
          affiliate_source: 'amazon' | 'thrive' | 'iherb' | 'direct' | null;
          badges: string[];
          why_better: string | null;
          replaces_ingredients: string[];
          is_active: boolean;
          created_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          brand: string;
          category: string;
          score: number;
          price_cents?: number | null;
          image_url?: string | null;
          affiliate_url?: string | null;
          affiliate_source?: 'amazon' | 'thrive' | 'iherb' | 'direct' | null;
          badges?: string[];
          why_better?: string | null;
          replaces_ingredients?: string[];
          is_active?: boolean;
          created_at?: string;
        };
        Update: {
          name?: string;
          brand?: string;
          category?: string;
          score?: number;
          price_cents?: number | null;
          image_url?: string | null;
          affiliate_url?: string | null;
          affiliate_source?: 'amazon' | 'thrive' | 'iherb' | 'direct' | null;
          badges?: string[];
          why_better?: string | null;
          replaces_ingredients?: string[];
          is_active?: boolean;
        };
      };
    };
    Views: {};
    Functions: {};
    Enums: {};
  };
}
