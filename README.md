# Biodiversity

## Description
This app lets user visualize biodiversity in Poland. The data is taken from [Google Drive](https://drive.google.com/file/d/1l1ymMg-K_xLriFv1b8MgddH851d6n2sU/view?usp=sharing).

The polygons for the map come from [Poland map data](https://geodata.ucdavis.edu/gadm/gadm4.0/shp/gadm40_POL_shp.zip) and can be simplified with [rmapshaper](https://cran.r-project.org/package=rmapshaper). I used .05 as value for this but it was unable to keep the non UTF-8 names.

## Todo
- Error handling on initial load
- Edit sf object level 1 names to include non UTF-8 characters
- Randomize selection on load
- Get request to see if the observation has an associated picture of each observation -> add to popup.
