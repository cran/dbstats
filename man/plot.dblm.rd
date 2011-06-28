\name{plot.dblm}
\alias{plot.dblm}
\alias{plot.dbglm}


\title{
 Plots for objects of clases dblm or dbglm
}
\description{
    Six plots (selected by \code{which}) are available: a plot of residual vs 
 fitted values, the Q-Qplot of normality, a Scale-Location plot of 
 \code{sqrt(|residuals|)} against fitted values. A plot of Cook's distances 
 versus row labels, a plot of residuals against leverages, and the optimal 
 effective rank of \code{"OCV"}, \code{"GCV"}, \code{"AIC"} or \code{"BIC"} 
 method (only if one of these four methods have been chosen in function \code{dblm}). 
 By default, only the first three and \code{5} are provided.    
}
\usage{
\method{plot}{dblm}(x,which=c(1:3, 5),id.n=3,main="",
        cook.levels = c(0.5, 1),cex.id = 0.75,
        type.pred=c("link","response"),...)
}

\arguments{
  \item{x}{
   an object of class \code{\link{dblm}} or \code{\link{dbglm}}. 
 }
  \item{which}{
   	if a subset of the plots is required, specify a subset of the numbers 1:6.
 }
  \item{id.n}{
    number of points to be labelled in each plot, starting with the most extreme.
}
  \item{main}{
    an overall title for the plot. Only if one of the six plots is selected.
}
  \item{cook.levels}{
    levels of Cook's distance at which to draw contours.
}
  \item{cex.id}{
    magnification of point labels.
}
  \item{type.pred}{
      the type of prediction (required only for a \code{dbglm} class object). 
    Like \code{\link{predict.dbglm}}, the default \code{"link"} is on the scale
    of the linear predictors; the alternative \code{"response"} is on the scale 
    of the response variable. 
}
  \item{\dots}{
  other parameters to be passed through to plotting functions.
}
}
\details{
      The five first plots are very useful to the residual analysis and are 
  the same that \code{\link{plot.lm}}. A plot of residuals against fitted 
  values sees if the variance is constant. The qq-plot checks if the residuals 
  are normal (see \code{\link{qqnorm}}). 
  The plot between \code{"Scale-Location"} and the fitted values takes the 
  square root of the absolute residuals in order to diminish skewness.
  The Cook's distance against the row labels, measures the effect of deleting a 
  given observation (estimate of the influence of a data point). Points with a 
  large Cook's distance are considered to merit closer examination in the analysis. 
  Finally, the Residual-Leverage plot also shows the most influence points 
  (labelled by Cook's distance). See \code{\link{cooks.distance}}.
  
     The last plot, allows to view the \code{"OCV"} (just for \code{dblm}), \code{"GCV"}, \code{"AIC"}
  or \code{"BIC"} criterion according to the used rank in the 
  \code{\link{dblm}} or \code{\link{dbglm}} functions, and chosen the minimum. Applies only if 
  the parameter \code{full.search} its \code{TRUE}.
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
 \code{\link{dblm}} for distance-based linear models.\cr
 \code{\link{dbglm}} for distance-based generalized linear models.
}
\examples{

n <- 64
p <- 4
k <- 3

Z <- matrix(rnorm(n*p),nrow=n)
b <- matrix(runif(p)*k,nrow=p)
s <- 1
e <- rnorm(n)*s
y <- Z\%*\%b + e

dblm1 <- dblm(y~Z,metric="gower",method="GCV", full.search=FALSE)
plot(dblm1)
plot(dblm1,which=4)

}



