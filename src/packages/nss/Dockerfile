FROM archlinux:latest

RUN pacman -Syy --needed --noconfirm base-devel pkgconf wget zstd python python-pip nspr perl ninja sqlite

RUN pip install --break-system-packages gyp-next

WORKDIR /build
ENV VERSION=3.109

# compiler wrapper to strip -Werror without touching source
RUN echo '#!/bin/bash' > /usr/local/bin/cc-wrapper && \
    echo 'args=("$@")' >> /usr/local/bin/cc-wrapper && \
    echo 'new_args=()' >> /usr/local/bin/cc-wrapper && \
    echo 'for arg in "${args[@]}"; do [[ $arg != "-Werror" ]] && new_args+=("$arg"); done' >> /usr/local/bin/cc-wrapper && \
    echo 'exec /usr/bin/cc "${new_args[@]}"' >> /usr/local/bin/cc-wrapper && \
    chmod +x /usr/local/bin/cc-wrapper

ENV CC=/usr/local/bin/cc-wrapper

RUN wget https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_109_RTM/src/nss-$VERSION.tar.gz
RUN tar -xzf nss-$VERSION.tar.gz

WORKDIR /build/nss-$VERSION/nss

RUN ./build.sh -j $(nproc) --opt --system-nspr --system-sqlite --disable-tests

RUN mkdir -p /package/usr/lib /package/usr/include/nss /package/usr/bin
RUN cp -L ../dist/Release/lib/*.so /package/usr/lib/
RUN cp -L ../dist/Release/bin/* /package/usr/bin/
RUN cp -rL ../dist/public/nss/* /package/usr/include/nss/

RUN echo "version $VERSION" > /package/car
RUN tar -I zstd -C /package -cf /package.tar.zst .
