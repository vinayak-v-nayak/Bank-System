from django.contrib import admin
from django.urls import path, include
from accounts.views import index  # Import the view for the homepage

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', index, name='home'),  # Add this line for the homepage
    path('accounts/', include('accounts.urls')),
]