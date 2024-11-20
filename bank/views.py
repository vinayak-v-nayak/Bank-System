from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, authenticate, logout
from django.contrib.auth.decorators import login_required
from .forms import SignUpForm, DepositForm, TransferForm, BillPaymentForm
from .models import BankAccount, Transaction, Bill
import random
from django.contrib import messages
from decimal import Decimal

def signup(request):
    if request.method == 'POST':
        form = SignUpForm(request.POST)
        if form.is_valid():
            user = form.save()
            # Create an associated Account for the new user
            account_number = f"ACC{random.randint(100000, 999999)}"  # Generate a random account number
            BankAccount.objects.create(user=user, account_number=account_number, balance=0)
            login(request, user)
            return redirect('dashboard')
    else:
        form = SignUpForm()
    return render(request, 'bank/signup.html', {'form': form})

@login_required
def deposit_money(request):
    if request.method == 'POST':
        form = DepositForm(request.POST)
        if form.is_valid():
            # Get the logged-in user's bank account
            bank_account = BankAccount.objects.get(user=request.user)

            # Get the deposit amount from the form
            amount = form.cleaned_data['amount']

            # Create the deposit transaction
            transaction = Transaction.objects.create(
                sender=bank_account,  # The sender is the user's bank account
                receiver=None,  # No receiver for deposit
                amount=amount,
                transaction_type='deposit'  # Mark this as a deposit
            )

            # Update the user's balance
            bank_account.balance += amount
            bank_account.save()

            # Show a success message and redirect
            messages.success(request, f'Deposited ₹{amount} successfully!')
            return redirect('dashboard')
        else:
            # Handle invalid form input
            messages.error(request, 'Invalid amount entered.')

    else:
        # Initialize the empty form
        form = DepositForm()

    return render(request, 'bank/deposit.html', {'form': form})



@login_required
def dashboard(request):
    try:
        account = BankAccount.objects.get(user=request.user)  # Directly using get() instead of get_object_or_404
    except BankAccount.DoesNotExist:
        # Redirect to signup if no bank account exists for the user
        return redirect('signup')  # Assuming 'signup' is the name of the signup view

    transactions = Transaction.objects.filter(sender=account) | Transaction.objects.filter(receiver=account)
    bills = Bill.objects.filter(user=request.user)

    return render(request, 'bank/dashboard.html', {
        'account': account,
        'transactions': transactions,
        'bills': bills,
    })


# In your views.py

@login_required
def transfer_funds(request):
    if request.method == 'POST':
        form = TransferForm(request.POST, user=request.user)  # Pass the user to the form
        if form.is_valid():
            sender_account = get_object_or_404(BankAccount, user=request.user)  # Get sender's account
            receiver_account_number = form.cleaned_data.get('receiver')  # Account number of the receiver
            
            try:
                receiver_account = BankAccount.objects.get(account_number=receiver_account_number)
            except BankAccount.DoesNotExist:
                form.add_error('receiver', "No BankAccount matches the given account number.")
                return render(request, 'bank/transfer_funds.html', {'form': form})

            amount = form.cleaned_data.get('amount')

            # Ensure the sender has sufficient balance
            if sender_account.balance >= amount:
                sender_account.balance -= amount
                receiver_account.balance += amount
                sender_account.save()
                receiver_account.save()

                # Create transaction records
                Transaction.objects.create(sender=sender_account, receiver=receiver_account, amount=amount)
                return redirect('dashboard')
            else:
                form.add_error(None, "Insufficient balance.")
    else:
        form = TransferForm(user=request.user)  # Pass the user to the form

    return render(request, 'bank/transfer_funds.html', {'form': form})


@login_required
def pay_bill(request):
    if request.method == 'POST':
        form = BillPaymentForm(request.POST)
        
        if form.is_valid():
            # Get the logged-in user's bank account
            bank_account = BankAccount.objects.get(user=request.user)
            
            # Get the biller name, amount, and due date from the form
            biller_name = form.cleaned_data['biller_name']
            amount = form.cleaned_data['amount']
            due_date = form.cleaned_data['due_date']
            
            # Check if the user has enough balance
            if bank_account.balance >= amount:
                # Deduct the amount from the user's account
                bank_account.balance -= amount
                bank_account.save()

                # Create the bill record (if you want to store the bill in your database)
                bill = Bill.objects.create(user=request.user, biller_name=biller_name, amount=amount, due_date=due_date)

                # Update the bill status to 'paid'
                bill.status = 'paid'
                bill.save()

                # Create the transaction record
                transaction = Transaction.objects.create(
                    sender=bank_account,  # Sender is the user's bank account
                    receiver=None,  # No receiver for a bill payment
                    amount=amount,
                    transaction_type='bill_payment',  # Mark this as a bill payment
                    biller_name=biller_name  # Store the biller's name in the transaction record
                )

                # Show a success message and redirect to dashboard
                messages.success(request, f'Bill paid successfully to {biller_name}!')
                return redirect('dashboard')
            else:
                # Show an error if balance is insufficient
                messages.error(request, 'Insufficient balance to pay this bill.')
        else:
            # Show an error if form is invalid
            messages.error(request, 'Error in form submission.')

    else:
        form = BillPaymentForm()

    return render(request, 'bank/pay_bill.html', {'form': form})





