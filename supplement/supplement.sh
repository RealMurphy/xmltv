#!/usr/bin/env bash

# simple script to update xmltv supplement servers from upstream's git
# repository
# run manually or preferably via cron

set -e

# HTTP download directory
HTTP_PATH=/var/www/xmltv/

# github upstream
UPSTREAM=https://github.com/XMLTV/xmltv.git

# where to clone to
CLONE_PATH=/var/share/xmltv

# clone/update our repo copy
if [[ -d "$CLONE_PATH" ]]; then
    cd "$CLONE_PATH"
    git pull >/dev/null
else
    cd "$(dirname $CLONE_PATH)"
    git clone "$UPSTREAM" "$(basename $CLONE_PATH)" > /dev/null
fi
cd "$CLONE_PATH"

# copy vital files to HTTP area
# given the overall number of files is low and hardly changing at all,
# simply list them all explicitly

# base files
cp -a xmltv.dtd xmltv-lineups.xsd "$HTTP_PATH/"

# tv_augment
mkdir -p "$HTTP_PATH/tv_augment/"
cp -a filter/augment/augment.rules filter/augment/augment.conf "$HTTP_PATH/tv_augment/"

# tv_grab_eu_epgdata
mkdir -p "$HTTP_PATH/tv_grab_eu_epgdata/"
cp -a grab/eu_epgdata/channel_ids "$HTTP_PATH/tv_grab_eu_epgdata/"

# tv_grab_huro
mkdir -p "$HTTP_PATH/tv_grab_huro/"
cp -a grab/huro/catmap.{cz,hu,sk,ro} "$HTTP_PATH/tv_grab_huro/"
cp -a grab/huro/jobmap "$HTTP_PATH/tv_grab_huro/"

# tv_grab_is
mkdir -p "$HTTP_PATH/tv_grab_is/"
cp -a grab/is/category_map "$HTTP_PATH/tv_grab_is/"

# tv_grab_it
mkdir -p "$HTTP_PATH/tv_grab_it/"
cp -a grab/it/channel_ids "$HTTP_PATH/tv_grab_it/"

# tv_grab_it_dvb
mkdir -p "$HTTP_PATH/tv_grab_it_dvb/"
cp -a grab/it_dvb/{sky_it.dict,sky_it.themes,channel_ids} "$HTTP_PATH/tv_grab_it_dvb/"

# tv_grab_uk_bleb
mkdir -p "$HTTP_PATH/tv_grab_uk_bleb/"
cp -a grab/uk_bleb/icon_urls "$HTTP_PATH/tv_grab_uk_bleb/"

# tv_grab_uk_tvguide
mkdir -p "$HTTP_PATH/tv_grab_uk_tvguide/"
cp -a grab/uk_tvguide/tv_grab_uk_tvguide.map.conf "$HTTP_PATH/tv_grab_uk_tvguide/"

exit 0
