from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from django.core.cache import cache
from .models import News, Reaction
from .serializers import NewsSerializer, CommentSerializer
from ..users.permissions import IsAdminOrReadOnly

class NewsViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = News.objects.all().order_by('-published_at')
    serializer_class = NewsSerializer
    permission_classes = [AllowAny]
    
    def get_queryset(self):
        queryset = super().get_queryset()
        tab = self.request.query_params.get('tab', 'for_you')
        
        if tab == 'following':
            # TODO: Filter by followed sources
            pass
        
        return queryset
    
    @action(detail=True, methods=['post'], permission_classes=[IsAuthenticated])
    def like(self, request, pk=None):
        news = self.get_object()
        user_id = request.user.id
        
        # Check if already liked
        reaction = Reaction.objects(user_id=str(user_id), news_id=pk, type='like').first()
        
        if reaction:
            # Unlike
            reaction.delete()
            news.like_count -= 1
            is_liked = False
        else:
            # Like
            Reaction(user_id=str(user_id), news_id=pk, type='like').save()
            news.like_count += 1
            is_liked = True
        
        news.save()
        
        return Response({
            'success': True,
            'like_count': news.like_count,
            'is_liked': is_liked,
        })
    
    @action(detail=True, methods=['get'])
    def comments(self, request, pk=None):
        # TODO: Implement comments retrieval
        return Response([])
    
    @action(detail=True, methods=['post'], permission_classes=[IsAuthenticated])
    def comments(self, request, pk=None):
        # TODO: Implement comment creation
        return Response({'success': True})

class TrendingViewSet(viewsets.ViewSet):
    permission_classes = [AllowAny]
    
    def list(self, request):
        # TODO: Implement trending calculation
        return Response([
            {'term': 'AI', 'count': 120},
            {'term': 'Crypto', 'count': 95},
        ])

class SearchViewSet(viewsets.ViewSet):
    permission_classes = [AllowAny]
    
    def list(self, request):
        query = request.query_params.get('q', '')
        # TODO: Implement search
        return Response([])