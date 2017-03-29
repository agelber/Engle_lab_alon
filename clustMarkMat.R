#returns matrix with top 100 differentially upregulated genes and downregulated genes
#for each cluster and the correcsponding differential expression

MakeClusterMatrix <- function(x){
  
nclusts <- length(levels(x@ident))
print(nclusts)


ClustMark <- matrix(nrow = 200, ncol= 2*nclusts)

v <- vector(mode = "character", length=2*nclusts)

for(i in 0:(nclusts-1)) { 
  nam <- levels(x@ident)[i+1]
  
  v[2*i+1] <- nam 
  v[2*i+2] <- "differential expression"
  
  
  marks <- FindMarkers(x, ident.1 = nam, min.pct = 0.25)
  
  marks <- marks[sort.list(marks[,"avg_diff"], decreasing = T), ]
  
  tot <- length(rownames(marks))
  tot1 <- tot-99
  
  ClustMark[1:100,2*i+1] <- rownames(marks)[1:100]
  ClustMark[101:200,2*i+1] <- rownames(marks)[tot1:tot]
  
  ClustMark[1:100,2*i+2] <- (marks[1:100,"avg_diff"])
  ClustMark[101:200,2*i+2] <- (marks[tot1:tot,"avg_diff"])
}

colnames(ClustMark) <- v
View(ClustMark)
return(ClustMark)
}
