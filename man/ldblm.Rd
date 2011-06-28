\name{ldblm}
\alias{ldblm}
\alias{ldblm.formula}
\alias{ldblm.dist}
\alias{ldblm.D2}
\alias{ldblm.Gram}
\alias{print.ldblm}



\title{
   Local distance-based linear model
}
\description{

	\code{ldblm} is a localized version of a distance-based linear model. 
	As in the global model \code{dblm}, explanatory information is coded as 
	distances between individuals.
	
	Neighborhood definition for localizing is done by the (semi)metric
	\code{dist1} whereas a second (semi)metric \code{dist2} (which may coincide
	with \code{dist1}) is used for distance-based prediction.  
	Both \code{dist1} and \code{dist2}  can either be computed from observed 
	explanatory variables or directly input as a squared interdistances 
	matrix or as a \code{Gram} matrix. The response is a continuous variable 
  as in the ordinary linear model. The model allows for a mixture of 
  continuous and qualitative explanatory variables or, in fact, from more 
  general quantities such as functional data. 
	
	
	Notation convention: in distance-based methods we must distinguish 
  \emph{observed explanatory variables} which we denote by Z or z, from 
  \emph{Euclidean coordinates} which we denote by X or x. For explanation
  on the meaning of both terms see the bibliography references below.
	
}
\usage{

\method{ldblm}{formula}(formula,data,...,kind.of.kernel=1,
        metric1="euclidean",metric2=metric1,method.h="GCV",weights,
        user.h=NULL,h.range=NULL,noh=10,k.knn=3,rel.gvar=0.95,eff.rank=NULL)

\method{ldblm}{dist}(dist1,dist2=dist1,y,kind.of.kernel=1,
        method.h="GCV",weights,user.h=quantile(dist1,.25),
        h.range=quantile(as.matrix(dist1),c(.05,.5)),noh=10,
        k.knn=3,rel.gvar=0.95,eff.rank=NULL,...)  

\method{ldblm}{D2}(D2.1,D2.2=D2.1,y,kind.of.kernel=1,method.h="GCV",
        weights,user.h=quantile(D2.1,.25)^.5,
        h.range=quantile(as.matrix(D2.1),c(.05,.5))^.5,noh=10,k.knn=3,
        rel.gvar=0.95,eff.rank=NULL,...) 
         
\method{ldblm}{Gram}(G1,G2=G1,y,kind.of.kernel=1,method.h="GCV",
        weights,user.h=NULL,h.range=NULL,noh=10,k.knn=3,rel.gvar=0.95,
        eff.rank=NULL,...)       
}

