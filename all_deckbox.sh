#!/bin/sh

#
# export the box and all combinations of the mana lids

CARDS=60

openscad -D CARDS=${CARDS} -D PART=\"box\" -o stl/box.stl scad/deckbox.scad

for MANA in "w" "u" "b" "r" "g" "wu" "wb" "wr" "wg" "ub" "ur" "ug" "br" "bg" "rg";
do
    openscad -D CARDS=${CARDS} -D PART=\"lid\" -D MANA=\"${MANA}\" -o stl/lid_${MANA}.stl scad/deckbox.scad
done