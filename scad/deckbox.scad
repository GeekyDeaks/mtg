//
$fn=30;

PART="example";
MANA="bw";

CARDS=60;
CARD_DEPTH=0.7;  // approx for shielded card
DEPTH=CARDS * CARD_DEPTH;

WIDTH=96;
HEIGHT=69;

FONT_SIZE=min(WIDTH, DEPTH)/3;

SLIDER_HEIGHT=3;
WALL_WIDTH=2.5;
WALL_RADIUS=1.5;

REBATE=.75;

LOCK_DIAMETER=1.7;
LOCK_CYLINDER_DISTANCE=2.5;
TOLERANCE=0.15;

NOTCH_DEPTH = SLIDER_HEIGHT * .7;

use <mana.ttf>

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

module lock_ball(offset=0) {
    // tranlate to just off 
    translate([WIDTH + WALL_WIDTH / 2, 0, HEIGHT + SLIDER_HEIGHT / 2])
    sphere(d=LOCK_DIAMETER + offset);

    translate([WIDTH + WALL_WIDTH / 2, DEPTH, HEIGHT + SLIDER_HEIGHT / 2])
    sphere(d=LOCK_DIAMETER + offset);
}

module lock_cylinder(offset=0) {
    // tranlate to just off 
    translate([LOCK_CYLINDER_DISTANCE, -WALL_WIDTH/2, - TOLERANCE])
    cylinder(d=LOCK_DIAMETER + offset, h=SLIDER_HEIGHT / 2);

    translate([LOCK_CYLINDER_DISTANCE, DEPTH +WALL_WIDTH/2, - TOLERANCE])
    cylinder(d=LOCK_DIAMETER + offset, h=SLIDER_HEIGHT / 2);
}

module box() {
    difference() {
        enclosure();
        translate([0, 0, HEIGHT])
        slider(TOLERANCE);
        // little dimple to help locking
        //lock_ball(TOLERANCE);
    }
    translate([0, 0, HEIGHT])
    lock_cylinder();
    
}

module grab_notch() {
    // little notch to help open the lid
    width = DEPTH / 2;
    length = width * .5;
    radius = WALL_RADIUS;

    translate([-length/2, -width/2])
    difference() {
        linear_extrude(NOTCH_DEPTH)
        translate([radius, radius])
        minkowski() {
            square( [length - 2 * radius, width - 2 * radius] );
            circle( radius );
        };

        translate([-0.001, width, -0.001])
        rotate([90, 0, 0])
        linear_extrude(width)
        polygon([[0,0], [length, 0], [0, NOTCH_DEPTH]    ]);
    }

}

module lid(mana) {
    // use the enclosure to get the correct
    // external profile

    notch = WIDTH * 0.9;

    translate([0, 0, -HEIGHT]) {
        intersection() {
            enclosure();
            translate([0, 0, HEIGHT + 0.001])
            // emboss the mana
            difference() {
                slider();

                translate([notch/2, DEPTH/2, SLIDER_HEIGHT - 1])
                linear_extrude(1.1)
                text(to_mana(mana), size=FONT_SIZE, font="Mana", valign="center", halign="center");

                lock_cylinder(TOLERANCE);
                // put a little notch in to help open
                translate([notch, DEPTH/2, SLIDER_HEIGHT - NOTCH_DEPTH])
                grab_notch();
            }
        }
        //lock_ball();
    }

}

if(PART=="box") box();
if(PART=="lid") lid(MANA);

if(PART=="example") {
    box();
    translate([0, 0, HEIGHT + 20])
    lid(MANA);
}
