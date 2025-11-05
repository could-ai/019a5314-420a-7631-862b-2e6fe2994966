import pytest
from django.test import TestCase
from rest_framework.test import APITestCase
from mongoengine import connect, disconnect

@pytest.fixture(scope='session', autouse=True)
@pytest.mark.django_db
class TestNews(APITestCase):
    @classmethod
    def setUpClass(cls):
        super().setUpClass()
        connect('test_pulsex', host='mongomock://localhost')
    
    @classmethod
    def tearDownClass(cls):
        disconnect()
        super().tearDownClass()

def test_news_list():
    # TODO: Test news listing
    pass

def test_news_detail():
    # TODO: Test news detail
    pass

def test_comments():
    # TODO: Test comments functionality
    pass