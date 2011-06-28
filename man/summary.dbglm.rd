\name{summary.dbglm}
\alias{summary.dbglm}
\alias{print.summary.dbglm}

\title{
    Summarizing distance-based generalized linear model fits
}

\description{
\code{summary} method for class \code{"dbglm"}
 }
 
\usage{
\method{summary}{dbglm}(object,dispersion,...)
}

\arguments{
  \item{object}{
   an object of class \code{dbglm}. Result of \code{\link{dbglm}}.
 }
  \item{dispersion}{
     the dispersion parameter for the family used. 
   Either a single numerical value or \code{NULL} (the default)
 }
 \item{\dots}{
    currently not used.
 }
}

\value{
  A list of class \code{summary.dbglm} containing the following components: 
 
  \item{call }{	the matched call. }
  \item{family }{ the \code{\link{family}} object used.}
  \item{deviance }{ measure of discrepancy or goodness of fitt. Proportional 
                    to twice the difference between the maximum log likelihood 
                    achievable and that achieved by the model under investigation.}
  \item{aic }{ Akaike's An Information Criterion.}                 
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
  \item{gvar }{	weighted geometric variability of the squared distance matrix. }
  \item{gvec }{	diagonal entries in weighted inner products matrix G. }                     
                                  
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
 \code{\link{dbglm}}  for distance-based generalized linear models.
}