\arguments{

\item{formula}{
      an object of class \code{\link{formula}}. A formula of the form \code{y~Z}.
	  This argument is a remnant of the \code{\link{loess}} function, 
	  kept for compatibility. 
}
 \item{data}{
      an optional data frame containing the variables in the model 
	  (both response and explanatory variables, either
	  the observed ones, Z, or a Euclidean configuration X).  
}
 \item{y}{
     	(required if no formula is given as the principal argument). 
		Response (dependent variable) must be numeric, matrix or data.frame.
}
  \item{dist1}{
     a \code{dist} or \code{dissimilarity} class object.   
   Distances between observations, used for neighborhood localizing 
	 definition. Weights for observations are computed as a decreasing
	 function of their \code{dist1} distances to the neighborhood
	 center, e.g. a new observation whose reoponse has to be predicted. 
	 These weights are then entered to a \code{dblm}, where distances 
	 are evaluated with \code{dist2}.
	
}
  \item{dist2}{
     a \code{dist} or \code{dissimilarity} class object.
   Distances between observations, used for fitting \code{\link{dblm}}. 
   Default \code{dist2=dist1}. 
}
  \item{D2.1}{
     a \code{D2} class object. Squared distances matrix between individuals. 
   One of the alternative ways of entering distance information
   to a function. See the Details section in \code{\link{dblm}}.
   See above \code{dist1} for explanation of its role in this function.
   
}
  \item{D2.2}{
     a \code{D2} class object. Squared distances between observations.
	 One of the alternative ways of entering distance information
   to a function. See the Details section in \code{\link{dblm}}.
   See above \code{dist2} for explanation of its role in this function.
   Default \code{D2.2=D2.1}. 
}
  \item{G1}{
	   a \code{Gram} class object. Doubly centered inner product matrix 
	 associated with the squared distances matrix \code{D2.1}.
		
}
  \item{G2}{
     a \code{Gram} class object. Doubly centered inner product matrix 
	 associated with the squared distances matrix \code{D2.2}.
	 Default \code{G2=G1}
}
  \item{kind.of.kernel}{
     integer number between 1 and 6 which determines the user's choice 
	 of smoothing kernel.
   (1) Epanechnikov (Default), (2) Biweight, (3) Triweight, (4) Normal, 
   (5) Triangular, (6) Uniform.
}

\item{metric1}{
    metric function to be used when computing \code{dist1} from observed 
	explanatory variables. 
	One of \code{"euclidean"} (default), \code{"manhattan"}, 
	or \code{"gower"}. 
}
\item{metric2}{
    metric function to be used when computing \code{dist2} from observed 
	explanatory variables. 
	One of \code{"euclidean"} (default), \code{"manhattan"}, 
	or \code{"gower"}. 
}
  \item{method.h}{
     sets the method to be used in deciding the \emph{optimal bandwidth h}.
	 There are five different methods, \code{AIC}, \code{BIC}, \code{OCV}, 
	 \code{GCV} (default) and \code{user.h}. 
   \code{OCV} and \code{GCV} take the optimal bandwidth minimizing 
	 a cross-validatory quantity (either \code{ocv} or \code{gcv}).  
   \code{AIC} and \code{BIC} take the optimal bandwidth minimizing,
	 respectively, the Akaike or Bayesian Information Criterion 
	(see \code{\link{AIC}} for more details). 
	   When \code{method.h} is \code{user.h}, the bandwidth is explicitly
	 set by the user through the \code{user.h} optional parameter 
	 which, in this case, becomes mandatory.   
}
  \item{weights}{
     an optional numeric vector of weights to be used in the fitting process. 
	 By default all individuals have the same weight.  
}
  \item{user.h}{
    global bandwidth \code{user.h}, set by the user, controlling the size 
    of the local neighborhood of Z.
    Smoothing parameter (Default: 1st quartile of all the distances 
    d(i,j) in \code{dist1}). Applies only if \code{method.h="user.h"}.
}
  \item{h.range}{
    a vector of length 2 giving the range for automatic bandwidth 
	choice. (Default: quantiles 0.05 and 0.5 of d(i,j) in \code{dist1}).
}
  \item{noh}{
    number of bandwidth \code{h} values within \code{h.range} for 
  automatic bandwidth choice (if \code{method.h!="user.h"}).
}
 \item{k.knn}{
	minimum number of observations with positive weight
    in neighborhood localizing. To avoid runtime errors
	due to a too small bandwidth originating neighborhoods 
	with only one observation. By default \code{k.nn=3}.
	
}
 \item{rel.gvar}{
	  relative geometric variability (a real number between 0 and 1). 
	  In each \code{dblm} iteration, take the lowest effective rank, with 
	  a relative geometric variability higher or equal to \code{rel.gvar}. 
	  Default value (\code{rel.gvar=0.95}) uses the 95\% of the total
	  variability.
}
 \item{eff.rank}{
	integer between 1 and the number of observations minus one. 
	Number of Euclidean coordinates used for model fitting in
	each \code{dblm} iteration. If specified its value overrides
	\code{rel.gvar}. When \code{eff.rank=NULL} (default), 
	calls to \code{dblm} are made with \code{method=rel.gvar}.  
}  
  \item{\dots}{
    arguments passed to or from other methods to the low level. 
  }   
}
\details{
    There are two semi-metrics involved in local linear distance-based estimation:
	\code{dist1} and \code{dist2}. Both semi-metrics can coincide. 
	For instance, when \code{dist1=||xi-xj||} and 
	\code{dist2=||(xi,xi^2,xi^3)-(xj,xj^2,xj^3)||} the estimator 
	for new observations coincides with fitting a local cubic polynomial 
	regression.  
 
     
	The set of bandwidth \code{h} values checked in automatic 
	bandwidth choice is defined by \code{h.range} and \code{noh}, 
	together with \code{k.knn}. For each \code{h} in it a local linear 
	model is fitted and the optimal \code{h} is decided according to the 
	statistic specified in \code{method.h}.
 
	\code{kind.of.kernel} designates which kernel function is to be used
	in determining individual weights from \code{dist1} values. 
	See \code{\link{density}} for more information.
}
\value{          
	A list of class \code{ldblm} containing the following components: 
 
  \item{residuals }{the residuals (response minus fitted values).} 
  \item{fitted.values }{the fitted mean values.}
  \item{h.opt }{the optimal bandwidth h used in the fitting proces 
      (\code{if method.h!=user.h}).} 
  \item{S }{the Smoother hat projector.}
  \item{weights }{the specified weights.}
  \item{y }{the response variable used.}
  \item{call }{the matched call.}
  \item{dist1 }{the distance matrix (object of class \code{"D2"} or \code{"dist"}) used to calculate the weights of the observations.}
  \item{dist2 }{the distance matrix (object of class \code{"D2"} or \code{"dist"}) used to fit the \code{\link{dblm}}.}      

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
Boj, Eva <evaboj@ub.edu>, Caballe, Adria <adria.caballe@upc.edu>, Delicado, 
 Pedro <pedro.delicado@upc.edu> and Fortiana, Josep <fortiana@ub.edu>
}
\note{
  Model fitting is repeated \code{n} times (\code{n=} number of observations)
  for each bandwidth (\code{noh*n} times). 
  For a \code{noh} too large or a sample with many observations, the time of 
  this function can be very high.
 
}
\seealso{
 \code{\link{dblm}} for distance-based linear models.\cr
 \code{\link{ldbglm}} for local distance-based generalized linear models.\cr
 \code{\link{summary.ldblm}} for summary.\cr 
 \code{\link{plot.ldblm}} for plots.\cr
 \code{\link{predict.ldblm}} for predictions.
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

D2 <- as.matrix(dist(Z)^2)
class(D2) <- "D2"

ldblm1 <- ldblm(y~Z,kind.of.kernel=1,method="GCV",noh=3,k.knn=3)
ldblm2 <- ldblm(D2.1=D2,D2.2=D2,y,kind.of.kernel=1,method="user.h",k.knn=3)
 
 
 
}

