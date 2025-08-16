base_depth_back = 80;
base_depth_front = 40;
base_width = 80;
pyramid_height = 100;
backside_distance = 160;
angle_spread_front = 30;
angle_spread_back = 10;

difference() {

    color("pink", 0.8) {
        linear_extrude(height = pyramid_height, scale = 0) {
            polygon(points = [
                [base_depth_back, 0],
                [-base_depth_front, 0],
                [0, base_width]
            ]);
        }
    }

    union() {
        translate([0, -1, 45]) rotate([0, -75, 0]) {
            color("blue", 0.5) {
                translate([0, 0, -backside_distance]) {
                    translate([10, 0, 0]) {
                        cube([300, 100, 2 * backside_distance]);
                    }
                    translate([-10, 5, -5]) {
                        // ridge
                        cube([200, 3.5, 2 * backside_distance + 10]);
                    }
                }
            }
            color("purple", 0.5) {
                translate([-10, 8, 0]) {
                    rotate([0, 90, 0]) {
                        cube([100, 200, 100]);
                    }
                    rotate([0, 60, 0]) {
                        cube([100, 200, 100]);
                    }
                }
            }
            color("cyan", 0.5) {
                translate([-20, 5 + 14 - 1, -9 - 20]) {
                    cube([20, 20, 20]);

                }
            }
        }
    }

}
