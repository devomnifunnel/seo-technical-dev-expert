#!/bin/bash
# Validates hook scripts and their configuration
source "$(dirname "$0")/lib.sh"

header "Hook Dependencies"

# 1. Check python is available (CRITICAL for block-protected-files.sh)
if command -v python &>/dev/null; then
  pass "python is available: $(python --version 2>&1)"
else
  fail "python is NOT available (CRITICAL: block-protected-files.sh requires python for JSON parsing)"
fi

header "Hook Script Syntax & Content"

# 2. For each .sh file in .claude/hooks/, syntax check and verify non-empty
HOOKS_DIR="$PROJECT_DIR/.claude/hooks"
if [ -d "$HOOKS_DIR" ]; then
  for hook_file in "$HOOKS_DIR"/*.sh; do
    [ -f "$hook_file" ] || continue
    hook_name="$(basename "$hook_file")"

    # Check file is not empty
    if [ -s "$hook_file" ]; then
      pass "$hook_name is not empty ($(wc -l < "$hook_file") lines)"
    else
      fail "$hook_name is empty"
    fi

    # Syntax check with bash -n
    syntax_output=$(bash -n "$hook_file" 2>&1)
    if [ $? -eq 0 ]; then
      pass "$hook_name passes bash syntax check"
    else
      fail "$hook_name has syntax errors: $syntax_output"
    fi
  done
else
  fail ".claude/hooks/ directory does not exist"
fi

header "block-protected-files.sh Functional Tests"

# 3. Test block-protected-files.sh with mock inputs
PROTECTED_HOOK="$HOOKS_DIR/block-protected-files.sh"
if [ -f "$PROTECTED_HOOK" ]; then

  # Test .env file (should be blocked, exit 2)
  echo '{"tool_input":{"file_path":"/home/user/.env"}}' | bash "$PROTECTED_HOOK" >/dev/null 2>&1
  exit_code=$?
  if [ $exit_code -eq 2 ]; then
    pass "Blocks .env file (exit code 2)"
  else
    fail "Did not block .env file (expected exit 2, got $exit_code)"
  fi

  # Test safe file (should be allowed, exit 0)
  echo '{"tool_input":{"file_path":"/home/user/readme.md"}}' | bash "$PROTECTED_HOOK" >/dev/null 2>&1
  exit_code=$?
  if [ $exit_code -eq 0 ]; then
    pass "Allows safe file readme.md (exit code 0)"
  else
    fail "Incorrectly blocked safe file readme.md (expected exit 0, got $exit_code)"
  fi

  # Test credentials path (should be blocked, exit 2)
  echo '{"tool_input":{"file_path":"/project/credentials.json"}}' | bash "$PROTECTED_HOOK" >/dev/null 2>&1
  exit_code=$?
  if [ $exit_code -eq 2 ]; then
    pass "Blocks credentials.json file (exit code 2)"
  else
    fail "Did not block credentials.json (expected exit 2, got $exit_code)"
  fi

else
  fail "block-protected-files.sh not found at $PROTECTED_HOOK"
fi

header "block-gtm-modifications.sh Functional Tests"

# 4. Verify block-gtm-modifications.sh exits with code 2
GTM_HOOK="$HOOKS_DIR/block-gtm-modifications.sh"
if [ -f "$GTM_HOOK" ]; then
  bash "$GTM_HOOK" >/dev/null 2>&1
  exit_code=$?
  if [ $exit_code -eq 2 ]; then
    pass "block-gtm-modifications.sh blocks with exit code 2"
  else
    fail "block-gtm-modifications.sh expected exit 2, got $exit_code"
  fi
else
  fail "block-gtm-modifications.sh not found at $GTM_HOOK"
fi

header "Settings & Hook File References"

# 5. Check .claude/settings.local.json exists and is valid JSON
SETTINGS_FILE="$PROJECT_DIR/.claude/settings.local.json"
if [ -f "$SETTINGS_FILE" ]; then
  pass "settings.local.json exists"
  if python -m json.tool "$SETTINGS_FILE" >/dev/null 2>&1; then
    pass "settings.local.json is valid JSON"
  else
    fail "settings.local.json is NOT valid JSON"
  fi
else
  fail "settings.local.json not found"
fi

# 6. For each hook command in settings.local.json, extract script path and verify it exists
if [ -f "$SETTINGS_FILE" ]; then
  # Extract all command strings from hooks, pull out script file paths
  script_paths=$(SETTINGS_INPUT="$SETTINGS_FILE" python -c '
import json, re, os
sf = os.environ["SETTINGS_INPUT"]
with open(sf) as f:
    data = json.load(f)
hooks = data.get("hooks", {})
for event, entries in hooks.items():
    for entry in entries:
        for hook in entry.get("hooks", []):
            cmd = hook.get("command", "")
            if cmd:
                match = re.search(r"\"([^\"]+)\"", cmd)
                if match:
                    path = match.group(1)
                    path = re.sub(r"^\$\{?CLAUDE_PROJECT_DIR\}?/", "", path)
                    print(event + "|" + path)
' 2>/dev/null)

  if [ -n "$script_paths" ]; then
    while IFS='|' read -r event rel_path; do
      rel_path="${rel_path%$'\r'}"
      full_path="$PROJECT_DIR/$rel_path"
      if [ -f "$full_path" ]; then
        pass "Hook script exists: $rel_path (event: $event)"
      else
        fail "Hook script NOT found: $rel_path (event: $event)"
      fi
    done <<< "$script_paths"
  else
    warn "No command-type hooks found in settings.local.json (or parsing failed)"
  fi
fi

summary "HOOKS"
