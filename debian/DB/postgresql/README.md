# PostgreSQL 설치
> 에디터는 `vim` 사용

## root(super user) 접속
- `su`
  - input password

<br>

## PostgreSQL 설치
- `apt-get install postgresql -y`

<br>

## 데이터 파일 위치 확인
- postgres 계정으로 접속
  - `sudo su - postgres`

- 위치 확인
  - `pwd`

- psql 접속
  - `psql`

<br>

## 원격 접근을 위한 파일 수정
- `sudo vim /etc/postgresql/11/main/postgresql.conf`
    ```
    #listen_addresses = ‘localhost’
    listen_addresses = ‘*’ 로 수정
    ```

- `sudo vim /etc/postgresql/11/main/pg_hba.conf`
    ```sh
    # Database administrative login by Unix domain socket
    local   all             postgres                                trust

    # TYPE  DATABASE        USER            ADDRESS                 METHOD
    local   all             all                                     md5

    # "local" is for Unix domain socket connections only
    local   all             all                                     peer
    # IPv4 local connections:
    host    all             all             127.0.0.1/32            md5
    # IPv6 local connections:
    host    all             all             ::1/128                 md5
    # Allow replication connections from localhost, by a user with the
    # replication privilege.
    #local   replication     all                                     peer
    #host    replication     all             127.0.0.1/32            md5
    #host    replication     all             ::1/128                 md5

    host    all             all             0.0.0.0/0               md5
    ```

<br>

## 원격접속을 위해 슈퍼 계정에 패스워드 설정
- 슈퍼 계정으로 psql 로그인
  - `sudo –u postgres psql`

- 슈퍼 계정 패스워드 변경
    ```sql
    ALTER USER postgres WITH ENCRYPTED PASSWORD ‘패스워드’;
    ```

<br>

## 사용자 계정 등록
- 사용자 생성
  - 쉘에서 입력
    ```sh
    createuser sismaster --interactive
    ```

  - psql 프롬프트에서 생성
    ```sql
    create user sismaster with encrypted password 'sis!master';
    ```

- 사용자 확인
  - `\du`

<br>

## 테이블 스페이스 생성하기
- 존재하는 테이블 스페이스 확인하기
    ```sql
    select * from pg_tablespace;
    ```

    ```sql
    \db
    \db+
    ```

- 테이블 스페이스 생성하기
    ```sql
    create tablespace ts_sismaster location '/home/pi/db/db_postgresql';
    ```

- 권한 에러 발생 시
  - ERROR:  could not set permissions on directory "/home/pi/db/db_postgresql": Operation not permitted
  - `sudo chown -R postgres:postgres /home/pi/db`

- default 테이블 스페이스 설정
    ```sql
    alter role sismaster set  default_tablespace = ts_sismaster;
    ```

<br>

## 데이터베이스 생성하기
- 존재하는 데이터베이스 확인하기
    ```sql
    select * from pg_database;
    ```

    ```sql
    \list
    \l
    \list+
    \l+
    ```

- 생성한 테이블 스페이스에 데이터베이스 생성하기
    ```sql
    create database sismaster with tablespace = ts_sismaster;
    ```

- 생성한 데이터베이스의 소유자 부여하기
    ```sql
    alter database sismaster owner to sismaster;
    ```

<br>

## 데이터 디렉토리 변경하기
- 디렉토리 확인
  - `su - postgres`
  - `psql`
  - `show data_directory`

- 기존 데이터 디렉토리를 새로운 디렉토리로 변경 또는 복사
  - `sudo cp -rf /var/lib/postgresql/11/main/ /home/pi/db/db_PostgreSQL/`

- postgresql 설정 파일 변경
  - `sudo vim /etc/postgresql/11/main/postgresql.conf`
  - `data_directory` 항목을 새로운 디렉토리로 변경
    ```sh
    #------------------------------------------------------------------------------
    # FILE LOCATIONS
    #------------------------------------------------------------------------------

    # The default values of these variables are driven from the -D command-line
    # option or PGDATA environment variable, represented here as ConfigDir.

    #data_directory = '/var/lib/postgresql/11/main'          # use data in another directory
                                            # (change requires restart)
    data_directory = '/home/pi/db/db_PostgreSQL'
    hba_file = '/etc/postgresql/11/main/pg_hba.conf'        # host-based authentication file
                                            # (change requires restart)
    ident_file = '/etc/postgresql/11/main/pg_ident.conf'    # ident configuration file
                                            # (change requires restart)

    # If external_pid_file is not explicitly set, no extra PID file is written.
    external_pid_file = '/var/run/postgresql/11-main.pid'                   # write an extra PID file
                                            # (change requires restart)
    ```

- postgresql 재시작
  - `sudo /etc/init.d/postgresql restart`

- 변경된 디렉토리 확인
  - `su - postgres`
  - `psql`
  - `show data_directory`

<br>

## postgresql 삭제
- 설치된 패키지 조회
  - `sudo apt list --installed | grep postgre`

- 패키지 삭제
  - `sudo apt-get remove postgresql postgresql-common postgresql-client-common postgresql-client-11 postgresql-11`

- 제거되었는지 확인
  - `sudo apt list --installed | grep postgre`