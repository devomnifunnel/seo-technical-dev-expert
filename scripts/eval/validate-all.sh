#!/bin/bash
# Master validation runner for the Claude Code SEO & Technical Dev Expert project
# Runs all validators and produces an aggregate report
# Usage: bash scripts/eval/validate-all.sh [--quick]

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Colors
if [ -t 1 ]; then
  GREEN='\033[0;32m'
  RED='\033[0;31m'
  YELLOW='\033[0;33m'
  BOLD='\033[1m'
  NC='\033[0m'
else
  GREEN='' RED='' YELLOW='' BOLD='' NC=''
fi

TOTAL_PASS=0
TOTAL_FAIL=0
TOTAL_WARN=0
FAILED_SUITES=()

echo -e "${BOLD}"
echo "============================================="
echo "  Claude Code Project Validation Suite"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "============================================="
echo -e "${NC}"

run_validator() {
  local name="$1"
  local script="$2"

  if [ ! -f "$script" ]; then
    echo -e "${RED}[SKIP]${NC} $name: script not found at $script"
    FAILED_SUITES+=("$name (missing)")
    return 1
  fi

  # Run and capture output
  local output
  output=$(bash "$script" 2>&1)
  local exit_code=$?

  echo "$output"

  # Parse summary line for counts
  local pass_count=$(echo "$output" | grep -oE '[0-9]+ passed' | grep -oE '[0-9]+' | tail -1)
  local fail_count=$(echo "$output" | grep -oE '[0-9]+ failed' | grep -oE '[0-9]+' | tail -1)
  local warn_count=$(echo "$output" | grep -oE '[0-9]+ warnings' | grep -oE '[0-9]+' | tail -1)

  TOTAL_PASS=$((TOTAL_PASS + ${pass_count:-0}))
  TOTAL_FAIL=$((TOTAL_FAIL + ${fail_count:-0}))
  TOTAL_WARN=$((TOTAL_WARN + ${warn_count:-0}))

  if [ "${fail_count:-0}" -gt 0 ]; then
    FAILED_SUITES+=("$name")
  fi
}

# Run all validators in sequence
VALIDATORS=(
  "Skills|$SCRIPT_DIR/validate-skills.sh"
  "Agents|$SCRIPT_DIR/validate-agents.sh"
  "Rules|$SCRIPT_DIR/validate-rules.sh"
  "Hooks|$SCRIPT_DIR/validate-hooks.sh"
  "Settings|$SCRIPT_DIR/validate-settings.sh"
  "References|$SCRIPT_DIR/validate-refs.sh"
  "Operational|$SCRIPT_DIR/validate-operational.sh"
)

# Quick mode skips hook functional tests
if [ "$1" = "--quick" ]; then
  export QUICK_MODE=1
  echo -e "${YELLOW}Running in quick mode (skipping functional tests)${NC}"
  echo ""
fi

for entry in "${VALIDATORS[@]}"; do
  IFS='|' read -r name script <<< "$entry"
  run_validator "$name" "$script"
done

# Aggregate report
echo ""
echo -e "${BOLD}============================================="
echo "  AGGREGATE RESULTS"
echo "=============================================${NC}"
echo ""
echo -e "  Total checks:   $((TOTAL_PASS + TOTAL_FAIL + TOTAL_WARN))"
echo -e "  ${GREEN}Passed:        $TOTAL_PASS${NC}"
echo -e "  ${RED}Failed:        $TOTAL_FAIL${NC}"
echo -e "  ${YELLOW}Warnings:      $TOTAL_WARN${NC}"
echo ""

if [ ${#FAILED_SUITES[@]} -gt 0 ]; then
  echo -e "${RED}Failed suites: ${FAILED_SUITES[*]}${NC}"
  echo ""
  echo -e "${RED}PROJECT STATUS: FAILING${NC}"
  exit 1
else
  echo -e "${GREEN}PROJECT STATUS: ALL CHECKS PASSING${NC}"
  exit 0
fi
