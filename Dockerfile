FROM openjdk:11

RUN apt update && apt install -y dumb-init wait-for-it
MAINTAINER mail@ingvord.ru

ARG JAR_FILE
ADD target/${JAR_FILE} /app/bin/virtual-tango-host.jar

RUN addgroup --system javauser && adduser --disabled-password --no-create-home --shell /bin/false --ingroup javauser --gecos "" javauser
RUN chown -R javauser /app

USER javauser

WORKDIR /app

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/bin/bash", "-c", "java -jar -server /app/bin/virtual-tango-host.jar"]
