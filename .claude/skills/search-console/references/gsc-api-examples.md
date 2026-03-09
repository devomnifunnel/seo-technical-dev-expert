# GSC API Examples

## Query Parameters for Programmatic Analysis

```python
# Google Search Console API - Python example
from googleapiclient.discovery import build
from google.oauth2 import service_account

SCOPES = ['https://www.googleapis.com/auth/webmasters.readonly']
SERVICE_ACCOUNT_FILE = 'service-account-key.json'

credentials = service_account.Credentials.from_service_account_file(
    SERVICE_ACCOUNT_FILE, scopes=SCOPES
)
service = build('searchconsole', 'v1', credentials=credentials)

# Query performance data
request = {
    'startDate': '2026-02-01',
    'endDate': '2026-02-28',
    'dimensions': ['query', 'page', 'device'],
    'dimensionFilterGroups': [{
        'filters': [{
            'dimension': 'country',
            'expression': 'usa'
        }]
    }],
    'rowLimit': 25000,
    'startRow': 0,
    'type': 'web'
}

response = service.searchanalytics().query(
    siteUrl='https://example.com',
    body=request
).execute()

for row in response.get('rows', []):
    query = row['keys'][0]
    page = row['keys'][1]
    device = row['keys'][2]
    clicks = row['clicks']
    impressions = row['impressions']
    ctr = row['ctr']
    position = row['position']
    print(f"{query} | {page} | {device} | {clicks} | {impressions} | {ctr:.2%} | {position:.1f}")
```

## Available Dimensions

| Dimension | Values | Notes |
|-----------|--------|-------|
| query | Search query text | Cannot combine with searchAppearance |
| page | Full URL | |
| device | DESKTOP, MOBILE, TABLET | |
| country | 3 letter country code | |
| date | YYYY-MM-DD | |
| searchAppearance | RICH_RESULT, etc. | Cannot combine with query |

## Date Range Limits

- Maximum date range: 16 months of historical data
- Freshest data: typically 2 to 3 days lag
- Row limit per request: 25,000 (use startRow for pagination)
- API quota: 1,200 queries per minute per project

## Useful API Query Patterns

**Striking distance report**:
```python
# Queries in position 5-15 with high impressions
request = {
    'startDate': '2026-02-01',
    'endDate': '2026-02-28',
    'dimensions': ['query', 'page'],
    'dimensionFilterGroups': [{
        'filters': [
            {'dimension': 'query', 'operator': 'excludingRegex', 'expression': 'brand_name'},
        ]
    }],
    'rowLimit': 25000
}
# Post-filter in code: position between 5 and 15, impressions > 100
```

**Page level performance trend**:
```python
# Daily performance for a specific page
request = {
    'startDate': '2026-01-01',
    'endDate': '2026-02-28',
    'dimensions': ['date'],
    'dimensionFilterGroups': [{
        'filters': [{
            'dimension': 'page',
            'expression': 'https://example.com/important-page'
        }]
    }]
}
```
