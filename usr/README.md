# PulseX - Social News Aggregator

PulseX is a Twitter-style news aggregator app built with Flutter (mobile/web) and Django REST API backend, featuring offline-first architecture, real-time notifications, and comprehensive admin controls.

## Features

- 🔐 Google OAuth Authentication
- 📱 Cross-platform (Android, iOS, Web)
- 🌐 Offline-first with caching and background sync
- 🔔 FCM Push Notifications
- 💬 Threaded Comments
- ❤️ Like, Bookmark, Share articles
- 📊 Trending Topics
- 🔍 Search & Filter
- 🌙 Dark Mode
- 🌍 Internationalization (English + Hindi)
- 👑 Role-based Access Control (User, Moderator, Admin, Owner)
- 📈 Analytics Dashboard
- 🛡️ Moderation Tools
- 🔄 CI/CD Pipeline
- 🐳 Docker Deployment

## Quick Start

### Prerequisites
- Docker & Docker Compose
- Flutter SDK (for local development)
- Python 3.11+ (for backend development)
- MongoDB (local or Atlas)
- Google OAuth & Firebase credentials

### One-Line Setup
```bash
# Clone and run full stack
docker-compose up --build

# For Flutter development
cd frontend && flutter pub get && flutter run
```

## Project Structure

```
pulsex/
├── frontend/          # Flutter app
├── backend/           # Django REST API
├── docker-compose.yml # Development environment
├── .github/           # CI/CD workflows
└── README.md
```

## Environment Setup

1. **Google OAuth**: Create project at Google Cloud Console, enable OAuth, get client IDs for Android/iOS/Web
2. **Firebase**: Create project for FCM notifications
3. **MongoDB**: Use local Docker or MongoDB Atlas
4. **Redis**: For caching and background tasks

Copy `.env.example` files and fill in your credentials.

## API Documentation

- Swagger UI: `http://localhost:8000/docs/`
- OpenAPI Spec: `http://localhost:8000/swagger.json`

## Deployment

### Development
```bash
docker-compose up --build
```

### Production (Docker Compose)
```bash
docker-compose -f docker-compose.prod.yml up -d
```

### Production (Kubernetes)
```bash
kubectl apply -f k8s/
```

## Demo Steps

See [DEMO_STEPS.md](./DEMO_STEPS.md) for a 10-minute walkthrough.

## Contributing

1. Fork the repository
2. Create feature branch
3. Run tests: `flutter test` and `pytest`
4. Submit PR

## License

MIT License