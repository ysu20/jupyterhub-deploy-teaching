#!/bin/bash
echo "Generating an SSL private key to sign your certificate..."
openssl genrsa -des3 -out myssl.key 1024

echo "Generating a Certificate Signing Request..."
openssl req -new -key myssl.key -out myssl.csr

echo "Removing passphrase from key (for nginx)..."
cp myssl.key myssl.key.org
openssl rsa -in myssl.key.org -out myssl.key
rm myssl.key.org

echo "Generating certificate..."
openssl x509 -req -days 365 -in myssl.csr -signkey myssl.key -out myssl.crt

echo "Copying certificate (myssl.crt) to ./security/"
cp myssl.crt ./security/ssl.crt

echo "Copying key (myssl.key) to ./security/"
cp myssl.key ./security/ssl.key

echo "Generating Cokkie secret"
openssl rand -hex 1024 > ./security/cookie_secret