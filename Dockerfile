FROM python:3.7-alpine

# Set the working directory inside the container
WORKDIR /code

# Environment variables for Flask
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000

# Install dependencies
RUN apk add --no-cache gcc musl-dev linux-headers

# Copy the requirements.txt and install dependencies
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Expose the port Flask will run on
EXPOSE 5000

# Command to run Flask app
CMD ["flask", "run"]
