FROM ubuntu:16.04
MAINTAINER Tyler Levine <tylevine@cisco.com>

# install tools
RUN apt-get update && apt-get install -y git-core maven wget openjdk-8-jdk

# clone project
RUN git clone https://git.opendaylight.org/gerrit/p/systemmetrics.git /opt/systemmetrics

# setup odl maven repositories
RUN mkdir -p ~/.m2
RUN wget -q -O - https://raw.githubusercontent.com/opendaylight/odlparent/master/settings.xml > ~/.m2/settings.xml

# build project
WORKDIR /opt/systemmetrics
RUN mvn clean install

# expose ports
EXPOSE 8181

# set startup command
CMD ["/opt/systemmetrics/karaf/target/assembly/bin/karaf"]