def user_login(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(username=username, password=password)
        if user:
            login(request, user)
            return redirect('dashboard')
        else:
            return render(request, 'bank/login.html', {'error': 'Invalid username or password.'})
    return render(request, 'bank/login.html', {})

@login_required
def user_logout(request):
    logout(request)
    return redirect('login')


from .forms import UserProfileUpdateForm
from .forms import ProfileUpdateForm
from .models import UserProfile

# View for Profile Page
@login_required
def profile(request):
    try:
        user_profile = UserProfile.objects.get(user=request.user)
    except UserProfile.DoesNotExist:
        user_profile = UserProfile.objects.create(user=request.user)

    return render(request, 'bank/profile.html', {
        'user': request.user,
        'profile': user_profile
    })

# View for Update Profile Page
@login_required
def update_profile(request):
    try:
        user_profile = UserProfile.objects.get(user=request.user)
    except UserProfile.DoesNotExist:
        user_profile = UserProfile.objects.create(user=request.user)

    if request.method == 'POST':
        # Handling the update for User model (username, email)
        user_form = ProfileUpdateForm(request.POST, instance=request.user)
        # Handling the update for UserProfile model (phone_number, address)
        profile_form = UserProfileUpdateForm(request.POST, instance=user_profile)

        if user_form.is_valid() and profile_form.is_valid():
            user_form.save()  # Save the updated User model (username, email)
            profile_form.save()  # Save the updated UserProfile model (phone_number, address)
            return redirect('profile')  # Redirect back to the profile page with updated data
    else:
        user_form = ProfileUpdateForm(instance=request.user)
        profile_form = UserProfileUpdateForm(instance=user_profile)

    return render(request, 'bank/update_profile.html', {
        'user_form': user_form,
        'profile_form': profile_form,
        'user_profile': user_profile
    })


from .forms import ServiceRequestForm
from .models import ServiceRequest

@login_required
def request_service(request):
    if request.method == 'POST':
        form = ServiceRequestForm(request.POST)
        if form.is_valid():
            service_request = form.save(commit=False)
            service_request.user = request.user
            service_request.save()
            return redirect('dashboard')  # Redirect to dashboard after form submission

    else:
        form = ServiceRequestForm()

    return render(request, 'bank/request_service.html', {'form': form})

@login_required
def my_requests(request):
    # Get the service requests for the logged-in user
    user_requests = ServiceRequest.objects.filter(user=request.user)

    return render(request, 'bank/my_requests.html', {'user_requests': user_requests})


from .forms import WithdrawForm  # Create a form for withdrawal

@login_required
def withdraw_money(request):
    account = BankAccount.objects.get(user=request.user)
    
    if request.method == 'POST':
        form = WithdrawForm(request.POST)
        if form.is_valid():
            amount = form.cleaned_data['amount']
            if amount <= account.balance:
                # Deduct the amount from the account balance
                account.balance -= amount
                account.save()

                # Log the withdrawal transaction
                Transaction.objects.create(
                    sender=account,  # The user's account
                    receiver=None,   # No receiver for withdrawal
                    amount=amount,
                    transaction_type='withdraw'  # Mark this as a withdrawal
                )

                # Show a success message
                messages.success(request, f"Successfully withdrawn {amount}.")
                return redirect('dashboard')
            else:
                # Handle insufficient balance
                messages.error(request, "Insufficient balance.")
    else:
        # Initialize the empty form
        form = WithdrawForm()

    return render(request, 'bank/withdraw.html', {'form': form, 'account': account})


@login_required
def account_statement(request):
    # Get the user's bank account
    account = request.user.bankaccount
    
    # Get all transactions related to this account
    transactions = Transaction.objects.filter(
        sender=account
    ) | Transaction.objects.filter(
        receiver=account
    )
    
    transactions = transactions.order_by('-timestamp')  # Order by most recent

    return render(request, 'bank/account_statement.html', {'transactions': transactions, 'account': account})