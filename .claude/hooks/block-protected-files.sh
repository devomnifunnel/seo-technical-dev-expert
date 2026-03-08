#!/bin/bash
# Blocks Edit/Write operations on sensitive files (.env, credentials, .ssh, .aws, .pem, .key, .pfx)
# Reads tool input from stdin as JSON (official Claude Code hook input format)

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null)

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

FILE_LOWER=$(echo "$FILE_PATH" | tr '[:upper:]' '[:lower:]')

# Use bash built-in matching (no grep) to avoid regex issues and Windows grep bugs
# Check path components and extensions, not substrings, to prevent false positives
# like "netsuite-environment" matching ".env" or "keyword" matching ".key"
case "$FILE_LOWER" in
  */.env|*/.env.*|*.env) echo "BLOCKED: .env file. Ask Michael to provide values directly." >&2; exit 2 ;;
  */credentials*) echo "BLOCKED: credentials file. Ask Michael to provide values directly." >&2; exit 2 ;;
  */.ssh/*) echo "BLOCKED: .ssh directory. Ask Michael to provide values directly." >&2; exit 2 ;;
  */.aws/*) echo "BLOCKED: .aws directory. Ask Michael to provide values directly." >&2; exit 2 ;;
  *.pem) echo "BLOCKED: .pem file. Ask Michael to provide values directly." >&2; exit 2 ;;
  *.key) echo "BLOCKED: .key file. Ask Michael to provide values directly." >&2; exit 2 ;;
  *.pfx) echo "BLOCKED: .pfx file. Ask Michael to provide values directly." >&2; exit 2 ;;
esac

exit 0
