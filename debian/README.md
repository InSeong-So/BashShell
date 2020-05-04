# 라즈베리 파이로 개인 서버 구축하기
> 버전 : Raspberry Pi 3B+
>> Micro SD Card : 16GB *(2020.03.19 부)*

# 목차

# 운영체제 설치
## [라즈비안 이미지 파일](https://www.raspberrypi.org/downloads/raspbian/)
- `Desktop` : GUI를 포함한 여러 모듈 추가 버전, `Lite` : Minimal 버전

<hr>
<br>

## [SD카드 이미지 Write 프로그램](https://etcher.io)
- 실행 후 다운받은 라즈비안 이미지 파일 Select, SD카드 Select 후 Flash 시작
  - Flash가 완료되면 SD카드 제거 후 재삽입

<hr>
<br>

## boot(E): 디스크에 파일 생성
### SSH enable 설정 파일
- SSH enable 을 위해 파일명이 `ssh`인 파일을 만들어 boot 드라이브 최상위 폴더에 위치시킨다.

- ssh 파일은 확장자가 없어야 하며 파일은 비어있어도 된다.

- RASIBIAN이 부팅 시, boot 파티션에 ssh 파일이 존재하면 이를 인식하고 ssh enable을 설정한다.

<br>

### WiFi 접속 설정 파일
```conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
network={
    ssid="접속할 WIFI 이름"
    psk="접속할 WIFI 암호"
}
```

- boot 드라이브 최상위 폴더에 `wpa_supplicant.conf` 파일을 생성하고 아래 내용을 파일에 기재한다.

- network 란에 접속할 WiFi 이름과 암호를 기재한다(따옴표는 남길 것).

- 라즈베리파이3 B+ 모델은 랜포트가 있기에 랜선을 사용하려면 WiFi 접속 설정 파일은 필요없다.

- 라즈베리파이 제로W 모델은 랜포트가 없기 때문에 WiFi 접속 설정이 필요하다.

<hr>
<br>

## 라즈베리 파이 부팅 후 SSH 접속
- SD 카드를 라즈베리 파이에 삽입하고 전원 연결

- 약 1분 대기 후 부팅이 완료되면 공유기 관리(일반적으로 192.168.0.1)에 접속하여 해당 라즈베리 파이 IP를 확인

- 확인된 IP로 ssh를 이용하여 접속

- 라즈베리파이는 기본 id와 password가 정해져 있으므로 반드시 본인 암호로 교체할 것

- 라즈베리파이 초기 암호(default id, password)
    ```
    id : pi
    password : raspberry
    ```

<hr>
<br>

## shell에서 라즈베리 파이 설정 메뉴 실행
- `sudo raspi-config`
  - 비밀번호 변경 등 여러 설정을 진행할 수 있음

<hr>
<br>

## [Ref. Pi Guide: 라즈베리파이 이야기 한눈에 보기](https://geeksvoyage.com/pi-guide/)

<hr>
<br>

# 네트워크 설정
## SSH 원격 접속
- 터미널 프로그램으로 ssh port 22번을 사용하여 접속
  - ssh 초기 설정 port 번호는 22번이며 변경 가능

- 패키지 버전 정보 최신 업데이트(root 계정으로 실행)
  - `sudo apt-get update -y && apt-get upgrade -y`

<hr>
<br>

## 리눅스 SSH를 통한 해킹 방어
### 프로세스 포트 확인
- 현재 실행중인 프로세스의 포트 확인
  - `sudo netstat -ntlp | grep :80`

<hr>
<br>

### ssh port 변경
- `sudo vim /etc/ssh/sshd_config`

- sshd_config 파일의 Port 항목을 원하는 번호로 변경
  - 이미 사용 중인 번호는 피해야 함

    ```sh
    # This sshd was compiled with PATH=/usr/bin:/bin:/usr/sbin:/sbin

    # The strategy used for options in the default sshd_config shipped with
    # OpenSSH is to specify options with their default value where
    # possible, but leave them commented.  Uncommented options override the
    # default value.

    #Port 22
    Port XXXXX # 원하는 포트 번호
    #AddressFamily any
    #ListenAddress 0.0.0.0
    #ListenAddress ::

    #HostKey /etc/ssh/ssh_host_rsa_key
    #HostKey /etc/ssh/ssh_host_ecdsa_key
    ```

