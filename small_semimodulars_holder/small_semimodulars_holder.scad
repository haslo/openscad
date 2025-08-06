coast_width = 23; coast_depth = 14; coast_height = 2; coast_angle = 30;
mavis_width = 23.2; mavis_depth = 13.4; mavis_height = 2; mavis_angle = coast_angle * 2;
coast_front_bottom_height = 4.5;
coast_front_height_offset = coast_depth * sin(coast_angle);
coast_front_lateral_offset = coast_depth * cos(coast_angle);
coast_front_top_height = coast_front_bottom_height + coast_front_height_offset;
mavis_front_bottom_height = coast_front_top_height;
mavis_front_bottom_lateral_offset = coast_front_lateral_offset;
mavis_front_height_offset = mavis_depth * sin(mavis_angle);
mavis_front_lateral_offset = mavis_depth * cos(mavis_angle);

holder_extension_sides_up = 0.2;
holder_extension_sides_bottom = 0.2;
holder_extension_sides_frontback = 0.3;
holder_creep_sides_up = 1.0;
holder_creep_sides_bottom = 0.5;

module left_bracket(synth_width, synth_depth) {
    translate([
        -holder_extension_sides_bottom,
        -holder_extension_sides_frontback,
        -holder_extension_sides_up
    ]) {
        cube([
            holder_extension_sides_bottom + holder_creep_sides_bottom,
            synth_depth + 2 * holder_extension_sides_frontback,
            holder_extension_sides_up + holder_creep_sides_up
        ]);
    }
}

module center_bracket(synth_width, synth_depth) {
    translate([
        synth_width / 2 - holder_creep_sides_bottom / 2,
        -holder_extension_sides_frontback,
        -holder_extension_sides_up
    ]) {
        cube([
            holder_creep_sides_bottom * 2,
            synth_depth + 2 * holder_extension_sides_frontback,
            holder_extension_sides_up + holder_creep_sides_up
        ]);
    }
}

module right_bracket(synth_width, synth_depth) {
    translate([
        synth_width - holder_creep_sides_bottom,
        -holder_extension_sides_frontback,
        -holder_extension_sides_up
    ]) {
        cube([
            holder_extension_sides_bottom + holder_creep_sides_bottom,
            synth_depth + 2 * holder_extension_sides_frontback,
            holder_extension_sides_up + holder_creep_sides_up
        ]);
    }
}

module coast_holder() {
    translate([-coast_width / 2, 0, 0]) {
        translate([0, 0, coast_front_bottom_height]) {
            rotate([coast_angle, 0, 0]) {
                translate([0, 0, -coast_height]) {
                    left_bracket(coast_width, coast_depth);
                    center_bracket(coast_width, coast_depth);
                    right_bracket(coast_width, coast_depth);
                    cube([coast_width, coast_depth, coast_height], center=false);
                }
            }
        }
    }
}

module mavis_holder() {
    translate([-mavis_width / 2, mavis_front_bottom_lateral_offset, 0]) {
        translate([0, 0, mavis_front_bottom_height]) {
            rotate([mavis_angle, 0, 0]) {
                translate([0, 0, -mavis_height]) {
                    left_bracket(mavis_width, mavis_depth);
                    center_bracket(mavis_width, mavis_depth);
                    right_bracket(mavis_width, mavis_depth);
                    cube([mavis_width, mavis_depth, mavis_height], center=false);
                }
            }
        }
    }
}

color("pink", 0.85) {
    coast_holder();
    mavis_holder();
}

// Calculate support connection points
coast_front_left = [-coast_width/2, 0, coast_front_bottom_height];
coast_front_right = [coast_width/2, 0, coast_front_bottom_height];
coast_back_center = [0, coast_front_lateral_offset, coast_front_top_height];

mavis_front_left = [-mavis_width/2, mavis_front_bottom_lateral_offset, mavis_front_bottom_height];
mavis_front_right = [mavis_width/2, mavis_front_bottom_lateral_offset, mavis_front_bottom_height];
mavis_back_center = [0, mavis_front_bottom_lateral_offset + mavis_front_lateral_offset, mavis_front_bottom_height + mavis_front_height_offset];
