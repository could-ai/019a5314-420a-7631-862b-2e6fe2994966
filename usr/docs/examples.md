# PulseX API Examples

## Authentication

### Google OAuth Login
```bash
curl -X POST http://localhost:8000/api/v1/auth/google/ \
  -H "Content-Type: application/json" \
  -d '{"id_token": "your-google-id-token"}'

# Response
{
  "access": "eyJ0eXAi...",
  "refresh": "eyJ0eXAi...",
  "user": {
    "id": "123",
    "name": "John Doe",
    "email": "john@example.com",
    "roles": ["user"]
  }
}
```

## News Feed

### Get Feed
```bash
curl -X GET "http://localhost:8000/api/v1/news/?page=1&limit=10&tab=for_you" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"

# Response
{
  "results": [
    {
      "id": "507f1f77bcf86cd799439011",
      "title": "Breaking News",
      "excerpt": "Summary...",
      "source": {
        "id": "bbc",
        "name": "BBC News",
        "is_verified": true
      },
      "published_at": "2025-01-05T10:00:00Z",
      "like_count": 123,
      "is_liked": false,
      "is_bookmarked": false
    }
  ],
  "page": 1,
  "total": 1000
}
```

### Like Article
```bash
curl -X POST http://localhost:8000/api/v1/news/507f1f77bcf86cd799439011/like/ \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"

# Response
{
  "success": true,
  "like_count": 124,
  "is_liked": true
}
```

## Comments

### Get Comments
```bash
curl -X GET http://localhost:8000/api/v1/news/507f1f77bcf86cd799439011/comments/?page=1 \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

### Post Comment
```bash
curl -X POST http://localhost:8000/api/v1/news/507f1f77bcf86cd799439011/comments/ \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"body": "Great article!", "parent_id": null}'
```

## Moderation (Admin)

### Flag Content
```bash
curl -X POST http://localhost:8000/api/v1/moderation/flag/ \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"news_id": "507f1f77bcf86cd799439011", "reason": "spam"}'
```

### Send Push Notification (Admin)
```bash
curl -X POST http://localhost:8000/api/v1/notifications/send/ \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Breaking News",
    "body": "Something important happened",
    "segment": "all"
  }'
```

## Search

```bash
curl -X GET "http://localhost:8000/api/v1/search/?q=bitcoin&source=bbc" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## Trending

```bash
curl -X GET http://localhost:8000/api/v1/trends/ \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"

# Response
[
  {"term": "AI", "count": 120},
  {"term": "Crypto", "count": 95}
]
```