 ##############################
 #### print.dbglm function ####
 ##############################

 ## Description:
 ##   print generic method. Show the most relevant attributes of a dbglm object 
 ##   in a pretty format.
 ##
 
print.dbglm<-function (x, digits = max(3, getOption("digits") - 3), ...)
{
   # print the call
   cat("\nCall:  ", paste(deparse(attr(x,"call")), sep = "\n", collapse = "\n"),
        "\n", sep = "")

   # print the family and the metric (if is used)
   cat(gettextf("\nfamily: %s",x$family$family))
   if(attr(x,"way")=="Z")
    cat(gettextf("\nmetric: %s",attr(x,"metric")))
   
   # Degrees of freedom
   cat("\n\nDegrees of Freedom:", x$df.null, "Total (i.e. Null); ",
        x$df.residual, "Residual\n")

   # Deviance
   cat("Null Deviance:\t   ", format(signif(x$null.deviance,
        digits)), "\nResidual Deviance:", format(signif(x$deviance,
        digits)), "\tAIC:", format(signif(x$aic, digits)), "\n\n") 
  
    invisible(x)
   
}

  