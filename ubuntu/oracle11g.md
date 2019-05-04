# 우분투 오라클 설치
> 우분투 데스크탑 환경에서 설치

## 설치 파일 다운
http://www.oracle.com/technetwork/indexes/downloads/index.html#database
> Database -> Database 11g Standard / Enterprise Edition -> 로그인 -> 파일저장

---

### 유저 및 그룹 설정(우분투 16.04 64bit)
```sh
sudo addgroup oinstall
sudo addgroup dba
sudo addgroup nobody
sudo usermod -g nobody nobody
sudo useradd -g oinstall -G dba -m -d /home/oracle -s /bin/bash oracle
sudo chown -R oracle:dba /home/oracle
sudo passwd oracle
=> 비밀번호 지정 : oracle
```

### 시작 스크립트 및 설치 디렉토리 준비(우분투 16.04 64bit)
```sh
sudo mkdir /etc/rc.d
for i in 0 1 2 3 4 5 6 S
> do sudo ln -s /etc/rc$i.d /etc/rc.d/rc$i.d 
> done
sudo mkdir -p /u01/app/oracle
sudo chown -R oracle:dba /u01
```

### 적용 및 실행(우분투 16.04 64bit)
```sh
sudo sysctl -p
```

### *커널 파라미터 변경(우분투 13.04)*
```sh
sudo sh -c 'cat >> /etc/sysctl.conf << EOF
# Settings for Oracle Database Installation
fs.aio-max-nr=1048576
fs.file-max=6815744
kernel.shmall=2097152
kernel.shmmni=4096
kernel.sem=250 32000 100 128
net.ipv4.ip_local_port_range=9000 65500
net.core.rmem_default=262144
net.core.rmem_max=4194304
net.core.wmem_default=262144
net.core.wmem_max=1048586
kernel.shmmax=1073741824
EOF'
```

### *적용 및 실행(우분투 13.04)*
```sh
# root 계정에서 다음 Shell limit 설정을 뒤에 추가
sudo sh -c 'cat >> /etc/security/limits.conf << EOF
# Settings for Oracle Database Installation
oracle soft nproc 2048
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
EOF'
```

---

## 필요 패키지 추가(우분투 16.04)
```sh
sudo apt-get update
sudo apt-get install gcc make binutils gawk x11-utils rpm build-essential libaio1 libaio-dev libtool expat alien ksh sysstat elfutils libelf-dev binutils libstdc++5
# 서비스 종료 패키지
# libmotif4 pdksh unixODBC unixODBC-dev lesstif2 lsb-cxx
```

---

## 설치 시 오류에 대한 대비(우분투 16.04)
```sh
sudo ln -s /usr/bin/awk /bin/awk
sudo ln -s /usr/bin/rpm /bin/rpm
sudo ln -s /usr/bin/basename /bin/basename
#lib 디렉토리 전체 링크를 사용해서 (미사용)
#sudo ln -s /usr/lib/x86_64-linux-gnu/libpthread_nonshared.a #/usr/lib/libpthread_nonshared.a
#sudo ln -s /usr/lib/x86_64-linux-gnu/libc_nonshared.a /usr/lib/libc_nonshared.a
#sudo ln -s /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/libgcc_s.so.1
#sudo ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/libstdc++.so.6
#sudo ln -s /usr/lib /usr/lib64
#64bit
sudo mkdir -p /usr/lib64
sudo ln -s /lib/x86_64-linux-gnu/libgcc_s.so.1 /usr/lib64/libgcc_s.so.1
sudo ln -s /usr/lib/x86_64-linux-gnu/libc_nonshared.a /usr/lib64/libc_nonshared.a
sudo ln -s /usr/lib/x86_64-linux-gnu/libpthread_nonshared.a /usr/lib64/libpthread_nonshared.a
sudo ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib64/libstdc++.so.6
```

### oracle 계정 환경변수
```sh
su - oracle
touch .bashrc
ln -s .bashrc .bash_profile

#### .bashrc 변경
> /home/oracle/.bashrc 파일에 다음과 같은 내용을 넣어준다.(*ORACLE_SID대소문자 주의 listener.ora 와 대소문자 동일 해야 함)
```sh
# set file creation mask
umask 022

