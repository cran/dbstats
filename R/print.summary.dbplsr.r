print.summary.dbplsr <- function(x,digits=4,...){
  # print the call
 cat("\ncall:   ")
 print(x$call)

 ncomp <- x$ncomp
 # print the Weighted Residuals
 cat(gettextf("\nWeighted Residuals using %i components: ",ncomp),"\n")
 print(format(summary(as.numeric(x$residuals[[ncomp+1]])),digits=3),quote = FALSE)

  R2 <-100*x$r.squared
  adjR2 <- 100*x$adj.r.squared
  gvar <- 100*(as.numeric(x$gvar)-x$gvar.iter)/as.numeric(x$gvar)
  
 # print R-squared and adjusted R-squared
 cat("\n% variance explained: \n")
 var_exp <- t(data.frame(R2=R2,adjR2=adjR2,gvar=gvar))
 colnames(var_exp)<-names(x$residuals)[2:(ncomp+1)]
 print(var_exp,digits=digits)
 cat("\n")
}