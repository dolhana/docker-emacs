FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
        autoconf \
        automake \
        autotools-dev \
        build-essential \
        curl \
        dpkg-dev \
        git \
        gnupg \
        imagemagick \
        ispell \
        libacl1-dev \
        libasound2-dev \
        libcanberra-gtk3-module \
        liblcms2-dev \
        libdbus-1-dev \
        libgif-dev \
        libgnutls28-dev \
        libgpm-dev \
        libgtk-3-dev \
        libjansson-dev \
        libjpeg-dev \
        liblockfile-dev \
        libm17n-dev \
        libmagick++-6.q16-dev \
        libncurses5-dev \
        libotf-dev \
        libpng-dev \
        librsvg2-dev \
        libselinux1-dev \
        libtiff-dev \
        libxaw7-dev \
        libxml2-dev \
        openssh-client \
        python \
        texinfo \
        xaw3dg-dev \
        xz-utils \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

ENV EMACS_BRANCH="emacs-26.3"
ENV EMACS_VERSION="26.3"
ENV EMACS_INSTALL_PREFIX="/opt/emacs"

RUN mkdir -p /tmp/emacs-src && \
    cd /tmp/emacs-src && \
    curl -LO http://ftpmirror.gnu.org/emacs/${EMACS_BRANCH}.tar.xz && \
    tar -x --xz -f ${EMACS_BRANCH}.tar.xz

RUN cd /tmp/emacs-src/${EMACS_BRANCH} && \
    ./autogen.sh && \
    ./configure --prefix=${EMACS_INSTALL_PREFIX} --with-modules && \
    make -j 8 && \
    make install

ENV PATH="${EMACS_INSTALL_PREFIX}/bin:$PATH"

CMD ["emacs"]
