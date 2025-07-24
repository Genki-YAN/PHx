# Get additional functions, etc.:
scriptPath <- "/jdfssz3/ST_STOMICS/P22Z10200N0661/wuyan/13.Hepatectomy/06.single_cell_integrate/script"
source(paste0(scriptPath, "/plotting_config.R"))
source(paste0(scriptPath, "/misc_helpers.R"))
source(paste0(scriptPath, "/matrix_helpers.R"))
source(paste0(scriptPath, "/archr_helpers.R"))

GSorce <- readRDS("Liver12_1009_subset_MotifMatrix.rds")
#metadata <- read.csv("/jdfssz3/ST_STOMICS/P22Z10200N0661/wuyan/13.Hepatectomy/07.subcluster/Liver12_1009_subcluster_Anno_sub_metadata.csv",header = TRUE,row.names = 1)
colData(GSorce)[,"bioSample"] <- as.character(colData(GSorce)[,"Time"])
colData(GSorce)[,"bioSample"][str_sub(as.character(colData(GSorce)[,"Sample"]), end = -3)=="D1-2"]="D1-2"
colData(GSorce)[,"bioSample"][str_sub(as.character(colData(GSorce)[,"Sample"]), end = -3)=="D1-3"]="D1-3"



#gsMatrix <- as.data.frame(t(as.data.frame(as.data.frame.matrix(GSorce@assays@data$GeneScoreMatrix))))

#gsMatrix$group <- metadata$Anno_sub

#print("step1")

#gsMatrixg <- aggregate(gsMatrix[,1:length(colnames(gsMatrix))-1], by=list(type=gsMatrix$group),mean)

#saveRDS(gsMatrixg,"Liver12_1009_GeneScoreMatrix_Anno_subaverage.rds")

GSM_mat <- assays(GSorce)[["z"]]
#GSM_mat <- assays(GSorce)$GeneScoreMatrix
rownames(GSM_mat) <- rowData(GSorce)$name

avgPctMat <- avgAndPctExpressed(GSM_mat,GSorce$bioSample, feature_normalize=TRUE, min_pct=0)
saveRDS(avgPctMat,"/jdfssz3/ST_STOMICS/P22Z10200N0661/wuyan/13.Hepatectomy/02.Project.raw.data/02.CallPeak/Liver12_1009_MotifMatrix_avgPctMat_bioSampletime.rds")
