-- ══════════════════════════════════════════
-- هيباغري v5 — تحديث قاعدة البيانات
-- شغّل هذا الملف في Supabase SQL Editor
-- ══════════════════════════════════════════

-- إضافة الأعمدة الجديدة لجدول profiles
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS email TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS nid_number TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS is_subscribed BOOLEAN DEFAULT FALSE;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS subscription_end DATE;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS is_verified BOOLEAN DEFAULT FALSE;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS is_admin BOOLEAN DEFAULT FALSE;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ DEFAULT NOW();

-- إضافة الأعمدة الجديدة لجدول listings
ALTER TABLE listings ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'active';
ALTER TABLE listings ADD COLUMN IF NOT EXISTS image_url TEXT;
ALTER TABLE listings ADD COLUMN IF NOT EXISTS address TEXT;
ALTER TABLE listings ADD COLUMN IF NOT EXISTS owner_phone TEXT;
ALTER TABLE listings ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ DEFAULT NOW();

-- تحديث الإعلانات القديمة: owner_phone = phone إن كان فارغاً
UPDATE listings SET owner_phone = phone WHERE owner_phone IS NULL AND phone IS NOT NULL;

-- تأكد من صلاحيات RLS (إن لم تكن موجودة)
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE listings ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS public_read_write ON profiles;
DROP POLICY IF EXISTS public_read_write ON listings;

CREATE POLICY public_read_write ON profiles FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY public_read_write ON listings FOR ALL USING (true) WITH CHECK (true);

-- لجعل مستخدم مديراً: استبدل PHONE_NUMBER برقم هاتفك
-- UPDATE profiles SET is_admin = TRUE WHERE phone = '0XXXXXXXXX';
