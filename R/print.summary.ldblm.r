 
 #############################
 #### print.summary.ldblm ####
 #############################

print.summary.ldblm <-function(x,...){
 
 if (!inherits(x,"summary.ldblm")&&!inherits(x, "summary.ldbglm")) 
   stop("use only with \"summary.ldblm\" or \"summary.ldbglm\" objects")
 
 # print the call 
 cat("\ncall:   ")
 if (class(x)[1] == "summary.ldblm")
    x$call[[1]]<-as.name("ldblm")
 else
    x$call[[1]]<-as.name("ldbglm")
    
 print(x$call)

 # print the Residuals
 cat("\nResiduals:\n")
 print(summary(as.numeric(format(round(x$residuals,2)))))

 # print the Number of Observations
 cat(gettextf("\nNumber of Observations: %i",x$nobs))

 # print the Sum of Squares
 cat(gettextf("\nR-squared : %s",format(round(x$r.squared,digits=4))))
 
 # print the Trace of smoother matrix
 cat(gettextf("\nTrace of smoothing matrix: %s",format(round(x$trace.hat,2)))) 
 
 # print the family
 if (!is.character(x$family))
  cat(gettextf("\nfamily: %s",x$family$family),"\n\n") 
 else
  cat("\nfamily: gaussian\n")

 # print the using 
  cat(gettextf("\nkind of kernel= %s",x$kind.kernel),"\n")  
  
  
  # print the used bandwidth 
  if (x$method.h!="user.h")
   cat(gettextf("optimal bandwidth h : %f",x$h.opt),"\n") # print h.opt  
  else 
   cat(gettextf("user bandwidth h : %f",x$h.opt),"\n") # print h.opt  
  
    # print the appropriate statistic according to the using method.h 
    if(!is.null(x$crit.value))
      cat(paste(x$method.h, "value criterion :", format(x$crit.value,scientific=TRUE)),"\n")
   cat("\n")
  
}

