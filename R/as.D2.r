

  ########################
  #### function as.D2 ####
  ########################


 as.D2 <- function(x){
 
   Delta = as.matrix(x)
   class(Delta)<-"D2"
 
   return(Delta)
 }
