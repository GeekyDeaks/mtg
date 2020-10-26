# Magic: The Gathering models

Various models for Magic: The Gathering

# Deckbox

Barebones [deckbox](scad/box.stl) , with adjustable cardcount.  Simply alter the `CARDS` variable as required

    openscad -D CARDS=60 -D PART=\"box\" -o box.stl deckbox.scad

You can print the [lids](scad/lid_bw.stl) with various mana symbols:

    openscad -D CARDS=60 -D PART=\"lid\" -D MANA=\"bw\" -o lid_bw.stl deckbox.scad

Simple update the `MANA` string with the required symbols from the table below:

| code | mana  |
|------|-------|
| w    | white |
| u    | blue  |
| b    | black |
| r    | red   |
| g    | green |
