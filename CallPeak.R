#.libPaths("/jdfssz1/ST_SUPERCELLS/P21Z10200N0090/USER/haoshijie/software/Miniconda3/lib/R/library")

library(ArchR)
library(patchwork)
library(BSgenome.Mmusculus.UCSC.mm10)
addArchRThreads(threads = 16)
addArchRGenome("mm10")

library(ggsci)

projI_L <- loadArchRProject(path = "/jdfssz3/ST_STOMICS/P22Z10200N0661/wuyan/13.Hepatectomy/07.subcluster/01.remove1314_subcluster/Save-callpeak_Liver12_1009", force = FALSE, showLogo = FALSE)

tmp <- getMatrixFromProject(
  ArchRProj = projI_L,
  useMatrix = "GeneScoreMatrix",
  useSeqnames = NULL,
  verbose = TRUE,
  binarize = FALSE,
  threads = getArchRThreads(),
  logFile = createLogFile("getMatrixFromProject")
)

saveRDS(tmp,"Liver12_1009_subset_GeneScoreMatrix.rds")

projI_L_2 <- addGroupCoverages(ArchRProj = projI_L, groupBy = "Anno_sub")

pathToMacs2 <- findMacs2()

projI_L_2 <- addReproduciblePeakSet(
    ArchRProj = projI_L_2, 
    groupBy = "Anno_sub", 
    pathToMacs2 = pathToMacs2
)

projI_L_2 <- addPeakMatrix(projI_L_2)


markersPeaks1 <- getMarkerFeatures(
    ArchRProj = projI_L_2,
    useMatrix = "PeakMatrix",
    groupBy = "Sample",
  bias = c("TSSEnrichment", "log10(nFrags)"),
  testMethod = "wilcoxon"
)

markersPeaks2 <- getMarkerFeatures(
    ArchRProj = projI_L_2,
    useMatrix = "PeakMatrix",
    groupBy = "Anno_sub",
  bias = c("TSSEnrichment", "log10(nFrags)"),
  testMethod = "wilcoxon"
)

saveRDS(markersPeaks1,"markersPeaks1_sample_Liver12_1009.rds")
saveRDS(markersPeaks2,"markersPeaks2_Anno_sub_Liver12_1009.rds")

saveArchRProject(ArchRProj = projI_L_2, outputDirectory = "Save-callpeak_Liver12_1009_subset", load = FALSE)
