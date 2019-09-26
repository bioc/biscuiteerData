---
title: "BiscuiteerData User Guide"
data: "25 September 2019"
package: "biscuiteerData 0.99.0"
output:
  BiocStyle::html_document:
    highlight: pygments
    toc_float: true
    fig_width: 8
    fig_height: 6
vignette: >
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteIndexEntry{Biscuiteer User Guide}
  %\VignetteEncoding[utf8]{inputenc}
---

# BiscuiteerData

`biscuiteerData` is a complementary package to the Bioconductor package
`biscuiteer`. It contains a handful of datasets to be used when running
functions in `biscuiteer`.

# Quick Start

## Installing

From Bioconductor,

```r
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("biscuiteerData")
```

A development version is available on GitHub and can be installed via:

```r
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("trichelab/biscuiteerData")
```

# Usage

`biscuiteerData` data is accessible using the `biscuiteerDataGet` function:

```r
library(biscuiteerData)
```

```
## Loading required package: ExperimentHub
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: parallel
```

```
## 
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:parallel':
## 
##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
##     clusterExport, clusterMap, parApply, parCapply, parLapply,
##     parLapplyLB, parRapply, parSapply, parSapplyLB
```

```
## The following objects are masked from 'package:stats':
## 
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
## 
##     anyDuplicated, append, as.data.frame, basename, cbind,
##     colnames, dirname, do.call, duplicated, eval, evalq, Filter,
##     Find, get, grep, grepl, intersect, is.unsorted, lapply, Map,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin,
##     pmin.int, Position, rank, rbind, Reduce, rownames, sapply,
##     setdiff, sort, table, tapply, union, unique, unsplit, which,
##     which.max, which.min
```

```
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
## Loading biscuiteerData.
```

```r
PMDs.hg19 <- biscuiteerDataGet("PMDs.hg19.rda")
```

A list of the titles for the available data can be retrieved via:

```r
biscuiteerDataList()
```

```
## snapshotDate(): 2019-09-25
```

```
## [1] "Zhou_solo_WCGW_inCommonPMDs.hg19.rda"
## [2] "PMDs.hg19.rda"                       
## [3] "Zhou_solo_WCGW_inCommonPMDs.hg38.rda"
## [4] "PMDs.hg38.rda"
```

A list of all versions (where the versions are the dates uploaded) is produced
via:

```r
biscuiteerDataListDates()
```

```
## snapshotDate(): 2019-09-25
```

```
## [1] "2019-09-25"
```

An older version of the data can be retrieved using the `dateAdded` argument of
`biscuiteerDataGet`:

```r
PMDs.hg19 <- biscuiteerDataGet("PMDs.hg19.rda", dateAdded = "2019-09-25")
```
