#!/bin/bash
# Blocks GTM container modifications without explicit approval
# Exit code 2 = deterministic block per Claude Code hook spec

echo "BLOCKED: This action modifies a live GTM container. Michael must explicitly approve before any external changes are made. Describe what you want to do and ask for approval." >&2
exit 2
