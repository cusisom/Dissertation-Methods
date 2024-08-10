setwd("C:/Users/danny/Documents/git/Dissertation-Methods/Coordinate-Data/Data")
require(geomorph)
require(SlicerMorphR)

SM.log.file = "Analysis 8-9/analysis.log"
SM.log <- parser(SM.log.file)
head(SM.log)

SM.output <- read.csv(file=paste(SM.log$output.path,
SM.log$OutputData,
sep = "/"))

SlicerMorph.PCs <- read.table(file = paste(SM.log$output.path,
SM.log$pcScores,
sep="/"),
sep=",", header = TRUE, row.names=1)

PD <- SM.output[,2]
if (!SM.log$skipped) {
no.LM <- SM.log$no.LM
} else {
no.LM <- SM.log$no.LM - length(SM.log$skipped.LM)
}

##Building Array
Coords <- arrayspecs(SM.output[,-c(1:3)],
p=no.LM,
k=3)

dimnames(Coords) <- list(1:no.LM,
c("x","y","z"),
SM.log$ID)

d1array.gpa <- gpagen(Coords, print.progress=FALSE)

summary(d1array.gpa)

Mshape.Coords<-mshape(Coords)
head(Mshape.Coords)

d1.pca<-gm.prcomp(d1array.gpa$coords)
plot(d1.pca)


 SlicerMorph.MS <- read.table(file = paste(SM.log$output.path,
                                            SM.log$MeanShape,
                                            sep="/"),
                               sep=",", header = TRUE, row.names=1)