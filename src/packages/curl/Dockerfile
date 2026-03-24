FROM archlinux:latest

RUN pacman -Syy --needed --noconfirm base-devel wget zstd openssl

WORKDIR /build
ENV VERSION=8.7.1

RUN wget https://curl.se/download/curl-$VERSION.tar.xz
RUN tar -xJf curl-$VERSION.tar.xz

WORKDIR /build/curl-$VERSION

RUN ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --with-openssl \
    --enable-ipv6 \
    --enable-threaded-resolver \
    --disable-static

RUN make -j$(nproc)
RUN make DESTDIR=/package install

RUN echo "version $VERSION" > /package/car
RUN tar -I zstd -C /package -cf /package.tar.zst .
