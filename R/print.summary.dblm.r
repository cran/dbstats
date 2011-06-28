 
 ############################
 #### print.summary.dblm ####
 ############################

print.summary.dblm <-function(x,...){
 
 # print the call
 cat("\ncall:   ")
 print(x$call)

 # print the Weighted Residuals
 cat("\nWeighted Residuals:\n")
 print(format(summary(as.numeric(x$residuals)),digits=3),quote = FALSE)
 
 # print the stand.resid.error with rff degree of freedom
 cat(gettextf("\nResidual standard error: %f on %d degrees of freedom",
        x$sigma,x$df.residuals),"\n")
 
 # print R-squared and adjusted R-squared 
 cat(gettextf("R-squared: %f \t Adjusted R-squared: %f",
        x$r.squared,x$adj.r.squared),"\n") 

 # print geometric variability 
 cat(gettextf("Weighted Geometric Variability: %f",
        x$gvar),"\n\n")  
}                                           