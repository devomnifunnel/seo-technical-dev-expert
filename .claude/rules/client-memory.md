---
paths:
  - "clients/**"
---

# Client Memory Management Rules

These rules govern how client-specific context is stored, retrieved, pruned, and
maintained across sessions to ensure continuity and efficiency.

---

## Client Name Variant Resolution

- Maintain a mapping of client name variants to canonical client identifiers.
  Example: "ABC Corp", "ABC", "abc-corp", "ABC Corporation" all resolve to the same client.
- When a client is referenced by any known variant, always resolve to the canonical name
  before performing any lookup or file operation.
- If an unknown name is used that partially matches an existing client (fuzzy match above 80%
  similarity), ask for confirmation before assuming identity.
- Store the canonical name and all known variants in the client's history file header.

## Multi-Division Clients

- Some clients operate multiple brands, divisions, or websites under one account.
- Each division gets its own history section within the parent client file, prefixed with the
  division identifier: `[division:brand-name]`.
- Cross-division insights should be surfaced proactively. If an issue affects one division,
  check whether the same issue might affect sibling divisions.
- Maintain a parent-level summary that aggregates key metrics across all divisions.
- When the user references a client without specifying a division, ask which division applies
  if the action is division-specific. For general inquiries, report across all divisions.

## History File Structure

- Location: `clients/{client-canonical-name}/history.md`
- Header block: client canonical name, known variants, divisions, primary contacts, active since.
- Entries are chronological, newest first, formatted as:
  ```
  ## YYYY-MM-DD | Session Topic
  - Key actions taken
  - Findings and anomalies flagged
  - Metrics snapshot (if relevant)
  - Open items / follow-ups
  ```

## History File Pruning

- **Archive threshold**: When a history file exceeds 500 lines, trigger archival.
- **Active window**: Keep the most recent 90 days of entries in the active history file.
- **Archive process**: Move entries older than 90 days to `clients/{name}/archive/history-{year}-{quarter}.md`.
- **Archive retention**: Keep archived files indefinitely. They may be referenced for trend analysis.
- **Pruning frequency**: Check file length at the start of each session. If over threshold,
  prune before proceeding with the session.
- **Never delete**: History entries are never deleted, only moved to archive.

## Cross-Client Pattern Detection

- When the same issue is detected across 3 or more clients, log it as a systemic pattern.
- Systemic patterns are stored in `_patterns/systemic-log.md` with:
  - Pattern description
  - Date first detected
  - Affected clients (anonymized in shared reports)
  - Root cause (if identified)
  - Resolution or mitigation applied
- Examples of systemic patterns:
  - Google algorithm update impacts (multiple clients losing rankings simultaneously)
  - Platform-wide bugs (e.g., NetSuite SuiteCommerce update breaking schema markup)
  - Third-party service outages (e.g., Prerender.io downtime affecting multiple SPAs)
  - Common misconfigurations appearing in new client onboarding
- When a systemic pattern is active, proactively mention it during relevant client sessions.

## Inactive Client Archival

- A client is considered inactive after 6 consecutive months with no session activity.
- Inactive clients are moved to `_archived/{client-canonical-name}/`.
- The archived folder preserves the full directory structure (history, archive, assets).
- If an archived client becomes active again, restore their folder to the main `clients/` directory
  and note the reactivation date in the history file.
- Run an inactivity check monthly. List clients approaching the 6-month threshold (5+ months
  inactive) as candidates for archival review.

## Session Continuity Protocol

- **Before every client engagement**: Re-read the client's active history file to load context.
  This is mandatory and must happen before any analysis or recommendation is given.
- **During session**: Append key findings, actions, and decisions to a running session buffer.
- **After session**: Write the session buffer to the history file as a new dated entry.
- **Context loading priority**: Most recent 5 entries get full detail review. Entries 6-20 get
  summary scan. Older entries are available on demand.
- **Cross-reference**: If the current session topic relates to a previous session's open items,
  explicitly reference and close or update those items.
- **Never assume**: If the history file is missing or empty, inform the user and ask for context
  rather than proceeding with assumptions.

## Data Integrity

- Always use UTF-8 encoding for history files.
- Escape any client-sensitive data (credentials, internal URLs) before writing to history.
- Include a last-modified timestamp at the top of each history file.
- If a file write fails, alert the user immediately and retain the session buffer for retry.
- Back up the clients directory structure before any bulk archival operation.
