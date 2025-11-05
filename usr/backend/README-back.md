# Backend Setup Guide

## Prerequisites
- Python 3.11+
- MongoDB (local or Atlas)
- Redis (for caching)
- Google OAuth credentials
- Firebase project

## Setup

1. Create virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # Linux/Mac
   venv\Scripts\activate     # Windows
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Environment variables:
   Create `.env` file with:
   ```
   DEBUG=True
   SECRET_KEY=your-secret-key
   MONGODB_URL=mongodb://localhost:27017/pulsex
   REDIS_URL=redis://localhost:6379/0
   GOOGLE_CLIENT_ID=your-google-client-id
   FCM_SERVER_KEY=your-fcm-server-key
   ```

4. Run migrations (if using Django ORM):
   ```bash
   python manage.py migrate
   ```

5. Run server:
   ```bash
   python manage.py runserver
   ```

## API Documentation

- Swagger UI: http://localhost:8000/api/schema/swagger-ui/
- ReDoc: http://localhost:8000/api/schema/redoc/

## Testing

```bash
pytest
```

## Production Deployment

Use Docker:
```bash
cd backend
sudo docker build -t pulsex-backend .
sudo docker run -p 8000:8000 pulsex-backend
```