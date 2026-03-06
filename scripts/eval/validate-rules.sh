#!/bin/bash
# Validates all .claude/rules/*.md files
# Checks: deprecated globs: field, paths: field with valid base directories

source "$(dirname "$0")/lib.sh"

header "Validating Rules"

RULE_FILES=("$PROJECT_DIR"/.claude/rules/*.md)

if [ ${#RULE_FILES[@]} -eq 0 ] || [ ! -f "${RULE_FILES[0]}" ]; then
  warn "No rule files found in .claude/rules/"
  summary "RULES"
  exit $?
fi

for rule_file in "${RULE_FILES[@]}"; do
  rule_name="$(basename "$rule_file" .md)"

  info "Checking rule: $rule_name"

  # If file has no frontmatter, it is a global rule and that is fine
  if ! has_frontmatter "$rule_file"; then
    pass "$rule_name: global rule (no frontmatter required)"
    continue
  fi
  pass "$rule_name: has frontmatter"

  fm="$(get_frontmatter "$rule_file")"

  # Check for deprecated globs: field
  if echo "$fm" | grep -qE "^globs:"; then
    fail "$rule_name: uses deprecated globs: field, should be paths:"
    continue
  fi

  # Check for paths: field
  if ! echo "$fm" | grep -qE "^paths:"; then
    warn "$rule_name: has frontmatter but no paths: field (rule will apply globally)"
    continue
  fi
  pass "$rule_name: has paths: field"

  # Extract each path value and verify the directory/pattern base exists
  # paths: is a YAML list, each entry on a line starting with "  - "
  echo "$fm" | grep -E '^\s*-\s+' | sed 's/^\s*-\s*//' | sed 's/^["'"'"']//' | sed 's/["'"'"']$//' | while read -r path_pattern; do
    # Strip glob wildcards to get the base directory
    # e.g., ".claude/agents/**" -> ".claude/agents"
    # e.g., "clients/**" -> "clients"
    base_dir="$(echo "$path_pattern" | sed 's|/\*\*.*||' | sed 's|\*.*||' | sed 's|/$||')"

    if [ -z "$base_dir" ]; then
      warn "$rule_name: path pattern '$path_pattern' has no verifiable base directory"
      continue
    fi

    if file_exists_rel "$base_dir"; then
      pass "$rule_name: path base '$base_dir' exists"
    else
      fail "$rule_name: path base '$base_dir' does not exist (from pattern '$path_pattern')"
    fi
  done

done

summary "RULES"
exit $?
