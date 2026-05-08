include <parameters.scad>;

module rounded_box(size=[10, 10, 10], r=2) {
    // Simple rounded rectangle prism from hull of corner cylinders.
    hull() {
        for (sx = [-1, 1])
            for (sy = [-1, 1])
                translate([sx * (size[0] / 2 - r), sy * (size[1] / 2 - r), 0])
                    cylinder(h = size[2], r = r);
    }
}

module board_mount_points() {
    for (mx = [-1, 1])
        for (my = [-1, 1])
            translate([mx * mount_hole_offset_x, my * mount_hole_offset_y, 0])
                children();
}

module join_points() {
    x = inner_len / 2 - join_offset;
    y = inner_wid / 2 - join_offset;
    for (sx = [-1, 1])
        for (sy = [-1, 1])
            translate([sx * x, sy * y, 0])
                children();
}

module connector_cutout_minus_x(y_pos, z_pos, w, h) {
    translate([-(outer_len / 2 + 0.6), y_pos, z_pos])
        cube([wall + 1.2, w + 2 * connector_clear, h + 2 * connector_clear], center = true);
}

module top_button_hole(xp, yp) {
    translate([xp, yp, lid_h - top_t - 0.1])
        cylinder(h = top_t + 0.3, d = btn_d + btn_clear);
}

module screen_opening() {
    translate([screen_center_x, screen_center_y, lid_h - top_t - 0.1])
        rounded_box(
            size = [screen_open_len, screen_open_wid, top_t + 0.3],
            r = screen_corner_r
        );
}

module base_shell() {
    difference() {
        rounded_box([outer_len, outer_wid, base_h], corner_r);

        // Main cavity
        translate([0, 0, floor_t])
            rounded_box(
                [inner_len, inner_wid, base_h - floor_t + 0.1],
                max(corner_r - wall, 1.2)
            );

        // USB connector windows
        connector_cutout_minus_x(usb1_y, usb1_z, usb1_w, usb1_h);
        connector_cutout_minus_x(usb2_y, usb2_z, usb2_w, usb2_h);
    }

    // Nucleo standoffs
    board_mount_points()
        translate([0, 0, floor_t])
            difference() {
                cylinder(h = standoff_h, d = standoff_d);
                translate([0, 0, -0.05])
                    cylinder(h = standoff_h + 0.2, d = standoff_screw_clear_d);
            }

    // Threaded insert pillars for joining lid/base
    join_points()
        translate([0, 0, floor_t])
            difference() {
                cylinder(h = base_inner_h, d = join_post_d);
                // Insert pocket from top
                translate([0, 0, base_inner_h - join_insert_depth])
                    cylinder(h = join_insert_depth + 0.2, d = join_insert_d);
                // Pilot hole through pillar
                translate([0, 0, -0.05])
                    cylinder(h = base_inner_h + 0.2, d = 1.8);
            }
}

module lid_shell() {
    difference() {
        rounded_box([outer_len, outer_wid, lid_h], corner_r);

        // Hollow inside, keep top wall thickness
        translate([0, 0, 0.0])
            rounded_box(
                [inner_len + 2 * fit_gap, inner_wid + 2 * fit_gap, lid_h - top_t + 0.1],
                max(corner_r - wall + fit_gap, 1.2)
            );

        // USB connector windows on lid side to keep full access
        connector_cutout_minus_x(usb1_y, usb1_z, usb1_w, usb1_h);
        connector_cutout_minus_x(usb2_y, usb2_z, usb2_w, usb2_h);

        // Screen opening
        screen_opening();

        // Button openings
        top_button_hole(btn1_x, btn1_y);
        top_button_hole(btn2_x, btn2_y);
        top_button_hole(btn3_x, btn3_y);

        // Status LED light pipe seat
        translate([led_x, led_y, lid_h - top_t - 0.1])
            cylinder(h = top_t + 0.3, d = led_hole_d);

        translate([led_x, led_y, lid_h - led_counterbore_h + 0.01])
            cylinder(h = led_counterbore_h + 0.2, d = led_counterbore_d);

        // Joining screw holes (through + head recess)
        join_points()
            translate([0, 0, 0]) {
                cylinder(h = lid_h + 0.2, d = join_screw_clear_d);
                translate([0, 0, lid_h - join_head_depth + 0.01])
                    cylinder(h = join_head_depth + 0.2, d = join_head_d);
            }
    }
}

module light_pipe() {
    // Print in translucent PETG, standing up on flange side.
    union() {
        cylinder(h = light_pipe_h, d = light_pipe_body_d);
        cylinder(h = light_pipe_flange_h, d = light_pipe_flange_d);
    }
}

module assembly() {
    base_shell();

    if (exploded_view) {
        translate([0, 0, base_h + explode_gap])
            lid_shell();
    } else {
        translate([0, 0, base_h - 0.01])
            lid_shell();
    }

    // Visual placement for check only
    translate([led_x, led_y, base_h + lid_h + (exploded_view ? explode_gap : 0)])
        color([0.8, 0.9, 1.0, 0.5])
            light_pipe();
}

assembly();
