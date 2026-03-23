FROM archlinux:latest

RUN pacman -Syy --needed --noconfirm base-devel wget zstd

WORKDIR /build
ENV VERSION=1.3.1

RUN wget https://github.com/madler/zlib/releases/download/v$VERSION/zlib-$VERSION.tar.gz
RUN tar -xzf zlib-$VERSION.tar.gz

WORKDIR /build/zlib-$VERSION

RUN ./configure --prefix=/usr
RUN make -j$(nproc)
RUN make DESTDIR=/package install

RUN echo "version $VERSION" > /package/car
RUN tar -I zstd -C /package -cf /package.tar.zst .
