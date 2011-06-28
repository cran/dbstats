

 ########################
 #### function dbglm ####
 ########################
 
 ## Description:  Weighted generalized distance-based regression. There are 
 ##        4 different calls to the function dbglm:
 ##           dbglm.formula, dbglm.default, dbglm.D2 and dbglm.dist 
 ##
 ##    Inputs: family: binomial()
 ##                    gaussian()
 ##                    Gamma()
 ##                    inverse.gaussian()
 ##                    poisson()
 ##                    quasi()
 ##                    quasibinomial()
 ##                    quasipoisson()
 ##            maxiter: 100 iterations
 ##            eps1: stopping criterion 1, "Devstat"
 ##            eps2: stopping criterion 2, "mustat"
 ##            metric: "euclidean", "gower", "manhattan"
 ##            weights: Default (all individuals have the same weights)
 ##            mustart: started values: default NULL
 ##            rel.gvar: relative variability used in the linear predictions.
 ##    Outputs: an object of class dbglm.
 ##  
  


    ################################
    #### dbglm of class formula ####
    ################################
    
     #generic function with a commun parameter (y).
 dbglm<-function(...)  UseMethod("dbglm")
 
 dbglm.formula <-function(formula,data,family=gaussian,...,metric="euclidean",
            weights,maxiter=100,eps1=1e-10,eps2=1e-10,rel.gvar=0.95,eff.rank=NULL,
            offset,mustart=NULL) 
{
  # call dbglm
  mf <- match.call(expand.dots = FALSE)
  
  # control metric. See the auxiliar function
  metric<-control_metric(metric)    
  
  if (missing(data))
    data <- environment(formula)
    
  # recover z and y of the formula
  zy <- formula_to_zy(formula,data,mf,"dbglm",metric)
  
  # y and z are defined--> pass to default method (try for avoid the program crash).
  try(ans <- dbglm.yz(y=zy$y,z=zy$z,metric=metric,family=family,weights=weights,
           maxiter=maxiter,eps1=eps1,eps2=eps2,rel.gvar=rel.gvar,eff.rank=eff.rank,
           offset=offset,mustart=mustart))        
 
  if (class(ans)[1]=="try-error") 
   return(paste("the program failed.Tries to read the help. If the error persists attempts to communicate with us "))
  
  # hidden attribute 'call' (used in print and summary)
  attr(ans,"call") <- mf
  attr(ans,"zs") <- zy$zini
  return(ans)   
}



    ################################
    #### default dbglm (y,z) #######
    ################################

dbglm.yz <- function(y,z,family=gaussian,metric="euclidean",
        weights,maxiter=100,eps1=1e-10,eps2=1e-10,
        rel.gvar=0.95,eff.rank=NULL,offset = rep(0, length(y)),
        mustart=NULL,...)
{
  # See if z or distance matrix is defined by the user.
   require(cluster)

   # control metric. See the auxiliar function
   metric <- control_metric(metric)
 
   # call z_to_dist to pass the explanatory variables to an object of class dist 
   dist_and_way <- z_to_dist(z,metric)
   D <- dist_and_way$D
   way <- dist_and_way$way
  
   # if metric=gower. the distance matrix D is already the squared.
   if (metric=="gower"){
     D2 <-as.matrix(D)
     class(D2) <- "D2"
   }else
     D2 <-disttoD2(D)
     
   # y and Distance are defined--> pass to dist method (try for avoid the program crash). 
   try(ans<-dbglm.D2(y=y,D2=D2,family=family,weights=weights,maxiter=maxiter,
          eps1=eps1,eps2=eps2,eff.rank=eff.rank,rel.gvar=rel.gvar,
          offset = offset,mustart=mustart))     
    
   if (class(ans)[1]=="try-error") 
    return(paste("the program failed.Tries to read the help. If the error persists attempts to communicate with us "))
 
   # hidden attributes 'metric', 'call', 'zs' and 'way'  
   attr(ans,"metric")<-metric
   attr(ans,"zs")<-z
   attr(ans,"call")<-match.call(expand.dots = FALSE)
   attr(ans,"way")<-way
  
   return(ans)
}


    #################################
    ####    dbglm with Dist or   ####
    ####  dissimilarity distance ####
    #################################

dbglm.dist <- function(distance,y,family=gaussian,weights,maxiter=100,
                eps1=1e-10,eps2=1e-10,rel.gvar=0.95,eff.rank=NULL,
                offset,mustart=NULL,...)
{ 
  
   # program controls: distance must be of class D2 dist or dissimilarity.
   if (missing(distance)||is.null(distance))
    stop("distance must be defined")
    
   # dist to D2
   # dist to D2
   Delta <- disttoD2(distance)     
  
   try(ans <- dbglm.D2(D2=Delta,y=y,family=family,weights=weights,maxiter=maxiter,
         eps1=eps1,eps2=eps2,rel.gvar=rel.gvar,eff.rank=eff.rank,
         offset = offset,mustart=mustart))

  if (class(ans)[1]=="try-error")
   return(paste("the program failed.Tries to read the help. If the error persists attempts to communicate with us "))
   
  # hidden attributes 'call' and 'way'   
  attr(ans,"call")<-match.call(expand.dots = FALSE)
  attr(ans,"way")<-"D2"
  attr(ans,"zs")<-Delta

   return(ans)                             
}


    #################################
    ####  dbglm with D2 distance ####
    #################################

