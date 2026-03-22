FROM archlinux:latest

RUN pacman -Syy --needed --noconfirm base-devel pkgconf libtool wget zstd

WORKDIR /build
ENV VERSION=6.6

RUN wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-$VERSION.tar.gz
RUN tar xvf ncurses-$VERSION.tar.gz

WORKDIR /build/ncurses-$VERSION
RUN ./configure --with-shared --without-debug --without-ada --enable-widec=no --prefix=/usr
RUN make -j$(nproc)
RUN make DESTDIR=/package install
RUN echo "version $VERSION" > /package/car
RUN tar -I zstd -C /package -cf /package.tar.zst .
