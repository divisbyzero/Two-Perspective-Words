// =======================================================
// Dual-View Standing Word Builder
// =======================================================

// Words to display 
// The words must have same number of letters
// The words should be capitalized so they have the same height
string_1 = "L♥VE";    // Seen from left side
string_2 = "HATE";    // Seen from right side

// Font information
letter_size = 25;       // Height of letters (mm)
font_name = "Verdana:style=Bold";  // Font for letters
round_letter_correction = 0.98;  // Scale round-top letters
rounded_letters = ["O", "C", "G", "Q", "S"];  // Round-top capital letters that are slightly taller than the rest

special_char = "♥";                     // Character to treat specially
special_font = "DejaVu Sans:style=Bold";    // Font for special character
special_scale = 1.42;                   // Scale for special character
special_vertical_shift = letter_size * (-0.1);  // Vertical shift for special character


// Control appearance
aspect_ratio = 1.1;
spacing_factor = 1.35;

// Baseplate settings
include_baseplate = true;  // Toggle baseplate ON or OFF

// ================== DERIVED PARAMETERS =================

// Letter size and spacing
letter_depth = letter_size * aspect_ratio;
letter_spacing = letter_depth * spacing_factor;

// Base dimensions
margin_x = letter_spacing * 0.05;
margin_y = letter_spacing * 0.05;
dims = compute_dimensions(letter_spacing, margin_x, margin_y, len(string_1));
xdim = dims[0];
ydim = dims[1];
zdim = letter_size * 0.15;
overlap = letter_size * 0.04;
corner_radius = zdim * 2;

// ================== FUNCTIONS ===========================

// Reverse a string
function reverse_string(s) = [for (i = [len(s)-1 : -1 : 0]) s[i]];

// Compute [xdim, ydim] based on spacing and margins
function compute_dimensions(letter_spacing, margin_x, margin_y, n_letters) = 
    [n_letters * letter_spacing + 2 * margin_x, letter_spacing + 2 * margin_y];

// Manual rounding to 1 decimal place
function round1(x) = round(x * 10) / 10;

// Check if a letter needs rounded correction
function needs_round_correction(letter) =
    len([for (x = rounded_letters) if (x == letter) x]) > 0;


// ================== MODULES ============================

// Create a standing 3D letter centered and rotated
module standing_letter(letter, angle) {
    correction = needs_round_correction(letter) ? round_letter_correction : 1.0;
    is_special = (letter == special_char);
    selected_font = is_special ? special_font : font_name;
    scale_factor = is_special ? special_scale : 1;
    extra_shift = is_special ? special_vertical_shift : 0;


    rotate([0, 0, angle])
        translate([0, 0, extra_shift])  // ← correct place to shift vertically
            translate([0, letter_depth/2, 0])
                rotate([90, 0, 0])
                    scale([scale_factor, correction * scale_factor, 1])
                        linear_extrude(height = letter_depth, center = false, convexity = 10)
                            text(letter,
                                 font = selected_font,
                                 size = letter_size,
                                 halign = "center",
                                 valign = "baseline",
                                 $fn = 100);
}

// Intersect two rotated letters at index i
module intersected_letter_at(i, s2, rev_s1) {
    intersection() {
        standing_letter(s2[i], -45);      // Seen from left
        standing_letter(rev_s1[i], 225);  // Seen from right
    }
}

// Assemble all standing letters
module create_letters(s1, s2) {
    rev_s1 = reverse_string(s1);
    
    // Center the word horizontally
    translate([-(len(s2)-1) * letter_spacing/2, 0, zdim - overlap]) {
        for (i = [0 : len(s2) - 1]) {
            translate([i * letter_spacing, 0, 0])
                intersected_letter_at(i, s2, rev_s1);
        }
    }
}
// Create a rounded rectangle baseplate
module create_baseplate() {
    linear_extrude(height=zdim, center=false)
        offset(r=corner_radius, $fn=100)
            square([xdim - 2*corner_radius, ydim - 2*corner_radius], center=true);
}

// Build the full word model (base and letters)
module standing_word_dual_view(s1, s2) {
    if (include_baseplate)
        create_baseplate();
    create_letters(s1, s2);
}

// ================== EXECUTION ==========================

if (len(string_1) != len(string_2)) {
    echo("ERROR: string_1 and string_2 must have the same number of letters!");
} else {
    echo(str("Final model dimensions (X x Y x Z) in mm: ", 
             round1(xdim), " x ", round1(ydim), " x ", round1(zdim + letter_size)));
    
    standing_word_dual_view(string_1, string_2);
}
