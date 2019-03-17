# 저장소(Repository) : 이미지가 저장된 장소
# 컨테이너(Container) : 가상화된 공간을 만들기 위해 리눅스 자체 기능 chroot, namespace, cgroup를 사용
# 이미지(Image) : 가상 머신을 생성할 때 사용하는 iso와 비슷한 개념으로 컨테이너를 생성할 때 필요
# 이미지 이름 : 해당 이미지가 어떤 역할을 하는지 표시. 반드시 설정
# 태그(Tag) : 이미지 버전 관리, 리비전(Revision) 관리에 사용

# 볼륨(Volume) : 데이터를 컨테이너가 아닌 호스트에 저장하는 방식으로 컨테이너끼리 데이터를 공유할 때 활용할 수 있음. 호스트 볼륨 공유, 볼륨 컨테이너, 도커 볼륨 3가지 방식이 있다

# 스테이트리스(stateless) : 컨테이너가 아닌 외부에 데이터를 저장하고 컨테이너는 그 데이터로 동작하도록 설계하는 것
# 스테이트풀(statefull) : 컨테이너가 데이터를 저장하고 있어 상태가 있는 경우이며 컨테이너 자체에 데이터를 보관하므로 지양하는 것이 좋음

# 컴포즈(Compose) : 여러 개의 컨테이너를 하나로 묶어 관리할 수 있다면 좀 더 편리할 것이므로 도커 컴포즈는 여러 개의 컨테이너 옵션과 환경을 정의한 파일을 읽어 순차적으로 생성하는 방식으로 동작한다. 도커 컴포즈의 설정 파일은 run 명령어의 옵션을 그대로 사용할 수 있으며 각 컨테이너의 의존성, 네트워크, 볼륨 등을 함께 정의할 수 있다. 컨테이너의 수가 많아지고 정의해야할 옵션이 많아지면 도커 컴포즈를 사용하는 것이 좋다.

# 설치, {{버전}}에 버전명 쓰기 : 2018.10.29 현재 날짜로 최신버전 = 1.23.0-rc3
curl -L https://github.com/docker/compose/releases/download/1.23.0-rc3/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose -v

# 도커파일(Dockerfile) : 


##################################### 공통(start) #####################################
# yum 업데이트
yum -y update
yum install -y yum-utils
# docker 설치
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# /etc/yum.repos.d/docker-ce.repo
yum install -y docker-ce
# docker 실행
systemctl start docker
systemctl enable docker
# 또는 쉘 스크립트로 설치하기
wget -qO- get.docker.com | sh
# 확인
docker version
# 실행 시 무조건 root 권한, 그게 싫으면 아래 입력
sudo usermod -aG docker (계정)
#(도커라는 그룹에 현재 계정을 추가한다는 것 addGroup), 적용시키려면 로그아웃하고 다시 접속

##################################### MySQL #####################################
# mysql 이미지 검색, official에 [OK]가 있으면 공식 이미지 
docker search mysql
# mysql 이미지 다운로드
docker pull mysql
# 도커 이미지를 통한 mysql 컨테이너 생성
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=1234 --name mysql_test mysql
# 컨테이너 동작 여부 확인
docker ps -a
# mysql 컨테이너 접속
docker exec -it mysql_test bash
# mysql 실행
mysql -uroot -p
# 위에서 지정한 환경변수 : 비밀번호 입력
1234
# 접속 성공!

##################################### MS-SQL #####################################
# mssql 이미지 검색
docker search mssql
# mssql 이미지 다운로드
docker pull microsoft/mssql-server-linux
# 도커 이미지를 통한 mssql 컨테이너 생성
docker run -e "ACCPET_EULA=Y" -e "SA_PASSWORD=sisparang1234" -p 1433:1433 --name mssql microsoft/mssql-server-linux
# 컨테이너 동작 여부 확인
docker ps -a
# mssql 컨테이너 접속
docker exec -it mssql bash

##################################### Oracle #####################################


##################################### Docker image 만들기 #####################################
docker search
docker pull centos
docker run -i -t centos
cd ~
echo test >> test.html
