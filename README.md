mbentley/testssl
==================

docker image for testssl (https://testssl.sh/)

To pull this image:
`docker pull mbentley/testssl`

## Common usage:
Run full test suite:
`docker run -it --rm mbentley/testssl mbentley.net`

Display full command usage:
`docker run -it --rm mbentley/testssl`

Test for Heartbleed (CVE-2014-0160):
`docker run -it --rm mbentley/testssl -B mbentley.net`

Test for SSLv3 (and list available protocols):
`docker run -it --rm mbentley/testssl -p mbentley.net`
