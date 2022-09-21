FROM bluedata/centos7
MAINTAINER syju
LABEL tomcat=v9.0.65
RUN yum -y install wget && \
    yum -y install unzip

WORKDIR /opt/tomcat

RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65.tar.gz --no-check-certificate
RUN tar -xvzf apache-tomcat-9.0.65.tar.gz
RUN mv apache-tomcat-9.0.65/* /opt/tomcat/.
RUN yum -y install java
RUN java -version
RUN rm -rf /opt/tomcat/conf/tomcat-users.xml
ADD tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml
ADD manager/context.xml /opt/tomcat/webapps/manager/META-INF/context.xml
ADD host-manager/context.xml /opt/tomcat/webapps/host-manger/META-INF/context.xml
ADD SampleWebApp.war /opt/tomcat/webapps/SampleWebApp.war
COPY --from=slave01 /home/jenkins-slave/workspace/final-pipline-2/target/simple-app-3.0.0-SNAPSHOT.war /opt/tomcat/webapps/simple-app-3.0.0-SNAPSHOT.war

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
