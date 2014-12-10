\name{summary.ldblm}
\alias{summary.ldblm}
\alias{print.summary.ldblm}

\title{
    Summarizing local distance-based linear model fits
}

\description{
\code{summary} method for class \code{"ldblm"}.
 }
 
\usage{
\method{summary}{ldblm}(object,...)
}

\arguments{
  \item{object}{
   an object of class \code{ldblm}. 
   Result of \code{\link{ldblm}}.
 }
  \item{\dots}{
    arguments passed to or from other methods to the low level. 
 }                                                                              
}

\value{
  A list of class \code{summary.ldblm} containing the following components: 

  \item{nobs }{number of observations.}
  \item{r.squared }{ the coefficient of determination R2.}
  \item{trace.hat }{Trace of smoother matrix .}
  \item{call }{	the matched call. }
  \item{residuals }{ the residuals (the response minus fitted values).}
  \item{family }{ the \code{\link{family}} object used.}
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
 \code{\link{ldblm}} for local distance-based linear models.
}





