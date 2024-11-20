from django.urls import path
from . import views


urlpatterns = [
    path('', views.dashboard, name='dashboard'),  # Dashboard view for logged-in users
    path('transfer/', views.transfer_funds, name='transfer_funds'),  # View for transferring funds
    path('pay_bill/', views.pay_bill, name='pay_bill'),  # View for paying bills
    path('signup/', views.signup, name='signup'),  # Signup view for new users
    path('login/', views.user_login, name='login'),  # Login view for existing users
    path('logout/', views.user_logout, name='logout'),  # Logout view for users
    path('deposit/', views.deposit_money, name='deposit_money'),
    path('update_profile/', views.update_profile, name='update_profile'),
    path('profile/', views.profile, name='profile'),
    path('request-service/', views.request_service, name='request_service'),
    path('my-requests/', views.my_requests, name='my_requests'),
    path('withdraw/', views.withdraw_money, name='withdraw'),
    path('account-statement/', views.account_statement, name='account_statement'),
]