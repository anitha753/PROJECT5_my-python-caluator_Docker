MULTI STAGE DOCKERFILE
=============================================================
#STAGE 1 Build the application
#Base image
FROM ubuntu:20.04 As builder
#set the working directiry
WORKDIR /app
RUN apt-get update && apt-get install -y python3 python3-pip
#copy requirements
COPY requirement.txt .
#install the dependency
RUN pip3 install --no-cache-dir -r requirement.txt
#copy the application files
COPY app.py .
COPY templates/ ./templates
COPY static ./static

#STAGE 2 final stage
FROM python:3.9-slim
#set workdir
WORKDIR /app
#copy the build application files from the builder stage
COPY --from=builder /app .
#Install Flask from the builder stage
RUN pip3 install --no-cache-dir Flask
#expose
EXPOSE 5000
#SET env variables
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
#run the application
CMD ["python3", "-m", "flask", "run"]

=========================================without tags====================
#STAGE 1 Build the application
#Base image
FROM ubuntu:20.04 As builder
WORKDIR /app
RUN apt-get update && apt-get install -y python3 python3-pip
COPY requirement.txt .
RUN pip3 install --no-cache-dir -r requirement.txt
COPY app.py .
COPY templates/ ./templates
COPY static ./static

#STAGE 2 final stage
FROM python:3.9-slim
WORKDIR /app
COPY --from=builder /app .
RUN pip3 install --no-cache-dir Flask
EXPOSE 5000
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
CMD ["python3", "-m", "flask", "run"]
