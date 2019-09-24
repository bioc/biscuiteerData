metadata <- data.frame()

# Zhou, Dinh et al. Nature Genetics 2018 data
# hg19
zhou_hg19 <- c("Zhou_solo_WCGW_inCommonPMDs.hg19.rda",
               "Solo WCGWs living in hg19 common PMDs",
               "3.10",
               "hg19",
               "BED",
               "http://zwdzwd.io/pmd/solo_WCGW_inCommonPMDs_hg19.bed.gz",
               "19 September 2019",
               "Homo sapiens",
               "9606",
               "TRUE",
               "Wanding Zhou <zhouwanding@gmail.com>",
               "Tim Triche, Jr. <tim.triche@gmail.com>",
               "GRanges",
               "Rda",
               "biscuiteerData/v0.99.1/Zhou_solo_WCGW_inCommonPMDs.hg19.rda",
               "",
               ""
              )
pmd_hg19 <- c("PMDs.hg19.rda",
              "Common PMD locations in hg19 genome",
              "3.10",
              "hg19",
              "BED",
              "http://zwdzwd.io/pmd/PMD_coordinates_hg19.bed.gz",
              "19 September 2019",
              "Homo sapiens",
              "9606",
              "TRUE",
              "Wanding Zhou <zhouwanding@gmail.com>",
              "Tim Triche, Jr. <tim.triche@gmail.com>",
              "GRanges",
              "Rda",
              "biscuiteerData/v0.99.1/PMDs.hg19.rda",
              "",
              ""
             )
# hg38
zhou_hg38 <- c("Zhou_solo_WCGW_inCommonPMDs.hg38.rda",
               "Solo WCGWs living in hg38 common PMDs",
               "3.10",
               "hg38",
               "BED",
               "http://zwdzwd.io/pmd/solo_WCGW_inCommonPMDs_hg38.bed.gz",
               "19 September 2019",
               "Homo sapiens",
               "9606",
               "TRUE",
               "Wanding Zhou <zhouwanding@gmail.com>",
               "Tim Triche, Jr. <tim.triche@gmail.com>",
               "GRanges",
               "Rda",
               "biscuiteerData/v0.99.1/Zhou_solo_WCGW_inCommonPMDs.hg38.rda",
               "",
               ""
              )
pmd_hg38 <- c("PMDs.hg38.rda",
              "Common PMD locations in hg38 genome",
              "3.10",
              "hg38",
              "BED",
              "http://zwdzwd.io/pmd/PMD_coordinates_hg38.bed.gz",
              "19 September 2019",
              "Homo sapiens",
              "9606",
              "TRUE",
              "Wanding Zhou <zhouwanding@gmail.com>",
              "Tim Triche, Jr. <tim.triche@gmail.com>",
              "GRanges",
              "Rda",
              "biscuiteerData/v0.99.1/PMDs.hg38.rda",
              "",
              ""
             )

metadata <- rbind(metadata, zhou_hg19, stringsAsFactors=FALSE)
metadata <- rbind(metadata, pmd_hg19, stringsAsFactors=FALSE)
metadata <- rbind(metadata, zhou_hg38, stringsAsFactors=FALSE)
metadata <- rbind(metadata, pmd_hg38, stringsAsFactors=FALSE)

colnames(metadata) <- c("Title",
                        "Description",
                        "BiocVersion",
                        "Genome",
                        "SourceType",
                        "SourceUrl",
                        "SourceVersion",
                        "Species",
                        "TaxonomyId",
                        "Coordinate_1_based",
                        "DataProvider",
                        "Maintainer",
                        "RDataClass",
                        "DispatchClass",
                        "RDataPath",
                        "Tags",
                        "Notes"
                       )

metadata$BiocVersion <- as.numeric(metadata$BiocVersion)
metadata$TaxonomyId <- as.numeric(metadata$TaxonomyId)
metadata$Coordinate_1_based <- as.logical(metadata$Coordinate_1_based)

write.csv(metadata, file = "../extdata/metadata.csv", row.names = FALSE)
