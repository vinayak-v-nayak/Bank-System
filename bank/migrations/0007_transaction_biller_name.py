# Generated by Django 5.1.3 on 2024-11-17 16:55

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('bank', '0006_bill_status'),
    ]

    operations = [
        migrations.AddField(
            model_name='transaction',
            name='biller_name',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
    ]
