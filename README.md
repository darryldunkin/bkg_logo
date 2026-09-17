# BKG Logo Generator

An OpenSCAD module for generating a BKG logo and accessories.

Recommend using the latest development snapshots: https://openscad.org/downloads.html#snapshots

This tool was used to convert the complex shapes to paths: https://printnexus.io/tools/svg-to-openscad-converter

## Usage

1. Install OpenSCAD
2. Open the file **bkglogo.scad**
3. Change any parameters in the customizer, if **Automatic Pefresh** is checked, the preview will update immediately
4. When it looks good, press **F6** to render, this can take up to 5 minutes
5. Press **F7** to export the STL
6. Import the STL into your slicer
8. Color it.
7. Print it!

## Printing Notes

All tested on a Bambu P1S, PETG, on the 0.04mm nozzle. The minimum size I generally work with is **7cm**. This gives at least two lines width of printing for the smallest components.

* Size: As big as your print bed can handle, aware of accessories - printing at 45 degrees may give you enough room for clips or other attachments if you are going big
* Print quality: 0.20 standard works
* Ratio: At least 3 layers minimum for the embossed area. The default ratio of 0.7 for 2.5mm 

# Development Notes

The parametric model maker is mysterious, here are some hidden features:
https://github.com/nelsonjchen/unofficial-makerworld-parametric-model-maker-openscad-docs/blob/main/docs/pmm-openscad-api.md

## TODO

* Fonts - Limited font support, need to find something appropriate without path-tracing
* PMM - Does not like decimals
* OG support - This can be optional, the outline just needs to be drawn.
