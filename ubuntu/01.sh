# root 계정 비밀번호 변경
sudo passwd root
[sudo] password for {아이디}:{비밀번호}
Enter new UNIX password:{변경할 비밀번호}
Retype new UNIX password:{변경할 비밀번호 재입력}
passwd: password updated successfully

# root 계정 전환
su - root

# 네트워크 고정 IP 설정
## IP확인
ifconfig

## 설정파일(ubuntu 16.04)
vi /etc/network/interfaces

## 설정파일(ubuntu 18.04)
vi /etc/netplan/50-cloud-init.yaml

### 설정 전
---
network:
    ethernets:
        enp03s:
            dhcp: true
    version: 2
---

### 설정 후
---
network:
    ethernets:
        enp0s3:
            dhcp4: no
            addresses: [192.168.0.9/24]
            gateway4: 192.168.0.1
            nameservers:
                addresses: [8.8.8.8,8.8.4.4]
    version: 2
---

# 설정 변경 적용
netplan apply

# 설정 변경 확인
ip addr
ip route
ipconfig