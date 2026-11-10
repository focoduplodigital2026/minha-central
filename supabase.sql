-- Execute este script no SQL Editor do seu projeto Supabase.
-- As políticas RLS isolam os dados por usuário autenticado.
create extension if not exists pgcrypto;

create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null check (char_length(title) between 1 and 160),
  description text not null default '',
  category text not null default 'Casa' check (category in ('Trabalho','Casa','Moto RUVA','Financeiro','Agenda')),
  priority text not null default 'normal' check (priority in ('low','normal','high')),
  due_at timestamptz,
  completed boolean not null default false,
  recurrence text not null default 'none' check (recurrence in ('none','daily','weekly','monthly')),
  google_event_id text,
  created_at timestamptz not null default now()
);
create index if not exists tasks_user_due_idx on public.tasks(user_id,due_at);
alter table public.tasks enable row level security;

create policy "tasks_select_own" on public.tasks for select to authenticated using ((select auth.uid()) = user_id);
create policy "tasks_insert_own" on public.tasks for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "tasks_update_own" on public.tasks for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "tasks_delete_own" on public.tasks for delete to authenticated using ((select auth.uid()) = user_id);
