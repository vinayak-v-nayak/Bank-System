from django.shortcuts import render, redirect
from django.contrib.auth import login, authenticate
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.decorators import login_required
from .models import Account, Transaction

def index(request):
    """Homepage view."""
    return render(request, 'accounts/index.html')  # Ensure this template exists

def register(request):
    """Handles user registration."""
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()  # Save the new user
            Account.objects.create(user=user)  # Create an account for the new user
            login(request, user)  # Log the user in after registration
            return redirect('dashboard')  # Redirect to the dashboard after successful registration
    else:
        form = UserCreationForm()  # Create an empty form for GET requests
    return render(request, 'accounts/register.html', {'form': form})  # Render the registration template

def login_view(request):
    """Handles user login."""
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)  # Authenticate the user
        if user is not None:
            login(request, user)  # Log the user in
            return redirect('dashboard')  # Redirect to the dashboard after successful login
    return render(request, 'accounts/login.html')  # Render the login template

@login_required
def dashboard(request):
    """Displays the user's dashboard with account and transaction information."""
    account = Account.objects.get(user=request.user)  # Get the user's account
    transactions = Transaction.objects.filter(sender=account) | Transaction.objects.filter(receiver=account)  # Get transactions for the account
    return render(request, 'accounts/dashboard.html', {'account': account, 'transactions': transactions})  # Render the dashboard template

@login_required
def transfer_funds(request):
    """Handles fund transfer between users."""
    if request.method == 'POST':
        receiver_username = request.POST['receiver']  # Get the receiver's username
        amount = request.POST['amount']  # Get the transfer amount
        sender_account = Account.objects.get(user=request.user)  # Get the sender's account

        try:
            receiver_account = Account.objects.get(user__username=receiver_username)  # Get the receiver's account

            # Check if the sender has enough balance
            if sender_account.balance >= float(amount):
                sender_account.balance -= float(amount)  # Deduct the amount from sender's account
                receiver_account.balance += float(amount)  # Add the amount to receiver's account
                sender_account.save()  # Save the updated sender account
                receiver_account.save()  # Save the updated receiver account
                Transaction.objects.create(sender=sender_account, receiver=receiver_account, amount=amount)  # Create a transaction record
                return redirect('dashboard')  # Redirect to the dashboard after successful transfer
            else:
                return render(request, 'accounts/transfer_funds.html', {'error': 'Insufficient balance.'})  # Show error if insufficient balance
        except Account.DoesNotExist:
            return render(request, 'accounts/transfer_funds.html', {'error': 'Receiver account does not exist.'})  # Show error if receiver does not exist
    return render(request, 'accounts/transfer_funds.html')  # Render the transfer funds template