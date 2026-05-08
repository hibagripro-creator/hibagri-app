-- هيباغري v6 — تحديث قاعدة البيانات
-- شغّل هذا الملف في Supabase SQL Editor

-- إضافة عمود is_featured للإعلانات
ALTER TABLE listings ADD COLUMN IF NOT EXISTS is_featured BOOLEAN DEFAULT FALSE;

-- الإعلانات المميزة تظهر أولاً
-- (اختياري: يمكن إضافة index لتسريع الفرز)
CREATE INDEX IF NOT EXISTS idx_listings_featured ON listings (is_featured DESC, created_at DESC);
