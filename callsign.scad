module bkg_logo(callsign, size = 70, height = 5) {
  mid = height/2;
  translate([0,0,mid]) {
    $fn=100;
    cylinder(h=2.5, d=size, center=true);
    linear_extrude(mid) {
      resize([size*0.98, size*0.98]) {
         translate([0,-65])
           text(str("- ", callsign, " -"), size = 40, halign = "center", valign = "center", font="Helvetica:bold");
         import("bkg-callsign-b.svg", center=true);
      }
    }
  }
}
