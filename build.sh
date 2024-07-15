#!/usr/bin/env bash

DEST="frozen-bubble"

mkdir -p "${DEST}"
mkdir -p "${DEST}/perl/bin/aarch64-linux-gnu"
mkdir -p "${DEST}/perl/lib/aarch64-linux-gnu/perl/5.30.0"
mkdir -p "${DEST}/perl/lib/perl5"
mkdir -p "${DEST}/libs.aarch64"

cp /usr/games/frozen-bubble "${DEST}/"
cp /usr/lib/games/frozen-bubble/fb-server "${DEST}/"
cp -R /usr/share/games/frozen-bubble/* "${DEST}/"

patch "${DEST}/frozen-bubble" -i frozen-bubble.patch

git clone https://github.com/libsdl-org/sdl12-compat.git
cd sdl12-compat
mkdir -p build
cd build
cmake ../
make -j4

cd ../../

for lib in `cat libs.aarch64.txt`;do
    cp "${lib}" "${DEST}/libs.aarch64/"
done

cp /usr/bin/perl "${DEST}/perl/bin/aarch64-linux-gnu/"

rsync -avh /usr/lib/aarch64-linux-gnu/perl5/5.30/* "${DEST}/perl/lib/aarch64-linux-gnu/perl/5.30.0/"
rsync -avh /usr/lib/aarch64-linux-gnu/perl/5.30/* "${DEST}/perl/lib/aarch64-linux-gnu/perl/5.30.0/"
rsync -avh /usr/lib/aarch64-linux-gnu/perl-base/* "${DEST}/perl/lib/aarch64-linux-gnu/perl-base/"
rsync -avh /usr/share/perl5/* "${DEST}/perl/lib/perl5/"
rsync -avh /usr/share/perl/5.30/* "${DEST}/perl/lib/perl5/"

patch "${DEST}/perl/lib/perl5/Games/FrozenBubble/Config.pm" -i Config.pm.patch
patch "${DEST}/perl/lib/perl5/Games/FrozenBubble/Stuff.pm" -i Stuff.pm.patch

mksquashfs "${DEST}/perl" "${DEST}/perl.squashfs"
mksquashfs "${DEST}/gfx" "${DEST}/gfx.squashfs"

rm -rf "${DEST}/perl"
rm -rf "${DEST}/gfx"