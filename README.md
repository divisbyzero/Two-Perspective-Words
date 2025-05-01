[![GitHub](https://img.shields.io/badge/OpenSCAD-View%20Source-blue?logo=openscad)](https://github.com/YOUR_USERNAME/YOUR_REPO)
[![Download STL](https://img.shields.io/badge/Download-STL%20Files-orange?logo=3d-printing)](https://github.com/YOUR_USERNAME/YOUR_REPO/releases)

# Two-Perspective Words

This repository contains an OpenSCAD model for generating **two-view word sculptures**—3D designs that spell one word when viewed from the left and a different word when viewed from the right. 

## Description

- The model takes two words (of equal length) and creates a 3D object.
- The words are visible from **45° angles** on each side.
- A **rounded baseplate** supports the design for 3D printing stability.
- Symbols like **♥** are supported with font switching and custom scaling.

### Features

- Fully customizable: font, height, spacing, scaling
- Optional heart glyph scaling and Z-offset for durability
- STL export-ready
- Perfect for 3D printing

## Examples

### L♥VE / HATE

<p align="center">
  <img src="LoveHate1.jpeg" alt="Love/Hate View 1" width="400">
  <img src="LoveHate2.jpeg" alt="Love/Hate View 2" width="400">
</p>
<p align="center">
  <img src="LoveHate3.jpeg" alt="Love/Hate View 3" width="400">
  <img src="LoveHate4.jpeg" alt="Love/Hate View 4" width="400">
</p>

### OLIVIA / BALLET

<p align="center">
  <img src="OliviaBallet1.jpeg" alt="Olivia/Ballet View 1" width="400">
  <img src="OliviaBallet2.jpeg" alt="Olivia/Ballet View 2" width="400">
</p>

## STL Download

- [`LoveHate.stl`](LoveHate.stl) — L♥VE/HATE example

## How to Use

1. Open `TwoPerspectiveWords.scad` in [OpenSCAD](https://openscad.org/).
2. Set your desired word pair:

   ```openscad
   string_1 = "L♥VE";     // Viewed from the left
   string_2 = "HATE";     // Viewed from the right
   ```

3. Customize:
   - Font, letter size, spacing
   - `heart_scale` and `heart_vertical_shift` if using ♥
   - Set `include_baseplate = false;` to remove the base

4. Render and export to `.stl` for 3D printing.
## Printing Tips

When printing this model on a standard desktop FDM (extrusion-based) printer, keep the following in mind:

- **Supports are required** to successfully print the letters, which often have significant overhangs.
- Removing supports can be challenging. The letters and the attachment points of the letters to the base are relatively small and delicate, so it is important to remove supports carefully to avoid damaging them.
- To ensure durability, especially where letters intersect and connect to the baseplate, it is recommended to use a **high infill setting (e.g., 50%)**. This increases the strength of thin or intersecting parts and improves the overall robustness of the model.


## Files Included

- `TwoPerspectiveWords.scad` — Parametric OpenSCAD model
- `LoveHate.stl` — Love/Hate STL output

## License

This project is licensed under the [Creative Commons Attribution-NonCommercial 4.0 International License](https://creativecommons.org/licenses/by-nc/4.0/).  
You may use, remix, and print for personal or educational purposes, but **not for commercial sale**.
