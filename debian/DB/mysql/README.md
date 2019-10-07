# MySQL
## MySQL 설치
- `sudo apt-get install mysql-server`
  - 현재 `mysql-server`에서 `mariadb-server`로 대체되었음
- `sudo apt-get install mariadba-server -y`

- root 암호 설정
  - mysql 접속 : `sudo mysql -u root mysql`
  - 공백으로 초기화 : `update user set plugin='';`
  - root 계정 암호 설정 : `update user set password=password('변경할암호') where User='root';`
  - 적용 : `flush privileges;`
  - mysql 종료 : `\q`

- mariadb 원격접속 허용을 위한 포트 변경
  - `sudo vim /etc/mysql/mariadb.conf.d/50-server.cnf`
    ```sh
    # 상위 생략

    [mysqld]

    #
    # * Basic Settings
    #
    user                    = mysql
    pid-file                = /run/mysqld/mysqld.pid
    socket                  = /run/mysqld/mysqld.sock
    port                    = 8100 # 원하는 포트번호로 변경
    basedir                 = /usr
    datadir                 = /var/lib/mysql
    tmpdir                  = /tmp
    lc-messages-dir         = /usr/share/mysql
    #skip-external-locking

    # Instead of skip-networking the default is now to listen only on
    # localhost which is more compatible and is not less secure.
    #bind-address            = 127.0.0.1 주석처리할것

    # 하위 생략
    ```

  - 재시작
    - `sudo service mysql restart`

- mariadb 접속
  - `sudo mysql -u root -p`
  - 설정한 비밀번호 입력

- 데이터베이스 생성
  - `create database SISMASTER;`

- 데이터베이스 확인
  - `show databases;`

- 사용자 계정 생성
  - 첫번째 : `create user 'sismaster'@'%' identified by 'sisparang1!';`
  - 두번째 : `insert into user (host, user, password) values('%', '{아이디}', password('{패스워드}'));`

- 사용자 계정 권한 부여
  - `grant all privileges on SISMASTER.* to 'sismaster'@'%' idetified by 'sisparang1!' with grant option;`
  
- 데이베이스 사용
  - `use SISMASTER;`

<br>

## MySQL Workbench 운용
- [MySQL Workbench 공식 사이트](https://www.mysql.com/products/workbench/)
  - Download Now 클릭
  - Download 클릭
  - No thanks, just start my download 클릭
  - 에러 시 [추가 설치](https://dev.mysql.com/resources/workbench_prerequisites.html)

- 설치 된 MySQL Workbench 실행
  
- `+` 버튼을 눌러 새로운 커넥션 추가
  - Standard(TCP/IP)로 추가

- 모델 설계 후 DB 적용 확인

<br>

## 테스트 데이터 덤프
- [테스트 데이터 tar](https://launchpad.net/test-db/employees-db-1/1.0.6/+download/employees_db-full-1.0.6.tar.bz2)
  - FTP로 파일 전송 또는 `curl` 명령어로 리눅스에 직접 다운로드

- 압축 해제1
  - `sudo bunzip2 employees_db-full-1.0.6.tar.bz2`

- 압축 해제2
  - `sudo tar -xvf employees_db-full-1.0.6.tar`

- 파일 덤프
  - `cd employees_db/`
  - `sudo mysql -u root -p -t < employees.sql`

- 암호화 적용(둘 중 하나)
  - `sudo mysql -u root -p -t < test_employees_md5.sql`
  - `sudo mysql -u root -p -t < test_employees_SHA.sql`

- 사용 유저에 데이터베이스 권한 부여
  - `sudo mysql -u root -p`
    ```sql
    -- mysql 최상위 데이터베이스 사용
    use mysql;
    -- 유저 확인
    select user, host from user;
    -- 권한 부여
    grant all privileges on employees.* to [유저 아이디]@'%' identified by '[비밀번호]';
    ```

- 데이터베이스 권한 확인
  - `sudo mysql -u [아이디] -p`
    ```sql
    -- 데이터베이스 변경
    use employees;
    -- 확인
    select * from employees;
    ```