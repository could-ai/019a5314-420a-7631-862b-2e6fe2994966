from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework_simplejwt.tokens import RefreshToken
from google.oauth2 import id_token
from google.auth.transport import requests as google_requests
from django.conf import settings
from .models import Profile
from .serializers import ProfileSerializer, GoogleAuthSerializer, AuthResponseSerializer
from ..news.tasks import send_push_notification

class AuthViewSet(viewsets.ViewSet):
    permission_classes = [AllowAny]
    
    @action(detail=False, methods=['post'])
    def google(self, request):
        serializer = GoogleAuthSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        id_token_value = serializer.validated_data['id_token']
        
        # Verify Google token
        try:
            idinfo = id_token.verify_oauth2_token(
                id_token_value, 
                google_requests.Request(), 
                settings.SOCIALACCOUNT_PROVIDERS['google']['APP']['client_id']
            )
            
            user_id = idinfo['sub']
            email = idinfo['email']
            name = idinfo['name']
            
        except ValueError:
            return Response({'error': 'Invalid token'}, status=status.HTTP_400_BAD_REQUEST)
        
        # Get or create profile
        profile, created = Profile.objects.get_or_create(
            user_id=user_id,
            defaults={
                'name': name,
                'email': email,
            }
        )
        
        # Generate JWT tokens
        refresh = RefreshToken()
        refresh['user_id'] = str(profile.id)
        access = refresh.access_token
        access['user_id'] = str(profile.id)
        
        return Response({
            'access': str(access),
            'refresh': str(refresh),
            'user': ProfileSerializer(profile).data,
        })

class NotificationViewSet(viewsets.ViewSet):
    permission_classes = [IsAuthenticated]
    
    @action(detail=False, methods=['post'])
    def register_token(self, request):
        fcm_token = request.data.get('fcm_token')
        if not fcm_token:
            return Response({'error': 'FCM token required'}, status=status.HTTP_400_BAD_REQUEST)
        
        # TODO: Store FCM token for user
        return Response({'success': True})
    
    @action(detail=False, methods=['post'])
    def send(self, request):
        # TODO: Admin-only permission
        title = request.data.get('title')
        body = request.data.get('body')
        segment = request.data.get('segment', 'all')
        
        # TODO: Get tokens based on segment
        tokens = []  # Get FCM tokens
        
        send_push_notification.delay(tokens, title, body)
        
        return Response({'success': True, 'sent_count': len(tokens)})