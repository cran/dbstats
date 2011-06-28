

 ########################
 #### ldblm function ####
 ########################
 
 ## Description:
 ##     local linear distance-based Generalized Regression. Fit a polynomial 
 ##     surface determined by one or more numerical predictors, using local 
 ##     distance fitting. Cut short the range of the entry variables n times to 
 ##     approximate at each individual a linear model, with which estimate each 
 ##     Yi prediction. Modern regression methods are designed to address 
 ##     situations in which the classical procedures do not perform well or 
 ##     cannot be effectively applied without undue labor.
 ##        
 


    ################################
    #### dbglm of class formula ####
    ################################
    
ldblm.formula<-function(formula,data,...,kind.of.kernel=1,
              metric1="euclidean",metric2=metric1,method="GCV",weights,
              user_h=NULL,h.range=NULL,noh=10,k.knn=3,rel.gvar=0.95,
              eff.rank=NULL)
{ 
  # call dbglm
  mf <- match.call(expand.dots = FALSE)
  
  # control metric. See the auxiliar function
  metric1 <- control_metric(metric1)
  metric2 <- control_metric(metric2)  
  
  if (missing(data))
    data <- environment(formula)
  
  # recover z and y of the formula                            
  if (metric1=="gower"||metric2=="gower")
    zy <- formula_to_zy(formula,data,mf,"dblm","gower")
  else
    zy <- formula_to_zy(formula,data,mf,"dblm",metric1)
    
  # y and z are defined--> pass to default method (try for avoid the program crash). 
  try(ans<-ldblm.yz(y=zy$y,z=zy$z,kind.of.kernel=kind.of.kernel,
        method=method,weights=weights,metric1=metric1,metric2=metric2,
        user_h=user_h,h.range=h.range,noh=noh,k.knn=k.knn,rel.gvar=rel.gvar,
        eff.rank=eff.rank)) 
   
  if (class(ans)=="try-error") 
     return(paste("the program failed.Tries to read the help. If the error persists attempts to communicate with us "))
 
  # call dbglm
  ans$call<-mf
  attr(ans,"zs") <- zy$zini
 
  return(ans)  
}
      


    ################################
    #### default dbglm (y,z) #######
    ################################

ldblm.yz <- function(y,z,kind.of.kernel=1,metric1="euclidean",
        metric2=metric1,method="GCV",weights,user_h=NULL,h.range=NULL,
        noh=10,k.knn=3,rel.gvar=0.95,eff.rank=NULL,...)
{
  
   # See if z or distance matrix is defined by the user.
   require(cluster)
  
   # control metric. See the auxiliar function
   metric1 <- control_metric(metric1)
   metric2 <- control_metric(metric2)
  
   # call z_to_dist to pass the explanatory variables to an object of class dist 
   dist_and_way <- z_to_dist(z,metric1)
   dist1 <- dist_and_way$D
   dist2 <-  z_to_dist(z,metric2)$D
   way <- dist_and_way$way
  
   # if metric=gower. the distance matrix D is already the squared.
   if (metric1=="gower"){
    dist1 <-as.matrix(dist1)
    class(dist1) <- "D2"
   }
   if (metric2=="gower"){
    dist2 <-as.matrix(dist2)
    class(dist2) <- "D2"
   }     
      
   try(ans <- ldblm.dist(y=y,dist1=dist1,dist2=dist2,kind.of.kernel=kind.of.kernel,
     method=method,weights=weights,user_h=user_h,h.range=h.range,noh=noh,
     k.knn=k.knn,rel.gvar=rel.gvar,eff.rank=eff.rank)) 
  
   if (class(ans)=="try-error") 
    return(paste("the program failed.Tries to read the help. If the error persists attempts to communicate with us "))
  
   ans$call<-match.call(expand.dots = FALSE)
  
   # hidden attributes
   if (!missing(metric1))
    attr(ans,"metric1") <- metric1
   if (!missing(metric2))
    attr(ans,"metric2") <- metric2
   
   attr(ans,"zs")<-z
   attr(ans,"way")<- way
  
   # return ans
   return(ans)
}
                      


    #################################
    ####  ldblm with D2 distance ####
    #################################

