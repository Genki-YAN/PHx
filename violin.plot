ng <- "Sox9"
tmp1 <- cbind(phxobj8h@meta.data[,c("coor_x","coor_y","Cluster")],phxobj8h@assays$RNA@data[ng,])
names(tmp1) <- c("coor_x","coor_y","group","gene")
tmp1$group <- factor(tmp1$group,levels = c("2","1"))
#tmp1$pugene <- tmp1$gene+0.1
options(repr.plot.width=8,repr.plot.height=4)
p1 <- ggplot(data = tmp1[tmp1$gene>0,],aes(group,gene))+
geom_violin(aes(fill = group),scale = "width",trim = FALSE,adjust = 1.2,kernel = "triangular")+
#geom_boxplot(aes(fill = group),outlier.shape = NA)+
ylab(ng)+theme_bw()+
scale_fill_manual(values = c("#7b2134","#fefdf7","#9ecae1"))+
#stat_compare_means(aes(label = ..p.signif..),comparisons = comparison,method = "t.test")+
stat_summary(fun=mean, geom="crossbar", width=0.5, color="black")
p2 <- ggplot(data = tmp1,aes(group,gene))+
geom_violin(aes(fill = group),scale = "width",trim = FALSE,adjust = 1.2,kernel = "triangular")+
#geom_boxplot(aes(fill = group),outlier.shape = NA)+
ylab(ng)+theme_bw()+
scale_fill_manual(values = c("#bb3451","#fff1e2","#9ecae1"))+
stat_compare_means(aes(label = ..p.signif..),comparisons = comparison,method = "t.test")+
stat_summary(fun=mean, geom="crossbar", width=0.5, color="black")
print(p1|p2)
