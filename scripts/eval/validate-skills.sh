#!/bin/bash
# Validates all .claude/skills/*/SKILL.md files
# Checks: existence, frontmatter, name (kebab-case), description, trigger phrases

source "$(dirname "$0")/lib.sh"

header "Validating Skills"

SKILL_DIRS=("$PROJECT_DIR"/.claude/skills/*/)

if [ ${#SKILL_DIRS[@]} -eq 0 ] || [ ! -d "${SKILL_DIRS[0]}" ]; then
  warn "No skill directories found in .claude/skills/"
  summary "SKILLS"
  exit $?
fi

for skill_dir in "${SKILL_DIRS[@]}"; do
  skill_name="$(basename "$skill_dir")"
  skill_file="$skill_dir/SKILL.md"

  info "Checking skill: $skill_name"

  # Check SKILL.md exists
  if [ ! -f "$skill_file" ]; then
    fail "$skill_name: SKILL.md not found in directory"
    continue
  fi
  pass "$skill_name: SKILL.md exists"

  # Check has YAML frontmatter
  if ! has_frontmatter "$skill_file"; then
    fail "$skill_name: missing YAML frontmatter (file must start with ---)"
    continue
  fi
  pass "$skill_name: has YAML frontmatter"

  fm="$(get_frontmatter "$skill_file")"

  # Check name: field exists and is kebab-case
  name_val="$(get_field "$fm" "name")"
  if [ -z "$name_val" ]; then
    fail "$skill_name: missing 'name' field in frontmatter"
  elif ! is_kebab_case "$name_val"; then
    fail "$skill_name: name '$name_val' is not kebab-case"
  else
    pass "$skill_name: name '$name_val' is valid kebab-case"
  fi

  # Check description: field exists (handles single-line and multi-line YAML)
  if ! echo "$fm" | grep -q '^description:'; then
    fail "$skill_name: missing 'description' field in frontmatter"
    continue
  fi
  pass "$skill_name: has description"

  # Check description contains trigger phrases
  # For multi-line descriptions (using > or |), scan the full frontmatter block
  if echo "$fm" | grep -qi "trigger on\|use when"; then
    pass "$skill_name: description contains trigger phrases"
  else
    warn "$skill_name: description lacks trigger phrases ('trigger on' or 'use when')"
  fi

done

summary "SKILLS"
exit $?
