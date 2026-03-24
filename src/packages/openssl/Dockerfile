FROM archlinux:latest

RUN pacman -Syy --needed --noconfirm base-devel wget zstd

WORKDIR /build
ENV VERSION=3.3.0

RUN wget https://github.com/openssl/openssl/releases/download/openssl-$VERSION/openssl-$VERSION.tar.gz
RUN tar -xzf openssl-$VERSION.tar.gz

WORKDIR /build/openssl-$VERSION

RUN ./config \
    --prefix=/usr \
    --openssldir=/etc/ssl \
    --libdir=lib \
    shared \
    zlib-dynamic

RUN make -j$(nproc)
RUN make DESTDIR=/package install_sw

RUN echo "version $VERSION" > /package/car
RUN tar -I zstd -C /package -cf /package.tar.zst .
