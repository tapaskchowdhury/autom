#!/bin/bash


#########################################################
## Author: Tapas
## Usage: ./csr-git.sh $GIT_BRANCH $CSR_INFO_FILE
#########################################################

##################### params ############################
## 		params passed from Dockerfile
##
GIT_BRANCH=$1
CSR_INFO_FILE=$2
#########################################################

## other params##
GIT_URL=https://github.com/thefreeeman/autom.git
CSR_INFO_PATH=/app/autom/pa/csr/info
CSR_SH_PATH=/app/autom/pa/csr/sh
CSR_GEN_FILE=csr-gen.sh

do_git_clone(){
	echo "GIT_BRANCH is: $GIT_BRANCH " >> /app/params-check
	echo "CSR_INFO_FILE is: $CSR_INFO_FILE " >> /app/params-check
	echo "USERNAME is: $USERNAME" >> /app/params-check
	cd /app
	if [[ -d /app/autom ]]; then
		echo "git repo already exists; updating repo"
		cd /app/autom && \
		git clean -xdf &&\
		git reset --hard &&\
		git pull origin $GIT_BRANCH
		
        GIT_LOCAL_BRANCH=$(git branch | grep $GIT_BRANCH | wc -l)
      	if [[ $GIT_LOCAL_BRANCH -eq 1 ]]; then
      		echo $GIT_BRANCH exists locally
    		git checkout $GIT_BRANCH
      	else
      		echo $GIT_BRANCH does not exist locally
    		git checkout -b $GIT_BRANCH
      	fi
	else
		git clone $GIT_URL
	fi
}

call_csr_gen() {
	bash ${CSR_SH_PATH}/${CSR_GEN_FILE} $CSR_INFO_FILE
}

do_show_values() {
    echo "GIT_BRANCH: $GIT_BRANCH"
    echo "CSR_INFO_FILE: $CSR_INFO_FILE"
}

###########  main #####################
do_show_values
do_git_clone
call_csr_gen
