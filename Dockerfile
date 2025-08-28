FROM openjdk:17-jdk-slim AS base

# Cài wget + tar
RUN apt-get update && apt-get install -y wget tar && rm -rf /var/lib/apt/lists/*

# Cài Tomcat 10.1.44
RUN wget https://downloads.apache.org/tomcat/tomcat-10/v10.1.44/bin/apache-tomcat-10.1.44.tar.gz \
    && tar xzf apache-tomcat-10.1.44.tar.gz \
    && mv apache-tomcat-10.1.44 /usr/local/tomcat \
    && rm apache-tomcat-10.1.44.tar.gz

ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH="$CATALINA_HOME/bin:$PATH"

# Xóa webapps mặc định và copy WAR
RUN rm -rf /usr/local/tomcat/webapps/*
COPY ch04_ex1_survey_sol.war /usr/local/tomcat/webapps/ROOT.war

# Render cần PORT env
ENV PORT=10000
CMD sed -i "s/8080/${PORT}/" /usr/local/tomcat/conf/server.xml && catalina.sh run
