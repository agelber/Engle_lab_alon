# compares two clusters, can be from different or second objects
# inputs are first seuart object, cluter for first seurat object, second seuart object, cluter for second seurat object
# returns list of vectors, [upregulated shared genes, downregulated shared genes]

HowSimilar <- function(firstobj, clust1, secobj, clust2){
  sumry <- vector(mode = "numeric", 6) 
  marks1 <- FindMarkers(firstobj, ident.1 = clust1, min.pct = 0.25)
  marks2 <- FindMarkers(secobj, ident.1 = clust2, min.pct = 0.25)
  
  #Get upregulated genes for first obj
  t1 <- (marks1[,2]>0)
  mark1up <- rownames(marks1)
  mark1up <- mark1up[t1]
  
  #Get downregulated genes for first obj
  t1 <- (marks1[,2]<0)
  mark1down <- rownames(marks1)
  mark1down <- mark1down[t1]
  
  #Get number of up and down genes for first obj;  will use shorter list in comparison
  l1u <-  length(mark1up)
  l1d <- length(mark1down)
  sumry[1] <- l1u
  sumry[4] <- l1d
  
  #Get upregulated genes for second obj
  t1 <- (marks2[,2]>0)
  mark2up <- rownames(marks2)
  mark2up <- mark2up[t1]
  
  #Get downregulated genes for second obj
  t1 <- (marks2[,2]<0)
  mark2down <- rownames(marks2)
  mark2down <- mark2down[t1]
  
  #Get number of up and down genes for second obj
  l2u <-  length(mark2up)
  l2d <- length(mark2down)
  sumry[2] <- l2u
  sumry[5] <- l2d
  
  #analyze upregulated genes
  if(l1u >= l2u) {checkfr <- mark2up
    checkto <- mark1up
    len1 <- l2u
  }
  
  else {
    checkfr <-  mark1up
    checkto <- mark2up
    len1 <- l1u
  }
  j <- 0
  
  for(i in 1:len1 ){
    if(checkfr[i] %in% checkto){
      j <- j+1
    }
    
  }
  
  upregShared <- vector(mode = "character", j)
  
  b<-1
  
  for(i in 1:len1 ){
    if(checkfr[i] %in% checkto){
      upregShared[b] <- checkfr[i]
      b <- b+1
    }
    
    if(b==j+1){ break}
    
  }
  
  sumry[3] <- j
  
  #analyze downregulated genes
  if(l1d >= l2d) {checkfr <- mark2down
  checkto <- mark1down
  len1 <- l2d
  }
  
  else {
    checkfr <-  mark1down
    checkto <- mark2down
    len1 <- l1d
  }
  
  j <- 0
  
  for(i in 1:len1 ){
    if(checkfr[i] %in% checkto){j <- j+1}
  }
  
  downregShared <- vector(mode = "character", j)
  
  b<-1
  
  for(i in 1:len1 ){
    if(checkfr[i] %in% checkto){
      downregShared[b] <- checkfr[i]
      b <- b+1
    }
    
    if(b==j+1){ break}
    
  }
  
  sumry[6] <- j
  
  #summary
  
  m <- paste(" cluster", clust1 , "of" , deparse(substitute(firstobj)), "has", sumry[1], "upregulated genesand", sumry[2], "downregulated genes\n",
             "cluster", clust2 , "of" ,deparse(substitute(firstobj)), "has", sumry[4], "upregulated genes and", sumry[5], "downregulated genes\n",
             "they share", sumry[3], "upregulated genes and", sumry[6], "downregulated genes \n", sep=" "  )
  cat(m)
  
  return(list(upregShared, downregShared))
  
  
}
