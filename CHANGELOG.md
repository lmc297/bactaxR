# bactaxR CHANGELOG

All noteable changes to bactaxR will be documented in this file

## [0.2.3] 2024-01-30

### Added
- Added the ability to specify any hclust agglomeration method in `ANI.dendrogram` (default is "average", which was previously hard-coded as the hclust method).

## [0.2.2] 2022-10-06

### Added
- Added `ladderize` and `ladderize_right` parameters to the `phylo.discrete_trait_OTU` function.

## [0.2.1] 2022-06-03

### Added
- Added `font_angle` and `font_offset_y` parameters to the `phylo.discrete_trait_heatmap` function.

## [0.2.0] 2022-05-29

### Changed
- Fixed legend color order bug in `ANI.graph` function; in bactaxR v0.1.0, `ANI.graph` would assign colors to graph nodes by converting user-supplied metadata to a factor, converting resulting factors to numeric values, and then supplying the color palette with the numeric values, i.e., `vertex.color = color_palette[as.numeric(as.factor(vertex_attr(ig, "species")))],`. This resulted in colors in the legend sometimes not matching the plotted colors. To correct this, ordered levels are now explicitly used, i.e., `vertex.color = color_palette[as.numeric(factor(vertex_attr(ig, "species"), levels = sorted_labels))]`, where `sorted_labels <- unique(vertex_attr(ig, "species"))`.

## [0.1.0] 2020-01-24

### Added
- Initial commit

