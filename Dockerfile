FROM library/ubuntu:22.04

RUN apt-get update -qq && \
    apt-get install -qqy \
	openjdk-18-jre \
	curl
	

COPY launch.sh /
RUN chmod +x /launch.sh
ENTRYPOINT ["/bin/bash", "/launch.sh"]
