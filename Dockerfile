FROM tomcat:latest 
COPY ./target/*.jar /usr/local/tomcat/webapps
EXPOSE 8090