### services 파일 port 변경
- `sudo vim /etc/services`
  - 리눅스 services 파일에는 모든 네트워크 서비스의 포트 번호와 용도가 기재되어 있음
  - 기본적으로 네트워크 프로그램들은 모두 이 파일(/etc/services)의 서비스/포트번호/프로토콜을 확인
  - 따라서 services 파일의 ssh 항목도 위에서 변경한 포트 번호로 동일하게 변경

    ```sh
    qotd		17/tcp		quote
    msp		    18/tcp				    
    msp		    18/udp
    chargen		19/tcp		ttytst source
    chargen		19/udp		ttytst source
    ftp-data	20/tcp
    ftp		    21/tcp
    fsp		    21/udp		fspd
    ssh		    XXXXX/tcp	## 여기 변경
    telnet		23/tcp
    smtp		25/tcp		mail
    time		37/tcp		timserver
    time		37/udp		timserver
    rlp		    39/udp		resource	
    nameserver	42/tcp		name		
    whois		43/tcp		nicname
    tacacs		49/tcp				    
    ```

- 설정이 완료되면 라즈베리 파이 재부팅
  - `sudo shutdown -r now`

<br>

### fail2ban 설치
- fail2ban은 시스템 로그를 모니터링한다.
  - 일정 횟수의 로그인 실패 시 해당 IP를 iptables 명령으로 차단
  - 침입자가 brute-force 공격을 시도할 경우의 대비책임

- 설치
  - `sudo apt-get install fail2ban -y`

- 파일 설정 변경
  - `sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local`
  - `sudo vim /etc/fail2ban/jail.local`

  - jail.local 파일의 `[sshd]` 항목을 찾아 기재
    - `port` : ssh 기본 포트가 기록되어 있으며 변경한 포트 번호로 교체
    - `logpath` : %(sshd_log) 변수로 되어 있으며 이 변수가 지정하는 파일이 /var/log/auth.log이다. auth.log 파일을 모니터링하여 login fail 여부를 확인
    - `maxretry` : 허용할 fail 횟수. 이를 초과하면 bantime만큼 차단
    - `bantime` : 차단을 수행할 초 단위의 시간. -1은 영구적인 차단을 의미

- 설정 적용을 위한 재시작
  - `sudo service fail2ban restart`

- 차단 현황 확인
  - `sudo iptables -L` 또는 `sudo fail2ban-client status`

- 접속 ip 로그 확인
  - `sudo tail -10 /var/log/fail2ban.log`

- 접속 차단된 ip 해제
  - `sudo fail2ban-client set sshd unbanip [ip]`

<hr>
<br>

# 추가 설정
## 버전 확인
- 라즈베리 파이 환경 확인
  - `sudo cat /proc/cpuinfo`

<hr>
<br>

## 기기 이름 변경
- 라즈베리파이의 기본 기기 이름(hostname)은 raspberrypi

- `sudo raspi-config`
  - `Network Options` 선택
  - `Hostname` 선택
  - 변경하고자 하는 Hostname 기재 후 OK

- `sudo shutdown -r now`

<hr>
<br>

## 라즈베리 파이 한글 설정
- 라즈베리 파이 지역 설정
  - `sudo raspi-config`

- `Localisation Options` 선택
  - `Change Locale`
    - `en_GB(UTF-8)`, `en_US(UTF-8)`, `ko_KR(UTF-8)`, `ko_KR(EUC-KR)` 선택
    - 기본은 `ko_KR(UTF-8)` 선택
  - `Change Timezone`
    - `Asia` 선택
    - `Seoul` 선택

<hr>
<br>

## root 계정 비밀번호 설정
- `sudo passwd root`

<hr>
<br>

## 계정 추가 및 삭제
- 사용자 계정 추가
  - `sudo adduser [계정이름]`
  - 비밀번호 설정

- 사용자 계정 삭제
  - `sudo deluser --remove-all-files [계정이름]`

<hr>
<br>

## vim 설치
- vim 설치
  - `sudo apt-get install vim -y`

