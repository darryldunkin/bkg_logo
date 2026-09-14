# BKG Logo Generator

An OpenSCAD module for generating a BKG logo and accessories.

## Usage

1. Install OpenSCAD
2. Open the file **bkglogo.scad**
3. Change any parameters on the top, press **F5** to preview
4. When it looks good, press **F6** to render, this can take up to 5 minutes
5. Press **F7** to export the STL
6. Import the STL into your slicer, color it
7. Print it!

### Optional Flags

* size - The size in mm of the base badge, before accessories
* height - The thickness of the overall badge
* type - "buckle" for a belt buckle, "strap" for a vertical strap or "chain" for hanging
* strap_width - If you are generating a buckle, this is the width of the inside for your strap or belt
* freq - Frequency, this should be in the format of **###.###*** to fill the space the best

For a 7cm disc, the strap can be 0.5-1", for 1.5" 80mm and 2" 90mm.

## Printing Notes

I used the SVG converter at https://picsvg.com "Internal 3" to generate the source image.

All tested on a Bambu P1S with the default 0.04mm nozzle. The minimum size I generally work with is **7cm**. This gives at least two lines width of printing for the smallest components.

* Size: As big as your print bed can handle, aware of accessories - printing at 45 degrees may give you enough room for clips or other attachments if you are going big
* Print quality: 0.20 standard works

## TODO

* Efficiency - Render times are 10 minutes, primarily due to the complex SVG generated from a PNG. Generating raw elements will save a lot of space.
* OG support - Requires a new template
* Build the entire logo here, so it can be hosted on MakerWorld (does not support svg files)
