coast_width = 23; coast_depth = 14; coast_height = 2;
mavis_width = 23.2; mavis_depth = 13.4; mavis_height = 2;
ds2_width = 24.5; ds2_depth = 13; ds2_height = 4.1;

holder_distance_sides_bottom = 3;
holder_extension_sides_up = 0.3;
holder_extension_sides_frontback = 0.5;
holder_creep_sides_up = 0.8;
holder_creep_sides_bottom = 0.5;
holder_extension_clamps_depth = 0.3;

ground_height = 0.15;

pillar_radius = 0.55;
ground_pillar_radius = 0.8;
pillar_faces = 32;
ground_holder_radius = 1.1;

module ground_cylinder(offset, width) {
   translate([0, offset, 0]) {
       rotate([0, 90, 0]) {
           cylinder(r=ground_pillar_radius, h=width, center=true, $fn=pillar_faces);
       }
   }
}

module center_bracket(synth_width, synth_depth, angle) {
    bracket_x = synth_width / 2 - holder_creep_sides_bottom;
    bracket_y = -holder_extension_sides_frontback;
    bracket_z = -holder_extension_sides_up;
    bracket_width = holder_creep_sides_bottom * 2;
    bracket_depth = synth_depth + 2 * holder_extension_sides_frontback;
    bracket_height = holder_extension_sides_up + holder_creep_sides_up;
    
    translate([bracket_x, bracket_y, bracket_z]) {
        cube([bracket_width, bracket_depth, bracket_height]);
    }
}

scale(10) difference() {
	union () {
		// ring
		difference() {
			translate([0, 1.4, 0]) {
			   rotate([0, 90, 0]) {
			       cylinder(r=ground_holder_radius, h=holder_creep_sides_bottom * 2, center=true, $fn=pillar_faces);
			   }
			}
			ground_cylinder(1.4, coast_width - 8);
		}
		// ground square long with corners
		translate([-holder_creep_sides_bottom, 0, 0]) {
			translate([0, -ds2_depth - holder_extension_clamps_depth, 0]) {
				cube([holder_creep_sides_bottom * 2, holder_extension_clamps_depth, holder_creep_sides_up]);
			}
			translate([0, -ds2_depth, 0]) {
				cube([holder_creep_sides_bottom * 2, ds2_depth + 0.4, ground_height]);
			}
			cube([holder_creep_sides_bottom * 2, holder_extension_clamps_depth, holder_creep_sides_up]);
		}
		// side square with corners
		translate([0, -(ds2_depth / 2) - holder_creep_sides_bottom, 0]) {
			extension_length = 5.5;
			cube([extension_length, holder_creep_sides_bottom * 2, ground_height]);
			translate([extension_length, 0, 0]) {
				cube([holder_extension_clamps_depth, holder_creep_sides_bottom * 2, holder_creep_sides_up]);
			}
		}
	}
	translate([-100, -100, -100]) {
		cube([200, 200, 100]);
	}
}
