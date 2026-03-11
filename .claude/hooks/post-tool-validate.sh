#!/bin/bash
# PostToolUse Validation Hook: Validates MCP tool responses contain real data
# Catches auth failures, empty responses, and rate limits before bad data poisons an audit
# Exit 0 = proceed (always), stdout = warning injected into context if problem detected

# Hook Profile: skip validation in minimal mode (reduces overhead on simple reads)
PROFILE="${OFM_HOOK_PROFILE:-standard}"
case "$PROFILE" in
  minimal) exit 0 ;;
esac

# Read tool output from stdin (JSON with tool_name and tool_output)
INPUT=$(cat)

# Extract tool name and output using python for reliable JSON parsing
VALIDATION=$(echo "$INPUT" | python -c "
import sys, json

try:
    data = json.load(sys.stdin)
    tool_name = data.get('tool_name', '')
    tool_output = str(data.get('tool_output', ''))
    tool_output_lower = tool_output.lower()

    # Only validate MCP tool responses
    mcp_prefixes = [
        'mcp__google-search-console__',
        'mcp__google-analytics__',
        'mcp__google-ads__',
        'mcp__semrush__',
        'mcp__pagespeed__',
        'mcp__lighthouse__',
        'mcp__claude-in-chrome__',
        'mcp__chrome-devtools__',
        'mcp__meta-ads__',
    ]

    is_mcp = any(tool_name.startswith(p) for p in mcp_prefixes)
    if not is_mcp:
        sys.exit(0)

    warnings = []

    # Check for authentication failures
    auth_signals = [
        'unauthorized', 'unauthenticated', 'invalid credentials',
        'token expired', 'access denied', 'permission denied',
        'login required', 'not authenticated', '401', '403',
        'oauth', 'refresh token', 'invalid_grant',
    ]
    for signal in auth_signals:
        if signal in tool_output_lower:
            warnings.append('AUTH_FAILURE: MCP response contains authentication error signal: ' + signal)
            break

    # Check for empty or null responses
    empty_signals = [
        tool_output.strip() == '',
        tool_output.strip() == '{}',
        tool_output.strip() == '[]',
        tool_output.strip() == 'null',
        tool_output.strip() == 'None',
    ]
    if any(empty_signals):
        warnings.append('EMPTY_RESPONSE: MCP tool returned empty or null data')

    # Check for rate limiting
    rate_signals = [
        'rate limit', 'too many requests', '429', 'quota exceeded',
        'throttled', 'retry after', 'backoff',
    ]
    for signal in rate_signals:
        if signal in tool_output_lower:
            warnings.append('RATE_LIMITED: MCP response indicates rate limiting: ' + signal)
            break

    # Check for server errors
    error_signals = [
        'internal server error', '500', '502', '503', '504',
        'service unavailable', 'gateway timeout', 'bad gateway',
    ]
    for signal in error_signals:
        if signal in tool_output_lower:
            warnings.append('SERVER_ERROR: MCP response contains server error: ' + signal)
            break

    # Output warnings if any found
    if warnings:
        print('WARNING: MCP TOOL VALIDATION FAILED for ' + tool_name)
        for w in warnings:
            print('  ' + w)
        print('ACTION REQUIRED: Do NOT proceed with this data. Verify access, retry, or ask Michael for help.')
        print('ACCESS BLOCKER RULE: If authentication is failing, STOP and ask Michael for access.')

except Exception:
    pass
" 2>/dev/null)

# Output any warnings (they get injected into Claude's context)
if [ -n "$VALIDATION" ]; then
  echo "$VALIDATION"
fi

exit 0
