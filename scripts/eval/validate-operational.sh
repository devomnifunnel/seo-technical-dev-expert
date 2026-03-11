#!/bin/bash
# Operational validation: tests runtime behavior beyond structural checks
# Verifies skills, agents, hooks, and CLAUDE.md work correctly at runtime

source "$(dirname "$0")/lib.sh"

header "Operational Validation Suite"

# ============================================================
# TEST 1: CLAUDE.md Budget
# ============================================================
info "=== CLAUDE.md Budget ==="

CLAUDE_MD="$PROJECT_DIR/.claude/CLAUDE.md"
claude_lines=$(wc -l < "$CLAUDE_MD")
if [ "$claude_lines" -le 100 ]; then
  pass "CLAUDE.md is $claude_lines lines (target: under 100)"
else
  fail "CLAUDE.md is $claude_lines lines (target: under 100)"
fi

# Check no currentDate section (system injects it)
if grep -q "^# currentDate" "$CLAUDE_MD"; then
  fail "CLAUDE.md contains hardcoded currentDate (system injects this automatically)"
else
  pass "CLAUDE.md has no hardcoded currentDate"
fi

# Check verification command present
if grep -q "validate-all.sh" "$CLAUDE_MD"; then
  pass "CLAUDE.md references validation script"
else
  fail "CLAUDE.md missing validation script reference"
fi

# Check compaction guidance present
if grep -qi "compacting.*preserve\|preserve.*compacting" "$CLAUDE_MD"; then
  pass "CLAUDE.md has compaction guidance"
else
  fail "CLAUDE.md missing compaction guidance"
fi

# ============================================================
# TEST 2: Skill Description Budget
# ============================================================
info "=== Skill Description Budget ==="

total_desc_chars=0
skill_count=0
for skill_dir in "$PROJECT_DIR"/.claude/skills/*/; do
  skill_file="$skill_dir/SKILL.md"
  [ -f "$skill_file" ] || continue
  skill_count=$((skill_count + 1))
  fm="$(get_frontmatter "$skill_file")"
  desc_line=$(echo "$fm" | grep "^description:" | head -1)
  chars=$(echo "$desc_line" | wc -c)
  total_desc_chars=$((total_desc_chars + chars))
done

budget=30000  # SLASH_COMMAND_TOOL_CHAR_BUDGET setting
if [ "$total_desc_chars" -lt "$budget" ]; then
  pct=$((total_desc_chars * 100 / budget))
  pass "Skill description budget: $total_desc_chars / $budget chars ($pct% used, $skill_count skills)"
else
  fail "Skill description budget EXCEEDED: $total_desc_chars / $budget chars ($skill_count skills)"
fi

# ============================================================
# TEST 3: Skill Line Count (Progressive Disclosure)
# ============================================================
info "=== Skill Line Counts ==="

oversized=0
for skill_dir in "$PROJECT_DIR"/.claude/skills/*/; do
  skill_file="$skill_dir/SKILL.md"
  [ -f "$skill_file" ] || continue
  skill_name="$(basename "$skill_dir")"
  lines=$(wc -l < "$skill_file")
  if [ "$lines" -gt 500 ]; then
    fail "$skill_name: $lines lines (max 500)"
    oversized=$((oversized + 1))
  fi
done
if [ "$oversized" -eq 0 ]; then
  pass "All $skill_count skills are under 500 lines"
fi

# ============================================================
# TEST 4: Progressive Disclosure (reference files accessible)
# ============================================================
info "=== Progressive Disclosure References ==="

