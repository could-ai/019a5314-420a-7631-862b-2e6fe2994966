from rest_framework import serializers
from .models import Profile

class ProfileSerializer(serializers.Serializer):
    id = serializers.CharField(source='_id')
    user_id = serializers.CharField()
    name = serializers.CharField()
    email = serializers.EmailField()
    roles = serializers.ListField(child=serializers.CharField())
    followed_sources = serializers.ListField(child=serializers.CharField())
    settings = serializers.DictField()

class GoogleAuthSerializer(serializers.Serializer):
    id_token = serializers.CharField(required=True)

class AuthResponseSerializer(serializers.Serializer):
    access = serializers.CharField()
    refresh = serializers.CharField()
    user = ProfileSerializer()