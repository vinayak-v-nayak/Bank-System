import os
import sys

def main():
    """Run administrative tasks."""
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'banking_app.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    
    # Add a debug note to assist with troubleshooting
    print("Running manage.py...")
    print("Environment:", os.environ.get('DJANGO_SETTINGS_MODULE'))
    
    execute_from_command_line(sys.argv)

if __name__ == '__main__':
    main()
