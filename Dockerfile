FROM openjdk:8
  
EXPOSE 8081
 
ENV APP_HOME /usr/src/app

COPY target/petclinic.jar $APP_HOME/app.jar

WORKDIR $APP_HOME

ENTRYPOINT exec java -jar app.jar 
