FROM docker:18.03-git

MAINTAINER Yoshiaki Sugimoto <sugimoto@wnotes.net>

RUN apk add --update alpine-sdk readline readline-dev python3

RUN python3 -m ensurepip && \
  pip3 install --upgrade pip setuptools

ENV LUA_VERSION 5.3.4
ENV LUAROCKS_VERSION 2.4.4

RUN curl -L http://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz | tar xzf - && \
  cd /lua-${LUA_VERSION} && \
  make linux test && \
  make install && \
  cd .. && rm -rf /lua-${LUA_VERSION}

RUN curl -L https://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz | tar xzf - && \
  cd /luarocks-${LUAROCKS_VERSION} && \
  ./configure && \
  make build && \
  make install

RUN ln -s /usr/bin/python3 /usr/bin/python && \
  rm /usr/bin/pip && \
  ln -s /usr/bin/pip3 /usr/bin/pip

CMD ["sh"]
