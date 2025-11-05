from rest_framework import serializers
from .models import News, Source, Comment, Reaction

class SourceSerializer(serializers.Serializer):
    id = serializers.CharField(source='_id')
    name = serializers.CharField()
    url = serializers.URLField()
    is_verified = serializers.BooleanField()
    category = serializers.CharField()

class NewsSerializer(serializers.Serializer):
    id = serializers.CharField(source='_id')
    title = serializers.CharField()
    excerpt = serializers.CharField()
    content = serializers.CharField()
    url = serializers.URLField()
    image_url = serializers.URLField()
    published_at = serializers.DateTimeField()
    source = SourceSerializer()
    view_count = serializers.IntegerField()
    like_count = serializers.IntegerField()
    comments_count = serializers.SerializerMethodField()
    is_liked = serializers.SerializerMethodField()
    is_bookmarked = serializers.SerializerMethodField()
    tags = serializers.ListField(child=serializers.CharField())
    
    def get_comments_count(self, obj):
        # TODO: Implement comment count
        return 0
    
    def get_is_liked(self, obj):
        # TODO: Check if user liked
        return False
    
    def get_is_bookmarked(self, obj):
        # TODO: Check if user bookmarked
        return False

class CommentSerializer(serializers.Serializer):
    id = serializers.CharField()
    body = serializers.CharField()
    user_id = serializers.CharField()
    user_name = serializers.CharField()
    parent_id = serializers.CharField(allow_null=True)
    created_at = serializers.DateTimeField()
    like_count = serializers.IntegerField()
    replies = serializers.ListField(child=serializers.DictField())

class ReactionSerializer(serializers.Serializer):
    user_id = serializers.CharField()
    news_id = serializers.CharField()
    type = serializers.ChoiceField(choices=['like', 'bookmark'])