 
 #############################
 #### print.summary.ldblm ####
 #############################

print.summary.ldblm <-function(x,...){
 
 if (!inherits(x,"summary.ldblm")&&!inherits(x, "summary.ldbglm")) 
   stop("use only with \"summary.ldblm\" or \"summary.ldbglm\" objects")
 
 # print the call 
 cat("\ncall:   ")
 print(x$call)

 # print the Residuals
 cat("\nResiduals:\n")
 print(summary(as.numeric(format(round(x$residuals,2)))))

 # print the Number of Observations
 cat(gettextf("\nNumber of Observations: %i",x$nobs))

 # print the Sum of Squares
 cat(gettextf("\nR-squared : %s",format(round(x$r.squared,digits=4))))
 
 # print the Trace of smoother matrix
 cat(gettextf("\nTrace of smoother matrix: %s",format(round(x$trace.hat,2)))) 
 
 # print the family
 if (!is.character(x$family))
  cat(gettextf("\nfamily: %s",x$family$family),"\n\n") 
 else
  cat("\nfamily: gaussian\n")

 # print the using method
  cat(gettextf("\nkind of kernel= %s",x$kind.kernel),"\n")  
  
  
  # print the used bandwidth 
  if (x$method!="user_h")
   cat(gettextf("optimal bandwidth h : %f",x$h_opt),"\n") # print h_opt  
  else 
   cat(gettextf("user bandwidth h : %f",x$h_opt),"\n") # print h_opt  
  
    # print the appropriate statistic according to the using method 
    if(!is.null(x$crit.value))
      cat(paste(x$method, "value criterion :", format(x$crit.value,scientific=TRUE)),"\n")
   cat("\n")
  
}

