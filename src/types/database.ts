// Database types — synced with supabase/migrations/20250206140000 + 20250207100000

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
          subscription: 'free' | 'pro' | 'power';
          subscription_expires_at: string | null;
          scans_this_month: number;
          scans_month_reset_at: string;
          language: string;
          admin_role: 'owner' | 'manager' | null;
          preferences: Json;
          stats: Json;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id: string;
          display_name?: string | null;
          avatar_url?: string | null;
          subscription?: 'free' | 'pro' | 'power';
          subscription_expires_at?: string | null;
          scans_this_month?: number;
          scans_month_reset_at?: string;
          language?: string;
          admin_role?: 'owner' | 'manager' | null;
          preferences?: Json;
          stats?: Json;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          display_name?: string | null;
          avatar_url?: string | null;
          subscription?: 'free' | 'pro' | 'power';
          subscription_expires_at?: string | null;
          scans_this_month?: number;
          scans_month_reset_at?: string;
          language?: string;
          admin_role?: 'owner' | 'manager' | null;
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
          product_name: string | null;
          brand: string | null;
          score: number;
          verdict: 'safe' | 'caution' | 'toxic';
          analysis: Json;
          ocr_source: 'device' | 'cloud' | 'ai-mini' | 'ai-vision' | 'manual';
          ocr_confidence: number | null;
          image_path: string | null;
          barcode: string | null;
          was_cached: boolean;
          ai_model_used: string | null;
          saved_to_list: 'favorites' | 'avoid' | null;
          user_rating: number | null;
          user_notes: string | null;
          created_at: string;
        };
        Insert: {
          id?: string;
          user_id: string;
          product_id?: string | null;
          product_name?: string | null;
          brand?: string | null;
          score: number;
          verdict: 'safe' | 'caution' | 'toxic';
          analysis: Json;
          ocr_source: 'device' | 'cloud' | 'ai-mini' | 'ai-vision' | 'manual';
          ocr_confidence?: number | null;
          image_path?: string | null;
          barcode?: string | null;
          was_cached?: boolean;
          ai_model_used?: string | null;
          saved_to_list?: 'favorites' | 'avoid' | null;
          user_rating?: number | null;
          user_notes?: string | null;
          created_at?: string;
        };
        Update: {
          product_id?: string | null;
          product_name?: string | null;
          brand?: string | null;
          score?: number;
          verdict?: 'safe' | 'caution' | 'toxic';
          analysis?: Json;
          saved_to_list?: 'favorites' | 'avoid' | null;
          user_rating?: number | null;
          user_notes?: string | null;
        };
      };
      products: {
        Row: {
          id: string;
          name: string;
          brand: string | null;
          category: string;
          barcode: string | null;
          upc: string | null;
          score: number;
          verdict: 'safe' | 'caution' | 'toxic';
          summary: string | null;
          dads_take: string | null;
          analysis: Json | null;
          ingredients: string[] | null;
          ingredients_raw: string | null;
          ingredient_hash: string | null;
          analysis_version: number;
          last_analyzed_at: string;
          confidence_score: number;
          cache_ttl_days: number;
          manual_refresh_count: number;
          embedding: number[] | null;
          image_url: string | null;
          source: string;
          scan_count: number;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          brand?: string | null;
          category: string;
          barcode?: string | null;
          upc?: string | null;
          score: number;
          verdict: 'safe' | 'caution' | 'toxic';
          summary?: string | null;
          dads_take?: string | null;
          analysis?: Json | null;
          ingredients?: string[] | null;
          ingredients_raw?: string | null;
          ingredient_hash?: string | null;
          analysis_version?: number;
          last_analyzed_at?: string;
          confidence_score?: number;
          cache_ttl_days?: number;
          manual_refresh_count?: number;
          embedding?: number[] | null;
          image_url?: string | null;
          source?: string;
          scan_count?: number;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          name?: string;
          brand?: string | null;
          category?: string;
          barcode?: string | null;
          upc?: string | null;
          score?: number;
          verdict?: 'safe' | 'caution' | 'toxic';
          summary?: string | null;
          dads_take?: string | null;
          analysis?: Json | null;
          ingredients?: string[] | null;
          ingredients_raw?: string | null;
          ingredient_hash?: string | null;
          analysis_version?: number;
          last_analyzed_at?: string;
          confidence_score?: number;
          cache_ttl_days?: number;
          manual_refresh_count?: number;
          embedding?: number[] | null;
          image_url?: string | null;
          source?: string;
          scan_count?: number;
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
          regulatory_status: Json | null;
          safe_alternatives: string[];
          commonly_found_in: string[];
          embedding: number[] | null;
          sources: string[];
          last_reviewed_at: string | null;
          created_at: string;
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
          regulatory_status?: Json | null;
          safe_alternatives?: string[];
          commonly_found_in?: string[];
          embedding?: number[] | null;
          sources?: string[];
          last_reviewed_at?: string | null;
          created_at?: string;
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
          regulatory_status?: Json | null;
          safe_alternatives?: string[];
          commonly_found_in?: string[];
          embedding?: number[] | null;
          sources?: string[];
          last_reviewed_at?: string | null;
          updated_at?: string;
        };
      };
      swaps: {
        Row: {
          id: string;
          name: string;
          brand: string;
          category: string;
          description: string | null;
          score: number;
          why_better: string | null;
          badges: string[];
          replaces_ingredients: string[];
          replaces_products: string[];
          price_cents: number | null;
          affiliate_url: string | null;
          affiliate_source: 'amazon' | 'thrive' | 'iherb' | 'direct' | 'other' | null;
          affiliate_commission_percent: number | null;
          embedding: number[] | null;
          image_url: string | null;
          available_stores: string[];
          is_active: boolean;
          featured: boolean;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          brand: string;
          category: string;
          description?: string | null;
          score: number;
          why_better?: string | null;
          badges?: string[];
          replaces_ingredients?: string[];
          replaces_products?: string[];
          price_cents?: number | null;
          affiliate_url?: string | null;
          affiliate_source?: 'amazon' | 'thrive' | 'iherb' | 'direct' | 'other' | null;
          affiliate_commission_percent?: number | null;
          embedding?: number[] | null;
          image_url?: string | null;
          available_stores?: string[];
          is_active?: boolean;
          featured?: boolean;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          name?: string;
          brand?: string;
          category?: string;
          description?: string | null;
          score?: number;
          why_better?: string | null;
          badges?: string[];
          replaces_ingredients?: string[];
          replaces_products?: string[];
          price_cents?: number | null;
          affiliate_url?: string | null;
          affiliate_source?: 'amazon' | 'thrive' | 'iherb' | 'direct' | 'other' | null;
          affiliate_commission_percent?: number | null;
          embedding?: number[] | null;
          image_url?: string | null;
          available_stores?: string[];
          is_active?: boolean;
          featured?: boolean;
          updated_at?: string;
        };
      };
    };
    Views: {};
    Functions: {
      search_products_semantic: {
        Args: {
          query_embedding: number[];
          match_threshold?: number;
          match_count?: number;
        };
        Returns: {
          id: string;
          name: string;
          brand: string;
          score: number;
          similarity: number;
        }[];
      };
      find_similar_ingredients: {
        Args: {
          query_embedding: number[];
          match_threshold?: number;
          match_count?: number;
        };
        Returns: {
          id: string;
          name: string;
          toxicity_score: number;
          similarity: number;
        }[];
      };
      get_swap_recommendations: {
        Args: {
          product_category: string;
          product_embedding: number[];
          min_score?: number;
          match_count?: number;
          filter_store?: string;
        };
        Returns: {
          id: string;
          name: string;
          brand: string;
          score: number;
          price_cents: number | null;
          affiliate_url: string | null;
          why_better: string | null;
          similarity: number;
          available_stores: string[];
        }[];
      };
      check_and_increment_scan_quota: {
        Args: {
          user_uuid: string;
        };
        Returns: {
          allowed: boolean;
          scans_used: number;
          scans_limit: number;
          resets_at: string;
        }[];
      };
    };
    Enums: {};
  };
}
