create table if not exists public.leads (
  id uuid primary key default gen_random_uuid(),
  lead_id text not null unique,
  brand_name text,
  website text,
  category text,
  country text,
  lead_source text,
  status text,
  research_status text,
  creative_fit smallint check (creative_fit between 0 and 100),
  commercial_signal smallint check (commercial_signal between 0 and 100),
  timing_signal smallint check (timing_signal between 0 and 100),
  buyer_intent_evidence smallint check (buyer_intent_evidence between 0 and 100),
  accessibility smallint check (accessibility between 0 and 100),
  confidence text check (confidence in ('LOW','MEDIUM','HIGH')),
  decision text check (decision in ('GO','HOLD','REJECT')),
  decision_reason text,
  best_outreach_angle text,
  lead_score numeric(5,1),
  score_band text check (score_band in ('A','B','C','D')),
  action text check (action in ('CONTACT_NOW','PREPARE_TARGETED_OUTREACH','WATCHLIST','LOW_PRIORITY','REJECT')),
  research_text text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.leads enable row level security;

revoke all on table public.leads from anon, authenticated;
grant all on table public.leads to service_role;

create index if not exists leads_action_idx on public.leads(action);
create index if not exists leads_score_band_idx on public.leads(score_band);
create index if not exists leads_created_at_idx on public.leads(created_at desc);
