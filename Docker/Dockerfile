FROM python:latest
RUN mkdir /djangoweb
WORKDIR /djangoweb
ARG ATC_USERNAME=veerapandi
ARG ATC_PASSWORD=pass123
COPY . .
RUN touch index.html && echo $ATC_USERNAME >> index.html && echo $ATC_PASSWORD >> index.html && pip3 install -r requirements.txt && rm -rf ss/templates/index.html && cp index.html ss/templates/

ENTRYPOINT [ "python3", "manage.py", "runserver", "0.0.0.0:8000" ]
