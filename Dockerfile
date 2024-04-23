FROM openjdk:8
  
EXPOSE 8081
 
ENV APP_HOME /usr/src/app

COPY target/petclinic.war  $APP_HOME/app.war

WORKDIR $APP_HOME

ENTRYPOINT exec java -jar app.war 