ldblm.D2<-function(y,D2_1,D2_2=D2_1,kind.of.kernel=1,method="GCV",weights,
         user_h=NULL,h.range=NULL,noh=10,k.knn=3,rel.gvar=0.95,
         eff.rank=NULL,...){
    
   # stop if class of distance matrix is not D2      
   if (class(D2_1)[1]!="D2")
    stop("for a ldblm.D2 method the class of the distance matrix D2_1 must be 'D2'")
   if (class(D2_2)[1]!="D2")
    stop("for a ldblm.D2 method the class of the distance matrix D2_2 must be 'D2'")    
   
   # y and Distance are defined--> pass to dist method (try for avoid the program crash). 
   try(ans <- ldblm.dist(y=y,dist1=D2_1,dist2=D2_2,kind.of.kernel=kind.of.kernel,
              method=method,weights=weights,user_h=user_h,h.range=h.range,
              noh=noh,k.knn=k.knn,rel.gvar=rel.gvar,eff.rank=eff.rank))    
   if (class(ans)=="try-error")
    return(paste("the program failed.Tries to read the help. If the error persists attempts to communicate with us "))
   
   ans$call <- match.call(expand.dots = FALSE) 
   # hidden attributes  
   attr(ans,"way") <- "D2"  
   return(ans)
}
     
     
     

    ##########################
    ####  ldblm with Gram ####
    ##########################

ldblm.Gram <- function(y,G1,G2=G1,kind.of.kernel=1,method="GCV",weights,
         user_h=NULL,h.range=NULL,noh=10,k.knn=3,rel.gvar=0.95,
         eff.rank=NULL,...){
    
   # stop if class of distance matrix is not D2      
   if (class(G1)[1]!="Gram")
    stop("for a ldblm.Gram method the class of the distance matrix G1 must be 'Gram'")
   if (class(G2)[1]!="Gram")
    stop("for a ldblm.Gram method the class of the distance matrix G2 must be 'Gram'")   
   
   # converts G to D2
   D2_1 <- GtoD2(G1)
   D2_2 <- GtoD2(G2) 
   
   # y and Distance are defined--> pass to dist method (try for avoid the program crash). 
   try(ans <- ldblm.dist(y=y,dist1=D2_1,dist2=D2_2,kind.of.kernel=kind.of.kernel,
              method=method,user_h=user_h,h.range=h.range,noh=noh,k.knn=k.knn,
              rel.gvar=rel.gvar,eff.rank=eff.rank))    
   if (class(ans)=="try-error")
    return(paste("the program failed.Tries to read the help. If the error persists attempts to communicate with us "))
   
   ans$call <- match.call(expand.dots = FALSE) 
   # hidden attributes  
   attr(ans,"way") <- "G" 
   attr(ans,"G1") <- G1 
   attr(ans,"G2") <- G2 
    
   return(ans)
}



    #################################
    ####    dbglm with Dist or   ####
    ####  dissimilarity distance ####
    #################################