- vim 사용자 서식 설정
  - `sudo vim /etc/vim/vimrc`
      ```sh
      set number              # line 표시를 해줍니다.
      set ai                  # auto index
      set si                  # smart index
      set cindent             # c style index
      set shiftwidth=4        # shift를 4칸으로 ( >, >>, <, << 등의 명령어)
      set tabstop=4           # tab을 4칸으로
      set ignorecase          # 검색시 대소문자 구별하지않음
      set hlsearch            # 검색시 하이라이트(색상 강조)
      set expandtab           # tab 대신 띄어쓰기로
      set background=dark   # 검정배경을 사용할 때, (이 색상에 맞춰 문법 하이라이트 색상이 달라집니다.)
      set nocompatible        # 방향키로 이동가능
      set fileencodings=utf-8,euc-kr    # 파일인코딩 형식 지정
      set bs=indent,eol,start    # backspace 키 사용 가능
      set history=1000        # 히스토리를 1000개까지 출력
      set ruler               # 상태표시줄에 커서의 위치 표시
      set nobackup            # 백업파일을 만들지 않음
      set title               # 제목을 표시
      set showmatch           # 매칭되는 괄호를 보여줌
      set nowrap              # 자동 줄바꿈 하지 않음
      set wmnu                # tab 자동완성 가능한 목록을 출력

      syntax on               # 문법 하이라이트 킴
      ```

