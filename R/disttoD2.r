

  ###########################
  #### function D2toDist ####
  ###########################


 disttoD2 <- function(distance){
   if (!inherits(distance,"D2")){
     if (!inherits(distance,"dist")&&!inherits(distance,"dissimilarity")) 
       stop("the distance matrix must be of class 'dist'/'dissimilarity")
     if (inherits(distance,"dissimilarity")&&attr(distance,"Metric")=="mixed")
      Delta <- as.matrix(distance)
     else
      Delta<-as.matrix(distance)^2
   }
   else
    Delta<-distance
   
   class(Delta)<-"D2"             
  return(Delta)
 }
