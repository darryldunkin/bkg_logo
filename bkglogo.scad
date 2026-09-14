bkg_logo(
  callsign = "KD9ZZK",     // Registered callsign
  number   = "999",        // Official BKG number
  freq     = "144.069",    // Optional QSY
  size     = 70,          // Size in mm
  height   = 2.5,          // Thickness in mm
  // Chain, strap (vertical), buckle (horzontal) or coin (default)
  type     = "coin",
  // Strap/belt width in inches
  strap = 0.75);

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
      frequency(freq);
      callsign(callsign, number);
      import("bkglogo.svg", center=true);
    }
}

module callsign(callsign, number) {
  translate([0,-65])
    text(str(callsign," | #",number), size = 35, halign = "center", valign = "center", font="Ebrima:bold");
}

module frequency(freq = "144.025"){
  length = len(freq);
  // Fill degrees -42 to 7 = 49 total
  degrees = 49.5 / length; // Character spacing
  for (i = [0 : length - 1]) {
    rotate([0, 0, (-42+(degrees*i))])
      // Offset from center
      translate([0,-258])
       rotate([0, 0, ((1*i))]) // Rotation offset
        text(freq[i], size = 36, font = "NanumGothic:bold");
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