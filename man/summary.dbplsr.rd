\name{summary.dbplsr}
\alias{summary.dbplsr}
\alias{print.summary.dbplsr}

\title{
    Summarizing distance-based partial least squares fits
}

\description{
\code{summary} method for class \code{"dbplsr"}
 }
 
\usage{
\method{summary}{dbplsr}(object,...)
}

\arguments{
  \item{object}{
   an object of class \code{dbplsr}. Result of \code{\link{dbplsr}}.
 }
  \item{\dots}{
    arguments passed to or from other methods to the low level. 
 }
}

\value{
  A list of class \code{summary.dbplsr} containing the following components: 

  \item{ncomp }{ the number of components of the model.}     
  \item{r.squared }{ the coefficient of determination R2.}
  \item{adj.r.squared }{ adjusted R-squared.}
  \item{call }{	the matched call. }                  
  \item{residuals }{ a list containing the residuals for each iteration 
          (response minus fitted values).}  
  \item{sigma }{ the residual standard error.}
  \item{gvar }{total weighted geometric variability.}  
  \item{gvec }{the diagonal entries in G0.} 
  \item{gvar.iter }{ geometric variability for each iteration.}   
  \item{method}{ the using method to set \code{ncomp}.}
  \item{crit.value }{ value of criterion defined in \code{method}.}
   \item{ncomp.opt }{optimum number of components according to the selected method.}  
 
}

\references{
Boj E, Delicado P, Fortiana J (2010). \emph{Distance-based local linear regression for functional predictors}.
	Computational Statistics and Data Analysis 54, 429-437.

Boj E, Grane A, Fortiana J, Claramunt MM (2007). \emph{Implementing PLS for distance-based regression: 
 computational issues}.
\emph{Computational Statistics} 22, 237-248.

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
 \code{\link{dbplsr}} for distance-based partial least squares.
}

\examples{
# require(pls)
library(pls)
data(yarn)
## Default methods:
yarn.dbplsr <- dbplsr(density ~ NIR, data = yarn, ncomp=6, method="GCV")
summary(yarn.dbplsr)
}