ref_skills=0
ref_broken=0
for skill_dir in "$PROJECT_DIR"/.claude/skills/*/; do
  skill_file="$skill_dir/SKILL.md"
  [ -f "$skill_file" ] || continue
  skill_name="$(basename "$skill_dir")"
  ref_dir="$skill_dir/references"

  # Check if SKILL.md references any reference files
  if grep -q 'CLAUDE_SKILL_DIR.*references\|references/' "$skill_file" 2>/dev/null; then
    ref_skills=$((ref_skills + 1))
    if [ -d "$ref_dir" ]; then
      ref_count=$(find "$ref_dir" -name "*.md" 2>/dev/null | wc -l)
      if [ "$ref_count" -gt 0 ]; then
        pass "$skill_name: references/ dir has $ref_count files"
      else
        fail "$skill_name: references/ dir exists but is empty"
        ref_broken=$((ref_broken + 1))
      fi
    else
      fail "$skill_name: SKILL.md references files but references/ dir missing"
      ref_broken=$((ref_broken + 1))
    fi
  fi
done
if [ "$ref_skills" -gt 0 ] && [ "$ref_broken" -eq 0 ]; then
  pass "All $ref_skills skills with references have valid reference files"
fi

# ============================================================
# TEST 5: Agent Completeness (all required frontmatter)
# ============================================================
info "=== Agent Frontmatter Completeness ==="

required_agent_fields="name model description memory skills tools permissionMode maxTurns"
for agent_file in "$PROJECT_DIR"/.claude/agents/*.md; do
  [ -f "$agent_file" ] || continue
  agent_name="$(basename "$agent_file" .md)"
  fm="$(get_frontmatter "$agent_file")"

  missing=""
  for field in $required_agent_fields; do
    if ! echo "$fm" | grep -q "^${field}:"; then
      missing="$missing $field"
    fi
  done

  if [ -z "$missing" ]; then
    pass "$agent_name: all required frontmatter fields present"
  else
    fail "$agent_name: missing fields:$missing"
  fi
done

# ============================================================
# TEST 6: Skill Frontmatter Completeness
# ============================================================
info "=== Skill Frontmatter Completeness ==="

skills_with_allowed=0
skills_with_hint=0
skills_invocable=0
for skill_dir in "$PROJECT_DIR"/.claude/skills/*/; do
  skill_file="$skill_dir/SKILL.md"
  [ -f "$skill_file" ] || continue
  fm="$(get_frontmatter "$skill_file")"

  if echo "$fm" | grep -q "^allowed-tools:"; then
    skills_with_allowed=$((skills_with_allowed + 1))
  fi
  if echo "$fm" | grep -q "^argument-hint:"; then
    skills_with_hint=$((skills_with_hint + 1))
  fi
  # Count user-invocable skills (those without user-invocable: false and without disable-model-invocation: true)
  if ! echo "$fm" | grep -q "user-invocable: false"; then
    if ! echo "$fm" | grep -q "disable-model-invocation: true"; then
      skills_invocable=$((skills_invocable + 1))
    fi
  fi
done

if [ "$skills_with_allowed" -ge 28 ]; then
  pass "allowed-tools coverage: $skills_with_allowed / $skill_count skills"
else
  warn "allowed-tools coverage: $skills_with_allowed / $skill_count skills (target: 28+)"
fi

if [ "$skills_with_hint" -ge 25 ]; then
  pass "argument-hint coverage: $skills_with_hint / $skill_count skills"
else
  warn "argument-hint coverage: $skills_with_hint / $skill_count skills (target: 25+)"
fi

# ============================================================
# TEST 7: Hook Functional Tests (expanded)
# ============================================================
info "=== Hook Functional Tests ==="

HOOK_SCRIPT="$PROJECT_DIR/.claude/hooks/block-protected-files.sh"

# Should BLOCK
for test_path in "/test/.env" "/test/.env.production" "/home/user/secret.key" "/data/credentials.json" "/home/.ssh/id_rsa" "/home/.aws/config" "/certs/server.pem" "/certs/server.pfx"; do
  result=$(echo "{\"tool_input\":{\"file_path\":\"$test_path\"}}" | bash "$HOOK_SCRIPT" 2>&1; echo "EXIT:$?")
  exit_code=$(echo "$result" | grep -o "EXIT:[0-9]*" | cut -d: -f2)
  if [ "$exit_code" = "2" ]; then
    pass "Blocks: $test_path"
  else
    fail "Should block $test_path but got exit $exit_code"
  fi
done

# Should ALLOW (false positive tests)
for test_path in "/skills/netsuite-environment/SKILL.md" "/skills/keyword-research/SKILL.md" "/agents/technical-seo-auditor.md" "/clients/test/profile.md" "/frameworks/seo-audit-methodology.md"; do
  result=$(echo "{\"tool_input\":{\"file_path\":\"$test_path\"}}" | bash "$HOOK_SCRIPT" 2>&1; echo "EXIT:$?")
  exit_code=$(echo "$result" | grep -o "EXIT:[0-9]*" | cut -d: -f2)
  if [ "$exit_code" = "0" ]; then
    pass "Allows: $test_path"
  else
    fail "Should allow $test_path but got exit $exit_code"
  fi
done

