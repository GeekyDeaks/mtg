//
$fn=30;

PART="example";
MANA="bw";

CARDS=60;
CARD_DEPTH=0.7;  // approx for shielded card
DEPTH=CARDS * CARD_DEPTH;

WIDTH=95;
HEIGHT=69;

FONT_SIZE=min(WIDTH, DEPTH)/3;

SLIDER_HEIGHT=2.5;
WALL_WIDTH=2;
WALL_RADIUS=1.5;

REBATE=0.5;

use <mana.ttf>
include <mana-str.scad>

// https://github.com/andrewgioia/mana/blob/master/css/mana.css
mana_map = [
    ["w", "\ue600"], // white
    ["u", "\ue601"], // blue
    ["b", "\ue602"], // black
    ["r", "\ue603"], // red
    ["g", "\ue604"]  // green
];

// OpenSCAD uses to recursion to generate new strings
// so here we keep incrementing through each character in the string
// and concatenating the mapped character as we go along
function to_mana(m, i=0, out="") =
    (i >= len(m)) 
        ? out 
        : to_mana(m, i + 1, str(out, mana_map[search(m[i], mana_map)[0]][1] ));

module slider(offset = 0) {

    translate([WIDTH + WALL_WIDTH + offset, 0, 0])
    rotate([0, -90, 0])
    linear_extrude(WIDTH + WALL_WIDTH + offset)
    polygon([
        [0 - offset, 0 - offset - REBATE],
        [0 - offset, DEPTH + offset + REBATE],
        [SLIDER_HEIGHT + offset, DEPTH + offset],
        [SLIDER_HEIGHT + offset, 0 - offset]
    ]);

}

module enclosure() {
    delta = WALL_WIDTH - WALL_RADIUS;
    difference() {
        translate([-delta, -delta, -delta])
        minkowski() {
            cube(size = [
                    WIDTH + delta * 2, 
                    DEPTH + delta * 2, 
                    HEIGHT + SLIDER_HEIGHT - WALL_WIDTH + delta *2
                ]);
            sphere(r = WALL_RADIUS);
        }
        cube(size = [WIDTH, DEPTH, HEIGHT]);
    }

}

module box() {
    difference() {
        enclosure();
        translate([0, 0, HEIGHT])
        slider(0.2);
    }
}

module lid(mana) {
    // use the enclosure to get the correct
    // external profile
    translate([0, 0, -HEIGHT])
    intersection() {
        enclosure();
        translate([0, 0, HEIGHT])
        // emboss the mana
        difference() {
            slider();
            translate([WIDTH/2, DEPTH/2, SLIDER_HEIGHT - 1])
            linear_extrude(1.1)
            text(to_mana(mana), size=FONT_SIZE, font="Mana", valign="center", halign="center");
        }
    }
}


if(PART=="box") box();
if(PART=="lid") lid(MANA);

if(PART=="example") {
    box();
    translate([0, 0, HEIGHT + 20])
    lid(MANA);
}