dbglm.D2<-function(D2,y,...,family=gaussian,weights,maxiter=100,eps1=1e-10,
              eps2=1e-10,rel.gvar=0.95,eff.rank=NULL,offset,mustart=NULL)
{ 
  # D2 squared distances must be of class "D2"
  if (!any (class(D2)=="D2")) 
    stop("for a dbglm.D2 method the class of the distance matrix D2 must be 'D2'")

   Delta <- D2
   # number of observations
   nobs <- nrow(as.matrix(y)) 
   n <- nobs 

   # Program controls: see de auxiliar function 
   controls <- controls_dbglm(Delta,weights,offset,rel.gvar,maxiter,
                        eps1,eps2,y)
   weights  <- controls$weights 
   #weights <- weights/sum(weights)
   offset   <- controls$offset 
   rel.gvar <- controls$rel.gvar 
   maxiter  <- controls$maxiter 
   eps1 <- controls$eps1
   eps2 <- controls$eps2
       
   # start and etastart <- NULL (internal parameters of glm that need initialize
   start<-NULL
   etastart<-NULL
  
   # get the function of the family (can be a character or function)  
   family <-control_family(family)

   # functions variance and linkinv according to the family of y
   variance <- family$variance
   linkinv <- family$linkinv
   
   # control: variance and linkinv must be a functions. 
   if (!is.function(variance) || !is.function(linkinv))
        stop("'family' argument seems not to be a valid family object",
        call. = FALSE)
   
   # another important functions: dev.resids, aic, mu.eta, valideta and validmu     
   dev.resids <- family$dev.resids # deviance
   aic <- family$aic               # aic
   mu.eta <- family$mu.eta         # wdmu: derivative function(eta)

   valideta <-family$valideta      # check if starting values mu and eta are valid 
   validmu <- family$validmu  
   
   # possibles links
   problem.links<-c("inverse","identity","logit","1/mu^2") 
      
   # Iterative dblm:  Distance-Based Linear Model (with weights)
   # Step 0: Initial values, assigned by the user, or set the intrinsic values 
   # in the initialize function
   class(Delta)<-"D2"
   if (is.null(mustart)) {
        eval(family$initialize)
   }
   else {
        mukeep <- mustart
        eval(family$initialize)
        mustart <- mukeep
   }
   
   # eta = the link function.
   eta<-family$linkfun(mustart)
   
   # mu= the inverse of the link function.
   mu <- linkinv(eta)
   
   # check if starting values mu and eta are valid with validmu and valideta 
   # functions. 
   if (!(validmu(mu) && valideta(eta)))
            stop("cannot find valid starting values: please specify some",
                call. = FALSE)
   
   # Deviance Dev 
   Dev<-sum(dev.resids(y,mu,weights))
   dblm_aux <- NULL
   # Step i, i=iter, 1<=iter<=maxiter
   iter <- 0   
   while ( TRUE ){
     iter <- iter + 1
     mu0 <- mu
     Dev0 <- Dev
     dblm0 <- dblm_aux
     eta0 <-eta

     # gdmu and wdmu, using the derivative function of eta
     gdmu<- 1/mu.eta(eta)
     wdmu<- mu.eta(eta)

     # the weights must be > 0 and wdmu must be != 0 to fit the dblm.
     good <- weights > 0
     if (any(is.na(wdmu[good])))
       stop("NAs in d(mu)/d(eta)")
     good <- (weights > 0) & (wdmu != 0)
     # if all the observations are not good -->  break the program  
     if (all(!good)) {
        stop("no observations informative at iteration ",iter)
     }
     # varmu = variance only with good observations. 
     varmu <- variance(mu)[good]
     if (any(is.na(varmu)))
       stop("NAs in V(mu)")
     if (any(varmu == 0))
       stop("0s in V(mu)")
     
     # new y, to fit the dblm. z only has the good observations
     z <- (eta-offset)[good] + (y-mu)[good]/wdmu[good]    

     # new_weights, see pag 43 of generalized linear models.  
     new_weights<- (weights[good] * wdmu[good]^2)/varmu
     Delta_aux<-Delta[good,good]

     # make the dblm only with the valid observations (weights > 0)
     class(Delta_aux)="D2"
    
     if (!is.null(eff.rank))
      method="eff.rank"
     else
      method="rel.gvar" 
     
    if (!is.null(eff.rank))
       eff.rank_aux<-min(length(z)-1,eff.rank)
    else
       eff.rank_aux<- NULL
     
     if (length(z)<2)
      stop(paste("there are only one observation in the dblm iteration ",iter,". The weights are negative. Try to use other link"))
           
      
     dblm_aux <- dblm.D2(D2=Delta_aux,y=z,weights=new_weights,method=method,
                    rel.gvar=rel.gvar,eff.rank=eff.rank_aux)          
     Hhat<-dblm_aux$H
     
     # eta[good] = fitted values of the dblm (only with good observations)
     eta[good]<-dblm_aux$fitted.values
     
     # predict the values of the observations with negative weights or a wdmu=0
     if (any(!good)){ 
       Hhat=matrix(0,ncol=nobs,nrow=nobs)   

       Delta_pr<-Delta[!good,good]
       if (is.null(nrow(Delta_pr))) 
        Delta_pr <- t(as.matrix(Delta_pr))
       
       class(Delta_pr)<-"D2"
       eta[which(!good)]<-predict(dblm_aux,Delta_pr,type="D2")
       Hhat[good,good]<-dblm_aux$H   
     }
     
     # link: 1. logit, 2. logarithmic, 3. Identity, 4. mu-1, 5. mu-2 
     mu<-linkinv(eta)                                      
     Dev<- sum(dev.resids(y,mu,weights))
     
     if (is.finite(any(mu<0)))
      neg.mu<-any(mu<0)
     else 
      neg.mu<-TRUE
                                              
     if (!is.finite(Dev) && neg.mu && any(problem.links==family$link)){
      stop(gettextf("The linear predictor is negative and some components of 'mu' are < 0. The Deviance in the iteration %i is NULL, 
                      Try to change the link to any one different than: 'inverse', 'identity', 'logit' or '1/mu^2'",iter))
     }
    
     if (!is.finite(Dev))
      stop("The deviance is Null. Try to change the link function.")
       
     # check if the the relative error of mu and Dev is small enough 
     rel_incr_mu <- sum(abs(mu-mu0))/sum(abs(mu))
     rel_incr_Dev <- abs(Dev - Dev0)/(0.1 + abs(Dev))
      
     if (rel_incr_Dev < eps1){
       convcrit <- "DevStat"
       break
     }
     if (rel_incr_mu < eps2){
       convcrit <- "muStat"
       break
     }
     if (iter>=maxiter){
       convcrit <- "MaxIter"  
       break
     }
   }
  
   # residuals, residuals degree of freedom, null deviance and aic 
   wtdmu<-sum(weights*y)/sum(weights)
   null.deviance<-sum(dev.resids(y,wtdmu,weights))
   n.ok<-nobs-sum(weights==0)
   df.null<-n.ok-1
   df.residual<-df.null-dblm_aux$eff.rank
   aic.model<-aic(y,n,mu,weights,Dev)+2*(dblm_aux$eff.rank+1)              
   
   # residuals like glm
   residuals<-(y-mu)/mu.eta(eta)
 
   # return a list with the following attributes 
   ans<-list(residuals=residuals,fitted.values=mu,family=family,deviance=Dev,
            aic.model=aic.model,null.deviance=null.deviance,iter=iter,
            weights=new_weights,prior.weights=weights,df.residual=df.residual,
            df.null=df.null,y=y,convcrit=convcrit,H=Hhat,
            rel.gvar=dblm_aux$rel.gvar,eff.rank=dblm_aux$eff.rank)
                        
                         
   class(ans) <- c(ans$class, c("dbglm", "dblm"))
   attr(ans,"last_dblm")<- dblm_aux
   attr(ans,"call")<-match.call(expand.dots = FALSE)
   attr(ans,"ori_weights")<-weights
   attr(ans,"way")<-"D2"
   attr(ans,"G")<-D2toG(Delta,weights)
   attr(ans,"zs")<-Delta
   attr(ans,"eta")<-eta  
  return(ans)
}



    #################################
    ####  dbglm with G products  ####
    #################################

dbglm.Gram<-function(G,y,...,family=gaussian,weights,maxiter=100,eps1=1e-10,
              eps2=1e-10,rel.gvar=0.95,eff.rank=NULL,offset,mustart=NULL)
{ 
  # D2 squared distances must be of class "D2"
  if (class(G)[1]!="Gram") 
    stop("for a dbglm.Gram method the class of the inner products matrix G must be 'Gram'")
  else{
  
   D2<-GtoD2(G)
   
   try(ans <- dbglm.D2(D2=D2,y=y,family=family,weights=weights,maxiter=maxiter,
         eps1=eps1,eps2=eps2,rel.gvar=rel.gvar,eff.rank=eff.rank,
         offset = offset,mustart=mustart))
  }
  if (class(ans)[1]=="try-error")
   return(paste("the program failed.Tries to read the help. If the error persists attempts to communicate with us "))
  
  # hidden attributes 'call' and 'way'   
  attr(ans,"call")<-match.call(expand.dots = FALSE)
  attr(ans,"way")<-"G"
  ans$G <- G    
  return(ans)
}







