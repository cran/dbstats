\name{summary.dblm}
\alias{summary.dblm}
\alias{print.summary.dblm}

\title{
    Summarizing distance-based linear model fits
}

\description{
\code{summary} method for class \code{"dblm"}
 }
 
\usage{
\method{summary}{dblm}(object,...)
}

\arguments{
  \item{object}{
   an object of class \code{dblm}. Result of \code{\link{dblm}}.
 }
 \item{\dots}{
    arguments passed to or from other methods to the low level. 
 } 
}

\value{
  A list of class \code{summary.dblm} containing the following components: 

  \item{residuals }{ the residuals (response minus fitted values).}  
  \item{sigma }{ the residual standard error.}
  \item{r.squared }{ the coefficient of determination R2.}
  \item{adj.r.squared }{ adjusted R-squared.}
  \item{rdf }{ the residual degrees of freedom.}     
  \item{call }{	the matched call. }
  \item{gvar }{	weighted geometric variability of the squared distance matrix. }
  \item{gvec }{	diagonal entries in weighted inner products matrix G. }
  \item{method }{ method used to decide the \emph{effective rank}. }
  \item{eff.rank}{
      integer between 1 and the number of observations minus one. 
  	  Number of Euclidean coordinates used for model fitting. Applies only  
	  if \code{method="eff.rank"}.  
  }
  \item{rel.gvar}{
      relative geometric variability (real between 0 and 1). Take the 
	  lowest effective rank with a relative geometric variability higher 
      or equal to \code{rel.gvar}. Default value (\code{rel.gvar=0.95}) 
	  uses a 95\% of the total variability.
      Applies only \code{rel.gvar} if \code{method="rel.gvar"}.
}
     \item{crit.value }{ value of criterion defined in \code{method}.}

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
 \code{\link{dblm}}  for distance-based linear models.
}





