FROM tomcat:9.0.1-jre8-alpine
MAINTAINER ericzhangyang@hotmail.com
COPY ./myweb/target/mywebdemo-0.1.war /usr/local/tomcat/webapps/myweb.war
