# image to build a webapp image

FROM tomcat:latest
RUN rm -rf webapps
RUN mv webapps.dist webapps
EXPOSE 8080
COPY $WORSPACE/webapp/target/webapp-5.0-SNAPSHOT.war /usr/local/tomcat/webapps
ENTRYPOINT sh bin/startup.sh
