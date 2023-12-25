FROM openjdk:8
ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar demo-helloworld.jar
ENTRYPOINT [ "java", "-jar", "demo-helloworld.jar" ]