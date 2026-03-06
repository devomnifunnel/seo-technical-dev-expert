#!/bin/bash
# Validates that all file references across the project resolve to existing files.
# Checks: @imports, Reference Architecture dirs, agent refs in skills,
#          script refs in skills, orphaned frameworks, rule file references.

source "$(dirname "$0")/lib.sh"

CLAUDE_MD="$PROJECT_DIR/.claude/CLAUDE.md"

# ---------------------------------------------------------------------------
# 1. CLAUDE.md @imports
# ---------------------------------------------------------------------------
header "CLAUDE.md @imports"

if [ ! -f "$CLAUDE_MD" ]; then
  fail "CLAUDE.md not found at .claude/CLAUDE.md"
else
  # Match @.claude/... or @path references: lines containing @. followed by path chars
  import_lines=$(grep -oE '@\.[a-zA-Z0-9_./-]+' "$CLAUDE_MD" || true)
  if [ -z "$import_lines" ]; then
    warn "No @import references found in CLAUDE.md"
  else
    while IFS= read -r ref; do
      # Strip the leading @
      rel_path="${ref#@}"
      if [ -e "$PROJECT_DIR/$rel_path" ]; then
        pass "@import resolves: $rel_path"
      else
        fail "@import BROKEN: $rel_path does not exist"
      fi
    done <<< "$import_lines"
  fi
fi

# ---------------------------------------------------------------------------
# 2. Reference Architecture directories
# ---------------------------------------------------------------------------
header "Reference Architecture directories"

# The data line follows the ## Reference Architecture heading (may have a blank line between)
ref_arch_data=$(grep -A3 '## Reference Architecture' "$CLAUDE_MD" 2>/dev/null | grep -v '^##' | grep -v '^--$' | grep -v '^$' | head -1 || true)

if [ -z "$ref_arch_data" ]; then
  warn "No Reference Architecture data line found in CLAUDE.md"
else
  # Extract path values ending with / (e.g. ".claude/agents/", "scripts/chrome/", "clients/")
  ref_dirs=$(echo "$ref_arch_data" | grep -oE '[.a-zA-Z0-9_/-]+/' | sort -u || true)
  if [ -z "$ref_dirs" ]; then
    warn "No directory paths extracted from Reference Architecture line"
  else
    while IFS= read -r dir_path; do
      if [ -d "$PROJECT_DIR/$dir_path" ]; then
        pass "Ref arch directory exists: $dir_path"
      else
        fail "Ref arch directory MISSING: $dir_path"
      fi
    done <<< "$ref_dirs"
  fi
fi

# ---------------------------------------------------------------------------
# 3. Agent references in skills
# ---------------------------------------------------------------------------
header "Agent references in skill files"

skill_files=$(find "$PROJECT_DIR/.claude/skills" -name "SKILL.md" 2>/dev/null || true)

if [ -z "$skill_files" ]; then
  warn "No SKILL.md files found in .claude/skills/"
else
  agent_refs_found=0
  while IFS= read -r skill_file; do
    skill_name=$(basename "$(dirname "$skill_file")")
    # Extract .claude/agents/something.md references
    agent_refs=$(grep -oE '\.claude/agents/[a-zA-Z0-9_-]+\.md' "$skill_file" 2>/dev/null | sort -u || true)
    if [ -n "$agent_refs" ]; then
      while IFS= read -r agent_ref; do
        agent_refs_found=1
        if [ -f "$PROJECT_DIR/$agent_ref" ]; then
          pass "[$skill_name] agent ref resolves: $agent_ref"
        else
          fail "[$skill_name] agent ref BROKEN: $agent_ref does not exist"
        fi
      done <<< "$agent_refs"
    fi
  done <<< "$skill_files"

  if [ "$agent_refs_found" -eq 0 ]; then
    warn "No agent references found in any SKILL.md files"
  fi
fi

# ---------------------------------------------------------------------------
# 4. Script references in skills
# ---------------------------------------------------------------------------
header "Script references in skill files"

if [ -z "$skill_files" ]; then
  warn "No SKILL.md files found (skipping script reference check)"
