from django.db import models
from django.contrib.auth.models import User
import uuid

from django.db import models
from django.contrib.auth.models import User

class BankAccount(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    account_number = models.CharField(max_length=20, unique=True)
    balance = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f"{self.user.username}'s Bank Account"

class Transaction(models.Model):
    sender = models.ForeignKey(BankAccount, related_name='sent_transactions', on_delete=models.CASCADE)
    receiver = models.ForeignKey(BankAccount, related_name='received_transactions', on_delete=models.CASCADE, null=True, blank=True)  # Receiver is optional for bill payments
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    timestamp = models.DateTimeField(auto_now_add=True)

    # Add 'deposit' to the choices to handle deposit transactions
    transaction_type = models.CharField(
        max_length=20,
        choices=[('transfer', 'Transfer'), ('bill_payment', 'Bill Payment'), ('deposit', 'Deposit')],
        default='transfer'
    )

    biller_name = models.CharField(max_length=100, null=True, blank=True)  # For bill payments

    def __str__(self):
        # Special case handling for withdrawal and deposit
        if self.transaction_type == 'deposit':
            return f"Deposit of {self.amount} to {self.sender.user.username}'s account"
        elif self.transaction_type == 'withdraw':
            return f"Withdrawal of {self.amount} from {self.sender.user.username}'s account"
        receiver_name = self.receiver.user.username if self.receiver else self.biller_name or 'Unknown Biller'
        return f"Transaction of {self.amount} from {self.sender.user.username} to {receiver_name}"


class Bill(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    biller_name = models.CharField(max_length=100)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    due_date = models.DateField()
    status = models.CharField(max_length=20, default='unpaid')  # 'unpaid' by default

    def __str__(self):
        return f"Bill from {self.biller_name} for ₹{self.amount} due on {self.due_date}"

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phone_number = models.CharField(max_length=15, blank=True, null=True)
    address = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.user.username}'s Profile"
    




class ServiceRequest(models.Model):
    SERVICE_CHOICES = [
        ('Cheque Book', 'Cheque Book'),
        ('Credit/Debit Card', 'Credit/Debit Card'),
        ('Loan Inquiry', 'Loan Inquiry'),
        ('ATM Card Blocking/Replacement', 'ATM Card Blocking/Replacement'),
        ('Address Change', 'Address Change'),
        ('Transaction Limit', 'Transaction Limit'),
    ]

    STATUS_CHOICES = [
        ('Pending', 'Pending'),
        ('Processed', 'Processed'),
        ('Rejected', 'Rejected'),
    ]

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    service_type = models.CharField(max_length=50, choices=SERVICE_CHOICES)
    details = models.TextField(blank=True, null=True)  # Optional details for any service
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='Pending')
    created_at = models.DateTimeField(auto_now_add=True)

    cheque_leaves = models.IntegerField(blank=True, null=True)  # For cheque book requests
    start_date = models.DateField(blank=True, null=True)        # For account statements
    end_date = models.DateField(blank=True, null=True)          # For account statements
    card_type = models.CharField(max_length=20, blank=True, null=True)  # For card requests
    new_address = models.TextField(blank=True, null=True)       # For address change
    new_limit = models.IntegerField(blank=True, null=True)      # For transaction limit changes
    loan_amount = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)  # For loan inquiry
    loan_term = models.IntegerField(blank=True, null=True)  # For loan inquiry (loan term)

    def __str__(self):
        return f"{self.service_type} Request by {self.user.username}"