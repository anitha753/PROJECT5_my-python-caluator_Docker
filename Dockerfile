# Base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Update the package repository and install necessary dependencies
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

# Create a virtual environment
RUN python3 -m venv /venv

# Activate the virtual environment
ENV PATH="/venv/bin:$PATH"

# Copy requirement.txt
COPY requirement.txt .

# Install the dependencies
RUN pip3 install --no-cache-dir -r requirement.txt

# Copy the application files
COPY app.py .
COPY templates/ ./templates
COPY static ./static

# Expose the application port
EXPOSE 5000

# Set environment variables
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Run the application
CMD ["flask", "run"]

