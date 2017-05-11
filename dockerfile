# Use latest jboss/base-jdk:8 image as the base
FROM rudaondo/wildfly

ENV JBOSS_HOME /opt/jboss/wildfly

USER root

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd $HOME \
	&& ${JBOSS_HOME}/bin/add-user.sh -a -u kieadmin -p kiepassword -ro admin,kie-server,rest-all,kiemgmt

# Set the KIE env variable
#ENV KIE_REPOSITORY https://repository.jboss.org/nexus/content/groups/public-jboss
ENV KIE_REPOSITORY https://download.jboss.org/drools/release/
ENV KIE_VERSION 6.5.0.Final
#ENV KIE_CLASSIFIER ee7
ENV KIE_CLASSIFIER wildfly10
ENV KIE_CONTEXT_PATH kie-server

###### INSTALL PACKAGES ######
# RUN yum install -y net-tools

##### SWITCH BACK TO jboss ####
USER jboss

####### KIE-SERVER ############
#RUN curl -o $HOME/$KIE_CONTEXT_PATH.war $KIE_REPOSITORY/org/kie/server/kie-server/$KIE_VERSION/kie-server-$KIE_VERSION-$KIE_CLASSIFIER.war && \
RUN curl -o $HOME/$KIE_CONTEXT_PATH.war $KIE_REPOSITORY/$KIE_VERSION/kie-drools-wb-$KIE_VERSION-$KIE_CLASSIFIER.war && \
	unzip -q $HOME/$KIE_CONTEXT_PATH.war -d $JBOSS_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war &&  \
	touch $JBOSS_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war.dodeploy &&  \
	rm -rf $HOME/$KIE_CONTEXT_PATH.war

# Expose the ports we're interested in
EXPOSE 8080
EXPOSE 9990

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-Dorg.kie.demo=false", "-Dorg.kie.example=false"]
