#!/bin/bash

CLUSTER_ID="128073"
KUBE_API_IP="https://61.28.226.208:6443"
CA_CRT="-----BEGIN CERTIFICATE-----
MIIB7zCCAVigAwIBAgIBAjANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDEwhWaW5h
ZGF0YTAeFw0xOTA1MjIwNDUzNTVaFw00NjEwMDcwNDUzNTVaMBMxETAPBgNVBAMT
CFZpbmFkYXRhMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCN6L+8lsgaNBfZ
LFnF3m/Kym9AnBgywaAKU95XU/mji2v5NCQDZVnvnNIs9oxgQz2htAzlc4hVodFU
bnG2nui/1B4+/8/NaH3NU96edqtmnvfGY3RQZjOPHq3+AKI2OdYR8bB6QvpOaiSM
71pqNeXqDaSDjCQi6BwDMQbQhLtrewIDAQABo1MwUTAdBgNVHQ4EFgQU/VbH2ZxJ
FsQ//0q4563/3e23+nwwHwYDVR0jBBgwFoAU/VbH2ZxJFsQ//0q4563/3e23+nww
DwYDVR0TBAgwBgEB/wIBADANBgkqhkiG9w0BAQsFAAOBgQBbAxZr4hmjCdAs2Aiy
5zHHUbWvDaBtJdLfePs11ISNi0mG+PaM8QqUxE9B+jeAQezuADO7lOTbF+81TbbN
Q2HbdoqBNNNvYSSvt4v2gfFxCkf0C9AzIdcjq3QmDt59YmkjVQdrcQehTsgAl5Zy
dzyE9t3Bla0r5db+nm9LWhss/A==
-----END CERTIFICATE-----
"
K8S_KEY="-----BEGIN RSA PRIVATE KEY-----
MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAKwL9/puDbFnL1ft
B0iUjIVzDlSWrtVa2WRbCNEJi7eRN9CGSwk7GcHj/FZCV+9MVSVtP59VumJLiI1t
CQrlubKrXiZ3F8uPqz4RYtaJT/fRzwXHvfKhO7tS0lSgdzMe8X7wKsJbTTYKVJHA
N1yJlmAV0kNL7EQ+vLDtfu6OFUrFAgMBAAECgYEAkXYlGZVG+oEVZC/Bgrol/QaE
TTyBYV5IgzL8x1Bc0r1zBVklxA41/tq1lHDPTEGrk9NEgYDH7yeRspFHnfERCP2a
aUGOA+lTJ3Lo65/Sz+00MLNL52rBFSZMDGAqFHOw/m6NMoqRaGN+HfaiDw9ZoQV6
JJpaV+GnfERFcPfCpoECQQDe0u3qOVYa8f0/csmprf9p6dmyBJZzV43uVQKbXu2R
9SwvQMNnHdGJOCIWJ1Oa3knXugPhfKUibmn4h75qZlGRAkEAxamivSlj3/hG79Ge
q+BTDV5LFo/nuymeMM2ypyzbJDtgvHGJFjnuZqwpMevcY1+g7thlwqXepXFRAIt/
NigL9QJAPXU4Ic5GrY/pJcLnVGGlfPT/ElapmI6hmwbffTMlm4hf83iNbLeQv6Q3
4pxeNuzwuQuZXmwer+x8Vgw6vOYTwQJBALFK0aR33pSCniX3UCn8QKJKBHHNS94N
m01NA0R9sGXUOJVuBLcB6TsAisazNu+PU8tIICYyHv0oIa6qcMUDsI0CQDFmWNxf
/ba+bToi7xJlkKQYkytZJnmi6SyE7lcicDh/1gMkkIuvaB9PMZmhFATcR2lG6L5S
gGUeGuDrfdOJ1yg=
-----END RSA PRIVATE KEY-----
"
K8S_CRT="-----BEGIN CERTIFICATE-----
MIIBozCCAQygAwIBAgIGAWrd44MgMA0GCSqGSIb3DQEBCwUAMBMxETAPBgNVBAMT
CFZpbmFkYXRhMB4XDTE5MDUyMjA0NTM1NloXDTQ2MTAwNzA0NTM1NlowFzEVMBMG
A1UEAxMMQ2xpZW50LWFkbWluMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCs
C/f6bg2xZy9X7QdIlIyFcw5Ulq7VWtlkWwjRCYu3kTfQhksJOxnB4/xWQlfvTFUl
bT+fVbpiS4iNbQkK5bmyq14mdxfLj6s+EWLWiU/30c8Fx73yoTu7UtJUoHczHvF+
8CrCW002ClSRwDdciZZgFdJDS+xEPryw7X7ujhVKxQIDAQABMA0GCSqGSIb3DQEB
CwUAA4GBAFyFhZ2NW3R8Sgu9AV4ktF+HwvJDyV9pz2xkBKLjXvgbfzR/wuVgICpE
vGTm+wjc9rDmmQnDGkLHMi8DlBAs+UEruqlbXSLPUwW1Hq4XxayyTzTYv6UYgolV
HroASxQ9WODYsKPoAX4vKDsFYlkxUT3VuZIz5S94wP8MxY74h0zE
-----END CERTIFICATE-----
"


