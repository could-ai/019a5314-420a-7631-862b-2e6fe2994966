from rest_framework.permissions import BasePermission

class IsAdminOrReadOnly(BasePermission):
    def has_permission(self, request, view):
        if request.method in ['GET', 'HEAD', 'OPTIONS']:
            return True
        return request.user and request.user.is_staff

class IsOwnerOrAdmin(BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.user.is_staff:
            return True
        return obj.user_id == str(request.user.id)

class HasRole(BasePermission):
    def __init__(self, role):
        self.role = role
    
    def has_permission(self, request, view):
        if not request.user:
            return False
        # TODO: Check user roles from profile
        return self.role in ['user']  # Placeholder