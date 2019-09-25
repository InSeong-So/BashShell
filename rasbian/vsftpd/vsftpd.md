# 목차

<!-- TOC -->

- [목차](#%eb%aa%a9%ec%b0%a8)
- [기본설정](#%ea%b8%b0%eb%b3%b8%ec%84%a4%ec%a0%95)
  - [background=YES (기본값 = NO)](#backgroundyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [listen=YES (기본값 = NO)](#listenyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [listen_port=21](#listenport21)
  - [listen_address=none (기본값 = none)](#listenaddressnone-%ea%b8%b0%eb%b3%b8%ea%b0%92--none)
  - [listen_address6=none (기본값 = none)](#listenaddress6none-%ea%b8%b0%eb%b3%b8%ea%b0%92--none)
  - [pasv_address=none (기본값 = none)](#pasvaddressnone-%ea%b8%b0%eb%b3%b8%ea%b0%92--none)
  - [nopriv_user=ftpsecure (기본값 = nobody)](#noprivuserftpsecure-%ea%b8%b0%eb%b3%b8%ea%b0%92--nobody)
  - [max_clients=30 (기본값 = 0)](#maxclients30-%ea%b8%b0%eb%b3%b8%ea%b0%92--0)
  - [max_per_ip=3](#maxperip3)
  - [local_max_rate=0 (기본값 = 0)](#localmaxrate0-%ea%b8%b0%eb%b3%b8%ea%b0%92--0)
  - [trans_chunk_size=0](#transchunksize0)
  - [use_localtime=YES (기본값 = NO)](#uselocaltimeyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [setproctitle_enable=YES (기본값 = NO)](#setproctitleenableyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [user_config_dir=none (기본값 = none)](#userconfigdirnone-%ea%b8%b0%eb%b3%b8%ea%b0%92--none)
- [접속설정](#%ec%a0%91%ec%86%8d%ec%84%a4%ec%a0%95)
  - [local_enable=YES](#localenableyes)
  - [pam_service_name=vsftpd](#pamservicenamevsftpd)
  - [userlist_enable=YES (기본값 = NO)](#userlistenableyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [userlist_deny=YES (기본값 = YES)](#userlistdenyyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--yes)
  - [userlist_file=/etc/vsftpd.user_list (기본값 = /etc/vsftpd.user_list)](#userlistfileetcvsftpduserlist-%ea%b8%b0%eb%b3%b8%ea%b0%92--etcvsftpduserlist)
  - [text_userdb_names=NO (기본값 = NO)](#textuserdbnamesno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [tcp_wrappers=YES](#tcpwrappersyes)
  - [ssl_tlsv1=YES (기본값 = YES)](#ssltlsv1yes-%ea%b8%b0%eb%b3%b8%ea%b0%92--yes)
  - [ssl_enable=NO (기본값 = NO)](#sslenableno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [ssl_sslv2=NO (기본값 = NO)](#sslsslv2no-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [ssl_sslv3=NO (기본값 = NO)](#sslsslv3no-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [listen_ipv6=NO (기본값 = NO)](#listenipv6no-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [dsa_cert_file=none (기본값 = none)](#dsacertfilenone-%ea%b8%b0%eb%b3%b8%ea%b0%92--none)
  - [ssl_ciphers=DES-CBC3-SHA (기본값 = DES-CBC3-SHA)](#sslciphersdes-cbc3-sha-%ea%b8%b0%eb%b3%b8%ea%b0%92--des-cbc3-sha)
  - [force_local_data_ssl=YES (기본값 = YES)](#forcelocaldatasslyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--yes)
  - [force_local_logins_ssl=YES (기본값 = YES)](#forcelocalloginssslyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--yes)
- [대기시간 설정](#%eb%8c%80%ea%b8%b0%ec%8b%9c%ea%b0%84-%ec%84%a4%ec%a0%95)
  - [connect_timeout=60 (기본값 = 60/초)](#connecttimeout60-%ea%b8%b0%eb%b3%b8%ea%b0%92--60%ec%b4%88)
  - [accept_timeout=60 (기본값 = 60/초)](#accepttimeout60-%ea%b8%b0%eb%b3%b8%ea%b0%92--60%ec%b4%88)
  - [data_connection_timeout=300 (기본값 = 300/Secs)](#dataconnectiontimeout300-%ea%b8%b0%eb%b3%b8%ea%b0%92--300secs)
  - [idle_session_timeout=300 (기본값 = 300/Secs)](#idlesessiontimeout300-%ea%b8%b0%eb%b3%b8%ea%b0%92--300secs)
- [메시지 설정](#%eb%a9%94%ec%8b%9c%ec%a7%80-%ec%84%a4%ec%a0%95)
  - [banner_file=/etc/vsftpd/welcome.msg (기본값 = none)](#bannerfileetcvsftpdwelcomemsg-%ea%b8%b0%eb%b3%b8%ea%b0%92--none)
  - [ftpd_banner=Welcome to blah FTP service.](#ftpdbannerwelcome-to-blah-ftp-service)
  - [dirmessage_enable=YES](#dirmessageenableyes)
  - [Message_file=.message](#messagefilemessage)
- [모드설정](#%eb%aa%a8%eb%93%9c%ec%84%a4%ec%a0%95)
  - [port_enable=YES (기본값 = YES)](#portenableyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--yes)
  - [connect_from_port_20=YES](#connectfromport20yes)
  - [ftp_data_port=20 (기본값 = 20)](#ftpdataport20-%ea%b8%b0%eb%b3%b8%ea%b0%92--20)
  - [pasv_enable=YES (기본값 = YES)](#pasvenableyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--yes)
  - [pasv_promiscuous=NO (기본값 = NO)](#pasvpromiscuousno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [pasv_min_port=0 , pasv_max_port=0 (기본값 = 0)](#pasvminport0--pasvmaxport0-%ea%b8%b0%eb%b3%b8%ea%b0%92--0)
  - [ascii_upload_enable=YES , ascii_download_enable=YES](#asciiuploadenableyes--asciidownloadenableyes)
- [권한설정](#%ea%b6%8c%ed%95%9c%ec%84%a4%ec%a0%95)
  - [local_umask=022](#localumask022)
  - [file_open_mode=0644 (기본값 = 0666)](#fileopenmode0644-%ea%b8%b0%eb%b3%b8%ea%b0%92--0666)
  - [dirlist_enable=YES (기본값 = YES)](#dirlistenableyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--yes)
  - [force_dot_files=NO (기본값 = NO)](#forcedotfilesno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [tilde_user_enable=NO (기본값 = NO)](#tildeuserenableno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [hide_ids=NO (기본값 = NO)](#hideidsno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [write_enable=YES (기본값 = NO)](#writeenableyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [download_enable=YES (기본값 = YES)](#downloadenableyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--yes)
  - [chmod_enable=YES (기본값 = YES)](#chmodenableyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--yes)
  - [use_sendfile=YES (기본값 = YES)](#usesendfileyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--yes)
  - [cmds_allowed=PASV,RETR,QUIT (기본값 = none)](#cmdsallowedpasvretrquit-%ea%b8%b0%eb%b3%b8%ea%b0%92--none)
  - [deny_file={*.mp3,*.mov} (기본값 = none)](#denyfilemp3mov-%ea%b8%b0%eb%b3%b8%ea%b0%92--none)
  - [hide_file={*.mp3,*.mov} (기본값 = none)](#hidefilemp3mov-%ea%b8%b0%eb%b3%b8%ea%b0%92--none)
  - [async_abor_enable=YES (기본값 = NO)](#asyncaborenableyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [ls_recurse_enable=YES](#lsrecurseenableyes)
- [보안설정](#%eb%b3%b4%ec%95%88%ec%84%a4%ec%a0%95)
  - [chroot_list_enable=YES (기본값 = NO)](#chrootlistenableyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [chroot_list_file=/etc/vsftpd.chroot_list](#chrootlistfileetcvsftpdchrootlist)
  - [passwd_chroot_enable=NO (기본값 = NO)](#passwdchrootenableno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [chroot_local_user=YES](#chrootlocaluseryes)
  - [secure_chroot_dir=/usr/share/empty (기본값 = /usr/share/empty)](#securechrootdirusrshareempty-%ea%b8%b0%eb%b3%b8%ea%b0%92--usrshareempty)
- [로그설정](#%eb%a1%9c%ea%b7%b8%ec%84%a4%ec%a0%95)
  - [xferlog_enable=YES](#xferlogenableyes)
  - [vsftpd_log_file=/var/log/vsftpd.log(기본값 = /var/log/vsftpd.log)](#vsftpdlogfilevarlogvsftpdlog%ea%b8%b0%eb%b3%b8%ea%b0%92--varlogvsftpdlog)
  - [dual_log_enable=NO (기본값 = NO)](#duallogenableno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [syslog_enable=NO (기본값 = NO)](#syslogenableno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [xferlog_file=/var/log/vsftpd.log](#xferlogfilevarlogvsftpdlog)
  - [xferlog_std_format=YES](#xferlogstdformatyes)
  - [log_ftp_protocol=YES (기본값 = NO)](#logftpprotocolyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [no_log_lock=NO (기본값 = NO)](#nologlockno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [session_support=YES](#sessionsupportyes)
- [가상 사용자 설정](#%ea%b0%80%ec%83%81-%ec%82%ac%ec%9a%a9%ec%9e%90-%ec%84%a4%ec%a0%95)
  - [guest_enable=NO](#guestenableno)
  - [guest_username=ftp](#guestusernameftp)
  - [virtual_use_local_privs=NO (기본값 = NO)](#virtualuselocalprivsno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [user_sub_token=$USER (기본값 = none)](#usersubtokenuser-%ea%b8%b0%eb%b3%b8%ea%b0%92--none)
  - [local_root=/home/virtual/$USER (기본값 = none)](#localroothomevirtualuser-%ea%b8%b0%eb%b3%b8%ea%b0%92--none)
- [익명사용자 기본 설정](#%ec%9d%b5%eb%aa%85%ec%82%ac%ec%9a%a9%ec%9e%90-%ea%b8%b0%eb%b3%b8-%ec%84%a4%ec%a0%95)
  - [anonymous_enable=NO](#anonymousenableno)
  - [anon_max_rate=0 (기본값 = 0)](#anonmaxrate0-%ea%b8%b0%eb%b3%b8%ea%b0%92--0)
  - [allow_anon_ssl=NO (기본값 = NO)](#allowanonsslno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [deny_email_enable=YES (기본값 = NO)](#denyemailenableyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [banned_email_file=/etc/vsftpd.banned_emails (기본값 = /etc/vsftpd.banned_emails)](#bannedemailfileetcvsftpdbannedemails-%ea%b8%b0%eb%b3%b8%ea%b0%92--etcvsftpdbannedemails)
  - [secure_email_list_enable=NO (기본값 = NO)](#secureemaillistenableno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [email_password_file=/etc/vsftpd.email_passwords (기본값 = /etc/vsftpd.email_passwords)](#emailpasswordfileetcvsftpdemailpasswords-%ea%b8%b0%eb%b3%b8%ea%b0%92--etcvsftpdemailpasswords)
  - [ftp_username=ftp (기본값 = ftp)](#ftpusernameftp-%ea%b8%b0%eb%b3%b8%ea%b0%92--ftp)
  - [no_anon_password=NO (기본값 = NO)](#noanonpasswordno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [one_process_model=NO (기본값 = NO)](#oneprocessmodelno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [anon_root=/var/ftp/pub (기본값 = none)](#anonrootvarftppub-%ea%b8%b0%eb%b3%b8%ea%b0%92--none)
- [익명사용자 권한 설정](#%ec%9d%b5%eb%aa%85%ec%82%ac%ec%9a%a9%ec%9e%90-%ea%b6%8c%ed%95%9c-%ec%84%a4%ec%a0%95)
  - [anon_upload_enable=YES](#anonuploadenableyes)
  - [anon_mkdir_write_enable=YES](#anonmkdirwriteenableyes)
  - [anon_world_readable_only=YES (기본값 = YES)](#anonworldreadableonlyyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--yes)
  - [anon_other_write_enable=NO (기본값 = NO)](#anonotherwriteenableno-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [chown_uploads=YES (기본값 = NO)](#chownuploadsyes-%ea%b8%b0%eb%b3%b8%ea%b0%92--no)
  - [anon_umask=022 (기본값 = 077)](#anonumask022-%ea%b8%b0%eb%b3%b8%ea%b0%92--077)
  - [chown_username=whoever (기본값 = root)](#chownusernamewhoever-%ea%b8%b0%eb%b3%b8%ea%b0%92--root)

<!-- /TOC -->

<hr>
<br>

# 기본설정
## background=YES (기본값 = NO)
> VsFTP 데몬을 background로 실행할 것인지 설정 합니다.

## listen=YES (기본값 = NO)
> VsFTP 데몬은 기본적으로 inetd 모드로 동작이 됩니다.
>> 따라서 독립모드(standalone)로 데몬을 운영하실 거라면 이 옵션과 listen 옵션을 모두 YES로 켜주셔야 됩니다. 반대로 VsFTP 데몬을 inetd 모드로 운영하시려면 이 옵션과 listen 옵션을 비활성화 하시면 됩니다.일반적으로 FTP 데몬은 많은 접속이 있을 경우에 standalone 모드로 운영하는것이 좋으며, 많은 접속이 없는 경우에는 inetd 모드로 운영하는것이 시스템 자원효율에 좋습니다. background 옵션과 같이 사용되며, 이 옵션은 listen_port에서 들어오는 요청에 대해서 데몬이 요청을 받아드릴지에 대해 설정합니다. 만약 데몬을 독립모드(standalone)로 운영하실 거라면 background 옵션과 같이 이 옵션도 함께 활성화 시켜야 됩니다.

## listen_port=21
> 만약 vsftpd를 xinetd모드가 아닌 독립데몬 (standalone)으로 서비스하려면 위의 listen 지시자를 YES로 설정하시고 listen_port 에 서비스할 포트번호(기본 21번)를 지정하시면 됩니다.

## listen_address=none (기본값 = none)
> 멀티 FTP 데몬을 사용할 때 요청을 받아드릴 IP를 설정합니다.

## listen_address6=none (기본값 = none)
> listen_address와 동일하며 IPv6에서 운영할 때 사용 합니다.

## pasv_address=none (기본값 = none)
> NAT를 사용하는 클라이언트의 공용 IP를 설정할 때 사용 합니다. 일반적으로 설정하지 않아도 상관 없습니다.

## nopriv_user=ftpsecure (기본값 = nobody)
> VsFTPd가 구동될 서버의 유저를 설정합니다.

## max_clients=30 (기본값 = 0)
> FTP 서버에 접속할 수 있는 클라이언트의 최대수를 제한하는 옵션 입니다. 기본값인 0으로 설정하면 제한을 두지 않습니다.

## max_per_ip=3
> 이 설정은 동시 ftp 접속자수를 제한하는 설정입니다. 첫번째 max_client 는 ftp 접속을 최대 30명까지만 허용한다는 설정입니다. 그리고 max_per_ip 는 한 IP(호스트)에서 동시에 3번까지만 접속이 가능하다는 설정입니다. 이 또한 서비스거부공격(DoS)를 방어하기 위한 방법으로 활용될 수 있습니다.

## local_max_rate=0 (기본값 = 0)
> 계정 사용자의 최대전송률을 지정합니다.업/다운로드의 속도를 제한할 때 사용하며, 단위는 bps 입니다.

## trans_chunk_size=0
> 위의 세가지 설정은 ftp 서비스의 전송속도를 제한 하도록 하는 설정입니다. 즉, 초당 byte 수를 지정할 수 있으며 제한없이 허용하려면 0 으로 설정하시면 됩니다. 이 설정은 vsftpd 가 독립데몬(standalone)모드로 서비스될 때에만 적용되는 것입니다.

## use_localtime=YES (기본값 = NO)
> 서버의 FTP 데몬시간을 서버의 표준시간으로 고정할지 설정합니다. 만약 이 옵션을 비활성화 하게되면 표준시각(GMT)를 보여주므로, 한국의 경우 9시간의 오차가 발생합니다.

## setproctitle_enable=YES (기본값 = NO)
> 프로토콜의 현재 상태를 출력해줄 것인지 설정합니다. 이 옵션을 활성화하면 ps 명령어를 사용했을 때 세션의 현재 상태도 보여줍니다. 또한 LTN에서 제공하는 ftpwho 스크립트를 사용할 때에도 이 옵션을 활성화 하셔야 됩니다.

## user_config_dir=none (기본값 = none)
> 특정 사용자의 개별 설정 파일을 지정합니다. 이 옵션을 사용하면 /etc/vsftpd/vsftpd.conf의 지시문을 무시하고 사용할 수 있습니다.

<br>

# 접속설정
## local_enable=YES
> 로컬 계정 사용자들의 접속을 허용할 것인가의 여부를 결정합니다. YES 로 설정하면 로컬계정사용자의 접속을 허용하는 것이며 NO로 설정하면 허용하지 않는 것입니다. 기본 설정은 YES로 되어있기 때문에 접속을 허용하게 됩니다. 만약 NO로 설정되어 있을 때 로컬 계정으로 접속을 시도하면 “530 This FTP server is anonymous only.”와 같은 에러메시지를 출력하면서 접속을 거부합니다.

## pam_service_name=vsftpd
> vsftpd에서 PAM설정파일명으로 사용할 파일명을 지정합니다. 이 설정이 적용되면 기본이 vsftpd 이므로 /etc/pam.d/vsftpd 파일이 사용됩니다.

## userlist_enable=YES (기본값 = NO)
> 명시된 사용자만 로그인을 허용할 때 사용하는 옵션입니다. userlist_deny 옵션이 비활성화 된 상태에서만 작동합니다.

## userlist_deny=YES (기본값 = YES)
> 명시된 사용자가 로그인을 할 수 없도록 제한하는 옵션 입니다.
>> userlist_enable 옵션이 비활성화 된 상태에서만 작동하며, 서로 반대되는 개념 입니다.

## userlist_file=/etc/vsftpd.user_list (기본값 = /etc/vsftpd.user_list)
> 명시된 사용자를 읽어올 파일을 지정합니다.

## text_userdb_names=NO (기본값 = NO)
> 디렉토리 목록의 사용자와 그룹 필드들에 있는 숫자 ID 들이 보이는 것이 기본값 입니다.
>> 당신은 이 파라미터를 활성화 함으로써 글자 이름을 사용할 수도 있습니다. 그러나 이 항목은 성능상의 이유로 기본적으로 비활성화 되어 있습니다.

## tcp_wrappers=YES
> tcp_wrappers 적용 여부를 설정하는 것으로 사용할 것인가(YES) 사용하지 않을 것인가(NO)를 설정합니다. YES로 설정하시면 허용할 호스트는 /etc/hosts.allow 허용하지 않을 호스트는 /etc/hosts.deny에 설정합니다.

## ssl_tlsv1=YES (기본값 = YES)
> TLS를 사용할 것인지에 대해 설정합니다.
>> 이 옵션은 TLS를 활성화하며, TLS가 가능한 클라이언트가 이용하는데 도움이 됩니다.

## ssl_enable=NO (기본값 = NO)
> SSL을 통한 보안접속을 지원할 것인지에 대해 설정합니다.
>> 만약 OpenSSL에 대해서 컴파일 되어 있고, 이 옵션을 허용할 경우 vsftpd는 SSL을 통한 보안 접속을 지원합니다. 이 옵션은 제어 연결을 지원(로그인을 포함)하며, 또한 데이터 연결도 지원 합니다. 사용자는 SSL을 지원하는 클라이언트를 필요로 할 것이며, 반드시 필요한 경우에만 허용하는것이 좋습니다. 그러나 vsftpd는 OpenSSL 라이브러리의 보안과 관련한 게런티를 만들 수 없으며, 이 옵션을 활성화 합니다는것은 OpenSSL 라이브러리의 보안을 믿는다는 것을 전제로 합니다.

## ssl_sslv2=NO (기본값 = NO)
> SSL v2 프로토콜 연결을 허용할 것인지에 대해 설정합니다.
>> 이 옵션은 ssl_enable이 활성화 되었을 때만 적용되며, TLS v1 연결들을 선호 합니다.

## ssl_sslv3=NO (기본값 = NO)
> SSL v3 프로토콜 연결을 허용할 것인지에 대해 설정합니다.
>> 이 옵션은 ssl_enable이 활성화 되었을 때만 적용되며, TLS v1 연결들을 선호 합니다.

## listen_ipv6=NO (기본값 = NO)
> listen 옵션과 동일하지만, IPv6에서 운영할 때 사용 합니다. 일반적으로 IPv6는 사용하지 않으므로 비활성화 하시면 됩니다.

## dsa_cert_file=none (기본값 = none)
> SSL 인증서의 위치를 지정합니다. SSL의 암호화 접속을 사용하기 위해, DSA 인증서의 위치를 지정합니다.

## ssl_ciphers=DES-CBC3-SHA (기본값 = DES-CBC3-SHA)
> 이 옵션은 vsftpd가 암호화 된 SSL 연결들에 대해 어떤 SSL 암호화 방식을 선택하는지에 따라 사용됩니다. 더 자세한 사항은 관련 암호 메뉴얼 페이지를 보십시요.
>> 암호화를 알리지 않는 것은 원격에서 선택된 암호화 방식의 취약점을 공격하려고 불법적인 원격 공격을 막기 위한 유용한 보안 지침이 될 수 있습니다.

## force_local_data_ssl=YES (기본값 = YES)
> 이 옵션은 ssl_enable이 활성화 되었을 때만 적용되며, 만약 이 옵션이 활성화 되어 있습니다. 모든 비익명 로그인은 데이터 연결 상태에서 데이터를 주고 받기 위해 보안 SSL 연결을 사용하도록 강제적으로 설정됩니다.

## force_local_logins_ssl=YES (기본값 = YES)
> 이 옵션은 ssl_enable이 활성화 되었을 때만 적용되며, 만약 이 옵션이 활성화 되어 있습니다. 모든 비익명 로그인은 비밀번호를 전달하기 위해 보안 SSL 연결을 사용하도록 강제적으로 설정됩니다.

<br>

# 대기시간 설정
## connect_timeout=60 (기본값 = 60/초)
> 액티브 모드(Active Mode)를 사용하는 클라이언트의 접속 허용시간을 설정합니다. 클라이언트의 요청패킷(SYN Packet)을 받은뒤, 지정된 시간내에 접속이 안될경우 종료합니다.

## accept_timeout=60 (기본값 = 60/초)
> 패시브 모드(Passive Mode)를 사용하는 클라이언트의 접속 허용시간을 설정합니다. 클라이언트의 요청패킷(SYN Packet)을 받은뒤, 지정된 시간내에 접속이 안될경우 종료합니다.

## data_connection_timeout=300 (기본값 = 300/Secs)
> 데이터 전송시 적용되는 타임아웃값을 설정합니다. 만약 ftp 연결시 큰 파일을 업로드 또는 다운로드 할 때에 전송도중 접속이 끊기는 상황이 발생한다면 이 설정을 주석처리하거나 또는 이 값을 현재 설정값 보다 크게 잡아주시고 재시도 해보십시요.

## idle_session_timeout=300 (기본값 = 300/Secs)
> ftp 연결에서 idle 타임에 대한 타임아웃값을 설정합니다. 예를 들어 이 값이 600으로 설정되어 있다면 ftp 접속후에 600초(10분)동안 아무런 작업도 없이 놀고 있다면 강제 로그아웃(timeout)시켜 버립니다.

<br>

# 메시지 설정
## banner_file=/etc/vsftpd/welcome.msg (기본값 = none)
> 사용자가 FTP 서버에 접속했을 때 보여줄 환영 메시지 파일을 설정합니다.

## ftpd_banner=Welcome to blah FTP service.
> ftp 서버로 접속할 때에 안내메시지등을 출력하려면 여기서 설정하시면 됩니다. 이 설정이 적용되면 ftp 접속을 하였을 때 "Welcome to blah FTP service"라는 안내문이 출력됩니다. 이 설정에서 한글을 사용할 수도 있습니다. 각 디렉토리별 안내문에 대한 설정은 다음 지시자의 설명을 보시기 바랍니다.

## dirmessage_enable=YES
> ftp 접속한 사용자가 특정 디렉토리로 이동하였을 때 개별 디렉토리의 메시지를 보여주도록 허용할 것인가(YES) 허용하지 않을 것인가(NO) 를 설정하는 것입니다. 밑에서 설명하고 있는 "message_file" 지시자에서 개별 디렉토리안내 파일로 사용할 파일명을 지정할 수 있습니다.

## Message_file=.message
> ftp 접속후에 특정 디렉토리로 이동할 때에 디렉토리 안내메시지 파일로 사용할 파일명을 지정한 것입니다. 이 설정은 바로 위에서 설명한 "dirmessage_enable" 이 YES로 설정되어 있을 때 적용됩니다.

<br>

# 모드설정
## port_enable=YES (기본값 = YES)
> 데이터 전송을 위해서 Active Mode를 사용할 것인지 설정합니다.

## connect_from_port_20=YES
> ftp 서비스는 기본적으로 21번 포트와 20번 포트를 사용합니다. ftp 접속과 명령어에 사용되는 포트는 21번이며 실제 데이터전송에 사용되는 기본포트는 20번입니다. 이때 20번 포트의 데이터전송 연결을 허용할 것인가(YES) 허용하지 않을 것인가(NO)를 설정하는 지시자 입니다.

## ftp_data_port=20 (기본값 = 20)
> 데이터 전송 포트를 지정합니다.
>> connect_from_port_20 옵션이 활성화 되었을 때 사용되는 포트를 지정합니다.

## pasv_enable=YES (기본값 = YES)
> 데이터 전송을 위해서 Passive mode를 사용할 것인지 설정합니다.
>> Active Mode로 접근할 수 없는 사용자들을 위해 활성화 하는 것 이 좋습니다.

## pasv_promiscuous=NO (기본값 = NO)
> 동일한 IP주소에서 이루어지는 데이터 연결을 보장해주는 보안체크 기능을 사용할 것인지 설정합니다.

## pasv_min_port=0 , pasv_max_port=0 (기본값 = 0)
> 패시브 모드로 연결시 할당될 최대 및 최소 포트를 설정하는 옵션 입니다. 일반적으로 50000~60000 포트를 지정하는 것이 좋으며, 기본값인 0으로 설정하게 되면 well-known port를 제외한 무작위 포트를 이용하게 됩니다.

## ascii_upload_enable=YES , ascii_download_enable=YES
> 기본적으로 ASCII 모드로 업로드/다운로드하는 것이 제한되어 있습니다. 이 설정으로 ASCII모드로의 업로드/다운로드를 허용하도록 설정할 수 있습니다.

<br>

# 권한설정
## local_umask=022
> 로컬계정 사용자들의 umask 값을 설정하는 지시자입니다. 거의 모든 ftp 서버에서 기본 umask 값은 022 입니다. 하지만 vsftp 에서의 umask 기본값은 077입니다. Umask 값이 077 일 경우에 새로 생성되는 파일의 퍼미션은 600 이 되며 새로 생성되는 디렉토리의 퍼미션은 700 이 됩니다. 당연히 umask 값이 022 일 때보다는 보안이 훨씬 강화됩니다. 여기서 "local_umask=022"의 주석을 제거하여 유효하게 설정하면 대부분의 FTP 서버에서 사용하는 umask 값을 022로 설정하게 됩니다. 만약 022 외에 다른 umask 값을 설정하고자 한다면 그 값을 설정해 주시면 됩니다.

## file_open_mode=0644 (기본값 = 0666)
> 파일이 업로드 되었을 때의 퍼미션을 지정해주는 옵션 입니다.
>> 이 옵션은 반드시 umask 옵션보다 아래에 있어야 됩니다.

## dirlist_enable=YES (기본값 = YES)
> 접속한 디렉토리의 파일리스트를 보여줄 지 설정합니다.

## force_dot_files=NO (기본값 = NO)
> 히든 파일/디렉토리를 보여줄 것인지 설정하는 옵션 입니다. 히든 파일/디렉토리는 dot(.) 으로 시작하는 것을 말합니다.

## tilde_user_enable=NO (기본값 = NO)
> 이 옵션이 활성화되면, vsftpd는 ~chris/pics와 같이 사용자 계정 이름에 틸드 표시가 따라오는 경우의 경로명을 접근하도록 시도하고 해석할 것입니다. vsftpd는 항상 ~ 와 ~/somthing 을 해석합니다는 것을 주의하시기 바랍니다.
>> (여기서 ~ 는 기본적으로 로그인 했을 때의 디렉토리로 해석됩니다.) ~user 경로들은 _current_ chroot() 에서 /etc/passwd 파일을 찾을 수 있을 경우에만 해석 될 수 있을 것입니다.

## hide_ids=NO (기본값 = NO)
> 디렉토리 목록에서 UID를 보여주지 않고, 모두 FTP로 표시할 것인지 설정합니다.
>> 이 옵션을 활성화 하면 모든 파일의 소유권이 FTP로 표시되므로 보안에 도움이 될 수 있습니다.

## write_enable=YES (기본값 = NO)
> ftp 로 접속이 된 상태에서 사용할 수 있는 ftp 전용명령어에는 여러가지가 있습니다. 이 설정은 ftp 전용명령어 중에 write 명령어를 허용할 것인가를 결정하는 것입니다. 허용하려면 YES, 허용하지 않으려면 NO 를 설정하시면 됩니다.

## download_enable=YES (기본값 = YES)
> 다운로드에 대한 권한을 설정합니다.

## chmod_enable=YES (기본값 = YES)
> 사용자가 퍼미션을 변경할 수 있도록 설정합니다.

## use_sendfile=YES (기본값 = YES)
> 이 옵션은 당신의 플랫폼에서 sendfile() 시스템 호출을 사용하는 것과 관련된 이익을 테스트 할 때 사용되는 내부 설정입니다.

## cmds_allowed=PASV,RETR,QUIT (기본값 = none)
> 사용자에게 허가할 명령어를 지정합니다.

## deny_file={*.mp3,*.mov} (기본값 = none)
> 업로드를 거부할 파일명을 지정합니다.

## hide_file={*.mp3,*.mov} (기본값 = none)
> 숨길 파일명을 지정합니다.
>> 이 옵션을 사용하면 서버에 실제로 데이터는 존재하지만, FTP 사용자에게는 보이지 않도록 설정하는 기능입니다. 악의적인 사용자에게 간단한 fake를 걸 수 있습니다.

## async_abor_enable=YES (기본값 = NO)
> async ABOR 명령어를 사용할 수 있도록 설정합니다.
>> 일부 FTP 클라이언트에서 파일전송을 취소했을 경우, 취소되지 않은 상태로 있는 경우가 생길 수 있는데 그것을 방지하기 위해 사용할 수 있습니다. 그러나 보안상 좋지 않기 때문에, 비활성화 하시는것이 좋습니다.

## ls_recurse_enable=YES
> ftp 접속에서는 ls 사용시 –R 옵션을 허요하지 않는 것이 기본 설정입니다. –R 옵션이란 서브디렉토리내의 파일들의 리스팅(목록)까지 모두 확인할 수 있도록 하는 것입니다. 서버부하등의 이유로 ftp에서 기본적으로는 지원하지 않지만 vsftpd 에서는 이 옵션을 사용하여 허용하도록 설정할 수 있습니다. 즉, 이 지시자의 값이 YES로 되어 있다면 ftp 접속후에 디렉토리 목록 확인시에 서브디렉토리들의 목록들까지 한번에 볼 수 있는 –R 옵션을 허용하게 됩니다.

<br>

# 보안설정
## chroot_list_enable=YES (기본값 = NO)
> 명시된 사용자가 자신의 홈상위 디렉토리를 접근할 수 없도록 설정합니다.이 옵션은 chroot_local_user 옵션이 비활성화되어 있어야 사용할 수 있습니다. 전체 적용이 아니라 일부 사용자만 제한할때 편하지만, 개별 적용은 보안상 좋지 않습니다.

## chroot_list_file=/etc/vsftpd.chroot_list
> 전체 사용자가 아닌 특정 사용자들에 대하여 자신의 홈디렉토리를 루트디렉토리로 인식하도록 하는 기능으로서 이 기능은 사용자의 홈디렉토리의 상위디렉토리로 벗어나지 못하도록 하는 설정입니다.
>> 먼저 "chroot_list_enable=YES" 로 설정하시고 /etc/vsftpd.chroot_list 파일에는 이 기능을 적용할 사용자계정명을 등록해 두시면 됩니다. 즉, /etc/vsftpd.chroot_list 파일에 등록된 사용자들에 한하여 chroot()기능이 적용되어 자기 자신의 홈디렉토리 상위 디렉토리의 이동이 제한됩니다. 이 파일에 등록할 때에는 한행에 한 사용자 계정씩만 등록하셔야 합니다. 만약 전체 사용자를 대상으로 chroot()기능을 적용하고자 한다면 바로 밑에서 설정하고 있는 "chroot_local_user=YES"로 설정하시기 바랍니다.

## passwd_chroot_enable=NO (기본값 = NO)
> SSH로 접속했을 때 자신의 홈 상위 디렉토리를 접근할 수 없도록 설정합니다.
>> chroot_local_user 옵션이 활성화되었고, OpenSSH에 패치를 했을경우, SSH 또한 자신의 홈상위 디렉토리를 접근할 수 없도록 설정할 수 있으며, /etc/passwd 파일의 홈 디렉토리 필드의 /home/사용자/./와 같이 "/./"를 붙여 사용자를 홈디렉토리에 제한하게 합니다.

## chroot_local_user=YES
> 특정 사용자가 아닌 전체 사용자를 대상으로 chroot()기능을 적용하여 자기 자신의 홈디렉토링 상위 디렉토리로 이동하지 못하도록 하려면 이 설정을 YES로 설정하십시요. 반드시 앞의 설정과 비교해 보시기 바랍니다.
>> 만약 위 의 두 설정이 모두 설정되었다면 즉, "chroot_list_enable=YES"와 "chroot_local_user=YES" 설정이 모두 YES로 되어 있다면 /etc/vsftpd.chroot_list 에 등록된 사용자만 chroot()적용을 받지 않게 됩니다. 즉, 이 두 설정이 모두 YES 로 되어 있다면 /etc/vsftpd.chroot_list 에 등록된 사용자들을 제외한 나머지 사용자들만 chroot()가 적용되어 상위 디렉토리로의 이동이 안된다는 의미입니다.

## secure_chroot_dir=/usr/share/empty (기본값 = /usr/share/empty)
> secure chroot()에 사용될 디렉토리를 지정합니다.
>> 이 옵션에서 지정된 디렉토리는 비어있어야되며, ftp 사용자에 대해 쓰기 권한이 없어야 됩니다.

<br>

# 로그설정
## xferlog_enable=YES
> ftp 접속후에 파일 업로드와 다운로드에 대한 로그를 남길것인가(YES) 남가지 않을 것인가(NO)를 설정하는 지시자입니다. 이 지시자의 설정은 디스크의 용량을 고려하여 결정해야 합니다. 즉, 파일 업로드/다운로드 로그는 굉장히 많은 용량을 필요로 하고 또한 시스템 부하율도 함께 고려하여 신중히 결정해야 합니다. 물론 로그를 남기는 것이 로그분석과 개별 사용자의 파일 업로드/다운로드 상황을 알 수 있는 방법이기는 하지만 시스템 상황을 고려해야 하는 의미입니다.

## vsftpd_log_file=/var/log/vsftpd.log(기본값 = /var/log/vsftpd.log)
> VsFTP의 기본 로그 파일을 지정합니다.
>> 이 옵션은 xferlog_enable 옵션과 xferlog_std_format 옵션이 비활성화일 때 작동하며, dual_log_enable 옵션이나 syslog_enable 옵션이 활성화될때 사용됩니다.

## dual_log_enable=NO (기본값 = NO)
> 2중 로그를 기록할 것인지에 대해 설정합니다.
>> 만약 이 옵션을 활성화하면, /var/log/xferlog와 /var/log/vsftpd.log에 로그가 기록됩니다.

## syslog_enable=NO (기본값 = NO)
> syslogd 데몬을 이용해서 로그를 기록할 것인지 설정합니다.

## xferlog_file=/var/log/vsftpd.log
> ftp 로그파일의 위치를 결정하는 지시자입니다.
>> Vsftp는 기본적으로 /var/log/vsftpd.log 파일을 기본 로그파일로 사용합니다. 만약 로그파일 위치나 파일명을 변경하시려면 이 지시자에서 설정 변경하시면 됩니다.

## xferlog_std_format=YES
> 로그파일에 남길 로그파일의 포맷을 기본포맷으로 남길 것인가(YES) 아닌가(NO)를 설정하는 지시자 입니다. 리눅스에서 ftp 기본 로그파일을 /var/log/xferlog을 사용합니다. 이 지시자는 이 파일의 표준포맷으로 로그를 남기도록 하는 설정입니다. 이 파일의 포맷보다는 vsftpd 로그포맷을 사용하시는 것이 보다 자세한 로그를 남길 수 있습니다. 즉, 디렉토리생성로그나 또는 로그인 로그 같은 상세로그까지 기록해 줍니다.

## log_ftp_protocol=YES (기본값 = NO)

> FTP Protocol의 모든 내용을 기록할지 설정합니다.
>> 이 옵션을 활성화하면 FTP 명령어와 반응이 모두 로깅되므로 디버그에 유용하게 쓰입니다.

## no_log_lock=NO (기본값 = NO)
> 로그 파일을 잠글것인지에 대해서 설정합니다.
>> 이 옵션은 vsftpd가 로그 파일을 기록할 때, 파일을 잠그는 것을 막는 옵션 입니다. 보통은 활성화 하지 않아도 되며, 솔라리스/베리타스 파일 시스템 조합에서 때때로 로그파일을 잠그려는 시도를 하는 운영체제 시스템 버그를 피하기 위해 존재 합니다.

## session_support=YES
> 이 설정은 YES로 설정되어 유효하게 되었을 때에는 바이너리파일인 wtmp에 ftp 접속관련 기록을 남기게 됩니다.
>> Last 라는 명령어는 각 사용자들의 접속기록을 wtmp 파일에서 가져와 확인하는 명령어이므로 이 설정이 적용되면 last 명령어로 ftp 접속기록을 확인 할 수 있게 됩니다.

<br>

# 가상 사용자 설정
## guest_enable=NO
> 가상유저 모드로 운영할 것인지에 대해 설정합니다. (기본값 = NO)
>> 이 옵션을 활성화하면 모든 비익명 사용자는 가상 사용자로 접속이 됩니다.

## guest_username=ftp
> 가상유저들의 실제 계정을 지정합니다. (기본값 = ftp)

## virtual_use_local_privs=NO (기본값 = NO)
> 가상유저들의 권한을 실제 계정의 권한처럼 허용할 것인지를 설정합니다.
>> 이 옵션이 활성화되어있지 않으면 가상유저는 FTP에 접속해서 파일을 생성하지 못합니다. 또한 가상유저는 기본적으로 anonymous의 권한을 갖고 있습니다.

## user_sub_token=$USER (기본값 = none)
> 가상유저들을 지칭할 가상의 변수를 지정합니다.

## local_root=/home/virtual/$USER (기본값 = none)
> 가상유저들이 로그인 후 이동될 디렉토리를 지정합니다.

<br>

# 익명사용자 기본 설정
## anonymous_enable=NO
> 익명(anonymous) 접속을 허용할 것인가(YES) 허용하지 않을 것인가(NO)를 결정하는 지시자입니다. 기본값은 YES로 되어있으며 익명계정 접속을 허용하지 않으려면 NO 로 설정하시기 바랍니다.

## anon_max_rate=0 (기본값 = 0)
> 익명 사용자의 다운로드 최대전송률을 지정합니다. 다운로드 속도를 제한할때 사용하며, 단위는 bps 입니다.

## allow_anon_ssl=NO (기본값 = NO)
> 익명사용자의 SSL을 통한 보안접속을 지원할 것인지에 대해 설정합니다.
>> 이 옵션은 ssl_enable이 활성화 되었을 때만 적용됩니다.

## deny_email_enable=YES (기본값 = NO)
> 로그인 거부 리스트 사용에 대한 설정을 합니다.
>> /etc/vsftpd.banned_emails 에 설정된 주소로 로그인을 거부할 수 있습니다.
>>> 만약 anonymous@ 라고 설정해두면, anonymous@를 사용하는 사용자는 접속할 수 없게됩니다.

## banned_email_file=/etc/vsftpd.banned_emails (기본값 = /etc/vsftpd.banned_emails)
> 로그인 거부 파일을 지정합니다.
>> deny_email_enable 옵션을 활성화했을 경우에 리스트를 읽어올 파일을 지정합니다.

## secure_email_list_enable=NO (기본값 = NO)
> 명시된 이메일 주소로만 접속을 허용할 지 설정합니다.

## email_password_file=/etc/vsftpd.email_passwords (기본값 = /etc/vsftpd.email_passwords)
> 접속을 허용할 이메일 주소 파일을 지정합니다.
>> secure_email_list_enable 옵션을 활성화했을 경우에 리스트를 읽어올 파일을 지정합니다.

## ftp_username=ftp (기본값 = ftp)
> 익명 사용자의 접속에 사용될 계정명을 지정합니다.

## no_anon_password=NO (기본값 = NO)
> 익명 사용자가 접속할 때 패스워드를 묻지않고 접속시킬 것인지 설정합니다.
>> 이 옵션을 활성화하면 접속시 패스워드를 묻지 않습니다.

## one_process_model=NO (기본값 = NO)
> 클라이언트 접속마다 하나의 프로세스가 작동되도록 할 것인지 설정합니다.
>> 이 옵션을 활성화하면 접속하는 수만큼 프로세스가 작동되므로 효율이 좋습니다.

## anon_root=/var/ftp/pub (기본값 = none)
> 익명 사용자의 기본 디렉토리를 지정합니다.
>> 일반적으로 익명 사용자의 접근을 허용하면 ftp_username에 지정된 사용자의 홈 디렉토리가 기본적으로 설정됩니다. 그렇지만 만약 변경할 필요가 있을 경우에 이 옵션을 사용하면 됩니다.

<br>

# 익명사용자 권한 설정
## anon_upload_enable=YES
> 익명(anonymous) 계정 사용자에게 파일 업로드를 허용할 것인가(YES) 허용하지 않을 것인가(NO) 의 여부를 설정하는 지시자입니다. 기본값은 허용하지 않는 NO 입니다. 가능한 익명 계정으로 접속한 사용자에게는 업로드 권한을 허용하지 않는 것이 보안에 훨씬 좋습니다. 따라서 가능한 NO로 설정하시기 바랍니다.

## anon_mkdir_write_enable=YES
> 익명(anonymous) 계정 사용자에게 디렉토리 생성권한을 허용할 것인가(YES) 허용하지 않을 것인가(NO)의 여부를 설정하는 지시자 입니다. 기본값은 허용하지 않는 NO 입니다. 가능한 익명계정으로 접속한 사용자에게는 디렉토리 생성권한을 허용하지 않는 것이 보안에 훨씬 좋습니다. 따라서 가능한 NO로 설정하시기 바랍니다.

## anon_world_readable_only=YES (기본값 = YES)
> 익명 사용자들의 다운로드에 대한 설정을 합니다.
>> 익명 사용자들이 읽기 가능한 파일을 다운로드 할 수 있게 설정합니다.

## anon_other_write_enable=NO (기본값 = NO)
> 익명 사용자의 파일 삭제,변경에 대한 설정을 합니다.
>> 파일 삭제 및 파일명 변경등과 같은 기능을 사용할 수 있게 합니다.

## chown_uploads=YES (기본값 = NO)
> 익명 사용자의 소유권 변경에 대한 설정을 합니다.
>> 익명으로 업로드된 파일을 chown_username 옵션으로 명시된 사용자의 소유권으로 변경되도록 할 수 있습니다.

## anon_umask=022 (기본값 = 077)
> 익명 사용자의 파일생성 umask 값을 지정 합니다.
>> umask에 대한 설명은 local_mask의 설명을 참조하시기 바랍니다.

## chown_username=whoever (기본값 = root)
> 익명 사용자의 소유권 변경이 가능한 계정명을 설정합니다.