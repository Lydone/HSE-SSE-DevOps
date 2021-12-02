# Task 1
docker build -t task1 .
docker run -p 5000:5000 task1

To test, go to a browser and enter http://localhost:5000/app - you will see "ok" string

# Task 2
docker-compose up -d

To test, wait 2 minutes, then go to a browser and enter http://localhost:8080/ - you will see main web page