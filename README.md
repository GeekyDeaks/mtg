# Magic: The Gathering models

Various models for Magic: The Gathering

# Deckbox

Barebones [deckbox](stl/box.stl) , with adjustable cardcount.  Simply alter the `CARDS` variable as required

    openscad -D CARDS=60 -D PART=\"box\" -o box.stl deckbox.scad

You can print the [lids](stl/lid_wb.stl) with various mana symbols:

    openscad -D CARDS=60 -D PART=\"lid\" -D MANA=\"wb\" -o lid_bw.stl deckbox.scad

Simple update the `MANA` string with the required symbols from the table below:

| code | mana  |
|------|-------|
| w    | white |
| u    | blue  |
| b    | black |
| r    | red   |
| g    | green |


# Acknowledgements

https://github.com/andrewgioia/mana