- [참고1](http://norus.tistory.com/13)

- [참고2](http://egloos.zum.com/daftcoder/v/245008)

<hr>
<br>

## 스크린 세이버 설정
- 라즈베리파이는 기본 이미지에 스크린 세이버가 설정되어 있음
  - 일정 시간(10분) 사용자의 입력이 없을 경우, 자동으로 화면이 꺼짐

- 스크린 세이버
  - `sudo apt-get install xscreensaver -y`

- 커널 cmdline
  - `sudo vim /boot/cmdline.txt`
  - `consoleblank=0`을 행의 마지막에 추가

<hr>
<br>

## IP 접속 주소(지역) 확인
- whois 설치
  - `sudo apt-get install jwhois -y`

- IP 접속 지역 확인
  - `sudo whois [ip]`

<hr>
<br>

## IP 주소 확인
- 공인 IP 확인
  - `sudo curl bot.whatismyipaddress.com`

- 내부 IP 확인
  - `ifconfig` 또는 `ipconfig`

<hr>
<br>

## 방화벽 설치
- 방화벽 설치
  - `sudo apt-get install ufw -y`

- 방화벽 활성화
  - `sudo ufw enable`

- 접근 허용 룰 설정
  - `sudo ufw allow [port]`

- 접근 허용 룰 여러 개 동시 설정(~부터 ~까지)
  - `sudo ufw allow [port:port]`

- 접근 거부 룰 설정
  - `sudo ufw deny [port]`

- 접근 거부 룰 삭제
  - `sudo ufw delete deny [port]`

- 방화벽 상태와 룰 확인
  - `sudo ufw status`

<hr>
<br>

# 라즈베리 파이에 외장하드로 NAS 구성하기
- NTFS 시스템 패키지 설치
  - `sudo apt-get install ntfs-3g -y`

- 외장하드 UUID 정보 확인
  - `sudo blkid`

- 마운트 디렉토리 생성
  - `mkdir /home/pi/hdd_storage`

- 외장하드 마운트
  - `sudo mount /dev/sda1 /home/pi/hdd_storage`

- 부팅 후에도 마운트 유지 설정
  - `sudo vim /etc/fstab`
  
  - `UUID=[UUID]     [경로]      [PATH]      [OPTIONS]`

- 외장하드 언마운트
  - `sudo umount /home/pi/hdd_storage`

## vsftpd로 ftp 서버 구축하기
- vsftpd 설치하기
  - `sudo apt-get install vsftpd -y`

- vsftpd 설정
  - `sudo /etc/vsftpd.conf`
  - [vsftpd 옵션들](vsftpd/vsftpd.md)

- 접속 중인 유저 확인
  - `sudo ps aux | grep vsftpd`

<hr>
<br>

## 공유를 위한 계정 추가와 디렉토리 설정
- FTP는 리눅스 계정과 연결되므로 리눅스 계정을 추가
  - `sudo adduser [계정이름]`
  - 비밀번호 설정

- 리눅스 로그인 막기
  - `sudo vim /etc/passwd`
  - `계정명:x:번호:번호:,,,:/home/계정명:/usr/sbin/nologin`

- bind 옵션을 이용하여 마운트된 디렉토리를 다른 디렉토리에 붙이기
  - `sudo mount --bind /home/pi/hdd_storage/07_video/movie /home/sis_01/hdd_storage/movie`

- 위의 방법으론 재부팅 시 해제되므로 부팅 시 자동 적용 변경(마지막 행에 추가)
  - `sudo vim /etc/fstab`
  - `/home/pi/hdd_storage/07_video/movie /home/sis_01/hdd_storage/movie/ none bind,defaults 0 1`

<hr>
<br>

# 라즈베리 파이에 웹 서비스 호스팅하기
## Java 설치
- ~~openjdk 설치~~(스프링부트 에러로 인해 버전 다운로드)
  - ~~`sudo apt-get install openjdk-8-jdk -y`~~

- ~~java compiler 위치 확인~~
  - ~~`which javac`~~

- ~~환경변수 추가~~
  - ~~`sudo vim /etc/profile`~~
  - ~~export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-armhf~~
  - ~~`sudo shutdown -r now`~~

- jdk 다운로드 후 압축 해제
  - `sudo tar -zxvf jdk-8u221-linux-arm32-vfp-hflt.tar.gz`

- 압축해제된 jdk 폴더 이동
  - `sudo mv jdk1.8.0_221 /usr/lib/jvm/jdk1.8.0_221`

- 설정파일 변경
  - `sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_221/bin/java 1`
  - `sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_221/bin/javac 1`
  - `sudo update-alternatives --config java`
  - `sudo update-alternatives --config javac`

- 버전 확인
  - `sudo java --version`

- JAVA_HOME 설정(Maven 설치 시 JAVA_HOME이 설정되어 있지 않으면 오류 발생)
- `sudo export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_221`
- `sudo export PATH=$JAVA_HOME/jre/bin:$PATH`

- 재부팅
  - `sudo shutdown -r now`

<hr>
<br>

## Tomcat 설치
- tomcat8 설치
  - `sudo apt-get install tomcat8 -y`

- 홈 디렉토리에 심볼릭 링크 만들기
  - `sudo ln -s /var/lib/tomcat8/ ~/tomcat8`

- server.xml 설정
  - `sudo vim tomcat8/conf/server.xml`
  - 기본 주석 제거 풀 소스코드
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <Server port="8005" shutdown="SHUTDOWN">
      <Listener className="org.apache.catalina.startup.VersionLoggerListener" />
      <Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
      <Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
      <Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
      <Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />

      <GlobalNamingResources>
        <Resource name="UserDatabase" auth="Container"
                  type="org.apache.catalina.UserDatabase"
                  description="User database that can be updated and saved"
                  factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
                  pathname="conf/tomcat-users.xml" />
      </GlobalNamingResources>

      <!-- 변경1 : port는 접속을 허용할 포트번호, 임의로 설정 가능-->
      <!-- 변경2 : address는 접속을 허용할 IP, 0.0.0.0은 전부 허용-->
      <!-- 추가 : UTIEncoding은 한글이 깨지지 않게 설정 -->
      <Service name="Catalina">
        <Connector port="8100" protocol="HTTP/1.1"
                  connectionTimeout="20000"
                  URIEncoding="UTF-8"
                  redirectPort="8443" address="0.0.0.0" />

        <Engine name="Catalina" defaultHost="localhost">
          <Realm className="org.apache.catalina.realm.LockOutRealm">
            <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
                  resourceName="UserDatabase"/>
          </Realm>
          <Host name="localhost"  appBase="webapps"
                unpackWARs="true" autoDeploy="true">
            <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
                  prefix="localhost_access_log" suffix=".txt"
                  pattern="%h %l %u %t &quot;%r&quot; %s %b" />
          </Host>
        </Engine>
      </Service>
    </Server>
    ```

- tomcat8 설치 확인
  - `sudo service tomcat8 status`

- tomcat8 설정 후 적용
  - `sudo service tomcat8 restart`

<hr>
<br>

## Maven 설치
- maven 설치
  - `sudo apt-get install maven -y`

- 설치 후 버전 확인
  - `sudo mvn --version`

<hr>
<br>

## 완료 후 테스트
- index.jsp 파일 만들기
  - `sudo mv tomcat8/webapps/ROOT/index.html tomcat8/webapps/ROOT/index2.html`
  - `sudo vim index.jsp`

<hr>
<br>

# 라즈베리 파이 subversion 설치
> 기본 포트 : 3690/tcp, 3690/udp
>> 클라이언트는 [VisualSVN](https://www.visualsvn.com/server/download/) 또는 [TortoiseSVN](https://tortoisesvn.net/downloads.html) 사용
>>> [참고2](https://hellogk.tistory.com/128)

## 패키지 설치
- 패키지 업데이트
  - `sudo apt-get update`
  - `sudo apt-get upgrade`

- 필요 모듈 설치
  - `sudo apt-get install libapache2-mod-svn -y`
  - `sudo apt-get install subversion -y`
  - `sudo apt-get install apache2 -y`

## Repository 폴더 생성
- 폴더 생성
  - mkdir /home/pi/repose
  - svnadmin create /home/pi/repose/{프로젝트명}

## svn 접속권한 설정
- vi /usr/local/svnserver/project/conf/svnserve.conf

## 패키지 설치(시스템 업데이트 실시 후 진행)
- svn 패키지 설치
  - `sudo apt-get install subversion -y`

- svn 서버 구동을 위한 패키지 설치
  - `sudo apt-get install apache2 -y`
  - `sudo apt-get install libapache2-mod-svn -y`

- 원격 저장소 생성
  - `sudo mkdir /srv/svn/`
  - `sudo mkdir /srv/svn/java`
  - `sudo svnadmin create --fs-type fsfs /srv/svn/java`

<hr>
<br>

## svn 설정
- 컨트롤 권한 추가
  - `sudo addgroup sisrepo`
  - `sudo chgrp -R sisrepo /srv/svn/java`
    ```sh
    # 기타 옵션
    chmod -R g+rw  /srv/svn/java       # group mebers my write
    chmod -R o-rwx  /srv/svn/java      # other not.
    chmod g+s /srv/svn/java/db         #  this ensures log-write
    ```

  - `sudo useradd isso`
  - `sudo adduser isso sisrepo`

- svn 옵션 설정
  - `sudo vim /srv/svn/java/conf/svnserve.conf`
    ```sh
    anon-access = read
    auth-access = write
    realm = SIS Java Repository
    ```

- Umask 설정
  - `sudo which svnserve`
  - `sudo mv /usr/bin/svnserve /usr/bin/svnserve_orig`
  - `sudo touch /usr/bin/svnserve`
  - `sudo chmod 755 /usr/bin/svnserve`
  - `sudo vim /usr/bin/svnserve`
    ```sh
    #!/bin/bash
    umask 002  
    /usr/bin/svnserve_orig $*
    ```

<hr>
<br>

## Apache2 설치
- 패키지 설치
  - `sudo apt-get install apache2 -y`

<hr>
<br>

## libapache2-mod-svn 설치
- 패키지 설치
  - `sudo apt-get install libapache2-mod-svn -y`

- Apache server 설정
  - `sudo vim /etc/apache2/mods-enabled/dav_svn.conf`
    ```sh
    # Check the location of dav_svn.conf then just
    # copy all following lines to your shell and hit enter.
    #  conf will be appended to dav_svn.conf
    DAV svn  
    SVNPath /srv/svn/java

    AuthType Basic  
    AuthName &quot;My Java Repository&quot;  
    AuthUserFile /etc/apache2/svn.pass  
    Require valid-user
    ```

- User 비밀번호 추가
  - `sudo htpasswd -cm /etc/apache2/svn.pass aho`

<hr>
<br>

~~## 접속방법 1 : 저장소에 svn://아이피 형태로 직접 접속~~(위에 재정리)
~~- svn 통합 저장소 디렉토리 생성~~
  ~~- `sudo svnadmin create /home/pi/svn`~~

~~- 프로젝트에 접근을 허용할 ID와 Password 설정~~
  ~~- `sudo vim /home/pi/svn/conf/passwd`~~

~~- 프로젝트에 접근에 대한 보안정책 설정(주석 제거)~~
  ~~- `sudo vim /home/pi/svn/conf/svnserve.conf`~~
    ~~- `anon-access` = read~~
    ~~- `auth-access` = write~~
    ~~- `password-db` = passwd~~
    ~~- `realm` = My First Repository~~

<hr>
<br>

~~## 접속방법 2 : 저장소에 http://아이피/svn 형태로 웹 브라우저를 통해 접속~~

<hr>
<br>

# sudo 명령어로 root 권한을 얻지 못할 때
- 경고문
  - `userid is not in the sudoers file. This incident will be reported`
  - `userid 은(는) sudoers 설정 파일에 없습니다.  이 시도를 보고합니다.`

- sudoers 파일 사용
  - default sudo security policy plugin
  - `sudo visudo -f /etc/sudoers`

- root    ALL=(ALL:ALL) ALL 이라는 부분이 root 유저가 sudo 명령어를 사용할 수 있도록 하는 부분
    ```sh
    #
    # This file MUST be edited with the 'visudo' command as root.
    #
    # Please consider adding local content in /etc/sudoers.d/ instead of
    # directly modifying this file.
    #
    # See the man page for details on how to write a sudoers file.
    #
    Defaults        env_reset
    Defaults        mail_badpass
    Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

    # Host alias specification

    # User alias specification

    # Cmnd alias specification

    # User privilege specification
    root    ALL=(ALL:ALL) ALL
    sis_01  ALL=(ALL:ALL) ALL
    # Allow members of group sudo to execute any command
    %sudo   ALL=(ALL:ALL) ALL

    # See sudoers(5) for more information on "#include" directives:

    #includedir /etc/sudoers.d
    ```

<hr>
<br>

# ~~Oracle DB Client 연결~~
- ~~리눅스 버전 확인~~
  - ~~`uname -m`~~
  - ~~armv71 이면 32bit, 8 이상이면 64bit~~

- ~~[Oracle InstantClient 다운로드](https://www.oracle.com/database/technologies/instant-client/downloads.html)~~
  - ~~basic, sql*plus, jdbc development 다운로드~~

- ~~rpm 패키지 설치~~
  - ~~`sudo apt-get install rpm -y`~~

- ~~libaio 설치~~
  - ~~`sudo apt-get install libaio-dev -y`~~
  - ~~`sudo apt-get install alien libaio1 -y`~~

- ~~InstantClient 설치~~
  - ~~basic~~
    - ~~`sudo alien -ct oracle-instantclient19.3-basic-19.3.0.0.0-1.i386.rpm`~~
    - ~~`sudo alien -c oracle-instantclient19.3-basic-19.3.0.0.0.tgz`~~
    - ~~`sudo dpkg -i 3-basic_19.3.0.0.0-2_all.deb`~~

  - ~~sqlplus~~
    - ~~`sudo alien -ct oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.i386.rpm`~~
    - ~~`sudo alien -c oracle-instantclient19.3-sqlplus-19.3.0.0.0.tgz`~~
    - ~~`sudo dpkg -i 3-sqlplus_19.3.0.0.0-2_all.deb`~~
    
  - ~~jdb devleopment~~
    - ~~`sudo alien -ct oracle-instantclient19.3-jdbc-19.3.0.0.0-1.i386.rpm`~~
    - ~~`sudo alien -c oracle-instantclient19.3-jdbc-19.3.0.0.0.tgz`~~
    - ~~`sudo dpkg -i 3-jdbc_19.3.0.0.0-2_all.deb`~~

## 현 운영채제에서는 Oracle DB 설치불가
- debian OS에서는 불가능함

- Linux for Oracle OS를 설치해야 가능

<hr>
<br>

# [MySQL 설치와 운용](DB/mysql/README.md)

<hr>
<br>

# [PostgreSQL 설치와 운용](DB/postgresql/README.md)

<hr>
<br>

# [MS-SQL 설치와 운용](DB/ms-sql/README.md)

<hr>
<br>

# 라즈베리 파이 토렌트 운용
- 토렌트 머신 설치
  - `sudo apt-get install transmission-daemon -y`

- 토렌트 머신 설정
  - `sudo service transmission-daemon stop`
  - `sudo vim /etc/transmission-daemon/settings.json`
    ```sh
    ## [웹 클라이언트 접속 설정 항목]
    "rpc-whitelist-enabled": false, ## 웹 클라이언트의 whitelist(접속 허용 목록) 설정 여부
                                    ## false 설정 시, 모든 접속 허용. true는 whitelist 목록만 허용
    "rpc-password": "{543d21048c36a0add7d82410fadc6008248e2b73cBW6uECv", 
                                    ## whiltelist를 false 설정하면 웹 클라이언트 접속 id와 password 설정 필요
    "rpc-username": "transmission", ## 초기 계정 정보는 username : transmission, password : transmission
    "rpc-port": 9091,               ## 웹 클라이언트 접속 주소 설정(포트 번호)

    ## [다운로드 폴더 설정 항목]
    "download-dir": "/home/pi/Torrent/temp_bucket",
                                    ## 다운로드 완료 파일을 저장할 폴더 지정
    "incomplete-dir": "/home/pi/Torrent/Incomplete_box",
    "incomplete-dir-enabled": true, ## 다운로드 진행 중인 파일을 저장할 폴더 지정
                                    ## incomplete-dir-enabled을 true 설정해줘야 적용
    
    ## [토렌트 파일 다운로드 시작시, 토렌트 시드 파일(.torrent) 제거]
    "trash-original-torrent-files": true,
                                    ## 다운로드 시작하면 업로드한 토렌트 시드 파일을 자동으로 제거

    ## [토렌트 파일 업로드 시 다운로드 자동 실행 항목]
    "watch-dir": "/home/pi/Torrent/magnet_box",
                                    ## watch-dir-enabled를 true로 설정하고 dir 지정
    "watch-dir-enabled": true       ## watch 관련한 설정은 settings.json에 기본으로 존재하지 않음
                                    ## 파일 마지막 부분에 새로 추가(콤마 없음)
    ```

# Docker 설치
- 도커 설치(일반적인 리눅스 설치방법과 상이함)
  - `sudo apt update`
  - `sudo apt install apt-transport-https ca-certificates curl software-properties-common`
  - `sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`
  - `sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"`
  - `sudo apt update`
  - `sudo apt-cache policy docker-ce`
  - `sudo apt-get install docker -y`
  - `sudo snap install docker`

- 도커 설치 확인
  - `sudo docker --version`

- 도커 서비스 확인
  - `sudo snap services`
  - `sudo snap start docker`
  - `sudo snap services`

- ubuntu core 16 사용시 추가
  - `sudo snap connect docker:home`

- 도커 그룹 설정
  - `sudo addgroup --system docker`
  - `sudo adduser $USER docker`
  - `sudo newgrp docker`

- 도커 enable/disenable
  - `sudo snap disable docker`
  - `sudo snap enable docker`

- 도커 로그인
  - `sudo docker login`

- MS-SQL 이미지 받기
  - `sudo docker pull mcr.microsoft.com/mssql/server:2017-latest-ubuntu`
  - `sudo docker run -e ACCEPT_EULA=Y -e SA_PASSWORD='sisparang1!' -e MSSQL_PID=Express -p 443:443 -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu`

<hr>
<br>

# Nginx 설치
- 패키지 설치
  - `sudo apt-get install nginx -y`
  - `sudo service nginx start`

- nginx 실행 확인
  - `sudo service nginx status`

- nginx 포트 변경
  - `sudo vim /etc/nginx/sites-enabled/default`
    ```sh
    server {
        #listen 80 default_server;
        #listen [::]:80 default_server;
        listen 포트 default_server;
        listen [::]:포트 default_server;

            # SSL configuration
            #
            # listen 443 ssl default_server;
            # listen [::]:443 ssl default_server;
            #
            # Note: You should disable gzip for SSL traffic.
            # See: https://bugs.debian.org/773332
            #
            # Read up on ssl_ciphers to ensure a secure configuration.
            # See: https://bugs.debian.org/765782
            #
            # Self signed certs generated by the ssl-cert package
            # Don't use them in a production server!
            #
            # include snippets/snakeoil.conf;

            root /var/www/html;

            # Add index.php to the list if you are using PHP
            index index.html index.htm index.nginx-debian.html;

            server_name _;

            location / {
            proxy_pass http://호스트주소:포트;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
                    try_files $uri $uri/ =404;
            }

        location ~* \.(?:manifest|appcache|html?|xml|json)$ {
            expires -1;
        }

        location ~* \.(?:jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp4|ogg|ogv|webm|htc|ttf|woff|woff2)$ {
            proxy_pass http://호스트주소:포트;
            expires 1M;
            access_log off;
            add_header Cache-Control "public";
        }

        location ~* \.(?:css|js)$ {
            proxy_pass http://호스트주소:포트;
            expires 1y;
            access_log off;
            add_header Cache-Control "public";
        }

            # pass PHP scripts to FastCGI server
            #
            #location ~ \.php$ {
            #       include snippets/fastcgi-php.conf;
            #
            #       # With php-fpm (or other unix sockets):
            #       fastcgi_pass unix:/run/php/php7.3-fpm.sock;
            #       # With php-cgi (or other tcp sockets):
            #       fastcgi_pass 127.0.0.1:9000;
            #}

            # deny access to .htaccess files, if Apache's document root
            # concurs with nginx's one
            #
            #location ~ /\.ht {
            #       deny all;
            #}
    }


    # Virtual Host configuration for example.com
    #
    # You can move that to a different file under sites-available/ and symlink that
    # to sites-enabled/ to enable it.
    #
    #server {
    #       listen 80;
    #       listen [::]:80;
    #
    #       server_name example.com;
    #
    #       root /var/www/example.com;
    #       index index.html;
    #
    #       location / {
    #               try_files $uri $uri/ =404;
    #       }
    #}
    ```
  - `sudo service nginx restart`

- 리스타트 후 변경한 설정 적용 안될 시
  - `sudo service nginx reload`

<hr>
<br>

# NodeJs 설치
> [참고](https://promobile.tistory.com/381)

- 설치 *(build-essntial, curl이 설치되었다면 생략)*
  - `sudo apt-get update`
  - `sudo apt-get install -y build-essential`
  - `sudo apt-get install -y curl`
  - `curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash --`
  - `sudo apt-get install -y node.js`

- 확인
  - `node -v` 또는 `npm -v`

- Node.js 응용 프로그램을 실행하는 방법은 `node <filename>` 또는 `npm <command>` 임
  - 별개의 터미널을 이용해 실행하거나 OS의 스케쥴러를 활용함
  - 단, 웹 서비스와 같이 실행되어야 하는 App은 문제 발생 가능
  - PM2는 Node.js App을 백그라운드에서 실행하여 문제를 예방할 수 있다.

- 설치
  - sudo npm install --g pm2

- 실행
  - `sudo pm2 start <app.js>`
  - `sudo pm2 start <app.js> --name=<app name>` *(별도로 지정하고 싶은 경우)*

- 현재 실행 중인 App 목록 조회
  - sudo pm2 list

  - 항목별 설명

    |항목|설명|
    |----|----|
    |App name|실행 중인 App의 이름. 이 이름을 이용해 프로세스를 제어할 수 있으며 이후로 `<name>`이라고 표현|
    |id|실행 중인 App의 ID. ID를 이용해서도 프로세스를 제어할 수 있으며 이후로 `<id>`라고 표현|
    |mode|프로세스 실행 방식. 일반적으로 fork가 표시되고 클러스터링인 경우 cluster가 표시|
    |pid|OS에서 지정된 Process ID|
    |status|현재 상태. 정상 실행인 경우 online으로 표시되며 상태에 따라 error, stopped 등이 표시|
    |restart|재시작 횟수. restart 명령어로 재시작하거나, 오류로 인해 자동으로 재시작 된 경우 횟수가 증가|
    |uptime|시작된 이후로부터의 실행 시간. restart 된 경우 0초부터 다시 시작|
    |cpu|CPU 사용량|
    |mem|메모리 사용량|
    |watching|watch 여부가 표시|

- 현재 실행 중인 App의 간략한 정보 조회
  - `sudo pm2 show <id>`
  - `sudo pm2 show <name>`

- 실행된 App Log 조회
  - `sudo pm2 log`
  - `sudo pm2 log <id>`
  - `sudo pm2 log <name>`

- App 다시 실행
  - `sudo pm2 restart <id>`
  - `sudo pm2 restart <name>`

- App 중지
  - `sudo pm2 stop <id>`
  - `sudo pm2 stop <name>`

- 목록에서 App 삭제
  - `sudo pm2 delete <id>`
  - `sudo pm2 delete <name>`

<hr>
<br>

# MongoDB 설치
- 설치
  - `sudo apt-get update`
  - `sudo apt-get upgrade -y`
  - `sudo apt-get install mongodb-server -y`

- mongodb 외부접속 허용
  - `sudo vi /etc/mongodb.conf`
  - `bind_ip 주석 제거`
  - `port` 변경을 원하면 주석을 제거하고 원하는 번호 기입

- 변경한 설정 적용
  - `sudo service mongodb restart`

- mongodb 작동 확인
  - `sudo cat /var/log/mongodb/mongod.log`

- mongodb 접속
  - `mongo`

<hr>
<br>
