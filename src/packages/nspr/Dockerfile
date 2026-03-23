FROM archlinux:latest

RUN pacman -Syy --needed --noconfirm base-devel pkgconf wget zstd

WORKDIR /build
ENV VERSION=4.36

RUN wget https://ftp.mozilla.org/pub/nspr/releases/v$VERSION/src/nspr-$VERSION.tar.gz
RUN tar -xzf nspr-$VERSION.tar.gz

WORKDIR /build/nspr-$VERSION/nspr

RUN ./configure \
    --prefix=/usr \
    --libdir=/usr/lib \
    --includedir=/usr/include/nspr \
    --enable-64bit \
    --disable-debug \
    --enable-optimize

RUN make -j$(nproc)
RUN make DESTDIR=/package install

RUN echo "version $VERSION" > /package/car
RUN tar -I zstd -C /package -cf /package.tar.zst .
