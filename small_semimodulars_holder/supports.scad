// Simple pillar supports

module tree_supports(support_points) {
    color("gray", 0.7) {
        // Just make simple pillars under the front corners
        coast_front_left = support_points[0];
        coast_front_right = support_points[1];
        mavis_front_left = support_points[3];
        mavis_front_right = support_points[4];
        
        // Left pillar
        translate([coast_front_left[0], coast_front_left[1] - 1, 0]) {
            cube([1, 2, coast_front_left[2]]);
        }
        
        // Right pillar  
        translate([coast_front_right[0] - 1, coast_front_right[1] - 1, 0]) {
            cube([1, 2, coast_front_right[2]]);
        }
        
        // Center back pillar
        translate([-0.5, 8, 0]) {
            cube([1, 2, mavis_front_left[2] + 3]);
        }
    }
}