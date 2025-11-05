# Flutter Frontend Setup

## Prerequisites
- Flutter SDK (3.19.0+)
- Android Studio / VS Code
- Google OAuth credentials
- Firebase project

## Setup

1. Clone the repository
2. Navigate to frontend directory: `cd frontend`
3. Install dependencies: `flutter pub get`
4. Configure Firebase: Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
5. Configure Google OAuth in Android manifest and iOS Info.plist
6. Run: `flutter run`

## Development

- Format code: `flutter format .`
- Analyze: `flutter analyze`
- Test: `flutter test`

## Build

- Android APK: `flutter build apk --release`
- iOS: `flutter build ios --release`
- Web: `flutter build web --release`