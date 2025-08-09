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

holder_distance_sides_bottom = 3;
holder_extension_sides_up = 0.3;
holder_extension_sides_frontback = 0.5;
holder_creep_sides_up = 0.8;
holder_creep_sides_bottom = 0.5;
holder_extension_clamps_depth = 0.3;

pillar_length = 35;
pillar_radius = 0.55;
ground_pillar_radius = 0.8;
pillar_faces = 32;

module pillars(bracket_width, bracket_depth, bracket_height, pillar_x, bracket_y, bracket_z, angle) {
    // Front pillar
    translate([pillar_x + bracket_width/2, bracket_y + 0.5, bracket_z]) {
        rotate([-angle, 0, 0]) {
            translate([0, 0, -pillar_length]) {
                cylinder(r=pillar_radius, h=pillar_length, $fn=pillar_faces);
            }
        }
        sphere(r=pillar_radius, $fn=pillar_faces);
    }
    // Center pillar
    translate([pillar_x + bracket_width/2, bracket_y + bracket_depth/2, bracket_z]) {
        rotate([-angle, 0, 0]) {
            translate([0, 0, -pillar_length]) {
                cylinder(r=pillar_radius, h=pillar_length, $fn=pillar_faces);
            }
        }
        sphere(r=pillar_radius, $fn=pillar_faces);
    }
    // Back pillar
    translate([pillar_x + bracket_width/2, bracket_y + bracket_depth - 1, bracket_z]) {
        rotate([-angle, 0, 0]) {
            translate([0, 0, -pillar_length]) {
                cylinder(r=pillar_radius, h=pillar_length, $fn=pillar_faces);
            }
        }
        sphere(r=pillar_radius, $fn=pillar_faces);
    }
}

module left_bracket(synth_width, synth_depth, angle) {
    bracket_x = holder_distance_sides_bottom;
    bracket_y = -holder_extension_sides_frontback;
    bracket_z = -holder_extension_sides_up;
    bracket_width = holder_creep_sides_bottom * 2;
    bracket_depth = synth_depth + 2 * holder_extension_sides_frontback;
    bracket_height = holder_extension_sides_up + holder_creep_sides_up;
    
    translate([bracket_x, bracket_y, bracket_z]) {
        cube([bracket_width, bracket_depth, bracket_height]);
    }
    pillars(bracket_width, bracket_depth, bracket_height, bracket_x, bracket_y, bracket_z, angle);
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
    pillars(bracket_width, bracket_depth, bracket_height, bracket_x, bracket_y, bracket_z, angle);
}

module right_bracket(synth_width, synth_depth, angle) {
    bracket_x = synth_width - holder_distance_sides_bottom - holder_creep_sides_bottom * 2;
    bracket_y = -holder_extension_sides_frontback;
    bracket_z = -holder_extension_sides_up;
    bracket_width = holder_creep_sides_bottom * 2;
    bracket_depth = synth_depth + 2 * holder_extension_sides_frontback;
    bracket_height = holder_extension_sides_up + holder_creep_sides_up;
    
    translate([bracket_x, bracket_y, bracket_z]) {
        cube([bracket_width, bracket_depth, bracket_height]);
    }
    pillars(bracket_width, bracket_depth, bracket_height, bracket_x, bracket_y, bracket_z, angle);
}

module coast_holder() {
    translate([-coast_width / 2, 0, 0]) {
        translate([0, 0, coast_front_bottom_height]) {
            rotate([coast_angle, 0, 0]) {
                translate([0, 0, -coast_height]) {
                    difference() {
                        union() {
                            left_bracket(coast_width, coast_depth, coast_angle);
                            center_bracket(coast_width, coast_depth, coast_angle);
                            right_bracket(coast_width, coast_depth, coast_angle);
                        }
                        cube([coast_width, coast_depth, coast_height], center=false);
                    }
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
                    difference() {
                        union() {
                            left_bracket(mavis_width, mavis_depth, mavis_angle);
                            center_bracket(mavis_width, mavis_depth, mavis_angle);
                            right_bracket(mavis_width, mavis_depth, mavis_angle);
                        }
                        cube([mavis_width, mavis_depth, mavis_height], center=false);
                    }
                }
            }
        }
    }
}

module ground_cylinder(offset, width) {
   translate([0, offset, 0]) {
       rotate([0, 90, 0]) {
           cylinder(r=ground_pillar_radius, h=width, center=true, $fn=pillar_faces);
       }
       // Left end cap
       translate([-width/2, 0, 0]) {
           sphere(r=ground_pillar_radius, $fn=pillar_faces);
       }
       // Right end cap  
       translate([width/2, 0, 0]) {
           sphere(r=ground_pillar_radius, $fn=pillar_faces);
       }
   }
}

module added_mavis_holder() {
	ground_height = 0.2;
	ground_go_over = 0.15;
    scale([10, 10, 10]) {
        rotate([-mavis_angle + 90, 0, 0]) difference() {
		    translate([-mavis_width / 2, mavis_front_bottom_lateral_offset, 0]) {
		        translate([0, 0, mavis_front_bottom_height]) {
		            rotate([mavis_angle, 0, 0]) {
		            	translate([0, 0, -mavis_height - ground_height]) {
		            		cube([mavis_width, holder_creep_sides_bottom * 2, ground_height + ground_go_over]);
		            	}
		            	translate([-holder_extension_clamps_depth, 0, -mavis_height - ground_height]) {
							cube([holder_extension_clamps_depth, holder_creep_sides_bottom * 2, holder_creep_sides_up + ground_height]);
		            	}
		            	translate([mavis_width, 0, -mavis_height - ground_height]) {
							cube([holder_extension_clamps_depth, holder_creep_sides_bottom * 2, holder_creep_sides_up + ground_height]);
		            	}
		            }
		        }
		    }
            mavis_holder();
	    }
    }    
}
module added_coast_holder() {
	// TODO
	ground_height = 0.2;
	ground_go_over = 0.15;
    scale([10, 10, 10]) {
        rotate([-coast_angle + 90, 0, 0]) difference() {
		    translate([-coast_width / 2, coast_front_bottom_lateral_offset, 0]) {
		        translate([0, 0, coast_front_bottom_height]) {
		            rotate([coast_angle, 0, 0]) {
		            	translate([0, 0, -coast_height - ground_height]) {
		            		cube([coast_width, holder_creep_sides_bottom * 2, ground_height + ground_go_over]);
		            	}
		            	translate([-holder_extension_clamps_depth, 0, -coast_height - ground_height]) {
							cube([holder_extension_clamps_depth, holder_creep_sides_bottom * 2, holder_creep_sides_up + ground_height]);
		            	}
		            	translate([coast_width, 0, -coast_height - ground_height]) {
							cube([holder_extension_clamps_depth, holder_creep_sides_bottom * 2, holder_creep_sides_up + ground_height]);
		            	}
		            }
		        }
		    }
            coast_holder();
	    }
    }    
}

added_mavis_holder();
