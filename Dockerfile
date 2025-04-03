# Use official Python 3.9 image
FROM python:3.9

# Set the working directory
WORKDIR /app/backend

# Copy and install dependencies
COPY requirements.txt /app/backend

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev python3-dev musl-dev mariadb-dev \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir -r requirements.txt

# Copy all project files
COPY . /app/backend

# Expose the port for Django
EXPOSE 8000

# Run migrations before starting the server
RUN python manage.py makemigrations && python manage.py migrate

# Start Django application
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
