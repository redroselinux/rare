FROM archlinux:latest
RUN pacman -Syy --needed --noconfirm base-devel wget zstd
WORKDIR /build
ENV VERSION=2.3.3
RUN wget https://www.jedsoft.org/releases/slang/slang-$VERSION.tar.bz2
RUN tar -xjf slang-$VERSION.tar.bz2
WORKDIR /build/slang-$VERSION
RUN ./configure --prefix=/usr --sysconfdir=/etc
RUN make -j$(nproc)
RUN make DESTDIR=/package install

RUN mkdir -p /rootfs/filesystem
RUN mv /package/* /rootfs/filesystem/
RUN rm -rf /rootfs/filesystem/usr/include /rootfs/filesystem/usr/share/doc
RUN echo "version $VERSION" > /rootfs/car
RUN tar -I zstd -C /rootfs -cf /package.tar.zst .
