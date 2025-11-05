from mongoengine import Document, StringField, ListField, DictField, DateTimeField, BooleanField
from django.contrib.auth.models import AbstractUser

class Profile(Document):
    user_id = StringField(required=True, unique=True)
    name = StringField(required=True)
    email = StringField(required=True, unique=True)
    roles = ListField(StringField(), default=['user'])
    followed_sources = ListField(StringField())
    fcm_tokens = ListField(StringField())
    settings = DictField(default={'dark_mode': False, 'language': 'en'})
    is_active = BooleanField(default=True)
    created_at = DateTimeField(default=datetime.utcnow)
    updated_at = DateTimeField(default=datetime.utcnow)
    
    meta = {'collection': 'profiles'}

class Follow(Document):
    user_id = StringField(required=True)
    source_id = StringField(required=True)
    created_at = DateTimeField(default=datetime.utcnow)
    
    meta = {'collection': 'follows', 'indexes': [
        {'fields': ['user_id', 'source_id'], 'unique': True}
    ]}