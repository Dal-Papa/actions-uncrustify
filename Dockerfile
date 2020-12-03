FROM debian:stretch AS base

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    colordiff \
    curl \
    git \
    python3

FROM base
ARG VERSION=0.72.0

COPY entrypoint.sh /entrypoint.sh
COPY default.cfg /default.cfg
RUN chmod +x entrypoint.sh

RUN curl -L -o uncrustify-$VERSION.tar.gz https://github.com/uncrustify/uncrustify/archive/uncrustify-$VERSION.tar.gz
RUN tar -xzf uncrustify-$VERSION.tar.gz
WORKDIR /uncrustify-uncrustify-$VERSION
RUN mkdir build
WORKDIR /uncrustify-uncrustify-$VERSION/build
RUN cmake ..
RUN cmake --build .
RUN cp uncrustify /usr/local/bin && chmod +x /usr/local/bin/uncrustify

ENTRYPOINT ["/entrypoint.sh"]
