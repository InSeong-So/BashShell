# 목차

## [CentOS](centos/README.md)

<br>

## [Ubuntu](ubuntu/README.md)

<br>

## [Raspberry Pi](debian/README.md)

<br>

# 기타
## 대용량 파일 커밋
- 설치
  - [Git lfs 다운로드](https://git-lfs.github.com/)
- Git Bash 또는 Linux에서 대용량 파일을 커밋하려는 Repository로 이동
  ```sh
  $ git lfs install
  Updated pre-push hook.
  Git LFS initialized.
  ```
 
<br>
  
- 대용량 파일을 git-lfs의 관리 대상으로 지정
  ```sh
  $ git lfs track "*.확장자"
  Tracking *.exe
  
  $ git add 파일
  
  $ git commit -m 커밋 메세지
  [master (...) ... ] 커밋 메세지
  (...)
  
  $ git push
  Uploading LFS objects: ...
  ```


<br>

## 네트워크 정보 확인
> cmd - ipconfig/all

<br>

# 네트워크 환경 설정
> 제어판 - 네트워크 및 공유 센터 - 어댑터 설정 변경 - IPv4 속성 변경 - 확인된 네트워크 정보 기입

<br>

## 가상서버 IP 변경
```sh
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

#############################################################################

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
```

<br>

## Docker 설치
```sh
#설치 :
yum install -y docker

#또는
curl -fsSL https://get.docker.com/

#실행 :
systemctl start docker
systemctl enable docker
```

<br>

## Docker-Compose 설치
```sh
#설치 :
curl -L https://github.com/docker/compose/releases/download/1.23.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

#권한 부여 :
chmod +x /usr/local/bin/docker-compose

#버전 확인 :
docker-compose --version

#실행 :
docker-compose up -d
```

<br>