base_depth = 40;
base_width = 80;
pyramid_height = 100;
backside_distance = 200;
angle_spread = 20;

union() {

    color("pink", 0.8) {
        linear_extrude(height = pyramid_height, scale = 0) {
            polygon(points = [
                [base_depth, 0],
                [-base_depth, 0],
                [0, base_width]
            ]);
        }
    }

    union() {
        translate([0, -1, 35]) rotate([0, -80, 0]) {
            color("blue", 0.5) {
                translate([0, 0, -backside_distance]) {
                    cube([300, 100, 2 * backside_distance]);
                    translate([-10, 5, -5]) {
                        // ridge
                        cube([200, 5, 2 * backside_distance + 10]);
                    }
                }
            }
            color("purple", 0.5) {
                translate([-10, 8, 0]) {
                    rotate([0, 45 - angle_spread, 0]) {
                        cube([100, 200, 100]);
                    }
                    rotate([0, 45 + angle_spread, 0]) {
                        cube([100, 200, 100]);
                    }
                }
            }
        }
    }

}
