#!/bin/sh

openscad -D CARDS=60 -D PART=\"box\" -o stl/box.stl scad/deckbox.scad
