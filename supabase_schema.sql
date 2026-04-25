-- ═══════════════════════════════════════════
-- HIBAGRI — Supabase Schema
-- شغّل هذا في SQL Editor في Supabase
-- ═══════════════════════════════════════════

-- 1. جدول المستخدمين
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  phone TEXT UNIQUE NOT NULL,
  name TEXT,
  wilaya TEXT,
  account_type TEXT DEFAULT 'farmer',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. جدول الإعلانات
CREATE TABLE IF NOT EXISTS public.listings (
  id TEXT PRIMARY KEY,
  cat TEXT NOT NULL,
  name TEXT NOT NULL,
  owner_name TEXT,
  phone TEXT,
  wilaya TEXT,
  price INTEGER DEFAULT 0,
  unit TEXT DEFAULT 'يوم',
  avail TEXT DEFAULT 'green',
  bg TEXT,
  rating NUMERIC DEFAULT 4.5,
  reviews INTEGER DEFAULT 0,
  from_city TEXT,
  to_city TEXT,
  distance TEXT,
  capacity TEXT,
  with_driver BOOLEAN DEFAULT FALSE,
  with_operator BOOLEAN DEFAULT FALSE,
  insurance_required BOOLEAN DEFAULT FALSE,
  insurance_expiry DATE,
  listing_type TEXT,
  material_type TEXT,
  quantity TEXT,
  quality INTEGER,
  certified BOOLEAN DEFAULT FALSE,
  certification TEXT,
  storage_type TEXT,
  temp_range TEXT,
  area TEXT,
  humidity TEXT,
  has_dock BOOLEAN DEFAULT FALSE,
  year INTEGER,
  power TEXT,
  fuel TEXT,
  flow TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. جدول الحجوزات
CREATE TABLE IF NOT EXISTS public.bookings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  listing_id TEXT,
  listing_name TEXT,
  user_phone TEXT,
  user_name TEXT,
  date_from DATE,
  date_to DATE,
  note TEXT,
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. جدول المحفوظات
CREATE TABLE IF NOT EXISTS public.favorites (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_phone TEXT NOT NULL,
  listing_id TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_phone, listing_id)
);

-- 5. جدول الرسائل
CREATE TABLE IF NOT EXISTS public.messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  listing_id TEXT,
  sender_phone TEXT,
  sender_name TEXT,
  content TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ── تفعيل الصلاحيات (RLS) ──
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.listings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

-- ── سياسات الوصول (مفتوح للجميع في البداية) ──
CREATE POLICY "public_read_write" ON public.profiles FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_read_write" ON public.listings FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_read_write" ON public.bookings FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_read_write" ON public.favorites FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_read_write" ON public.messages FOR ALL USING (true) WITH CHECK (true);
