import pytest
from django.test import TestCase
from rest_framework.test import APITestCase
from mongoengine import connect, disconnect

@pytest.fixture(scope='session', autouse=True)
@pytest.mark.django_db
class TestBase(APITestCase):
    @classmethod
    def setUpClass(cls):
        super().setUpClass()
        # Connect to test database
        connect('test_pulsex', host='mongomock://localhost')
    
    @classmethod
    def tearDownClass(cls):
        disconnect()
        super().tearDownClass()

def test_google_auth():
    # TODO: Test Google authentication
    pass

def test_news_feed():
    # TODO: Test news feed API
    pass

def test_like_toggle():
    # TODO: Test like functionality
    pass