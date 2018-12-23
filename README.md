# BashShell
ShellScriptTest

# 네트워크 정보 확인
cmd - ipconfig/all

# 네트워크 환경 설정
(제어판)네트워크 및 공유 센터 - 어댑터 설정 변경 - IPv4 속성 변경 - 확인된 네트워크 정보 기입

# 가상서버 IP 변경
vi /etc/sysconfig/network-scripts/ifcfg-enp0s3

<기본>
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="dhcp"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="enp0s3"
UUID="3bab0769-8e7e-4a45-a83d-f20e94cc4279"
DEVICE="enp0s3"
ONBOOT="yes"

<변경 후>
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
#BOOTPROTO="dhcp"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="enp0s3"
UUID="3bab0769-8e7e-4a45-a83d-f20e94cc4279"
DEVICE="enp0s3"
ONBOOT="yes"

BOOTPROTO="static"
IPADDR="(자신에게 할당된 가상화 아이피)"
GATEWAY="(호스트 게이트웨이)"
DNS1="(호스트 DNS-1)"
DNS2="(호스트 DNS-2)"

# Docker 설치
설치 :
yum install -y docker
또는
curl -fsSL https://get.docker.com/

# Docker-Compose 설치
설치 :
curl -L https://github.com/docker/compose/releases/download/1.23.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
권한 부여 :
chmod +x /usr/local/bin/docker-compose
버전 확인 :
docker-compose --version
