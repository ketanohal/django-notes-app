# Use official Python 3.9 image
FROM python:3.9

# Set the working directory
WORKDIR /app/backend

# Copy requirements file
COPY requirements.txt /app/backend

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    default-libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . /app/backend

# Expose the port for Django
EXPOSE 8000

# Run migrations before starting the server
RUN python manage.py makemigrations && python manage.py migrate

# Start Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
