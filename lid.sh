#!/bin/sh

#!/bin/sh

if [ -z "${1}" ]; then
    echo "no mana defined"
    exit
fi

openscad -D CARDS=60 -D PART=\"lid\" -D MANA=\"${1}\" -o stl/lid_${1}.stl scad/deckbox.scad
