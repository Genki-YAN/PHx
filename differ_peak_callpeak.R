.libPaths("/jdfssz1/ST_SUPERCELLS/P21Z10200N0090/USER/haoshijie/software/Miniconda3/lib/R/library")

library(ArchR)
library(patchwork)
library(BSgenome.Mmusculus.UCSC.mm10)
addArchRThreads(threads = 16)
addArchRGenome("mm10")

library(ggsci)

projI_L <- loadArchRProject(path = "Save-callpeak_Liver12_1009", force = FALSE, showLogo = FALSE)

projI_L@cellColData$Anno_sub <- projI_L@cellColData$Anno
projI_L@cellColData$Anno_sub[projI_L@cellColData$HarmonyClusters=="C3"] <- "PV_ISdis"
projI_L@cellColData$Anno_sub[projI_L@cellColData$HarmonyClusters=="C1"] <- "PV_23"
projI_L@cellColData$Anno_sub[projI_L@cellColData$HarmonyClusters=="C2"] <- "Hep_IS"
projI_L@cellColData$Anno_sub[projI_L@cellColData$HarmonyClusters=="C4"] <- "CV_ISd"
projI_L@cellColData$Anno_sub[projI_L@cellColData$HarmonyClusters=="C5"] <- "CV_ISi"
projI_L@cellColData$Anno_sub[projI_L@cellColData$HarmonyClusters=="C9"] <- "CV_ISsh"

markersPeaks1 <- getMarkerFeatures(
    ArchRProj = projI_L,
    useMatrix = "PeakMatrix",
    groupBy = "Anno_sub",
  bias = c("TSSEnrichment", "log10(nFrags)"),
  testMethod = "wilcoxon"
)

saveRDS(markersPeaks1,"markersPeaks1_Anno_sub_Liver12_1009.rds")
