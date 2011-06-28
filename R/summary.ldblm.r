

 #######################
 #### summary.ldblm ####
 #######################

 ## Description:
 ##     Summary of an object of class ldblm.
 ##         - calculate the sum of square
 ##         - the hat trace
 ##        


summary.ldblm <-function(object,...){

    if (!inherits(object, "ldblm")&&!inherits(object, "ldbglm")) 
      stop("use only with \"ldblm\" or \"ldbglm\" objects")
 
    # recover attributes rdf, weights, residuals of dblm
    z <- object
    nobs <- length(z$y)
    weights <- object$weights
    
    # R2
    y0 <- z$y - sum(weights*z$y)
    R2 <- 1 - sum(weights*(z$fitted.values-z$y)^2)/(sum(weights*(y0^2)))

    # trace_hat
    t_hat <- sum(diag(z$Shat))

    # residual sigma
    sigma<-attr(z,"sigma")

    # matched call
    call <-z$call

    # family
    if (inherits(object, "ldbglm"))
     family <-object$family
    else 
     family <-"gaussian"
    
    # list to be returned
    ans <- list(nobs=nobs,r.squared=R2,trace.hat=t_hat,call=call,
                  residuals=z$residuals,family=family,y=z$y)
    class(ans)<-"summary.ldblm"

    return(ans)
}



