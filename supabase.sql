-- Execute no SQL Editor do seu projeto Supabase.
-- Crie seu usuário SOMENTE pelo painel Authentication > Users.
create table if not exists public.finance_state (
 user_id uuid primary key references auth.users(id) on delete cascade,
 data jsonb not null default '{}'::jsonb,
 updated_at timestamptz not null default now()
);
alter table public.finance_state enable row level security;
revoke all on public.finance_state from anon;
grant select,insert,update,delete on public.finance_state to authenticated;
drop policy if exists "owner_select" on public.finance_state;
drop policy if exists "owner_insert" on public.finance_state;
drop policy if exists "owner_update" on public.finance_state;
drop policy if exists "owner_delete" on public.finance_state;
create policy "owner_select" on public.finance_state for select to authenticated using (auth.uid() = user_id);
create policy "owner_insert" on public.finance_state for insert to authenticated with check (auth.uid() = user_id);
create policy "owner_update" on public.finance_state for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "owner_delete" on public.finance_state for delete to authenticated using (auth.uid() = user_id);
create or replace function public.finance_touch_updated_at() returns trigger language plpgsql as $$ begin new.updated_at=clock_timestamp(); return new; end $$;
drop trigger if exists finance_touch_updated_at on public.finance_state;
create trigger finance_touch_updated_at before update on public.finance_state for each row execute procedure public.finance_touch_updated_at();
