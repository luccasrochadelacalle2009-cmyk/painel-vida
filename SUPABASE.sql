-- Execute este arquivo uma vez no SQL Editor do seu projeto Supabase.
-- Ele cria a tabela onde o app guarda os dados de cada usuário.

create table if not exists public.painel_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  rev bigint not null default 0,
  device text
);

alter table public.painel_data enable row level security;

drop policy if exists "painel_select_own" on public.painel_data;
create policy "painel_select_own"
  on public.painel_data for select
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists "painel_insert_own" on public.painel_data;
create policy "painel_insert_own"
  on public.painel_data for insert
  to authenticated
  with check (auth.uid() = user_id);

drop policy if exists "painel_update_own" on public.painel_data;
create policy "painel_update_own"
  on public.painel_data for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "painel_delete_own" on public.painel_data;
create policy "painel_delete_own"
  on public.painel_data for delete
  to authenticated
  using (auth.uid() = user_id);

grant select, insert, update, delete on public.painel_data to authenticated;

-- Observação importante:
-- Nunca use a chave service_role no app. Use somente a chave anon/publishable.
-- A segurança vem das policies RLS acima: cada usuário acessa apenas a própria linha.
