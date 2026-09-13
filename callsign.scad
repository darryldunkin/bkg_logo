bkg_logo("KM7BUM", "14", "144.052");

module bkg_logo(callsign, number, freq = "144.025", size = 70, height = 5) {
  mid = height/2; // Mid-point
  // Base
  $fn = 100;
  cylinder(h=2.5, d=size, center=true);
  rings(offset = size/2);

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
    text(str("- ",callsign," | #",number," -"), size = 32, halign = "center", valign = "center", font="Ebrima:bold");
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

// Mirror a copy
module copy_mirror() {
  children();
  mirror([1,0,0]) children();
}