\name{plot.dbplsr}
\alias{plot.dbplsr}


\title{
 Plots for a dbplsr object
}
\description{
    Four plots (selected by \code{which}) are available: plot of scores, 
 response vs scores, R2 contribution in each component and the value of 
 \code{"OCV"}, \code{"GCV"}, \code{"AIC"} or \code{"BIC"} vs the number 
 of component chosen.   
}

\usage{
\method{plot}{dbplsr}(x,which=c(1L:4L),main="",scores_comps=1:2,
        component=1,method=c("OCV","GCV","AIC","BIC"),...)
}

\arguments{
  \item{x}{
   an object of class \code{dbplsr}.
 }
  \item{which}{
   	if a subset of the plots is required, specify a subset of the numbers 1:4.
 }
  \item{main}{
    an overall title for the plot. Only if one of the four plots is selected.
}
 \item{scores_comps}{
    array containing the component scores crossed in the first plot 
  (default the first two).
}
 \item{component}{
   numeric value. Component vs response in the second plot
  (Default the first component). 
}
 \item{method}{
   choosen method \code{"OCV"}, \code{"GCV"}, \code{"AIC"} or \code{"BIC"} 
   in the last plot.
}
  \item{\dots}{
  other parameters to be passed through to plotting functions.
}
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

Belsley, D. A., Kuh, E. and Welsch, R. E. (1980). \emph{Regression Diagnostics}. New York: Wiley. 
}
\author{
Boj, Eva <evaboj@ub.edu>, Caballe, Adria <adria.caballe@upc.edu>,
Delicado, Pedro <pedro.delicado@upc.edu> and Fortiana, Josep <fortiana@ub.edu>
}
\seealso{
 \code{\link{dbplsr}} for distance-based partial least squares.
 
}
\examples{
#require(pls)
library(pls)
data(yarn)
## Default methods:
yarn.dbplsr <- dbplsr(density ~ NIR, data = yarn, ncomp=6, method="GCV")
plot(yarn.dbplsr,scores_comps=1:3)

}



