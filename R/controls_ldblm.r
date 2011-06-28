
 ########################
 #### controls_ldblm #####
 ########################

 ## description: Internal function. Check if the attributes are consistents.
 ##
 ##        Inputs:  distance, weights, eff.rank, rel.gvar, method and y.
 ##        Outputs: eff.rank
 ##


controls_ldblm <- function(dist1,dist2,user_h,method,h.range,noh,k.knn,
                    kind.of.kernel,y,weights)
{

   # program controls: weights
   if (missing(weights)||is.null(weights))
    weights<-rep(1,nrow(as.matrix(y)))
   if (!is.null(weights) && !is.numeric(weights))
    stop("'weights' must be a numeric vector")
   if (sum(weights<0)>0)
    stop("Weights array weights is not valid: some weights are negative")
   if (sum(weights)==0)
    stop("Weights array weights is not valid: sum(weights)=0")
    
     # Controls of dist class
    if (class(dist1)[1]!="D2"){
     if (class(dist1)[1]!="dist"&&class(dist1)[1]!="dissimilarity")
       stop("the distance matrix dist1 must be of class 'dist'/'dissimilarity")
     if (class(dist1)[1]=="dissimilarity"&&attr(dist1,"Metric")=="mixed")
     dist1 <- as.matrix(dist1)
     else 
      dist1<-as.matrix(dist1)^2
     class(dist1)<-"D2"
    }
    if (class(dist2)[1]!="D2"){
     if (class(dist2)[1]!="dist"&&class(dist2)[1]!="dissimilarity")
       stop("the distance matrix dist2 must be of class 'dist'/'dissimilarity")
     if (class(dist2)[1]=="dissimilarity"&&attr(dist2,"Metric")=="mixed")
      dist2 <- as.matrix(dist2)
     else 
      dist2<-as.matrix(dist2)^2
     class(dist2)<-"D2"
    }

    # controls: user_h
    if(is.null(user_h)&&method=="user_h")
     user_h<-quantile(as.dist(dist1)^.5,.25)
    if (user_h<=0&&method=="user_h")
     stop("user_h must be upper than 0")                 

    # controls: h.range
    if(is.null(h.range)&&method!="user_h")
     h.range<-quantile(as.dist(dist1),c(.05,0.5))^.5
    if (method!="user_h"&&length(h.range)!=2)
     stop("h.range must be a numeric vector of lenght two")

    # controls: y and dist1, dist2
      # program controls: y
    if (missing(y)||is.null(y))
     stop("the response variable must be defined")
    if (!is.numeric(y)&&!is.data.frame(y)&&!is.matrix(y)&&!is.factor(y))
     stop("the response 'y' must be numeric, data.frame, matrix or a factor")
    
    if (nrow(as.matrix(y))!=nrow(as.matrix(dist1))) {
     stop(gettextf("The dimensions of the distance matrix dist1: nrow=ncol= %d, should equal %d (number of observations)",
                nrow(as.matrix(dist1)),nrow(as.matrix(y))))
    }
    if (nrow(as.matrix(y))!=nrow(as.matrix(dist2))){
     stop(gettextf("The dimensions of the distance matrix dist2: nrow=ncol= %d, should equal %d (number of observations)",
                nrow(as.matrix(dist2)),nrow(as.matrix(y))))
    }

    # controls: noh, k.knn, method and kind of kernel
    if (length(noh)<=0)
     stop("noh must be positive")
    if (k.knn<2)
     stop("k.knn must be > 1")
    if ((kind.of.kernel!=1)&&(kind.of.kernel!=2)&&(kind.of.kernel!=3)
        &&(kind.of.kernel!=4)&&(kind.of.kernel!=5)&&(kind.of.kernel!=6))
      stop("kind of kernel must be a natural number between 1 and 6")
      
   return(list(dist1=dist1,dist2=dist2,user_h=user_h,h.range=h.range,weights=weights))
 }