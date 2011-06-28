

#######################
#### summary.dbplsr ####
#######################

 ## Description:
 ##     Summary of an object of class dbplsr.
 ##         - calculate the R-squared
 ##         - the adjusted R-squared
 ##         - % variance explained
 ##


summary.dbplsr <-function(object,...)
{
    # recover attributes rdf, weights, residuals of dblm
    z <- object
    weights <- z$weights/sum(z$weights)
    ncomp <- z$ncomp
    yhat <- z$fitted.values
    ytit <- z$residuals
    y <- z$y

    # weighted residuals
    wytit<-lapply(ytit,function(ytit){
     ytit<-ytit*z$weights
     ytit
    })
    names(wytit)<-names(ytit)
    
    # sigma
    sigma<-sqrt(sum(z$weights*(yhat[[ncomp+1]]-y)^2)/(length(y)-1-ncomp))

    # R squared
    R2 <- apply(as.matrix(1:ncomp),1,function(i){
     return(1 - sum(weights*(yhat[[i+1]]-y)^2)/(sum(weights*(ytit[[1]]^2))))
    })

    R2adj <- apply(as.matrix(1:ncomp),1,function(i){
    return( 1- sum(weights*(yhat[[i+1]]-y)^2)/
      (sum(weights*(ytit[[1]]^2)))*(length(y)-1)/(length(y)-1-i))
    })

    # gvect
    gvec <- object$gvec
    
    # total Gemoetric variability
    gvar <- object$gvar
    
    # iteration geometric variability
     gvar.iter <- object$gvar.iter
    
    # matched call
    call <-object$call

    # list to be returned
    ans <- list(ncomp=ncomp,r.squared=R2,adj.r.squared=R2adj,call=z$call,residuals=wytit,
                  sigma=sigma,gvar=gvar,gvec=gvec,gvar.iter=gvar.iter)
    class(ans)<-"summary.dbplsr"

    return(ans)
}