# ============================================================
# TEST 8: @import Resolution
# ============================================================
info "=== @import Framework Resolution ==="

import_count=0
import_broken=0
while IFS= read -r line; do
  path=$(echo "$line" | sed 's/.*@//' | tr -d '\r')
  full_path="$PROJECT_DIR/$path"
  if [ -f "$full_path" ]; then
    import_count=$((import_count + 1))
  else
    fail "@import broken: $path"
    import_broken=$((import_broken + 1))
  fi
done < <(grep "^- .*@\." "$CLAUDE_MD")

if [ "$import_broken" -eq 0 ] && [ "$import_count" -gt 0 ]; then
  pass "All $import_count @import paths resolve correctly"
fi

# ============================================================
# TEST 9: Agent Permission Scoping
# ============================================================
info "=== Agent Permission Scoping ==="

for agent_file in "$PROJECT_DIR"/.claude/agents/*.md; do
  [ -f "$agent_file" ] || continue
  agent_name="$(basename "$agent_file" .md)"
  fm="$(get_frontmatter "$agent_file")"

  perm=$(echo "$fm" | grep "^permissionMode:" | sed 's/permissionMode: *//')
  tools_line=$(echo "$fm" | grep "^tools:")

  if [ "$perm" = "plan" ]; then
    # Plan mode = requires approval before writing. Write/Edit tools are allowed.
    if echo "$tools_line" | grep -qi "Write\|Edit"; then
      pass "$agent_name: plan mode with write tools (approval required)"
    else
      pass "$agent_name: plan mode with read-only tools"
    fi
  elif [ "$perm" = "default" ]; then
    # Default mode agents should have Write or Edit
    if echo "$tools_line" | grep -qi "Write\|Edit"; then
      pass "$agent_name: default mode with write tools"
    else
      warn "$agent_name: default mode but no write tools in list"
    fi
  fi
done

# ============================================================
# TEST 10: MEMORY.md Capacity
# ============================================================
info "=== MEMORY.md Capacity ==="

MEMORY_DIR="$HOME/.claude/projects/C--Users-mtate-OneDrive-Desktop-ClaudeCode-SEO---Technical-Dev-Expert/memory"
MEMORY_FILE="$MEMORY_DIR/MEMORY.md"
MEMORY_HARD_LIMIT=200
MEMORY_WARN_THRESHOLD=175

if [ -f "$MEMORY_FILE" ]; then
  memory_lines=$(wc -l < "$MEMORY_FILE")
  if [ "$memory_lines" -ge "$MEMORY_HARD_LIMIT" ]; then
    fail "MEMORY.md is $memory_lines lines (hard limit: $MEMORY_HARD_LIMIT). Lines after 200 are truncated!"
  elif [ "$memory_lines" -ge "$MEMORY_WARN_THRESHOLD" ]; then
    warn "MEMORY.md is $memory_lines / $MEMORY_HARD_LIMIT lines ($((MEMORY_HARD_LIMIT - memory_lines)) lines remaining before truncation)"
  else
    pass "MEMORY.md is $memory_lines / $MEMORY_HARD_LIMIT lines ($((MEMORY_HARD_LIMIT - memory_lines)) lines remaining)"
  fi
else
  warn "MEMORY.md not found at expected path"
fi

# ============================================================
# TEST 11: Global Settings Alignment
# ============================================================
info "=== Global Settings ==="

global_settings="$HOME/.claude/settings.json"
if [ -f "$global_settings" ]; then
  if grep -q "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS" "$global_settings"; then
    pass "Agent Teams enabled in global settings"
  else
    fail "Agent Teams NOT enabled in global settings"
  fi

  if grep -q "alwaysThinkingEnabled" "$global_settings"; then
    pass "Extended thinking enabled in global settings"
  else
    fail "Extended thinking NOT enabled in global settings"
  fi

  if grep -q "CLAUDE_CODE_EFFORT_LEVEL" "$global_settings"; then
    pass "Effort level configured in global settings"
  else
    fail "Effort level NOT configured in global settings"
  fi

  if grep -q "SLASH_COMMAND_TOOL_CHAR_BUDGET" "$global_settings"; then
    pass "Skill description budget override configured"
  else
    warn "SLASH_COMMAND_TOOL_CHAR_BUDGET not set (using default 15000)"
  fi
fi

# ============================================================
# SUMMARY
# ============================================================
summary "OPERATIONAL"
exit $?
