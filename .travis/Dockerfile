FROM debian:stretch

RUN apt-get update -qq \
    && apt-get install --no-install-recommends -y \
      build-essential pkg-config libtool autoconf automake autopoint \
      gettext lcov \
      zlib1g-dev libbz2-dev liblzma-dev libselinux1-dev libncursesw5-dev \
      libio-string-perl libdevel-cover-perl \
      cpanminus libio-socket-ssl-perl libmodule-install-perl \
    && cpanm --notest --skip-satisfied \
      Devel::Cover::Report::Codecov

RUN mkdir /build
WORKDIR /build
