 #############################
 #### print.summary.dbglm ####
 #############################


print.summary.dbglm <-function (x, digits = 2, ...){

    # print the call
    cat("\nCall:  ", paste(deparse(x$call), sep = "\n", collapse = "\n"),
        "\n", sep = "")

    # Deviance Residuals
    cat("\nDeviance Residuals:\n")
    print(summary(as.numeric(format(round(x$deviance.resid,digits=4)))))
    
    # dispersion
    if (x$family$family %in% c("poisson","binomial"))
     cat(gettextf("\n(Dispersion parameter for %s family taken to be %i)",
            x$family$family,x$dispersion),"\n")
    else
     cat(gettextf("\n(Dispersion parameter for %s family taken to be %f)",
          x$family$family,x$dispersion),"\n")
    
    # deviance: null or estimated model
    cat(gettextf("\n    Null deviance: %s  on %i degrees of freedom",
          format(round(x$null.deviance,digits)),x$df.null))
    cat(gettextf("\nResidual deviance: %s  on %i degrees of freedom",
          format(round(x$deviance,digits=digits)),x$df.residual))
    
    # AIC
    cat(paste("\nAIC:",format(round(x$aic,digits)),sep=" "),"\n")

    # Number of Fisher Scoring iterations and Convergence criterio
    cat(gettextf("\nNumber of Fisher Scoring iterations: %i",x$iter),"\n")
    cat(gettextf("Convergence criterion: %s",x$convcrit),"\n\n")
}

