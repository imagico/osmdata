#!/bin/bash
#
#  icesheet/update.sh
#

DATADIR=/home/robot/data/icesheet
PLANETDIR=/mnt/data/planet

iso_date='+%Y-%m-%dT%H:%M:%S'

export BIN="$( cd "$(dirname "$0")" ; pwd -P )"

set -e
set -x

mkdir -p $DATADIR

# these are used by icesheet_proc.sh
export OSM_SOURCE=${PLANETDIR}/planet.osm.pbf
export SRID=3857

echo "Started icesheet/update.sh"
date $iso_date

rm -f $DATADIR/antarctica_coastlines*
rm -rf $DATADIR/osm_noice*

rm -rf "$DATADIR/antarctica-icesheet-outlines-3857"
mkdir "$DATADIR/antarctica-icesheet-outlines-3857"
rm -rf "$DATADIR/antarctica-icesheet-polygons-3857"
mkdir "$DATADIR/antarctica-icesheet-polygons-3857"

cd $DATADIR

$BIN/icesheet_proc.sh

date $iso_date

echo "Calling update-icesheet-zip.sh..."

$BIN/update-icesheet-zip.sh

df -h

date $iso_date

echo "Done."