else
  script_refs_found=0
  while IFS= read -r skill_file; do
    skill_name=$(basename "$(dirname "$skill_file")")
    skill_dir=$(dirname "$skill_file")

    # 4a. References to scripts/chrome/ files (project-level)
    chrome_refs=$(grep -oE 'scripts/chrome/[a-zA-Z0-9_-]+\.[a-zA-Z]+' "$skill_file" 2>/dev/null | sort -u || true)
    if [ -n "$chrome_refs" ]; then
      while IFS= read -r script_ref; do
        script_refs_found=1
        if [ -f "$PROJECT_DIR/$script_ref" ]; then
          pass "[$skill_name] script ref resolves: $script_ref"
        else
          # Also check relative to the skill directory itself
          if [ -f "$skill_dir/$script_ref" ]; then
            pass "[$skill_name] script ref resolves (skill-relative): $script_ref"
          else
            fail "[$skill_name] script ref BROKEN: $script_ref does not exist"
          fi
        fi
      done <<< "$chrome_refs"
    fi

    # 4b. ${CLAUDE_SKILL_DIR}/scripts/chrome/ references
    # Use fgrep for the literal $ and braces, then extract with sed
    skill_dir_lines=$(grep -F '${CLAUDE_SKILL_DIR}/scripts/chrome/' "$skill_file" 2>/dev/null || true)
    if [ -n "$skill_dir_lines" ]; then
      # Extract each filename referenced via ${CLAUDE_SKILL_DIR}/scripts/chrome/<file>
      skill_dir_refs=$(echo "$skill_dir_lines" | grep -oE 'CLAUDE_SKILL_DIR\}/scripts/chrome/[a-zA-Z0-9_-]+\.[a-zA-Z]+' | sed 's/^CLAUDE_SKILL_DIR}\/scripts\/chrome\///' | sort -u || true)
      if [ -n "$skill_dir_refs" ]; then
        while IFS= read -r script_name; do
          script_refs_found=1
          local_path="scripts/chrome/$script_name"
          if [ -f "$skill_dir/$local_path" ]; then
            pass "[$skill_name] CLAUDE_SKILL_DIR ref resolves: $local_path"
          else
            fail "[$skill_name] CLAUDE_SKILL_DIR ref BROKEN: $local_path not found in $skill_name/"
          fi
        done <<< "$skill_dir_refs"
      fi
    fi
  done <<< "$skill_files"

  if [ "$script_refs_found" -eq 0 ]; then
    warn "No script references found in any SKILL.md files"
  fi
fi

# ---------------------------------------------------------------------------
# 5. Orphaned framework files
# ---------------------------------------------------------------------------
header "Orphaned framework files"

framework_dir="$PROJECT_DIR/.claude/frameworks"

if [ ! -d "$framework_dir" ]; then
  warn "Frameworks directory does not exist: .claude/frameworks/"
else
  framework_files=$(find "$framework_dir" -maxdepth 1 -name "*.md" -type f 2>/dev/null || true)
  if [ -z "$framework_files" ]; then
    warn "No framework .md files found in .claude/frameworks/"
  else
    while IFS= read -r fw_file; do
      fw_basename=$(basename "$fw_file")
      fw_rel=".claude/frameworks/$fw_basename"
      # Check if this framework is referenced by an @import in CLAUDE.md
      if grep -qF "@$fw_rel" "$CLAUDE_MD" 2>/dev/null; then
        pass "Framework is @imported: $fw_basename"
      else
        # Also check for non-@import references (inline mentions)
        if grep -qF "$fw_rel" "$CLAUDE_MD" 2>/dev/null; then
          pass "Framework is referenced (inline): $fw_basename"
        else
          warn "Orphaned framework (not referenced in CLAUDE.md): $fw_basename"
        fi
      fi
    done <<< "$framework_files"
  fi
fi

# ---------------------------------------------------------------------------
# 6. Rule file references to project files
# ---------------------------------------------------------------------------
header "Rule file references to project files"

rule_files=$(find "$PROJECT_DIR/.claude/rules" -name "*.md" -type f 2>/dev/null || true)

if [ -z "$rule_files" ]; then
  warn "No rule files found in .claude/rules/"
else
  rule_refs_found=0
  while IFS= read -r rule_file; do
    rule_name=$(basename "$rule_file")

    # Extract references to specific .md files inside known project directories
    # Patterns: .claude/agents/X.md, .claude/frameworks/X.md
    specific_refs=$(grep -oE '\.claude/(agents|frameworks)/[a-zA-Z0-9_-]+\.md' "$rule_file" 2>/dev/null | sort -u || true)
    if [ -n "$specific_refs" ]; then
      while IFS= read -r sref; do
        rule_refs_found=1
        if [ -f "$PROJECT_DIR/$sref" ]; then
          pass "[$rule_name] file ref resolves: $sref"
        else
          fail "[$rule_name] file ref BROKEN: $sref does not exist"
        fi
      done <<< "$specific_refs"
    fi

    # Check references to known project directories (clients/, .claude/agents/, .claude/skills/, etc.)
    # Look for patterns like "clients/" ".claude/agents/" ".claude/skills/" ".claude/frameworks/"
    dir_patterns=$(grep -oE '(clients|\.claude/(agents|skills|frameworks))/' "$rule_file" 2>/dev/null | sort -u || true)
    if [ -n "$dir_patterns" ]; then
      while IFS= read -r dref; do
        rule_refs_found=1
        if [ -d "$PROJECT_DIR/$dref" ]; then
          pass "[$rule_name] directory ref exists: $dref"
        else
          fail "[$rule_name] directory ref MISSING: $dref"
        fi
      done <<< "$dir_patterns"
    fi
  done <<< "$rule_files"

  if [ "$rule_refs_found" -eq 0 ]; then
    warn "No project file references found in rule files"
  fi
fi

# ---------------------------------------------------------------------------
summary "REFERENCES"
exit $?
