# BKG Logo Generator

An OpenSCAD module for generating a BKG logo.

## Usage

Add your parameters at the top. The rest can be ignored unless you want to tune it further. 

```
// Callsign, size in mm, optional height
bkg_logo("KM7BUM", 100);
```

### Optional Flags

* type - "buckle" for a belt buckle, "strap" for a vertical strap or "chain" for hanging
* strap_width - If you are generating a buckle, this is the width of the inside for your strap or belt
* freq - Frequency, this should be in the format of **###.###*** to fill the space the best

For a 7cm disc, the strap can be 0.5-1", for 1.5" 80mm and 2" 90mm.

## Notes

I used the SVG converter at https://picsvg.com "Internal 3" to generate the source image.

All tested on a Bambu P1S with the default 0.04mm nozzle. The minimum size I generally work with is **7cm**. This gives at least two lines width of printing for the smallest components.

## TODO

* Fix the hash sign for smaller prints 
* Build the entire logo here, so it can be hosted on MakerWorld
