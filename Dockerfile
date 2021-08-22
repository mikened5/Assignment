FROM python:3.9.4-slim

RUN apt-get update
RUN pip install Flask

ADD . /opt/webapp

WORKDIR /opt/webapp

ENV FLASK_APP=TreeAssignment.py

EXPOSE 5000

CMD [ "flask", "run", "--host=0.0.0.0" ]