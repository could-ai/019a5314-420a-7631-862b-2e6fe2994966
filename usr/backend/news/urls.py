from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import NewsViewSet, TrendingViewSet, SearchViewSet

router = DefaultRouter()
router.register(r'news', NewsViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('trends/', TrendingViewSet.as_view({'get': 'list'}), name='trends'),
    path('search/', SearchViewSet.as_view({'get': 'list'}), name='search'),
]