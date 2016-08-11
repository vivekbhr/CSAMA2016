setwd('2016_HiC/diffHic/')

all.regions <- GRanges("chrA", IRanges(0:9*10+1, 1:10*10))
index.1 <- 1:10
index.2 <- 1:10
region.1 <- all.regions[index.1]
region.2 <- all.regions[index.2]

gi <- GInteractions(region.1, region.2)
anchors(gi)
regions(gi)

## some random changes
temp.gi <- gi
annotation <- rep(c("E", "P", "N"), length.out=6)
regions(temp.gi)$anno <- annotation

anchors(temp.gi)
norm.freq <- rnorm(length(gi)) # obviously, these are not real frequencies.
gi$norm.freq <- norm.freq
mcols(gi)

lib.dat <- read.delim("2016_HiC/test_tools/chr1.RAWobserved", header = FALSE)

mydata <- read.delim("test.tsv", header=FALSE)
region1 <- GRanges(mydata$V1, IRanges(mydata$V2, mydata$V3))
region2 <- GRanges(mydata$V4, IRanges(mydata$V5, mydata$V6))
gi <- GInteractions(region1, region2, mode = "strict")
gi$norm.freq <- mydata$V7

lib.data <- DataFrame(lib.size=seq_len(1)*1e6)
iset <- InteractionSet(as.matrix(gi$norm.freq), gi, colData=lib.data)

cm <- inflate(gi, 2:10, 1:5, fill=gi$norm.freq)
anchors(cm, id=TRUE)
as.matrix(cm)
