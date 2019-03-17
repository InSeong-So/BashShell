yum install -y wget
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz
tar -zxvf jdk-8u191-linux-x64.tar.gz
echo "JAVA_HOME=~/jdk1.8.0_191" >> ~/.bash_profile
echo "export JAVA_HOME" >> ~/.bash_profile
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bash_profile
source ~/.bash_profile
curl -s get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version
sdk install springboot
spring --version






spring.application.name=SpringBootJdbc
spring.datasource.url=jdbc:mysql://192.168.2.44:3306/sms
spring.datasource.username=root
spring.datasource.password=(Thdlstjd12345!@#$%)
spring.datasource.driver-class-name=com.mysql.jdbc.Driver