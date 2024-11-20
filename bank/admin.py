from django.contrib import admin

# Register your models here.
from .models import BankAccount, Transaction, Bill, UserProfile, ServiceRequest

admin.site.register(BankAccount)
admin.site.register(Transaction)
admin.site.register(Bill)
admin.site.register(UserProfile)
admin.site.register(ServiceRequest)