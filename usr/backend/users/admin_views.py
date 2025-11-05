from rest_framework import viewsets
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response
from .models import Profile
from .serializers import ProfileSerializer

class AdminUserViewSet(viewsets.ModelViewSet):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    permission_classes = [IsAdminUser]
    
    @action(detail=True, methods=['patch'])
    def role(self, request, pk=None):
        profile = self.get_object()
        role = request.data.get('role')
        if role in ['user', 'moderator', 'admin']:
            profile.roles = [role]
            profile.save()
            return Response({'success': True})
        return Response({'error': 'Invalid role'}, status=400)

class AdminAnalyticsViewSet(viewsets.ViewSet):
    permission_classes = [IsAdminUser]
    
    def list(self, request):
        # TODO: Aggregate analytics data
        return Response({
            'total_users': 1000,
            'active_users': 500,
            'total_articles': 5000,
            'total_likes': 25000,
        })

class AdminModerationViewSet(viewsets.ViewSet):
    permission_classes = [IsAdminUser]
    
    def list(self, request):
        # TODO: Get reported content
        return Response([])