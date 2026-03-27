-- Game 2 Supabase setup
create table if not exists public.leaderboard_game2 (
  team_id text primary key,
  team_name text not null,
  found integer not null default 0,
  finished boolean not null default false,
  last_updated_at bigint not null
);

create table if not exists public.team_progress_game2 (
  team_id text primary key,
  team_name text not null,
  progress_index integer not null default 0,
  completed jsonb not null default '[]'::jsonb,
  scanned_tokens jsonb not null default '[]'::jsonb,
  used_hints integer not null default 0,
  next_hint_at bigint,
  finished boolean not null default false,
  started_at bigint not null,
  last_updated_at bigint not null,
  map_enabled boolean
);

alter table public.leaderboard_game2 enable row level security;
alter table public.team_progress_game2 enable row level security;

drop policy if exists "leaderboard_game2 read" on public.leaderboard_game2;
create policy "leaderboard_game2 read" on public.leaderboard_game2 for select to anon using (true);

drop policy if exists "leaderboard_game2 insert" on public.leaderboard_game2;
create policy "leaderboard_game2 insert" on public.leaderboard_game2 for insert to anon with check (true);

drop policy if exists "leaderboard_game2 update" on public.leaderboard_game2;
create policy "leaderboard_game2 update" on public.leaderboard_game2 for update to anon using (true) with check (true);

drop policy if exists "progress_game2 read" on public.team_progress_game2;
create policy "progress_game2 read" on public.team_progress_game2 for select to anon using (true);

drop policy if exists "progress_game2 insert" on public.team_progress_game2;
create policy "progress_game2 insert" on public.team_progress_game2 for insert to anon with check (true);

drop policy if exists "progress_game2 update" on public.team_progress_game2;
create policy "progress_game2 update" on public.team_progress_game2 for update to anon using (true) with check (true);

-- Add these only if Supabase says the tables are not already in realtime.
-- alter publication supabase_realtime add table public.leaderboard_game2;
-- alter publication supabase_realtime add table public.team_progress_game2;

insert into public.team_progress_game2
  (team_id, team_name, progress_index, completed, scanned_tokens, used_hints, next_hint_at, finished, started_at, last_updated_at, map_enabled)
values
  ('Team1', 'Team 1', 0, '[]'::jsonb, '[]'::jsonb, 0, null, false, 0, 0, true),
  ('Team2', 'Team 2', 0, '[]'::jsonb, '[]'::jsonb, 0, null, false, 0, 0, true),
  ('Team3', 'Team 3', 0, '[]'::jsonb, '[]'::jsonb, 0, null, false, 0, 0, true),
  ('Team4', 'Team 4', 0, '[]'::jsonb, '[]'::jsonb, 0, null, false, 0, 0, true),
  ('Team5', 'Team 5', 0, '[]'::jsonb, '[]'::jsonb, 0, null, false, 0, 0, true),
  ('__settings__', 'Shared Settings', 0, '[]'::jsonb, '[]'::jsonb, 0, null, false, 0, 0, true)
on conflict (team_id) do nothing;

insert into public.leaderboard_game2
  (team_id, team_name, found, finished, last_updated_at)
values
  ('Team1', 'Team 1', 0, false, 0),
  ('Team2', 'Team 2', 0, false, 0),
  ('Team3', 'Team 3', 0, false, 0),
  ('Team4', 'Team 4', 0, false, 0),
  ('Team5', 'Team 5', 0, false, 0)
on conflict (team_id) do nothing;

-- Reset Game 2
-- update public.team_progress_game2
-- set
--   progress_index = 0,
--   completed = '[]'::jsonb,
--   scanned_tokens = '[]'::jsonb,
--   used_hints = 0,
--   next_hint_at = null,
--   finished = false,
--   started_at = 0,
--   last_updated_at = 0;
-- 
-- update public.leaderboard_game2
-- set
--   found = 0,
--   finished = false,
--   last_updated_at = 0;
-- 
-- update public.team_progress_game2
-- set map_enabled = true
-- where team_id = '__settings__';
