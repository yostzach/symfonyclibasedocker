FROM phusion/baseimage
ENV HOME /root
ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
#Install Deps
RUN [ "add-apt-repository", "ppa:saiarcot895/myppa"]
RUN [ "apt-get", "update", "-y" ]
RUN apt-get -y upgrade
RUN [ "apt-get", "-y", "install", "apt-fast"]
RUN apt-get -y remove python*
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN [ "apt-fast", "install", "-y", "wget", "unzip","python-pip-whl", "python-setuptools-whl", "python-six-whl", "python-urllib3-whl", "patch", "pkg-config", "build-essential", "libicu-dev", "software-properties-common", "make", "git", "curl", "php5", "libapache2-mod-php5", "php5-mcrypt", "libpcre3-dev", "php5-mysql", "php5-cli", "php5-gd", "php5-intl", "python", "python-dev", "python-distribute", "python-pip", "cron", "php-pear", "php5-dev", "ssh", "nginx", "libio-socket-ssl-perl", "libnet-ssleay-perl", "sendemail", "php5-curl", "lynx-cur", "php5-json" ]
RUN sudo pecl install channel://pecl.php.net/ZendOpcache-7.0.3
RUN echo "zend_extension=opcache.so" >> /etc/php5/cli/php.ini
#RUN apt-add-repository ppa:ondrej/php5 -y
#RUN apt-get update -y
RUN [ "pip", "install", "pymongo" ]
RUN easy_install supervisor
RUN sudo apt-get install gcc libicu-dev php5 php5-dev php-pear build-essential --no-install-recommends
RUN pecl install intl
RUN sudo apt-get install subversion -y
# Install MP4Box https://github.com/linkthrow/docker-mp4-box/blob/master/Dockerfile
RUN sudo apt-get install zlib1g-dev -y
RUN svn co https://svn.code.sf.net/p/gpac/code/trunk/gpac gpac --trust-server-cert --non-interactive
RUN /gpac/configure
RUN make
RUN make install
RUN cp bin/gcc/libgpac.so /usr/lib
RUN wget https://s3.amazonaws.com/zach-test12346/ccextractor.zip
RUN unzip ccextractor.zip
RUN (cd /root/linux && ./build)
RUN cp /linux/ccextractor /usr/lib/ccextractor

#Mongo
RUN pecl install mongo-1.5.7
#NEED TO DO
#configuration option "php_ini" is not set to php.ini location
#You should add "extension=mongo.so" to php.ini
RUN echo "extension=mongo.so" >> /etc/php.ini
RUN echo "extension=mongo.so" >> /etc/php5/cli/php.ini
#RUN echo "extension=intl.so" >> /etc/php5/cli/php.ini
