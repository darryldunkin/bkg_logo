/* [Personalization] */
// Your registered callsign
callsign = "KD9ZZK"; 
// Your BKG number
number = 14;
// The frequency to display
freq = "144.025";

/* [Sizing] */
// The size in mm
size      = 70; // [70:256]
// How thick to print it
thickness = 2.5; // [2:8]

/* [Style] */
// Any attached accessories
type = "coin"; // [chain, strap, buckle, coin]
// How wide the strap is (for strap/buckle)
strap_width = 1; // [0.5:3]

// Translate UI variables to module
bkg_logo(
  callsign = callsign,
  number   = number,
  freq     = freq,
  size     = size,
  height   = thickness,
  type     = type,
  strap    = strap_width);

module bkg_logo(callsign, number,
                size = 70, height = 5,
                freq = "144.025", type = "coin", strap = 1) {
  mid = height * 0.8; // Mid-point

  cylinder(d = size, h = mid, $fn = 64);
  // Logo, text and accessories are extruded
  linear_extrude(mid) {
    if (type == "buckle") {
      buckle(width = strap, offset = (size/2)-8, rotate = 90);
    }
    else if (type == "strap") {
      buckle(width = strap, offset = (size/2)-4, rotate = 0);
    }
    else if (type == "chain") {
      rings(height = height/2, offset = size/2+3);
    } else {
      // Default coin, no accessories
    }
  }

  // The badge itself
  // Components are arranged in relation to the SVG before being resized
  translate([0, 0, mid]) linear_extrude(height-mid)
    resize([size*0.98, size*0.98]) {
      curved_text(freq, "MS UI Gothic:bold", 36, 1, -41, 7, -260);
      callsign(callsign, number);
      badge();
    }
}

module callsign(callsign, number) {
  translate([0,-65])
    text(str(callsign," | #",number), size = 35, halign = "center", valign = "center", font="Ebrima:bold");
}

// Curve text around the center, positive direction for cw, neg for ccw
module curved_text(string, font, size, spacing, start, end, offset){
  length = len(string);
  degrees = ((end - start) / length); // Degrees of spacing per-character
  for (i = [0 : length - 1]) {
    rotate([0, 0, (start+(degrees*i))])
      translate([0,offset])
           text(string[i], font = font, spacing = spacing, size = size, halign = "center");
  }
}

// Curved line - Assume CW rotation
module curved_line(start, end, width, offset) {
  steps = (end - start)/width; // Smoothness
  for (i = [0 : steps - 1]) {
    a1 = start + (end - start) * (i / steps);
    a2 = start + (end - start) * ((i+1) / steps);
    
    hull() {
        translate([offset * cos(a1), offset * sin(a1), 0]) 
            circle(r = width);
        translate([offset * cos(a2), offset * sin(a2), 0]) 
            circle(r = width);
    }
  }
}

// Generate rings to hang from
module rings(size = 10, height = 2.5, offset = 0) {
  copy_mirror()
    rotate([0, 0, +120])
      translate([offset,0,-height/2])
        difference() {
          circle(r = size, $fn = 50);
          translate([0,0,-.1]) circle(r = size*0.7, $fn = 50);
        }
}

// Mirror a copy of the first ring to the other side
module copy_mirror() {
  children();
  mirror([1,0,0]) children();
}

// Generate variable-width buckles, strap width in inches
module buckle(width = 1, rotate = 0, offset) {
  width = width * 25.4; // Convert to mm
  thickness = 5;        // Width around the outside
  radius = 1;           // Roundness
  length = 30;          // How far into the disc we go
  rotate([0, 0, rotate])
    rotate_mirror() {
      translate([0, offset, 0]) {
        // Retainer notch - Fixed width and depth
        translate([-width/2-1, 11, 0]) {
          square([4, 2.5], center=true);
          translate([2,0,0])
            circle(d=2.5, $fn = 20);
        }
        difference() {
          // Rounded outside
          offset(thickness)
            square([(width+thickness) - 2*radius, length - 2*radius], center=true);
          // Inside space for strap - 6mm
          translate([0, 17-thickness, 0])
            square([width+6, 7], center=true);
          // Strap gap - 2.5mm
          translate([-thickness+3, 8.5]) square([width+(thickness*2), 2.5], center=true);
        }
      }
    }
}

// Mirror a copy and rotate it
module rotate_mirror() {
  children();
  mirror([1,0,0])
    rotate([180, 0, 0])
      children();
}

// Ring
module ring(size, width) {
  $fn = 64;
  difference() {
    circle(d = size);
    circle(d = size - width);
  }
}

// The stock elements that do not change
module badge() {
  //import("bkglogo.svg", center=true);
  ring(610, 25);
  ring(571, 16);
  curved_line(204, 224, 4, 240);
  curved_line(316, 336, 4, 240);
  ring(422, 16);
  curved_text("BRASS KNUCKLE GANG", "Verdana", 45, 1, 77, -89, 224);
  curved_text("MHz", "Verdana", 36, 1, 20, 47, -260);
  translate([0,-135])
    text("BKG", size = 65, halign = "center", valign = "center", font="Cambria Math");
}