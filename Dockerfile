## Author: Z.OOL. (NAKATSUKA, Yukitaka) <zool@zool.jpn.org>
## Date:

#FROM debian:jessie
#FROM debian:sid
FROM debian:stretch

MAINTAINER Z.OOL. (NAKATSUKA, Yukitaka) <zool@zool.jpn.org>

## setup Debian Jessie environment.

ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
    DEBIAN_FRONTEND=noninterractive

RUN /usr/bin/env LANG=C apt-get update && /usr/bin/env LANG=C apt-get upgrade -y --no-install-recommends

RUN apt-get install -y --no-install-recommends apt-utils locales \
    && echo "en_US.UTF-8 UTF-8" >  /etc/locale.gen \
    && echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen \
    && /usr/sbin/locale-gen \
    && update-locale LANG=ja_JP.UTF-8 \
    && apt-get clean

## install package required by Linuxbrew.

RUN apt-get install -y --no-install-recommends build-essential coreutils curl wget file git sudo ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

## create user "linuxbrew".

RUN localedef -i en_US -f UTF-8 en_US.UTF-8 && useradd -m -s /bin/bash linuxbrew \
    && echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

## install Linuxbrew environment.

ENV SHELL="/bin/bash" USER="linuxbrew" HOME="/home/linuxbrew"

USER $USER
WORKDIR $HOME

RUN echo "" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" \
    && rm -rf $HOME/.cache/Homebrew/* $HOME/.linuxbrew/tmp/*

ENV HOMEBREW_PREFIX="$HOME/.linuxbrew" HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar" HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew"
ENV PATH="$HOMEBREW_PREFIX/sbin:$HOMEBREW_PREFIX/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV MANPATH="$HOMEBREW_PREFIX/share/man" INFOPATH="$HOMEBREW_PREFIX/share/info"
ENV HOMEBREW_NO_ANALYTICS=1 HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_MAKE_JOBS=6

## install autoconf, automake, libtool, etc.

RUN brew install patchelf m4 gdbm libbsd openssl@1.1 berkeley-db expat perl autoconf automake libtool pkg-config bison \
                 bzip2 unzip gpatch xz gnu-sed \
    && rm -rf $HOME/.cache/Homebrew/* $HOME/.linuxbrew/tmp/*

## install linuxdeploy

RUN mkdir -p $HOME/opt

COPY ./linuxdeploy.rb $HOME/opt/

RUN brew install $HOME/opt/linuxdeploy.rb --with-extract \
    && rm -rf $HOME/.cache/Homebrew/* $HOME/.linuxbrew/tmp/*


## default shell script.

CMD /bin/bash
