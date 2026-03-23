FROM archlinux:latest

RUN pacman -Syy --needed --noconfirm base-devel wget zstd

WORKDIR /build
ENV VERSION=3.4.6

RUN wget https://github.com/libffi/libffi/releases/download/v$VERSION/libffi-$VERSION.tar.gz
RUN tar -xzf libffi-$VERSION.tar.gz

WORKDIR /build/libffi-$VERSION
RUN ./configure --prefix=/usr --disable-static
RUN make -j$(nproc)
RUN make DESTDIR=/package install
RUN echo "version $VERSION" > /package/car
RUN tar -I zstd -C /package -cf /package.tar.zst .
