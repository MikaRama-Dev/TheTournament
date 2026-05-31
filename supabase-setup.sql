-- =====================================================
-- LE TOURNOI — Setup Supabase
-- =====================================================
-- À exécuter dans Supabase Dashboard → SQL Editor → New Query
-- Copie-colle TOUT ce fichier, clique sur "Run"
-- Crée les 4 tables + active la Row Level Security + crée les policies
-- =====================================================

-- ===== TABLE 1 : clubs =====
CREATE TABLE IF NOT EXISTS public.clubs (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  city TEXT NOT NULL,
  president TEXT NOT NULL,
  phone TEXT,
  status TEXT DEFAULT 'new' NOT NULL
);

-- ===== TABLE 2 : teams =====
CREATE TABLE IF NOT EXISTS public.teams (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  club TEXT NOT NULL,
  city TEXT NOT NULL,
  category TEXT NOT NULL,
  level TEXT NOT NULL,
  manager TEXT NOT NULL,
  phone TEXT,
  status TEXT DEFAULT 'new' NOT NULL
);

-- ===== TABLE 3 : sponsors =====
CREATE TABLE IF NOT EXISTS public.sponsors (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  sector TEXT NOT NULL,
  city TEXT NOT NULL,
  contact TEXT NOT NULL,
  phone TEXT,
  budget_range TEXT NOT NULL,
  status TEXT DEFAULT 'new' NOT NULL
);

-- ===== TABLE 4 : consents (traçabilité RGPD) =====
CREATE TABLE IF NOT EXISTS public.consents (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  email TEXT NOT NULL,
  account_type TEXT NOT NULL,
  consent_data_collection BOOLEAN NOT NULL,
  consent_marketing BOOLEAN DEFAULT FALSE NOT NULL,
  ip_address TEXT
);

-- =====================================================
-- SÉCURITÉ : Row Level Security
-- =====================================================
-- Active RLS sur toutes les tables (essentiel sur un site public)
ALTER TABLE public.clubs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sponsors ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.consents ENABLE ROW LEVEL SECURITY;

-- =====================================================
-- POLICIES : autoriser uniquement les INSERT publics
-- (PAS de SELECT public = personne ne peut lire les listes)
-- =====================================================

-- Clubs : autoriser les inscriptions par n'importe qui (anonyme)
DROP POLICY IF EXISTS "Allow public insert on clubs" ON public.clubs;
CREATE POLICY "Allow public insert on clubs"
  ON public.clubs FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- Teams : idem
DROP POLICY IF EXISTS "Allow public insert on teams" ON public.teams;
CREATE POLICY "Allow public insert on teams"
  ON public.teams FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- Sponsors : idem
DROP POLICY IF EXISTS "Allow public insert on sponsors" ON public.sponsors;
CREATE POLICY "Allow public insert on sponsors"
  ON public.sponsors FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- Consents : idem
DROP POLICY IF EXISTS "Allow public insert on consents" ON public.consents;
CREATE POLICY "Allow public insert on consents"
  ON public.consents FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- =====================================================
-- INDEX pour performances
-- =====================================================
CREATE INDEX IF NOT EXISTS idx_clubs_email ON public.clubs(email);
CREATE INDEX IF NOT EXISTS idx_clubs_created ON public.clubs(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_teams_email ON public.teams(email);
CREATE INDEX IF NOT EXISTS idx_teams_category ON public.teams(category);
CREATE INDEX IF NOT EXISTS idx_sponsors_email ON public.sponsors(email);
CREATE INDEX IF NOT EXISTS idx_consents_email ON public.consents(email);

-- =====================================================
-- VÉRIFICATION
-- =====================================================
-- Cette requête finale affiche les tables créées pour confirmer
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('clubs', 'teams', 'sponsors', 'consents')
ORDER BY table_name;

-- Tu dois voir 4 lignes en résultat : clubs, consents, sponsors, teams.
-- Si oui, ton setup Supabase est terminé.
