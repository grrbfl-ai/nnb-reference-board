-- 노는법 레퍼런스 창고 · Supabase 설정 (팀 공유용)
-- Supabase 왼쪽 메뉴 SQL Editor → New query → 이 내용 전체 붙여넣기 → Run
-- 여러 번 실행해도 괜찮아요.

-- 1) 레퍼런스 테이블
create table if not exists public.refs (
  id          uuid primary key default gen_random_uuid(),
  created_by  uuid default auth.uid() references auth.users(id) on delete set null,
  author      text not null default coalesce(auth.jwt() ->> 'email', ''),
  category    text not null check (category in ('organic','paid')),
  url         text not null default '',
  title       text not null,
  source      text not null default '',   -- 계정 · 광고주
  period      text not null default '',   -- 광고 게재 기간 (paid-ads)
  tags        text[] not null default '{}', -- 예: format:릴스, point:카피, appeal:부정화법, 그리고 자유 태그
  why         text not null default '',
  idea        text not null default '',
  copy_text   text not null default '',   -- 카피 · 스크립트 옮겨두기
  image_path  text not null default '',
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

create index if not exists refs_cat_created_idx on public.refs (category, created_at desc);

grant select, insert, update, delete on public.refs to authenticated;

-- 2) 권한: 로그인한 팀원은 전부 보고, 쓰고, 고치고, 지울 수 있음
alter table public.refs enable row level security;

drop policy if exists "refs_team_select" on public.refs;
drop policy if exists "refs_team_insert" on public.refs;
drop policy if exists "refs_team_update" on public.refs;
drop policy if exists "refs_team_delete" on public.refs;

create policy "refs_team_select" on public.refs for select to authenticated using (true);
create policy "refs_team_insert" on public.refs for insert to authenticated with check (true);
create policy "refs_team_update" on public.refs for update to authenticated using (true) with check (true);
create policy "refs_team_delete" on public.refs for delete to authenticated using (true);

-- 3) 캡처 이미지 보관함 (비공개, 팀원만)
insert into storage.buckets (id, name, public)
values ('ref-images', 'ref-images', false)
on conflict (id) do nothing;

drop policy if exists "ref_images_team_select" on storage.objects;
drop policy if exists "ref_images_team_insert" on storage.objects;
drop policy if exists "ref_images_team_update" on storage.objects;
drop policy if exists "ref_images_team_delete" on storage.objects;

create policy "ref_images_team_select" on storage.objects for select to authenticated using (bucket_id = 'ref-images');
create policy "ref_images_team_insert" on storage.objects for insert to authenticated with check (bucket_id = 'ref-images');
create policy "ref_images_team_update" on storage.objects for update to authenticated using (bucket_id = 'ref-images');
create policy "ref_images_team_delete" on storage.objects for delete to authenticated using (bucket_id = 'ref-images');
