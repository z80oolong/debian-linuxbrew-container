## Author: Z.OOL. (NAKATSUKA, Yukitaka) <zool@zool.jpn.org>
## Date:

FROM debian:jessie
MAINTAINER Z.OOL. (NAKATSUKA, Yukitaka) <zool@zool.jpn.org>

## setup Debian Jessie environment.

ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV DEBIAN_FRONTEND=noninterractive

RUN /usr/bin/env LANG=C apt-get update && /usr/bin/env LANG=C apt-get upgrade -y --no-install-recommends

RUN apt-get install -y --no-install-recommends apt-utils locales \
    && echo "en_US.UTF-8 UTF-8" >  /etc/locale.gen \
    && echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen \
    && /usr/sbin/locale-gen \
    && update-locale LANG=ja_JP.UTF-8

## install package required by Linuxbrew.

RUN apt-get install -y --no-install-recommends build-essential coreutils curl wget file git sudo ca-certificates

## clean /var/cache/apt/archives/* and /var/lib/apt/lists/*

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

## create user "linuxbrew".

RUN localedef -i en_US -f UTF-8 en_US.UTF-8 && useradd -m -s /bin/bash linuxbrew \
    && echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

## install Linuxbrew environment.

USER linuxbrew
WORKDIR /home/linuxbrew

RUN echo "" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

ENV SHELL=/bin/bash
ENV USER=linuxbrew

ENV HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
ENV HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
ENV HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew"
ENV PATH="$HOMEBREW_PREFIX/sbin:$HOMEBREW_PREFIX/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV MANPATH="$HOMEBREW_PREFIX/share/man"
ENV INFOPATH="$HOMEBREW_PREFIX/share/info"

ENV HOMEBREW_NO_ANALYTICS=1
ENV HOMEBREW_NO_AUTO_UPDATE=1
ENV HOMEBREW_MAKE_JOBS=6

## install autoconf, automake, libtool, etc.

RUN brew install patchelf m4 gdbm libbsd berkeley-db expat
RUN brew install -s perl
RUN brew install autoconf automake libtool pkg-config bison
RUN brew install bzip2 unzip gpatch xz

## install linuxdeploy

RUN  mkdir -p /home/linuxbrew/opt
COPY ./linuxdeploy.rb /home/linuxbrew/opt/
RUN  brew install /home/linuxbrew/opt/linuxdeploy.rb --with-extract

## default shell script.

CMD /bin/bash