KUBECTL=kubectl
KUBERNETES_VERSION=1.5.1
JQ=jq
CURL=curl

############### CHECK COMMAND EXIST ###############################
check_command_exist(){
	command -v $1 > /dev/null 2>&1
	echo $?
}

############### INSTALL VIA APT ###################################
install_via_apt(){
	echo "Install $1 via apt"
	sudo apt update
	sudo apt install $1 -y
}

############## DOWNLOAD KUBECTL ##################################
download_kubectl(){
	echo "Download kubectl version $1" 
	curl -L https://storage.googleapis.com/kubernetes-release/release/v$1/kubernetes-client-linux-amd64.tar.gz -o kubernetes.tar.gz
	tar xf kubernetes.tar.gz
	sudo chmod +x kubernetes/client/bin/kubectl
	sudo cp kubernetes/client/bin/kubectl /usr/bin/
	sudo rm -rf kubernetes*
}

############## CHECK JQ ###########################################
if [[ $(check_command_exist $JQ) -ne 0 ]]; then
        install_via_apt $JQ
fi

############### CHECK CURL ########################################
if [[ $(check_command_exist $CURL) -ne 0 ]]; then
        install_via_apt $CURL
fi

############### CHECK KUBECTL #####################################
if [[ $(check_command_exist $KUBECTL) -ne 0 ]]; then
        download_kubectl $KUBERNETES_VERSION
fi

############## GENERATE CERTIFICATES ##############################
if [ ! -f CA_"$CLUSTER_ID".crt ] && [ ! -f K8S_"$CLUSTER_ID".key ] && [ ! -f K8S_"$CLUSTER_ID".crt ]; then
        echo "$CA_CRT" > CA_"$CLUSTER_ID".crt
        echo "$K8S_KEY" > K8S_"$CLUSTER_ID".key
        echo "$K8S_CRT" > K8S_"$CLUSTER_ID".crt
fi

############# CREATE CONFIG #######################################

KUBE_CONFIG_DIR=$HOME/.kube

if [ ! -f $KUBE_CONFIG_DIR/CA_"$CLUSTER_ID".crt ] && [ ! -f $KUBE_CONFIG_DIR/K8S_"$CLUSTER_ID".key ] && [ ! -f $KUBE_CONFIG_DIR/K8S_"$CLUSTER_ID".crt ]; then
        kubectl config set-credentials kubeclient_"$CLUSTER_ID" --client-certificate=$KUBE_CONFIG_DIR/K8S_"$CLUSTER_ID".crt --client-key=$KUBE_CONFIG_DIR/K8S_"$CLUSTER_ID".key
        kubectl config set-cluster kubernetes_"$CLUSTER_ID" --certificate-authority=$KUBE_CONFIG_DIR/CA_"$CLUSTER_ID".crt --server="$KUBE_API_IP"
        kubectl config set-context service-account-context-"$CLUSTER_ID" --cluster=kubernetes_"$CLUSTER_ID" --user=kubeclient_"$CLUSTER_ID"
        kubectl config use-context service-account-context-"$CLUSTER_ID"
        mv CA_"$CLUSTER_ID".crt K8S_"$CLUSTER_ID".crt K8S_"$CLUSTER_ID".key $KUBE_CONFIG_DIR
fi
