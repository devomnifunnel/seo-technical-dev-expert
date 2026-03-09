#!/bin/bash
# Validates all .claude/agents/*.md files
# Checks: frontmatter, name (kebab-case), model, memory, description, permissionMode

source "$(dirname "$0")/lib.sh"

header "Validating Agents"

AGENT_FILES=("$PROJECT_DIR"/.claude/agents/*.md)

if [ ${#AGENT_FILES[@]} -eq 0 ] || [ ! -f "${AGENT_FILES[0]}" ]; then
  warn "No agent files found in .claude/agents/"
  summary "AGENTS"
  exit $?
fi

VALID_MODELS="opus sonnet haiku inherit"
VALID_PERMISSION_MODES="plan default bypassPermissions"

for agent_file in "${AGENT_FILES[@]}"; do
  agent_name="$(basename "$agent_file" .md)"

  info "Checking agent: $agent_name"

  # Check has YAML frontmatter
  if ! has_frontmatter "$agent_file"; then
    fail "$agent_name: missing YAML frontmatter (file must start with ---)"
    continue
  fi
  pass "$agent_name: has YAML frontmatter"

  fm="$(get_frontmatter "$agent_file")"

  # Check name: field exists and is kebab-case
  name_val="$(get_field "$fm" "name")"
  if [ -z "$name_val" ]; then
    fail "$agent_name: missing 'name' field in frontmatter"
  elif ! is_kebab_case "$name_val"; then
    fail "$agent_name: name '$name_val' is not kebab-case"
  else
    pass "$agent_name: name '$name_val' is valid kebab-case"
  fi

  # Check model: field is one of the valid values
  model_val="$(get_field "$fm" "model")"
  if [ -z "$model_val" ]; then
    fail "$agent_name: missing 'model' field in frontmatter"
  elif echo "$VALID_MODELS" | grep -qw "$model_val"; then
    pass "$agent_name: model '$model_val' is valid"
  else
    fail "$agent_name: model '$model_val' is not valid (expected: $VALID_MODELS)"
  fi

  # Check memory: field exists
  memory_val="$(get_field "$fm" "memory")"
  if [ -z "$memory_val" ]; then
    fail "$agent_name: missing 'memory' field in frontmatter"
  else
    pass "$agent_name: memory is '$memory_val'"
  fi

  # Check description: field exists
  desc_val="$(get_field "$fm" "description")"
  if [ -z "$desc_val" ]; then
    fail "$agent_name: missing 'description' field in frontmatter"
  else
    pass "$agent_name: has description"
  fi

  # If permissionMode: field exists, validate its value
  perm_val="$(get_field "$fm" "permissionMode")"
  if [ -n "$perm_val" ]; then
    if echo "$VALID_PERMISSION_MODES" | grep -qw "$perm_val"; then
      pass "$agent_name: permissionMode '$perm_val' is valid"
    else
      fail "$agent_name: permissionMode '$perm_val' is not valid (expected: $VALID_PERMISSION_MODES)"
    fi
  fi

  # Check for background + plan conflict (background agents auto-deny permission prompts)
  bg_val="$(get_field "$fm" "background")"
  if [ "$bg_val" = "true" ] && [ "$perm_val" = "plan" ]; then
    fail "$agent_name: background=true conflicts with permissionMode=plan (background agents auto-deny prompts)"
  fi

done

summary "AGENTS"
exit $?
