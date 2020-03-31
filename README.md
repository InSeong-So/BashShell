# Server 저장소

## Plan
### TODO
- [x] 각 OS에 맞는 환경 구축용 셸 스크립트 작성
- [ ] 반영 준비
- [ ] 라즈베리파이 유튜브 동영상 무료 다운로드 구축
- [ ] 마크다운 정리 → 위키로 변경

<br>

### DOING
- [ ] Not thing

<br>

### DONE
- [x] 개인 서버 구축 완료
  - ~~[보안상의 이유로 영화 다운로드용 파일 서버 링크](ftp://101.235.203.94:20000)~~ **

<hr>
<br>

## 목차
- [RaspberryPi-Debian](debian/README.md)
- [CentOS](centos/README.md)
- [Ubuntu](ubuntu/README.md)

<hr>
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

<hr>
<br>
