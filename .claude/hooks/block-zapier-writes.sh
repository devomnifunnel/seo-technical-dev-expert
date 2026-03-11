#!/bin/bash
# Blocks Zapier write operations (Google Ads, ActiveCampaign, Outlook) without explicit approval
# Exit code 2 = deterministic block per Claude Code hook spec

echo "BLOCKED: This action modifies a live client system through Zapier. Michael must explicitly approve before any external changes are made. Describe what you want to do and ask for approval." >&2
exit 2
