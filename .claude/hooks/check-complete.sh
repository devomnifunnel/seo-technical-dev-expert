#!/bin/bash
# Check if all phases in task_plan.md are complete
# Always exits 0. Uses stdout for status reporting.
# Used by Stop hook to report task completion status before session ends.

PLAN_FILE="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}/task_plan.md"

if [ ! -f "$PLAN_FILE" ]; then
    echo "[planning] No task_plan.md found. No active planning session."
    exit 0
fi

# Count total phases
TOTAL=$(grep -c "### Phase" "$PLAN_FILE" || true)

# Check for **Status:** format first
COMPLETE=$(grep -cF "**Status:** complete" "$PLAN_FILE" || true)
IN_PROGRESS=$(grep -cF "**Status:** in_progress" "$PLAN_FILE" || true)
PENDING=$(grep -cF "**Status:** pending" "$PLAN_FILE" || true)

# Fallback: check for [complete] inline format
if [ "$COMPLETE" -eq 0 ] && [ "$IN_PROGRESS" -eq 0 ] && [ "$PENDING" -eq 0 ]; then
    COMPLETE=$(grep -c "\[complete\]" "$PLAN_FILE" || true)
    IN_PROGRESS=$(grep -c "\[in_progress\]" "$PLAN_FILE" || true)
    PENDING=$(grep -c "\[pending\]" "$PLAN_FILE" || true)
fi

: "${TOTAL:=0}"
: "${COMPLETE:=0}"
: "${IN_PROGRESS:=0}"
: "${PENDING:=0}"

if [ "$COMPLETE" -eq "$TOTAL" ] && [ "$TOTAL" -gt 0 ]; then
    echo "[planning] ALL PHASES COMPLETE ($COMPLETE/$TOTAL)"
else
    echo "[planning] Task in progress ($COMPLETE/$TOTAL phases complete)"
    if [ "$IN_PROGRESS" -gt 0 ]; then
        echo "[planning] $IN_PROGRESS phase(s) still in progress."
    fi
    if [ "$PENDING" -gt 0 ]; then
        echo "[planning] $PENDING phase(s) pending."
    fi
fi
exit 0
