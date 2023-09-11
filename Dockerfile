# pull official base image
FROM python:3.11.4-slim-buster

# set work directory
WORKDIR /usr/src/server

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install system dependencies
RUN apt-get update && apt-get install -y netcat git

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements_dev.txt .
RUN pip install -r requirements_dev.txt

# copy entrypoint.sh
COPY ./entrypoint.sh .
RUN sed -i 's/\r$//g' /usr/src/server/entrypoint.sh
RUN chmod +x /usr/src/server/entrypoint.sh

# copy project
COPY . .

# run entrypoint.sh
ENTRYPOINT ["/usr/src/server/entrypoint.sh"]
