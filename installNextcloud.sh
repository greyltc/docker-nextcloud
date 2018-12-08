#!/usr/bin/env bash
set -e -u -o pipefail

# remove info.php (prevents server info leak)
rm /srv/http/info.php

# to mount SMB shares: 
pacman -S --noconfirm --noprogress --needed smbclient

# for video file previews
pacman -S --noconfirm --noprogress --needed ffmpeg

# for document previews
pacman -S --noconfirm --noprogress --needed libreoffice-fresh

# for ssh mounts
pacman -S --noconfirm --noprogress --needed openssh

# for image previews
pacman -S --noconfirm --noprogress --needed imagemagick ghostscript openexr openexr openexr libxml2 librsvg libpng libwebp

# not 100% sure what needs this:
pacman -S --noconfirm --noprogress --needed gamin

# nextcloud itself
pacman -S --noconfirm --noprogress --needed nextcloud nextcloud-app-bookmarks nextcloud-app-calendar nextcloud-app-contacts nextcloud-app-mail nextcloud-app-notes nextcloud-app-spreed nextcloud-app-tasks

# setup Apache for nextcloud
cp /etc/webapps/nextcloud/apache.example.conf /etc/httpd/conf/extra/nextcloud.conf
sed -i 's,Alias /nextcloud "/usr/share/webapps/nextcloud",Alias /${TARGET_SUBDIR} "/usr/share/webapps/nextcloud",g' /etc/httpd/conf/extra/nextcloud.conf
sed -i '$a Include conf/extra/nextcloud.conf' /etc/httpd/conf/httpd.conf

# reduce docker layer size
cleanup-image
