#!/bin/bash
# Shared library for project validation scripts
# Usage: source "$(dirname "$0")/lib.sh"

# Colors (disabled if not a terminal)
if [ -t 1 ]; then
  GREEN='\033[0;32m'
  RED='\033[0;31m'
  YELLOW='\033[0;33m'
  BLUE='\033[0;34m'
  BOLD='\033[1m'
  NC='\033[0m'
else
  GREEN='' RED='' YELLOW='' BLUE='' BOLD='' NC=''
fi

# Counters
PASS_COUNT=0
FAIL_COUNT=0
WARN_COUNT=0

# Project root (two levels up from scripts/eval/)
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

pass() {
  echo -e "${GREEN}[PASS]${NC} $1"
  ((PASS_COUNT++))
}

fail() {
  echo -e "${RED}[FAIL]${NC} $1"
  ((FAIL_COUNT++))
}

warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
  ((WARN_COUNT++))
}

info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

header() {
  echo ""
  echo -e "${BOLD}=== $1 ===${NC}"
  echo ""
}

summary() {
  local label="$1"
  echo ""
  echo -e "${BOLD}${label} SUMMARY:${NC} ${GREEN}${PASS_COUNT} passed${NC}, ${RED}${FAIL_COUNT} failed${NC}, ${YELLOW}${WARN_COUNT} warnings${NC}"
  return $FAIL_COUNT
}

# Extract YAML frontmatter from a markdown file (between first two --- lines)
# Usage: get_frontmatter "$file"
get_frontmatter() {
  local file="$1"
  sed -n '2,/^---$/{ /^---$/d; p; }' "$file"
}

# Get a frontmatter field value
# Usage: get_field "$frontmatter" "name"
get_field() {
  local fm="$1"
  local field="$2"
  echo "$fm" | grep -E "^${field}:" | head -1 | sed "s/^${field}: *//" | sed 's/^["'"'"']//' | sed 's/["'"'"']$//'
}

# Check if a file has YAML frontmatter
# Usage: has_frontmatter "$file"
has_frontmatter() {
  local file="$1"
  [ "$(head -1 "$file")" = "---" ]
}

# Check if string is kebab-case (lowercase, hyphens only, no spaces)
# Usage: is_kebab_case "$string"
is_kebab_case() {
  echo "$1" | grep -qE '^[a-z0-9]+(-[a-z0-9]+)*$'
}

# Check if file exists relative to project root
# Usage: file_exists_rel "path/to/file"
file_exists_rel() {
  [ -e "$PROJECT_DIR/$1" ]
}
