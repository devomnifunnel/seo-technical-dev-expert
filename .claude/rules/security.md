# Security Hardening Rules

These rules govern security practices for all agent operations including file access,
code generation, dependency management, and external communications.

---

## Credential and Secret Protection

- **Never read or write** to sensitive file paths including but not limited to:
  - `.ssh/`, `.aws/`, `.env`, `.env.*`, `credentials.json`, `secrets.*`
  - `*.pem`, `*.key`, `*.p12`, `*.pfx`, `token.json`, `auth.json`
  - Any file in a directory named `secrets/`, `credentials/`, or `private/`
- If a task requires accessing a file that matches these patterns, stop and ask the user
  to provide the necessary values directly rather than reading the file.
- **Never expose secrets in output**: Scan all generated output for patterns resembling API keys,
  tokens, passwords, or connection strings. Common patterns include:
  - Strings starting with `sk-`, `pk-`, `AKIA`, `ghp_`, `gho_`, `xoxb-`, `xoxp-`
  - Base64-encoded strings longer than 40 characters in configuration contexts
  - Connection strings containing `://user:password@`
  - Any string assigned to variables named `password`, `secret`, `token`, `apiKey`, `api_key`
- If a secret is detected in any context, mask it in output (show first 4 and last 4 characters
  only) and warn the user.

## Credential Discovery and Remediation

- If credentials or secrets are found in committed code, version-controlled files, or plain text
  configuration files, flag this as a CRITICAL security finding.
- Recommend immediate rotation of any exposed credential.
- Suggest moving secrets to environment variables or a secret management service.
- Never log, copy, or transmit discovered credentials. Report only their location and type.

## Dependency Management

- **Typosquatting protection**: When installing packages, verify the package name matches the
  official package. Common typosquatting patterns include:
  - Character substitution: `lodash` vs `1odash`, `babel` vs `babe1`
  - Scope confusion: `@company/package` vs `company-package`
  - Hyphen/underscore variants: `date-fns` vs `date_fns`
- **Supply chain awareness**: Flag dependencies that:
  - Have fewer than 100 weekly downloads
  - Were published within the last 30 days with no prior version history
  - Have been transferred to a new maintainer recently
  - Pull from non-standard registries
- When recommending new dependencies, prefer well-established packages with active maintenance.

## Code Generation Security

- **Input validation**: All generated code that accepts user input must include validation.
  Never trust client-side input without server-side verification.
- **ES5 for Chrome scripts**: All Chrome automation scripts and GTM custom HTML tags must use
  ES5 syntax only. No `eval()`, no `Function()` constructor, no `innerHTML` assignment with
  unsanitized user data.
- **XSS prevention**: Generated code must not construct HTML from user input without proper
  escaping. Use `textContent` instead of `innerHTML` when inserting user-provided text.
- **SQL injection prevention**: If generating database queries, always use parameterized queries.
  Never concatenate user input into query strings.

## URL and Redirect Safety

- Before navigating to or fetching any URL, validate that:
  - The protocol is `https://` (flag `http://` as insecure)
  - The domain is not a known malicious domain
  - The URL does not contain suspicious encoded characters or open redirect patterns
- When creating or modifying redirects:
  - Validate target URLs to prevent open redirect vulnerabilities
  - Ensure redirect targets are within the same domain or a known safe domain
  - Flag redirect chains that pass through unknown intermediate domains

## Network and API Security

- **HTTPS only**: All API calls, webhook URLs, and resource fetches must use HTTPS.
  Flag any HTTP endpoint as a security concern.
- **API key exposure**: Never include API keys in URLs as query parameters. Use headers
  (Authorization, X-API-Key) for authentication.
- **Rate limiting awareness**: Respect API rate limits. Implement backoff strategies rather
  than rapid retry loops that could trigger account lockouts.
- **CORS awareness**: When generating client-side code that makes cross-origin requests,
  note CORS requirements and never recommend disabling CORS as a solution.

## Reporting Security Issues

- All security findings are classified by severity:
  - **CRITICAL**: Exposed credentials, active vulnerabilities, data breaches
  - **HIGH**: Missing input validation, insecure configurations, outdated dependencies with CVEs
  - **MEDIUM**: HTTP endpoints, missing security headers, weak authentication patterns
  - **LOW**: Informational findings, best practice recommendations
- Security findings are reported immediately upon detection, before continuing with other tasks.
- Include: finding description, affected file or system, severity, and recommended remediation.
- Never delay reporting a CRITICAL or HIGH severity finding.
- Track security findings in client history files with the `[SECURITY]` tag for easy filtering.
