from django.urls import path
from .views import register, login_view, dashboard, transfer_funds

urlpatterns = [
    path('register/', register, name='register'),
    path('login/', login_view, name='login'),
    path('dashboard/', dashboard, name='dashboard'),
    path('transfer/', transfer_funds, name='transfer_funds'),
]