ldblm.dist <- function(y,dist1,dist2=dist1,kind.of.kernel=1,method="GCV",
           weights,user_h=quantile(dist1,.25)^.5, 
           h.range=quantile(as.matrix(dist1),c(.05,0.5))^.5,noh=10,k.knn=3,
           rel.gvar=0.95,eff.rank=NULL,...){
          

    # control method. See the auxiliar function
    method <- control_method(method,"ldblm")  
   
    # another controls: see the auxiliar function
    controls <- controls_ldblm(dist1,dist2,user_h,method,h.range,noh,k.knn,
            kind.of.kernel,y,weights)
    dist1 <- controls$dist1
    dist2 <- controls$dist2
    user_h <- controls$user_h
    h.range <- controls$h.range
    weights <- controls$weights
    ori_weights <- weights
    weights <- weights/sum(weights)
     
   # sequence of bandwidth to be evaluate
   if (method!="user_h"){
     h_low <- h.range[1]
     h_up <- h.range[2]
     h_vec <- exp(seq(log(h_low),log(h_up),length=noh))
   }
   n <- length(y) 

   # k.knn: three nearest neigbourh
   h.knn<-h.knn.funct(dist1^.5,k=k.knn)
   
   # compute the model for each method
   if (method!="user_h"){

    if (method=="OCV") OCV <- rep(0,noh) # OCV's for each h(only if method==OCV)
    if (method=="GCV") GCV <- rep(0,noh) # GCV's for each h(only if method==GCV)
    if (method=="AIC") AIC <- rep(0,noh) # AIC's for each h(only if method==AIC)
    if (method=="BIC") BIC <- rep(0,noh) # BIC's for each h(only if method==BIC)
    
    i <- 0
    for (h in h_vec){
      # fitted values and Shat for each bandwidth (h) 
      aux <-pred.train.sample(y,dist1,dist2,n,h,h.knn,kind.of.kernel,ori_weights,
                    rel.gvar,eff.rank) 
      i <- i+1
      S <- aux$Shat
      fitted.values <- aux$yhat
      diagS <- diag(S)
      nu <- sum(diagS)
      
      # Ordinary cross validation criterium to choose the best bandwidth.
      if (method=="OCV"){
        OCV[i] <-  sum(weights*((y-fitted.values)/(1-diagS))^2 ) # ocv formula
         if (is.nan(OCV[i]))
          stop(paste("OCV for the bandwidth ",round(h,5), " is a NaN. Try to use another method or h.range"))
         
         if (i==1){
         OCV_opt <- OCV[i]
         h_opt <- h
         S_opt <- S
         yhat_opt<-fitted.values
        }else{
         if (OCV_opt > OCV[i]){ # improve the best ocv
            OCV_opt <- OCV[i]   # edit the ocv optim
            h_opt <- h          
            S_opt <- S
            yhat_opt<-fitted.values
         }
        }
     }else OCV_opt<-NULL
        
     # Generalized cross validation criterium to choose the best bandwidth.
      if (method=="GCV"){
      
        GCV[i] <-sum(weights*(fitted.values-y)^2)/(n*(1-nu/n)^2)   # gcv formula
        if (is.nan(GCV[i]))
          stop(paste("GCV for the bandwidth ",round(h,5), " is a NaN. Try to use another method or h.range"))
        if (i==1){
         GCV_opt <- GCV[i]
         h_opt <- h
         S_opt <- S
         yhat_opt<-fitted.values
        }else{
         if (GCV_opt > GCV[i]){   # improve the best gcv
            GCV_opt <- GCV[i]     # edit the gcv optim
            h_opt <- h
            S_opt <- S
            yhat_opt<-fitted.values
         }
        }
     }else GCV_opt<-NULL

     # Aikaike criterium to choose the best bandwidth.
      if (method=="AIC"){
        rss<-sum(ori_weights*(fitted.values-y)^2)/n   # residual standard desviation
        AIC[i]<-2*sum(diag(S))+n*log(rss)   # aic formula

        if (i==1){
         AIC_opt <- AIC[i]
         h_opt <- h
         S_opt <- S
         yhat_opt<-fitted.values
        }else{
         if (AIC_opt > AIC[i]){  # improve the best aic
            AIC_opt <- AIC[i]    # edit the aic optim
            h_opt <- h
            S_opt <- S
            yhat_opt<-fitted.values
         }
        }
     }else AIC_opt<-NULL

     # Bayesian criterium to choose the best bandwidth.
      if (method=="BIC"){
        rss<-sum(ori_weights*(fitted.values-y)^2)/n       # residual standard desviation
        BIC[i]<-n*log(rss)+log(n)*sum(diag(S))  # bic formula

        if (i==1){
         BIC_opt <- BIC[i]
         h_opt <- h
         S_opt <- S
         yhat_opt<-fitted.values
        }else{
         if (BIC_opt > BIC[i]){      # improve the best bic
            BIC_opt <-BIC[i]         # edit the bic optim
            h_opt <- h
            S_opt <- S
            yhat_opt<-fitted.values
         }
        }
       }else BIC_opt<-NULL
     }
    }
    
    # if method=user_h --> the model is estimated with the h bandwidth defined by the user
    if (method=="user_h"){
      # fitted values and Shat for user_h bandwidth
      aux <-pred.train.sample(y,dist1,dist2,n,h=user_h,h.knn,kind.of.kernel,ori_weights,
              rel.gvar,eff.rank)    
      S <- aux$Shat
      yhat_opt <- aux$yhat
      h_opt<-user_h
      
      OCV_opt<-NULL
      GCV_opt<-NULL
      AIC_opt<-NULL
      BIC_opt<-NULL
    }


    call<- match.call(expand.dots = FALSE)

    # return the next attributes 
    ans<-list(residuals=y-yhat_opt,fitted.values=yhat_opt,h_opt=h_opt,Shat=S,
              y=y,weights=weights,call=call,dist1=dist1,dist2=dist2) 
    
    attr(ans,"kind.of.kernel")<-kind.of.kernel             
    attr(ans,"method")<-method
    attr(ans,"dist1")<-dist1
    attr(ans,"dist2")<-dist2
    attr(ans,"OCV_opt")<-OCV_opt
    attr(ans,"GCV_opt")<-GCV_opt
    attr(ans,"AIC_opt")<-AIC_opt
    attr(ans,"BIC_opt")<-BIC_opt   
    attr(ans,"noh")<-noh  
    attr(ans,"way")<-"D2"   
    attr(ans,"rel.gvar")<-rel.gvar
    attr(ans,"eff.rank")<-eff.rank
    
    if (method!="user_h") attr(ans,"h_vec")<-h_vec  
    if (method=="OCV") attr(ans,"OCV")<-OCV
    if (method=="GCV") attr(ans,"GCV")<-GCV
    if (method=="AIC") attr(ans,"AIC")<-AIC
    if (method=="BIC") attr(ans,"BIC")<-BIC
   
    class(ans)<-"ldblm"
    return(ans)
 }
  
  
   ldblm<-function(y,...)  #generic function with a commun paramatre (y).
  UseMethod("ldblm")