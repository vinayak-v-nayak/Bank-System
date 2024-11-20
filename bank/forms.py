from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm
from .models import BankAccount,Transaction, Bill


class TransferForm(forms.Form):
    receiver = forms.ChoiceField(choices=[])  # Initially empty, to be populated dynamically
    amount = forms.DecimalField(max_digits=10, decimal_places=2)

    def __init__(self, *args, user=None, **kwargs):
        super().__init__(*args, **kwargs)
        self.user = user  # Save the user to the instance
        if user:
            # Dynamically populate the receiver choices with all bank account numbers (except the current user's)
            self.fields['receiver'].choices = [
                (account.account_number, account.account_number) 
                for account in BankAccount.objects.exclude(user=user)
            ]


class BillPaymentForm(forms.Form):
    biller_name = forms.CharField(max_length=100)
    amount = forms.DecimalField(max_digits=10, decimal_places=2)
    due_date = forms.DateField(widget=forms.widgets.DateInput(attrs={'type': 'date'}))  # Adds date picker

class SignUpForm(UserCreationForm):
    email = forms.EmailField(required=True)

    class Meta:
        model = User
        fields = ('username', 'email', 'password1', 'password2')

class LoginForm(forms.Form):
    username = forms.CharField(max_length=150)
    password = forms.CharField(widget=forms.PasswordInput)

class DepositForm(forms.Form):
    amount = forms.DecimalField(max_digits=10, decimal_places=2, required=True, label="Deposit Amount")



from .models import UserProfile

class ProfileUpdateForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['username', 'email']

class UserProfileUpdateForm(forms.ModelForm):
    class Meta:
        model = UserProfile
        fields = ['phone_number', 'address']



from .models import ServiceRequest

class ServiceRequestForm(forms.ModelForm):
    class Meta:
        model = ServiceRequest
        fields = ['service_type', 'details']

    cheque_leaves = forms.IntegerField(required=False)
    card_type = forms.CharField(max_length=20, required=False)
    new_address = forms.CharField(widget=forms.Textarea, required=False)
    new_limit = forms.IntegerField(required=False)
    loan_amount = forms.DecimalField(max_digits=10, decimal_places=2, required=False)
    loan_term = forms.IntegerField(required=False)

    def __init__(self, *args, **kwargs):
        super(ServiceRequestForm, self).__init__(*args, **kwargs)

        # Dynamically enable/disable fields based on selected service type
        if 'service_type' in self.data:
            service_type = self.data.get('service_type')
            if service_type == 'Cheque Book':
                self.fields['cheque_leaves'].required = True
            elif service_type == 'Credit/Debit Card':
                self.fields['card_type'].required = True
            elif service_type == 'Address Change':
                self.fields['new_address'].required = True
            elif service_type == 'Transaction Limit':
                self.fields['new_limit'].required = True
            elif service_type == 'Loan Inquiry':
                self.fields['loan_amount'].required = True
                self.fields['loan_term'].required = True
        elif self.instance.pk:
            # For pre-filled data (if the service type was already selected)
            service_type = self.instance.service_type
            if service_type == 'Cheque Book':
                self.fields['cheque_leaves'].required = True
            elif service_type == 'Credit/Debit Card':
                self.fields['card_type'].required = True
            elif service_type == 'Address Change':
                self.fields['new_address'].required = True
            elif service_type == 'Transaction Limit':
                self.fields['new_limit'].required = True
            elif service_type == 'Loan Inquiry':
                self.fields['loan_amount'].required = True
                self.fields['loan_term'].required = True



class WithdrawForm(forms.Form):
    amount = forms.DecimalField(
        max_digits=10, 
        decimal_places=2, 
        min_value=1, 
        label="Amount to Withdraw"
    )