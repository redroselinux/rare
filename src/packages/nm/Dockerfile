FROM archlinux:latest

RUN pacman -Syy --needed --noconfirm base-devel wget zstd meson ninja pkgconf glib2 glib2-devel perl-xml-parser libxslt python-gobject jansson libndp libpsl curl libnl nss libnewt

WORKDIR /build
ENV VERSION=1.46.0

RUN wget https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/archive/$VERSION/NetworkManager-$VERSION.tar.gz
RUN tar -xzf NetworkManager-$VERSION.tar.gz

WORKDIR /build/NetworkManager-$VERSION

RUN meson setup build \
    --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    -Dsystemdsystemunitdir=no \
    -Dsystemd_journal=false \
    -Dlibaudit=no \
    -Dselinux=false \
    -Dppp=false \
    -Dmodem_manager=false \
    -Dnmtui=true \
    -Dqt=false \
    -Dsession_tracking=no \
    -Dsuspend_resume=upower \
    -Dpolkit=false \
    -Dtests=no \
    -Ddocs=false \
    -Dintrospection=false \
    -Dudev_dir=/usr/lib/udev

RUN ninja -C build
RUN DESTDIR=/package ninja -C build install

RUN echo "version $VERSION" > /package/car
RUN tar -I zstd -C /package -cf /package.tar.zst .
