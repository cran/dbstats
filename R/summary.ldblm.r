

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
    t_hat <- sum(diag(z$S))

    # residual sigma
    sigma<-attr(z,"sigma")

    # matched call
    call <-z$call

    # family
    if (inherits(object, "ldbglm"))
     family <-object$family
    else 
     family <-"gaussian"
     
     
    kind.kernel <- switch(attr(object,"kind.of.kernel"),
     "(1) Epanechnikov",
	   "(2) Biweight",
		 "(3) Triweight",
		 "(4) Normal",
		 "(5) Triangular",
		 "(6) Uniform")
    
      crit.value <- NULL
      if (!is.null(attr(object,"OCV_opt")))
        crit.value <- attr(object,"OCV_opt") 
      if (!is.null(attr(object,"GCV_opt")))
        crit.value <- attr(object,"GCV_opt") 
      if (!is.null(attr(object,"AIC_opt")))
        crit.value <- attr(object,"AIC_opt") 
      if (!is.null(attr(object,"BIC_opt")))
        crit.value <- attr(object,"BIC_opt")
         
      
     
    
    # list to be returned
    ans <- list(nobs=nobs,r.squared=R2,trace.hat=t_hat,call=call,
                  residuals=z$residuals,family=family,y=z$y,
                  kind.kernel=kind.kernel,method=attr(object,"method"),
                  h_opt=object$h_opt, crit.value=crit.value)
    class(ans)<-"summary.ldblm"

    return(ans)
}



