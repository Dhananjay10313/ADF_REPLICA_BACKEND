# Use an official Python base image
FROM python:3.10

# Set the working directory in the container
WORKDIR /app

# Install system dependencies for ODBC
RUN apt-get update && apt-get install -y \
    curl gnupg unixodbc msodbcsql17 && \
    rm -rf /var/lib/apt/lists/*

# Copy the application files
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Expose the required port for Uvicorn
EXPOSE 8000

# Start the FastAPI application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
