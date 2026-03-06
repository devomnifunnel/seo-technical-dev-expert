#!/bin/bash
# Blocks Edit/Write operations on sensitive files (.env, credentials, .ssh, .aws, .pem, .key, .pfx)
# Reads tool input from stdin as JSON (official Claude Code hook input format)

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null)

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

BLOCKED_PATTERNS=(".env" "credentials" ".ssh" ".aws" ".pem" ".key" ".pfx")

FILE_LOWER=$(echo "$FILE_PATH" | tr '[:upper:]' '[:lower:]')

for pattern in "${BLOCKED_PATTERNS[@]}"; do
  if echo "$FILE_LOWER" | grep -qi "$pattern"; then
    echo "BLOCKED: Cannot modify protected file matching pattern '$pattern'. Ask Michael to provide values directly." >&2
    exit 2
  fi
done

exit 0
