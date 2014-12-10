\name{summary.ldbglm}
\alias{summary.ldbglm}
\alias{print.summary.ldbglm}

\title{
  Summarizing local distance-based generalized linear model fits
}

\description{
  \code{summary} method for class \code{"ldbglm"}.
}

\usage{
  \method{summary}{ldbglm}(object,dispersion = NULL,...)
}

\arguments{
  \item{object}{
    an object of class \code{ldbglm}. 
    Result of \code{\link{ldbglm}}.
  }
 \item{dispersion}{
     the dispersion parameter for the family used. 
   Either a single numerical value or \code{NULL} (the default)
 }
  \item{\dots}{
    arguments passed to or from other methods to the low level. 
  }                                                                              
}

\value{
  A list of class \code{summary.ldgblm} containing the following components: 
    
  \item{nobs }{number of observations.}
  \item{trace.hat }{Trace of smoother matrix.}
  \item{call }{  the matched call.}
  \item{family }{ the \code{\link{family}} object used.}
  \item{deviance }{ measure of discrepancy or goodness of fitt. Proportional 
                    to twice the difference between the maximum log likelihood 
                    achievable and that achieved by the model under investigation.}
  \item{df.residual }{  the residual degrees of freedom.}
  \item{null.deviance }{ the deviance for the null model.}
  \item{df.null }{ the residual degrees of freedom for the null model.}
  \item{iter}{ number of Fisher Scoring (\code{dblm}) iterations.}
  \item{deviance.resid }{ the deviance residuals for each observation: 
                          sign(y-mu)*sqrt(di).}
  \item{pears.resid }{ the raw residual scaled by the estimated standard 
                       deviation of \code{y}.}
  \item{dispersion }{  the dispersion is taken as 1 for the binomial and Poisson
                       families, and otherwise estimated by the residual 
                       Chisquared statistic (calculated from cases with non-zero 
                       weights) divided by the residual degrees of freedom. }   
  \item{kind.kernel }{ smoothing kernel function.}
  \item{method.h }{ method used to decide the optimal bandwidth. }
  \item{h.opt }{the optimal bandwidth h used in the fitting proces 
                (\code{if method.h!=user.h}).} 
  \item{crit.value }{ value of criterion defined in \code{method.h}.}
  
  
}

\references{

  Boj E, Delicado P, Fortiana J (2010). \emph{Distance-based local linear regression for functional predictors}.
  Computational Statistics and Data Analysis 54, 429-437.
  
  Boj E, Grane A, Fortiana J, Claramunt MM (2007). \emph{Selection of predictors in distance-based regression}.
  Communications in Statistics B - Simulation and Computation 36, 87-98.
  
  Cuadras CM, Arenas C, Fortiana J (1996). \emph{Some computational aspects of a distance-based model
                                                 for prediction}. Communications in Statistics B - Simulation and Computation 25, 593-609.
  
  Cuadras C, Arenas C (1990). \emph{A distance-based regression model for prediction with mixed data}.
  Communications in Statistics A - Theory and Methods 19, 2261-2279.
  
  Cuadras CM (1989). \emph{Distance analysis in discrimination and classification using both 
                           continuous and categorical variables}. In: Y. Dodge (ed.), \emph{Statistical Data Analysis and Inference}.		
  Amsterdam, The Netherlands: North-Holland Publishing Co., pp. 459-473.
  
}
\author{
  Boj, Eva <evaboj@ub.edu>, Caballe, Adria <adria.caballe@upc.edu>,
  Delicado, Pedro <pedro.delicado@upc.edu> and Fortiana, Josep <fortiana@ub.edu>
}
\seealso{
  \code{\link{ldbglm}} for local distance-based generalized linear models.
}




