FROM archlinux:latest

RUN pacman -Syy --needed --noconfirm base-devel wget zstd

WORKDIR /build
ENV VERSION=1.9

RUN wget --no-check-certificate https://libndp.org/files/libndp-$VERSION.tar.gz
RUN tar -xzf libndp-$VERSION.tar.gz

WORKDIR /build/libndp-$VERSION
RUN ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-static
RUN make -j$(nproc)
RUN make DESTDIR=/package install

RUN echo "version $VERSION" > /package/car
RUN tar -I zstd -C /package -cf /package.tar.zst .
