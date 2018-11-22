#pass the following environment variables
#GIT_BRANCH
#CSR_INFO_FILE

FROM tchowdhury/my_centos:latest
ARG GIT_URL=https://raw.githubusercontent.com/thefreeeman/autom/
ARG GIT_FEATURE_BRANCH=master
COPY . /app
RUN yum -y update && \
	yum install -y \
	openssh-server \
	openssl.x86_64 \
	vim \
	git \
	curl

#### ENV GIT_URL=$GIT_URL
RUN curl -k -L $GIT_URL/raw/$GIT_FEATURE_BRANCH/pa/csr/sh/csr-init.sh \
	-o /tmp/csr-init.sh &&chmod +x /tmp/csr-init.sh	

WORKDIR /tmp
CMD ./csr-init.sh $GIT_BRANCH $CSR_INFO_FILE

