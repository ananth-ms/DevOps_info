FROM httpd

RUN yum update -y
COPY . /usr/local/apache2/htdocs/
EXPOSE 80




