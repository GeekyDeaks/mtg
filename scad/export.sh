#!/bin/sh

openscad -D CARDS=60 -D PART=\"box\" -o box.stl deckbox.scad
openscad -D CARDS=60 -D PART=\"lid\" -D MANA=\"b\" -o lid_b.stl deckbox.scad
openscad -D CARDS=60 -D PART=\"lid\" -D MANA=\"bw\" -o lid_bw.stl deckbox.scad