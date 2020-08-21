FROM openjdk:8-jdk-slim
RUN apt update -y && apt upgrade -y
RUN apt-get install sudo -y
RUN useradd -s /bin/bash -m -d /home/msuser msuser
RUN usermod -aG sudo msuser
RUN echo "msuser   ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
USER msuser
ENV PORT 8080
EXPOSE 8080
COPY ./gradle-springboot/build/libs/*.jar /opt/app.jar
ADD https://search.maven.org/remotecontent?filepath=co/elastic/apm/elastic-apm-agent/1.9.0/elastic-apm-agent-1.9.0.jar /opt/apm-agent.jar
WORKDIR /opt
CMD ["java", "-Dserver.port=${PORT}", "-XshowSettings:vm", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseG1GC", "-jar", "app.jar"]
