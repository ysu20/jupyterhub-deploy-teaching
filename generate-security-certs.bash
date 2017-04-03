#!/bin/bash
echo "Generating an SSL private key to sign your certificate..."
openssl genrsa -des3 -out jupyterhub-econ-rcc.key 1024

echo "Generating a Certificate Signing Request..."
openssl req -new -key jupyterhub-econ-rcc.key -out jupyterhub-econ-rcc.csr

echo "Removing passphrase from key (for nginx)..."
cp jupyterhub-econ-rcc.key jupyterhub-econ-rcc.key.org
openssl rsa -in jupyterhub-econ-rcc.key.org -out jupyterhub-econ-rcc.key
rm jupyterhub-econ-rcc.key.org

echo "Generating certificate..."
openssl x509 -req -days 365 -in jupyterhub-econ-rcc.csr -signkey jupyterhub-econ-rcc.key -out jupyterhub-econ-rcc.crt

echo "Copying certificate (jupyterhub-econ-rcc.crt) to ./security/"
cp jupyterhub-econ-rcc.crt ./security/ssl.crt

echo "Copying key (myssl.key) to ./security/"
cp jupyterhub-econ-rcc.key ./security/ssl.key

echo "Generating Cokkie secret"
openssl rand -hex 1024 > ./security/cookie_secret