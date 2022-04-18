# image to build a webapp image

FROM tomcat:latest
RUN rm -rf webapps
RUN mv webapps.dist webapps
EXPOSE 8080
COPY $WORSPACE/webapp/target/webapp.war /usr/local/tomcat/webapps
