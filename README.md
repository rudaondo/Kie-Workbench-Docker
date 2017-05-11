# Kie Workbench Docker image

This is an Dockerfile with [Kie Workbench 6.5.0.Final](http://www.jbpm.org/).

## Build Docker

To build the docker you must launch the following command.

    docker build -t rudaondo/kie-workbench 
	
Behind the proxy.

    docker build --build-arg HTTP_PROXY=http://user:passwd:user:passwd@ProxyIP:ProxyPort --build-arg HTTPS_PROXY=http://user:passwd:user:passwd@ProxyIP:ProxyPort -t rudaondo/kie-workbench
	
## Usage

To boot in standalone mode with admin console available remotely

    docker run -p 8080:8080 -p 9990:9990 rudaondo/kie-workbench 

## WildFly Administration Console

Administration console will be available on the port `9990` of the container. The admin user is "wildflyadmin" and the key "wildflypassword"

## Kie-Workbench Console

Kie Workbench  console will be available on the url http://localhost:8080/kie-workbench of the container. The admin user is `kieserver` and the key `kieadmin`.


