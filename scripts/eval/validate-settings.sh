#!/bin/bash
# Validates settings files (project and global)
source "$(dirname "$0")/lib.sh"

header "JSON Validity"

# 1. Check .claude/settings.local.json is valid JSON
PROJECT_SETTINGS="$PROJECT_DIR/.claude/settings.local.json"
if [ -f "$PROJECT_SETTINGS" ]; then
  if python -m json.tool "$PROJECT_SETTINGS" >/dev/null 2>&1; then
    pass "Project settings (settings.local.json) is valid JSON"
  else
    fail "Project settings (settings.local.json) is NOT valid JSON"
  fi
else
  fail "Project settings file not found: .claude/settings.local.json"
fi

# 2. Check ~/.claude/settings.json is valid JSON
GLOBAL_SETTINGS="$HOME/.claude/settings.json"
if [ -f "$GLOBAL_SETTINGS" ]; then
  if python -m json.tool "$GLOBAL_SETTINGS" >/dev/null 2>&1; then
    pass "Global settings (~/.claude/settings.json) is valid JSON"
  else
    fail "Global settings (~/.claude/settings.json) is NOT valid JSON"
  fi
else
  fail "Global settings file not found: ~/.claude/settings.json"
fi

header "Global Settings Checks"

# 3. Verify there is no top-level "effortLevel" field in global settings
if [ -f "$GLOBAL_SETTINGS" ]; then
  has_top_level_effort=$(python -c "
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
print('yes' if 'effortLevel' in data else 'no')
" "$GLOBAL_SETTINGS" 2>/dev/null)

  if [ "$has_top_level_effort" = "no" ]; then
    pass "Global settings has no top-level effortLevel (correctly moved to env)"
  else
    fail "Global settings has top-level effortLevel (should be in env.CLAUDE_CODE_EFFORT_LEVEL)"
  fi

  # 4. Verify env.CLAUDE_CODE_EFFORT_LEVEL exists in global settings
  has_env_effort=$(python -c "
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
env = data.get('env', {})
print('yes' if 'CLAUDE_CODE_EFFORT_LEVEL' in env else 'no')
" "$GLOBAL_SETTINGS" 2>/dev/null)

  if [ "$has_env_effort" = "yes" ]; then
    effort_value=$(python -c "
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
print(data['env']['CLAUDE_CODE_EFFORT_LEVEL'])
" "$GLOBAL_SETTINGS" 2>/dev/null)
    pass "Global settings has env.CLAUDE_CODE_EFFORT_LEVEL = $effort_value"
  else
    fail "Global settings missing env.CLAUDE_CODE_EFFORT_LEVEL"
  fi
fi

header "Project Settings Structure"

# 5. Verify hooks.PreToolUse exists in project settings
if [ -f "$PROJECT_SETTINGS" ]; then
  has_pretooluse=$(python -c "
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
hooks = data.get('hooks', {})
print('yes' if 'PreToolUse' in hooks else 'no')
" "$PROJECT_SETTINGS" 2>/dev/null)

  if [ "$has_pretooluse" = "yes" ]; then
    pass "Project settings has hooks.PreToolUse"
  else
    fail "Project settings missing hooks.PreToolUse"
  fi

  # 6. Verify permissions.allow and permissions.deny exist
  has_allow=$(python -c "
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
perms = data.get('permissions', {})
print('yes' if 'allow' in perms and len(perms['allow']) > 0 else 'no')
" "$PROJECT_SETTINGS" 2>/dev/null)

  if [ "$has_allow" = "yes" ]; then
    allow_count=$(python -c "
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
print(len(data['permissions']['allow']))
" "$PROJECT_SETTINGS" 2>/dev/null)
    pass "Project settings has permissions.allow ($allow_count rules)"
  else
    fail "Project settings missing or empty permissions.allow"
  fi

  has_deny=$(python -c "
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
perms = data.get('permissions', {})
print('yes' if 'deny' in perms and len(perms['deny']) > 0 else 'no')
" "$PROJECT_SETTINGS" 2>/dev/null)

  if [ "$has_deny" = "yes" ]; then
    deny_count=$(python -c "
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
print(len(data['permissions']['deny']))
" "$PROJECT_SETTINGS" 2>/dev/null)
    pass "Project settings has permissions.deny ($deny_count rules)"
  else
    fail "Project settings missing or empty permissions.deny"
  fi
fi

header "Security Deny Patterns"

# 7. Check permissions.deny includes patterns for .env, .ssh, credentials
if [ -f "$PROJECT_SETTINGS" ]; then
  deny_json=$(python -c "
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
deny = data.get('permissions', {}).get('deny', [])
for rule in deny:
    print(rule)
" "$PROJECT_SETTINGS" 2>/dev/null)

  # Check for .env pattern
  if echo "$deny_json" | grep -qi '\.env'; then
    pass "permissions.deny includes .env pattern"
  else
    fail "permissions.deny missing .env pattern"
  fi

  # Check for .ssh pattern
  if echo "$deny_json" | grep -qi '\.ssh'; then
    pass "permissions.deny includes .ssh pattern"
  else
    fail "permissions.deny missing .ssh pattern"
  fi

  # Check for credentials pattern
  if echo "$deny_json" | grep -qi 'credentials'; then
    pass "permissions.deny includes credentials pattern"
  else
    fail "permissions.deny missing credentials pattern"
  fi
fi

summary "SETTINGS"
