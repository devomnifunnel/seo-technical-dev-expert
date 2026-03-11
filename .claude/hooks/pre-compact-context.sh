#!/bin/bash
# PreCompact Hook v2: Dynamic context preservation
# Reads actual working state instead of static string
# Output is fed back to Claude as context to preserve through compaction

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"

echo "=== CRITICAL CONTEXT TO PRESERVE ==="
echo ""

# Core identity (always preserved)
echo "PROJECT: OFM SEO & Technical Dev Expert"
echo "RULES: No dashes in prose | Never modify live client systems without approval | .docx drafts | ES5 for Chrome/GTM"
echo "ASANA: Board GID=1213561988868639 | Workspace=1206269095077183 | Use mcp__claude_ai_Asana__ only"
echo "ORCHESTRATION: Swarm mode default | Opus lead, Sonnet execution, Haiku exploration | Parallel over sequential"
echo ""

# Dynamic: Planning with Files working memory (if present)
if [ -f "$PROJECT_DIR/task_plan.md" ]; then
  echo "=== ACTIVE TASK PLAN ==="
  head -40 "$PROJECT_DIR/task_plan.md"
  echo ""
fi

if [ -f "$PROJECT_DIR/findings.md" ]; then
  echo "=== CURRENT FINDINGS (last 30 lines) ==="
  tail -30 "$PROJECT_DIR/findings.md"
  echo ""
fi

if [ -f "$PROJECT_DIR/progress.md" ]; then
  echo "=== PROGRESS LOG (last 20 lines) ==="
  tail -20 "$PROJECT_DIR/progress.md"
  echo ""
fi

# Dynamic: Detect active client by recently modified files
echo "=== ACTIVE CLIENTS ==="
for client_dir in "$PROJECT_DIR/clients"/*/; do
  [ -d "$client_dir" ] || continue
  client_name="$(basename "$client_dir")"
  [ "$client_name" = "_template" ] && continue
  [ "$client_name" = "_patterns" ] && continue
  [ "$client_name" = "_archived" ] && continue

  # Check if CLAUDE.md or history.md was modified in last 2 hours (120 min)
  client_claude="${client_dir}CLAUDE.md"
  client_history="${client_dir}history.md"
  recently_active=false

  if [ -f "$client_claude" ]; then
    # Use python for cross-platform timestamp check (works on Windows bash too)
    is_recent=$(python -c "
import os, time
try:
    mtime = os.path.getmtime('$client_claude')
    print('yes' if (time.time() - mtime) < 7200 else 'no')
except:
    print('no')
" 2>/dev/null)
    [ "$is_recent" = "yes" ] && recently_active=true
  fi

  if [ -f "$client_history" ]; then
    is_recent=$(python -c "
import os, time
try:
    mtime = os.path.getmtime('$client_history')
    print('yes' if (time.time() - mtime) < 7200 else 'no')
except:
    print('no')
" 2>/dev/null)
    [ "$is_recent" = "yes" ] && recently_active=true
  fi

  if [ "$recently_active" = true ]; then
    echo "ACTIVE: $client_name"
    if [ -f "$client_claude" ]; then
      head -10 "$client_claude" | grep -v "^#" | head -5
    fi
    echo ""
  fi
done

# Dynamic: Recent git activity (what files were changed this session)
recent_changes=$(cd "$PROJECT_DIR" && git diff --name-only HEAD 2>/dev/null | head -10)
if [ -n "$recent_changes" ]; then
  echo "=== UNCOMMITTED CHANGES ==="
  echo "$recent_changes"
  echo ""
fi

staged_changes=$(cd "$PROJECT_DIR" && git diff --cached --name-only 2>/dev/null | head -10)
if [ -n "$staged_changes" ]; then
  echo "=== STAGED CHANGES ==="
  echo "$staged_changes"
  echo ""
fi

# Hook profile: minimal mode outputs only core identity and active task plan
PROFILE="${OFM_HOOK_PROFILE:-standard}"
if [ "$PROFILE" = "minimal" ]; then
  if [ -f "$PROJECT_DIR/task_plan.md" ]; then
    echo "=== ACTIVE TASK PLAN ==="
    head -20 "$PROJECT_DIR/task_plan.md"
  fi
  exit 0
fi

echo "HOOK PROFILE: ${PROFILE}"
echo ""

echo "=== REFERENCE PATHS ==="
echo "Agents: .claude/agents/ | Skills: .claude/skills/ | Frameworks: .claude/frameworks/"
echo "Scripts: scripts/chrome/ | Templates: templates/ | Clients: clients/ | Rules: .claude/rules/"
echo "Memory: MEMORY.md (auto) | Instincts: .claude/memory/instincts.md"
