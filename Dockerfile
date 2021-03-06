FROM centos:7

RUN yum install -y http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

RUN yum install -y postgresql-devel \
      nodejs \
      make \
      gcc \
      gcc-c++ \
      sqlite-devel \
      openssl-devel \
      zlib-devel \
      patch \
      readline-devel && \
    yum clean all && \
    yum -y autoremove

RUN npm install yarn -g

RUN curl https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.0.tar.gz -o /usr/local/src/ruby.tar.gz

RUN tar -xvf /usr/local/src/ruby.tar.gz -C /usr/local/src/

WORKDIR /usr/local/src/ruby-2.6.0

RUN ./configure --disable-install-rdoc

RUN make

RUN make install

RUN gem install bundler

ARG INSTALL_PATH=/app/

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock $INSTALL_PATH

RUN bundle install

CMD ./start_rails.sh
