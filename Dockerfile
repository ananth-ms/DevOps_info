FROM httpd 
RUN apt update

RUN apt install git -y

RUN git clone  https://github.com/ananth-ms/infinity.git
RUN cp -r https://github.com/ananth-ms/infinity.git/* /usr/local/apache2/htdocs/
EXPOSE 80

