FROM ubuntu:21.04

EXPOSE 5000

RUN apt update
RUN DEBIAN_FRONTEND="noninteractive" apt install -y build-essential cmake python3-pip python3.9-full
RUN pip install --upgrade pip
RUN pip install flask

WORKDIR /app

COPY /cmake-with-flask .

#Subtask a
RUN cmake . && make && ./bin/C

#Subtask b
RUN useradd -m techproguser

#Subtask c
CMD python3 app.py --port=5000 --host="0.0.0.0"
