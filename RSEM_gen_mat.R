RSEM_gen_mat <- function(){
  
#get inputs
b <- readline(prompt="Enter RSEM file type : isoforms or genes? ")
if(b=="genes") {n <- readline(prompt="Enter directory path (from working directory) containing only your .genes.results files: ")}
if(b=="isoforms") {n <- readline(prompt="Enter directory path (from working directory) containing only your .isoforms.results files: ")}

l <- readline(prompt="What metric would you like? ( enter: expected_count, TPM, or FPKM): ")

#get file list 
g <- getwd()
g <- paste(g, "/", n, sep = "")
file_list <- list.files(g)
size <- length(file_list)
i <- 1
v <- vector(mode = "character", length=size)
pb   <- txtProgressBar(1, size, style=3)

#loop through directory and make matrix

for (f in file_list){
  t <- paste(g, "/", f, sep = "")
  m <- as.matrix(read.table(t ,header = T))
  
  if(i==1){
    out <- matrix( nrow = nrow(m), ncol = size)
    rownames(out) <- m[,1]
  }
  
  if (b=="genes"){ v[i] <- gsub(".genes.results", "", f)}
  if (b == "isoforms") {v[i] <- gsub(".isoforms.results", "", f)}
    
  out[,i] <- m[,l]
  
  setTxtProgressBar(pb, i)
  
  i <- i+1
}

colnames(out) <- v
class(out) <- "numeric"
return(out)
}