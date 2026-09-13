bkg_logo(
  callsign = "KM7BUM", // Registered callsign
  number = "14",       // Official BKG number
  freq = "144.052",    // Optional QSY
  type = "buckle",      // Chain, strap (vertical), or buckle (horzontal)
  strap = 2, size=70);

module bkg_logo(callsign, number,
                size = 70, height = 5,
                freq = "144.025", type = "chain", strap = 1) {
  mid = height/2; // Mid-point
  // Base
  cylinder(h=2.5, d=size, center=true, $fn = 100);

  if (type == "buckle") {
    buckle(width = strap, offset = (size/2)-4, rotate = 90);
  }
  else if (type == "strap") {
    buckle(width = strap, offset = (size/2)-4, rotate = 0);
  } else {
    // Default chain
    rings(offset = size/2);
  }

  // Overlay
  linear_extrude(mid) {
    resize([size*0.98, size*0.98]) {
      frequency(freq);
      callsign(callsign, number);
      import("bkg-frequency.svg", center=true);
    }
  }
}

module callsign(callsign, number) {
  translate([0,-65])
    text(str("- ",callsign," | #",number," -"), size = 30, halign = "center", valign = "center", font="Ebrima:bold");
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
module rings(size = 5, height = 2.5, offset = 0) {
  $fn = 30;
  copy_mirror()
    rotate([0, 0, +120])
      translate([offset,0,-height/2])
        difference() {
          cylinder(h = height, r = size);
          translate([0,0,-.1]) cylinder(h = height+0.2, r = size*0.7);
        }
}

// Mirror a copy of the rings
module copy_mirror() {
  children();
  mirror([1,0,0]) children();
}

// Generate variable-width buckles, strap width in inches
module buckle(width = 1, rotate = 0, offset) {
  width = width * 25.4; // Convert to mm
  thickness = 5;        // 5mm around the outside
  radius = 0.5;           // Roundness
  length = 30;          // How far into the disc we go          

    rotate_mirror() {
      translate([0, offset, 0]) {
        // Retainer notch - Fixed width and depth
        translate([-width/2+1, 8.5, 0]) {
          square([3, 2.5], center=true);
          translate([1.5,0,0])
            circle(d=2.5, $fn = 20);
        }      
        difference() {
          // Rounded outside
          offset(thickness)
            square([(width+thickness) - 5*radius, length - 5*radius], center=true);
          // Inside space for strap - 7mm
          translate([0, 15-thickness, 0])
            square([width, 7], center=true);
          // Strap gap - 2.5mm
          translate([-thickness, 6]) square([width+(thickness*2), 2.5], center=true);
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