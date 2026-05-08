// Parametric enclosure for NUCLEO-U5A5ZJ-Q + Riverdi PCB_035_NUCLEO144_REV1.1
// Units: mm

// ---------- Global quality ----------
$fn = 64;

// ---------- Board envelope ----------
// Keep these values aligned with your measured footprint.
board_len = 114.0;            // X
board_wid = 82.0;             // Y
board_thk = 1.6;
max_component_h_bottom = 4.0; // lowest components under board
max_component_h_top = 18.0;   // highest stack above board (including display PCB)

// ---------- Display / screen opening ----------
// Position is relative to board center.
screen_center_x = 6.0;
screen_center_y = 0.0;
screen_open_len = 95.0;
screen_open_wid = 56.0;
screen_corner_r = 3.0;

// ---------- Buttons access holes ----------
// Reset + control buttons (example coordinates; update from PCB)
btn_d = 4.0;
btn_clear = 0.4;
btn1_x = -45.0;
btn1_y = 30.0;
btn2_x = -35.0;
btn2_y = 30.0;
btn3_x = -25.0;
btn3_y = 30.0;

// ---------- Status LED + light pipe ----------
led_x = -15.0;
led_y = 32.0;
led_hole_d = 3.2;          // lid hole for light pipe body
led_counterbore_d = 6.2;   // lid counterbore for flange
led_counterbore_h = 1.2;
light_pipe_body_d = 3.0;
light_pipe_flange_d = 6.0;
light_pipe_flange_h = 1.0;
light_pipe_h = 7.0;

// ---------- Nucleo mounting holes ----------
// Coordinates relative to board center (typical 4-point mounting pattern, to verify)
mount_hole_offset_x = 50.0;
mount_hole_offset_y = 34.0;

// Holes in board are usually around 3.2 mm for M3; support M2.5/M3 with spacers.
standoff_d = 8.0;
standoff_h = 6.0;
standoff_screw_clear_d = 2.8;  // M2.5 clearance; set 3.2 for M3 clearance

// ---------- External enclosure geometry ----------
wall = 2.4;
floor_t = 2.8;
top_t = 2.4;
corner_r = 4.0;
fit_gap = 0.35; // radial clearance between lid and base

// Internal margin around board
gap_x = 4.0;
gap_y = 4.0;

// Computed outer dimensions
inner_len = board_len + 2 * gap_x;
inner_wid = board_wid + 2 * gap_y;
outer_len = inner_len + 2 * wall;
outer_wid = inner_wid + 2 * wall;

// Base and lid heights
base_inner_h = max_component_h_bottom + board_thk + standoff_h + 1.5;
base_h = floor_t + base_inner_h;
lid_inner_h = max_component_h_top + 1.5;
lid_h = top_t + lid_inner_h;

// ---------- Base/Lid joining with M2 screws ----------
join_post_d = 7.0;
join_offset = 8.5;
join_screw_clear_d = 2.2;     // M2 clearance in lid
join_insert_d = 3.3;          // heat-set insert OD pocket in base (typical M2 insert)
join_insert_depth = 4.0;
join_head_d = 4.2;            // M2 pan/SHCS cap clearance
join_head_depth = 1.6;

// ---------- USB cutouts ----------
// Two windows on -X side for STLINK USB + USER USB (update to your real coordinates)
usb_side = "-X";
usb1_y = 18.0;
usb1_z = 11.5;
usb1_w = 12.0;
usb1_h = 8.0;

usb2_y = -3.0;
usb2_z = 11.5;
usb2_w = 12.0;
usb2_h = 8.0;

// Expand cutouts for print tolerance
connector_clear = 0.5;

// ---------- Utility ----------
exploded_view = false;
explode_gap = 16;
