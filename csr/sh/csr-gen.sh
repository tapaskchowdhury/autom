#!/bin/bash


#########################################################
## Author: Tapas
## This file generates csr file
## Usage: ./csr-gen.sh $CSR_INFO_FILE
#########################################################

##################### params ############################
## 		params passed from Dockerfile
##
CSR_INFO_FILE=$1
#########################################################

## other params##
CSR_INFO_PATH=/app/automation/pa/csr/info
#########################################################

do_generate_csr_key() {
	if [[ -d /tmp/test-keygen ]]; then
	    rm -rf /tmp/test-keygen
	fi
	mkdir -p /tmp/test-keygen &&\
	cd /tmp/test-keygen/ &&\
	openssl genrsa -aes256 -out my.key 2048 &&\
	openssl req -new -sha256 -key my.key -out my.csr -config $CSR_INFO_PATH/$CSR_INFO_FILE
}

do_show_values() {
    echo "CSR_INFO_FILE: $CSR_INFO_FILE"
}

do_copy_csr_to_local() {
    cd /tmp && cp -R test-keygen /app/csr
}

###########  main #####################
do_show_values
do_generate_csr_key $CSR_INFO_FILE
do_copy_csr_to_local
