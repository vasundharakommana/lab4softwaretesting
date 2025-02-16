#!/bin/bash

url="http://web:5000"
max_attempts=10
attempt=1

# Allow the web service to initialize properly before starting the test
sleep 5

while [ $attempt -le $max_attempts ]
do
  echo "Requesting from web service..."

  # Get the response from the web service
  response=$(curl -s -w "%{http_code}" -o /tmp/response.txt $url)
  echo "Response Code: $response"

  # Extract the visit count from the response using sed
  visits=$(cat /tmp/response.txt | sed 's/Hello World! I have been seen\([0-9]\{1,\}\) times./\1/')
  echo "Extracted visits: $visits"

  # Check if the visit count is increasing
  if [ $visits -ge 5 ]; then
    echo "Test Passed! Visits have increased."
  else
    echo "Test failed. Visits: $visits"
  fi

  # Retry after a brief pause
  sleep 2
  attempt=$((attempt + 1))
done
