# inputs are matrix geneterated by ClustMarkMat and coresponding Seurat object
# generates violin plots for top 20 upregulated and down reg genes for each cluster and saves them in wd

GetVioPlotsTopAndBottomTwenty <- function(matrx, serobj){
  
  j <- 0.5*(ncol(matrx))
  
  lba <- colnames(matrx)
  
  for(l in 1:j ){ 
    
    lb <- lba[2*l-1]
    
    for(i in 1:10){
      gne <- matrx[i,(2*l-1)]
      fle <- paste("cluster ",lb, " ", gne, " up", ".pdf", sep = "" )
      pdf(fle)
      VlnPlot(serobj, gne)
      dev.off()
    }
    
    for(k in 91:100){
      gne <- matrx[k,(2*l-1)]
      fle <- paste("cluster ",lb, " ", gne, " down", ".pdf", sep = "" )
      pdf(fle)
      VlnPlot(serobj, gne)
      dev.off()
    }
  }
}

  
  
  
  
  
