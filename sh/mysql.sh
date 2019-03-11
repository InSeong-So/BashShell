yum -y install wget
wget https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
rpm -ivh mysql80-community-release-el7-1.noarch.rpm 
yum install -y mysql-server
systemctl start mysqld
systemctl enable mysqld




vi /var/log/mysqld.log 
mysql_secure_installation
yes
vi /var/log/mysqld.log 
   14  mysql_secure_installation
   15  mysql -u root -p mysqlEnter password:
   16  mysql -u root -p
   17  mysql -uroot -p
   18  sudo service mysql restart
   19  systemctl restart mysql
   20  mysql -uroot -p
   21  systemctl status firewalld
   22  firewall-cmd --zons=public --add-port=3306/tcp -permanent
   23  firewall-cmd --zone=public --add-port=3306/tcp -permanent
   24  firewall-cmd --zone=public --add-port=3306/tcp --permanent
   25  firewall-cmd --reload
   26  systemctl restart firewalld
   27  mysql -uroot -p
   28  ifconfig
   29  uname -an
   30  ls
   31  cd /etc/sysconfig/
   32  l
   33  ls
   34  cd network-scripts/
   35  ls
   36  mv  ifcfg-enp0s3.bak ../
   37  vi ifcfg-enp0s3 
   38  ifconfig
   39  netstat -tupln
   40  ls
   41  whoami
   42  cd /root/
   43  ls
   44  yum list mysql
   45  ll
   46  rpm -ivh mysql80-community-release-el7-1.noarch.rpm 
   47  yum list mysql
   48  yum list mysql*
   50  rpm -qa | grep mysql*
   51  rpm -qa | grep *sql*
   52  rpm -qa 
   53  rpm -qa | grep mysql*
   54  rpm -qa | grep mysql-*
   55  yum list mysql-*
   56  mysql -uroot -p
   57  systemctl restart mysqld
   58  mysql -uroot -p
   59  vi /etc/sysconfig/network-scripts/ifcfg-enp0s3 
   60  systemctl restart network
   61  cat /etc/sysconfig/network-scripts/ifcfg-enp0s3 
   62  firewall-cmd --zones
   63  firewall-cmd --zone=public --add-port=3306/tcp -permanent
   64  firewall-cmd --zone=public --add-port=3306/tcp --permanent
   65  systemctl enable mysqld
   66  systemctl restart mysqld
   67  systemctl status mysqld
   68  mysql -uroot -p
   69  ifconfig
   70  mysql -uroot -p
   71  init 6
   72  ip addr
   73  mysql -uroot -p
   74  init 0
   75  mkdir /data/
   76  rsync -av /var/lib/mysql /data/
   77  chown -R mysql:mysql /data/mysql
   78  vi /etc/my.cnf
   79  systemctl stop mysqld
   80  vi /etc/my.cnf
   81  yum install -y policycoreutils-python
   82  semanage fcontext -a -t mysqld_db_t "/data/mysql(/.*)?"
   83  restorecon -R /data/mysql
   84  systemctl start mysql
   85  systemctl start mysqld
   86  systemctl status mysqld
   87  mysql -uroot -p
   88  init 0
   89  yum install -y wget
   90  wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz
   91  tar -zxvf http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz
   92  tar -zxvf jdk-8u191-linux-x64.tar.gz 
   93  echo "JAVA_HOME=~/jdk1.8.0_191" >> ~/.bash_profile
   94  echo "export JAVA_HOME" >> ~/.bash_profile
   95  echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bash_profile
   96  source ~/.bash_profile
   97  java -version
   98  curl -s get.sdkman.io | bash
   99  source "$HOME/.sdkman/bin/sdkman-init.sh"
  100  sdk version
  101  sdk install springboot
  102  spring --version
  103  ls -l
  104  spring run *.java
  105  spring run *.groovy
  106  vi ~/.bash_p
  107  vi ~/.bash_profile 
  108  sdk install springboot dev /path/to/spring-boot/spring-boot-cli/target/spring-boot-cli-2.0.6.RELEASE-bin/spring-2.0.6.RELEASE/
  109  dev /path/to/spring-boot/spring-boot-cli/target/spring-boot-cli-2.0.6.RELEASE-bin/spring-2.0.6.RELEASE/
  110  springboot dev /path/to/spring-boot/spring-boot-cli/target/spring-boot-cli-2.0.6.RELEASE-bin/spring-2.0.6.RELEASE/
  111  sdk uninstall springboot CLI v2.0.6.RELEASE
  112  sdk uninstall springboot v2.0.6.RELEASE
  113  sdk list
  114  sdk ls springboot
  115  sdk uninstall springboot 2.0.6.RELEASE
  116  sdk install springboot dev /path/to/spring-boot/spring-boot-cli/target/spring-boot-cli-2.0.6.RELEASE-bin/spring-2.0.6.RELEASE/
  117  sdk install springboot
  118  spring --version
  119  sdk default springboot dev
  120  spring --version
  121  vi ~/.bash_profile 
  122  ls -al
  123  spring run *.java
  124  spring run
  125  spring init --build gradle myapp
  126  cd ~
  127  ls -l
  128  cd my
  129  cd myapp/
  130  ls -l
  131  cd ~
  132  spring init -dweb, data-jpa, h2, thymeleaf --build maven myapp --force
  133  cd myapp/
  134  spring init -dweb, data-jpa, h2, thymeleaf --build maven myapp --force
  135  cd ~
  136  ruby `e
  137  ruby -e 
  138  `
  139  wget http://mirror.navercorp.com/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
  140  tar -zxvf apache-maven-3.5.4-bin.tar.gz 
  141        echo "MAVEN_HOME=~/apache-maven-3.5.4" >> ~/.bash_profile
  142        echo "export MAVEN_HOM" >> ~/.bash_profile
  143        echo "export PATH=\$PATH:\$MAVEN_HOME/bin" >> ~/.bash_profile      
  144        source ~/.bash_profile
  145  mvn -version
  146  init 0
  147  history
  148  history > out.txt




















































yum install -y policycoreutils-python

SELinux, semanage
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M
#
# Remove leading # to revert to previous value for default_authentication_plugin,
# this will increase compatibility with older clients. For background, see:
# https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin
# default-authentication-plugin=mysql_native_password

datadir=/data/mysql
socket=/data/mysql/mysql.sock

[client]
socket=/data/mysql/mysql.sock

log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid