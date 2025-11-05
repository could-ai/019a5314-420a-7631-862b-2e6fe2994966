DEMO_STEPS.md

# PulseX Demo Script (10 Minutes)

## Prerequisites
- PulseX app installed on device/emulator
- Backend running at http://localhost:8000
- MongoDB and Redis running
- Google account for login
- Admin account created

## Demo Steps

### 1. Login (1 minute)
- Open PulseX app
- Tap "Sign in with Google"
- Select Google account
- App navigates to feed

### 2. Explore Feed (2 minutes)
- View "For You" tab with infinite scroll
- Switch to "Following" tab (empty initially)
- Pull to refresh feed
- Toggle dark mode in settings

### 3. Read Article (2 minutes)
- Tap on any news card
- View article in WebView
- See like/bookmark/share buttons
- Browse comments section

### 4. Interact with Content (2 minutes)
- Like an article (optimistic update)
- Bookmark article (local storage)
- Leave a comment (threaded)
- Share article via system share

### 5. Follow Sources (1 minute)
- Go to profile/settings
- Follow some news sources
- Switch to "Following" tab to see filtered content

### 6. Offline Experience (1 minute)
- Turn off internet
- View cached feed and bookmarks
- Try to like (shows pending)
- Turn internet back on, sync happens

### 7. Admin Panel (1 minute)
- Login as admin user
- View dashboard with stats
- Send push notification to all users
- Moderate content if any reports

## Expected Results
- Smooth login flow
- Fast feed loading with pagination
- Responsive article reading
- Immediate UI feedback for interactions
- Offline functionality works
- Push notifications received
- Admin controls functional