# setting up oracle environment variables
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=${ORACLE_BASE}/product/11.2.0/dbhome_1
export ORACLE_SID=orcl
export ORACLE_UNQNAME=orcl
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib
export PATH=$PATH:$ORACLE_HOME/bin
```

#### .bashrc 적용
> oracle 환경변수 적용
```sh
. .bashrc
```

---

## Oracle 설치(우분투 16.04)
```sh
cd /home/oracle
sudo mv /home/somewhere/linux*database*.zip .
sudo chown oracle:dba linux*database*.zip
su oracle
unzip linux*database_1of2.zip
unzip linux*database_2of2.zip
cd database
LANG=C ./runInstaller -ignoreSysPrereqs
```

### 오류 시 화면조정
```sh
sisparang@sisparang-desktop:~$ sudo xhost +
[sudo] password for owthit: 
access control disabled, clients can connect from any host
sisparang@sisparang-desktop:~$ su oracle
암호: 
oracle@sisparang-desktop:/home/sisparang$ xhost +
access control disabled, clients can connect from any host
```

### 재실행
```sh
LANG=C ./runInstaller -ignoreSysPrereqs
```

### 설치 오류 시 실행
```sh
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/dbhome_1
sed -i 's/^\(\s*\$(MK_EMAGENT_NMECTL)\)\s*$/\1 -lnnz11/g' ${ORACLE_HOME}/sysman/lib/ins_emagent.mk
sed -i 's/^\(\$LD \$LD_RUNTIME\) \(\$LD_OPT\)/\1 -Wl,--no-as-needed \2/g' ${ORACLE_HOME}/bin/genorasdksh
sed -i 's/^\(\s*\)\(\$(OCRLIBS_DEFAULT)\)/\1 -Wl,--no-as-needed \2/g' ${ORACLE_HOME}/srvm/lib/ins_srvm.mk
sed -i 's/^\(TNSLSNR_LINKLINE.*\$(TNSLSNR_OFILES)\) \(\$(LINKTTLIBS)\)/\1 -Wl,--no-as-needed \2/g' ${ORACLE_HOME}/network/lib/env_network.mk
sed -i 's/^\(ORACLE_LINKLINE.*\$(ORACLE_LINKER)\) \(\$(PL_FLAGS)\)/\1 -Wl,--no-as-needed \2/g' ${ORACLE_HOME}/rdbms/lib/env_rdbms.mk
```

### 설치 중 실행 후 재시도
```sh
su root
/u01/app/oraInventory/orainstRoot.sh
/u01/app/oracle/product/11.2.0/dbhome_1/root.sh
```

### Web Manager 접속 URL
```sh
https://owthit-desktop:1158/em
```

### listener.ora 설정
> HOST는 /etc/hosts IP 등록 후 도메인 작성
>> SID_NAME는  ORACLE_SID와 대소문자 확인 후 동일하게 작성
- listener.ora
  ```sh
  LISTENER =
    (DESCRIPTION_LIST =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1521))
        (ADDRESS = (PROTOCOL = TCP)(HOST = owthit.oracle)(PORT = 1521))
      )
    )

  SID_LIST_LISTENER =
    (SID_LIST =
      (SID_DESC =
          (SID_NAME = orcl)
          (ORACLE_HOME = /u01/app/oracle/product/11.2.0/dbhome_1)
      )
    )

  ADR_BASE_LISTENER = /u01/app/oracle
  ```

```sh
lsnrctl stop
lsnrctl start
```

### Connect TEST
> cmd에서 실행
```sh
sqlplus system/oracle@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.0.12)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=orcl)))
```

---

## Linux에서 Oracle 삭제하기
- $ORACLE_HOME 디렉토리에 있는 설치 화일을 전부 삭제
  ```sh
  sudo rm -rf $ORACLE_HOME
  ```
- /etc 디렉토리에 있는 oraInst.loc, oratab 파일 삭제
  ```sh
  sudo rm -r /etc/ora*
  ``` 
- /usr/local/bin/oraenv 파일 삭제
  ```sh
  sudo rm -fr /usr/local/bin/oraenv
  ```
- /tmp 디렉토리에서 Ora 관련 파일 및 디렉토리 삭제
  ```sh
  sudo rm -fr /tmp/Ora*
  ```
  - /oraInventory 디렉토리 삭제
    ```sh
    sudo rm -rf /u01/app/oracle/oraInventory/
    ```
- oracle 계정의 환경설정 파일 백업
  ```sh
  .bashrc or .bashrc_profile or .profile ... backup
  ```
- oracle 계정을 삭제
  ```sh
  sudo deluser oracle
  ```
- oracle 계정의 HOME 디렉토리를 삭제
  ```sh
  sudo deluser --remove-home oracle
  ```
  
---

## Oracle service start/shutdown
> cmd에서 실행
```sh
su - oracle
sqlplus /nolog [sqlplus "/as sysdba"]
connect /as sysdba
shutdown immediate
startup
```

## Oracle listener start/stop
> cmd에서 실행
```sh
lsnrctl stop, start, reload, status
```

---

## Oracle
> cmd에서 실행

### 계정의 테이블 스페이스 생성
```sh
sqlplus /nolog
conn sys as sysdba
create tablespace [tablespace_name] 
datafile '/oradata/DANBEE/[file_name].dbf' size 500m;

예)
CREATE TABLESPACE ADMIN DATAFILE '/oradata/xe/admin.dbf' SIZE  500M ;

SELECT TABLESPACE_NAME, STATUS, CONTENTS FROM DBA_TABLESPACES;
```

### 오라클 유저 만들기
```sh
sqlplus /nolog
conn sys as sysdba
CREATE USER [user_name] 
IDENTIFIED BY [password]
DEFAULT TABLESPACE [tablespace_name]
TEMPORARY TABLESPACE TEMP;

예)
CREATE USER ugis IDENTIFIED BY tprPchlrkd DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;
```

### 생성한 USER에 권한주기
```sql
GRANT connect, resource, dba TO [user_name];

예)
grant connect, dba, resource to ugis; (모든 권한 주기)

GRANT CREATE SESSION TO 유저명         // 데이터베이스에 접근할 수 있는 권한
GRANT CREATE DATABASE LINK TO 유저명
GRANT CREATE MATERIALIZED VIEW TO 유저명
GRANT CREATE PROCEDURE TO 유저명
GRANT CREATE PUBLIC SYNONYM TO 유저명
GRANT CREATE ROLE TO 유저명
GRANT CREATE SEQUENCE TO 유저명
GRANT CREATE SYNONYM TO 유저명
GRANT CREATE TABLE TO 유저명             // 테이블을 생성할 수 있는 권한
GRANT DROP ANY TABLE TO 유저명         // 테이블을 제거할 수 있는 권한
GRANT CREATE TRIGGER TO 유저명 
GRANT CREATE TYPE TO 유저명 
GRANT CREATE VIEW TO 유저명

GRANT  
 CREATE SESSION
,CREATE TABLE
,CREATE SEQUENCE   
,CREATE VIEW
TO 유저명;
```

### 생성한 USER로 ORACLE에 접속하기
```sh
sqlplus nextree/nextree[@db_sid]
```

### 계정 삭제하기
```sh
drop user 사용자계정 cascade;
```
