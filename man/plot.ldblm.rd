\name{plot.ldblm}
\alias{plot.ldblm}
\alias{plot.ldbglm}

\title{
 Plots for objects of clases ldblm or ldbglm
}
\description{
    Three plots (selected by \code{which}) are available: a plot of 
 fitted values vs response, a plot of residuals vs fitted and the 
 optimal bandwidth \code{h} of \code{"OCV"}, \code{"GCV"}, \code{"AIC"} or 
 \code{"BIC"} criterion (only if one of these four methods have been chosen 
 in the \code{ldblm} function). By default, only the first and the second 
 are provided.
}

\usage{
\method{plot}{ldblm}(x,which=c(1,2),id.n=3,main="",...)
}

\arguments{
  \item{x}{
   an object of class \code{\link{ldblm}} or \code{\link{ldbglm}}.
 }
  \item{which}{
   	if a subset of the plots is required, specify a subset of the numbers 1:3.
 }
  \item{id.n}{
    number of points to be labelled in each plot, starting with the most extreme.
}
  \item{main}{
    an overall title for the plot. Only if one of the three plots is selected.
}
  \item{\dots}{
    other parameters to be passed through to plotting functions.
}
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

Belsley, D. A., Kuh, E. and Welsch, R. E. (1980). \emph{Regression Diagnostics}. New York: Wiley.
}
\author{
Boj, Eva <evaboj@ub.edu>, Caballe, Adria <adria.caballe@upc.edu>,
Delicado, Pedro <pedro.delicado@upc.edu> and Fortiana, Josep <fortiana@ub.edu>
}
\seealso{
 \code{\link{ldblm}}  for local distance-based linear models.\cr
 \code{\link{ldbglm}} for local distance-based generalized linear models.
 
}
\examples{

# example to use of the ldblm function
n <- 100
p <- 1
k <- 5

Z <- matrix(rnorm(n*p),nrow=n)
b1 <- matrix(runif(p)*k,nrow=p)
b2 <- matrix(runif(p)*k,nrow=p)
b3 <- matrix(runif(p)*k,nrow=p)

s <- 1
e <- rnorm(n)*s


y <- Z\%*\%b1 + Z^2\%*\%b2 +Z^3\%*\%b3 + e

D2<-as.matrix(dist(Z))^2
class(D2)<-"D2"

ldblm1<-ldblm.D2(D2,y=y,kind.of.kernel=1,method="AIC",noh=5,h.knn=NULL)
plot(ldblm1)
plot(ldblm1,which=3)


}



