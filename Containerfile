# Build Glass effect: https://github.com/4v3ngR/kwin-effects-glass
FROM fedora:latest AS build-glass
RUN dnf5 -y install git cmake extra-cmake-modules gcc-g++ \
                    kf6-kwindowsystem-devel plasma-workspace-devel \
                    libplasma-devel qt6-qtbase-private-devel qt6-qtbase-devel \
                    cmake kwin-devel extra-cmake-modules kwin-devel \
                    kf6-knotifications-devel kf6-kio-devel kf6-kcrash-devel \
                    kf6-ki18n-devel kf6-kguiaddons-devel libepoxy-devel \
                    kf6-kglobalaccel-devel kf6-kcmutils-devel \
                    kf6-kconfigwidgets-devel kf6-kdeclarative-devel \
                    kdecoration-devel kf6-kglobalaccel kf6-kdeclarative \
                    libplasma kf6-kio qt6-qtbase kf6-kguiaddons kf6-ki18n \
                    wayland-devel libdrm-devel \
                    rpm-build

WORKDIR /glass

RUN git clone https://github.com/4v3ngR/kwin-effects-glass \
    && cd kwin-effects-glass \
    && mkdir build \
    && cd build \
    && cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
    && make -j$(nproc) \
    && cpack -V -G RPM


# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Copy Glass effect from build-glass stage
COPY --from=build-glass /glass/kwin-effects-glass/build/kwin-glass.rpm /kwin-glass.rpm

# Base Image
FROM ghcr.io/ublue-os/bazzite:stable

## Other possible base images include:
# FROM ghcr.io/ublue-os/bazzite:latest
# FROM ghcr.io/ublue-os/bluefin-nvidia:stable
# 
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

COPY just_files/ /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    echo "import \"/usr/share/ublue-os/just/00-install-personal-defaults.just\"" >> /usr/share/ublue-os/justfile && \
    /ctx/build.sh
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
