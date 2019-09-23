# Load libraries
library(plyr)
library(dplyr)
library(data.table)
library(GenomicRanges)


#####--------------------------------------------------------------------------
#
# Annotation data from Zhou, Dinh et al. Nature Genetics 2018
# Both hg19 and hg38 reference genome data is retrieved
#
#####--------------------------------------------------------------------------
download_solo_wcgws_hg19 <- function() {
  # Download solo WCGWs in common PMDs for hg19 genome
  tmp_wcgw <- tempfile(fileext=".bed.gz")
  download.file(url="http://zwdzwd.io/pmd/solo_WCGW_inCommonPMDs_hg19.bed.gz",
                destfile=tmp_wcgw)
  wcgw19 <- fread(file=tmp_wcgw,
                  col.names=c("chr","start","end",
                              "zero", "frac", "four", "six", "wcgw",
                              "region")
                 )
  file.remove(tmp_wcgw)
  setDT(wcgw19)[, c("pmd","num") := tstrsplit(region, "|", fixed=TRUE)]
  
  # Download PMD locations for hg19
  # Subset for only "commonPMD"s
  tmp_pmd <- tempfile(fileext=".bed.gz")
  download.file(url="http://zwdzwd.io/pmd/PMD_coordinates_hg19.bed.gz",
                destfile=tmp_pmd)
  pmd19 <- fread(file=tmp_pmd,
                 col.names=c("chr","start","end","fraction","PMD/HMD",
                             "in_common")
                )
  pmd19 <- pmd19[pmd19$in_common == "commonPMD"]
  file.remove(tmp_pmd)
  
  # Add PMD names to common PMDs
  nPMDS <- as.list(table(pmd19$chr))
  name <- c()
  for (i in seq_len(length(nPMDS))) {
    name <- c(name, paste0(names(nPMDS[i]),"_PMD",1:nPMDS[[i]]))
  }
  pmd19$name <- name
  
  # Create pmd column to match with the pmd column in wcgw19
  pmd19$pmd <- paste0(pmd19$chr,":",pmd19$start,"-",pmd19$end)
  
  # Join pmd19 and wcgw19
  joined <- left_join(wcgw19, pmd19, by="pmd")
  
  # Keep only the necessary columns
  keepers <- c("chr.x","start.x","end.x","name")
  joined <- subset(joined, select=keepers)
  colnames(joined) <- c("chr","start","end","PMD")
  
  # Create a GRanges of the common PMDs
  keepers <- c("chr","start","end","name","fraction")
  remaining <- subset(pmd19, select=keepers)
  PMDs.hg19 <- makeGRangesFromDataFrame(remaining,
                                        keep.extra.columns=TRUE,
                                        starts.in.df.are.0based=TRUE)
  names(mcols(PMDs.hg19)) <- c("name","score")
  save(PMDs.hg19, file="PMDs.hg19.rda", compress="xz")

  # Create the GRanges object, name the entries, and sort by chromosome
  gr <- makeGRangesFromDataFrame(joined,
                                 keep.extra.columns=TRUE,
                                 starts.in.df.are.0based=TRUE)
  names(gr) <- paste0("WCGW_", seq_len(length(gr)))
  Zhou_solo_WCGW_inCommonPMDs.hg19 <- sort(gr)
  save(Zhou_solo_WCGW_inCommonPMDs.hg19,
       file="Zhou_solo_WCGW_inCommonPMDs.hg19.rda", compress="xz")
  return(Zhou_solo_WCGW_inCommonPMDs.hg19)
}


download_solo_wcgws_hg38 <- function() {
  # Download solo WCGWs in common PMDs for hg38 genome
  tmp_wcgw <- tempfile(fileext=".bed.gz")
  download.file(url="http://zwdzwd.io/pmd/solo_WCGW_inCommonPMDs_hg38.bed.gz",
                destfile=tmp_wcgw)
  wcgw38 <- fread(file=tmp_wcgw,
                  col.names=c("chr","start","end",
                              "zero", "frac", "four", "six", "wcgw")
                 )
  file.remove(tmp_wcgw)
  wcgw38$pmd <- paste0(wcgw38$chr, ":",
                       as.integer(round_any(wcgw38$start,100000,floor)), "-",
                       as.integer(round_any(wcgw38$end,100000,ceiling)))
  
  # Download PMD locations for hg38
  # Subset for only "commonPMD"s
  tmp_pmd <- tempfile(fileext=".bed.gz")
  download.file(url="http://zwdzwd.io/pmd/PMD_coordinates_hg38.bed.gz",
                destfile=tmp_pmd)
  pmd38 <- fread(file=tmp_pmd,
                 col.names=c("chr","start","end","fraction","PMD/HMD",
                             "in_common")
                )
  pmd38 <- pmd38[pmd38$in_common == "commonPMD"]
  file.remove(tmp_pmd)
  
  # Add PMD names to common PMDs
  nPMDS <- as.list(table(pmd38$chr))
  name <- c()
  for (i in seq_len(length(nPMDS))) {
    name <- c(name, paste0(names(nPMDS[i]),"_PMD",1:nPMDS[[i]]))
  }
  pmd38$name <- name
  
  # Create pmd column to match with the pmd column in wcgw38
  pmd38$pmd <- paste0(pmd38$chr,":",pmd38$start,"-",pmd38$end)
  
  # Join pmd38 and wcgw38
  joined <- left_join(wcgw38, pmd38, by="pmd")
  
  # Keep only the necessary columns
  keepers <- c("chr.x","start.x","end.x","name")
  joined <- subset(joined, select=keepers)
  colnames(joined) <- c("chr","start","end","PMD")
  
  # Create a GRanges of the common PMDs
  keepers <- c("chr","start","end","name","fraction")
  remaining <- subset(pmd38, select=keepers)
  PMDs.hg38 <- makeGRangesFromDataFrame(remaining,
                                        keep.extra.columns=TRUE,
                                        starts.in.df.are.0based=TRUE)
  names(mcols(PMDs.hg38)) <- c("name","score")
  save(PMDs.hg38, file="PMDs.hg38.rda", compress="xz")

  # Create the GRanges object, name the entries, and sort by chromosome
  gr <- makeGRangesFromDataFrame(joined,
                                 keep.extra.columns=TRUE,
                                 starts.in.df.are.0based=TRUE)
  names(gr) <- paste0("WCGW_", seq_len(length(gr)))
  Zhou_solo_WCGW_inCommonPMDs.hg38 <- sort(gr)
  save(Zhou_solo_WCGW_inCommonPMDs.hg38,
       file="Zhou_solo_WCGW_inCommonPMDs.hg38.rda", compress="xz")
  return(Zhou_solo_WCGW_inCommonPMDs.hg38)
}

download_solo_wcgws_hg19()
download_solo_wcgws_hg38()
