from mongoengine import Document, StringField, DateTimeField, IntField, ListField, BooleanField, ReferenceField, EmbeddedDocument, EmbeddedDocumentField

class Source(Document):
    name = StringField(required=True, unique=True)
    url = StringField()
    is_verified = BooleanField(default=False)
    category = StringField()
    last_scraped_at = DateTimeField()
    created_at = DateTimeField(default=datetime.utcnow)
    updated_at = DateTimeField(default=datetime.utcnow)
    
    meta = {'collection': 'sources'}

class News(Document):
    title = StringField(required=True)
    excerpt = StringField()
    content = StringField()
    url = StringField(required=True, unique=True)
    image_url = StringField()
    published_at = DateTimeField(required=True)
    source = ReferenceField(Source, required=True)
    view_count = IntField(default=0)
    like_count = IntField(default=0)
    tags = ListField(StringField())
    created_at = DateTimeField(default=datetime.utcnow)
    updated_at = DateTimeField(default=datetime.utcnow)
    
    meta = {'collection': 'news'}

class Comment(EmbeddedDocument):
    comment_id = StringField(required=True)
    user_id = StringField(required=True)
    body = StringField(required=True)
    parent_id = StringField()
    created_at = DateTimeField(default=datetime.utcnow)
    edited_at = DateTimeField()
    like_count = IntField(default=0)
    replies = ListField(EmbeddedDocumentField('self'))
    
class Reaction(Document):
    user_id = StringField(required=True)
    news_id = StringField(required=True)
    type = StringField(required=True, choices=['like', 'bookmark'])
    created_at = DateTimeField(default=datetime.utcnow)
    
    meta = {'collection': 'reactions'}

class View(Document):
    user_id = StringField()
    news_id = StringField(required=True)
    viewed_at = DateTimeField(default=datetime.utcnow)
    
    meta = {'collection': 'views'}

class AnalyticsEvent(Document):
    event_id = StringField(required=True, unique=True)
    user_id = StringField()
    event_type = StringField(required=True)
    metadata = DictField()
    created_at = DateTimeField(default=datetime.utcnow)
    
    meta = {'collection': 'analytics_events'}