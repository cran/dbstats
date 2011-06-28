\name{dbplsr}
\alias{dbplsr}
\alias{dbplsr.formula}
\alias{dbplsr.dist}
\alias{dbplsr.D2}
\alias{dbplsr.Gram}
\alias{print.dbplsr}

\title{
      Distance-based partial least squares regression
}
\description{
      \code{dbplsr} is a variety of partial least squares regression 
   where explanatory information is coded as distances between individuals.
   These distances can either be computed from observed explanatory variables
   or directly input as a squared interdistances matrix. 
  
   Since distances can be computed from a mixture of continuous and 
   qualitative explanatory variables or, in fact, from more general 
   quantities, \code{dbplsr} is a proper extension of \code{plsr}.
   
                                 
   Notation convention: in distance-based methods we must distinguish 
   \emph{observed explanatory variables} which we denote by Z or z, from 
   \emph{Euclidean coordinates} which we denote by X or x. For explanation
   on the meaning of both terms see the bibliography references below. 
}
\usage{

\method{dbplsr}{formula}(formula,data,...,metric="euclidean",
        method="ncomp",weights,ncomp) 

# method for distance class 'dist' or 'dissimilary'
dbplsr.dist(y,distance,...,weights,ncomp=ncomp,method="ncomp")

#  method for distance class 'D2'
dbplsr.D2(y,D2,...,weights,ncomp=ncomp,method="ncomp")

#  method for class 'Gram'
dbplsr.Gram(y,G,...,weights,ncomp=ncomp,method="ncomp")
}

\arguments{

  \item{formula}{
      an object of class \code{\link{formula}}. A formula of the form \code{y~Z}.
	  This argument is a remnant of the \code{\link{plsr}} function, 
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
  \item{distance}{
      a \code{dist} or \code{dissimilarity} class object. See functions
	  \code{\link{dist}} in the package \code{stats} and \code{\link{daisy}} 
	  in the package \code{cluster}.
}
  \item{D2}{
      a \code{D2} class object. Squared distances matrix between individuals.  
	  See details below to learn the usage of \code{dblm.D2}.
}
  \item{G}{
      a \code{Gram} class object. Weighted centered inner products matrix of the 
    squared distances matrix \code{D2}. 
	  See details in \code{\link{dblm}}.
}
  \item{metric}{
      metric function to be used when computing distances from observed 
	  explanatory variables. 
	  One of \code{"euclidean"} (default), \code{"manhattan"}, 
	  or \code{"gower"}. 
}
  \item{method}{
     sets the method to be used in deciding how many components needed to fit
    the best model for new predictions.
	  There are five different methods, \code{"AIC"}, \code{"BIC"}, \code{"OCV"}, 
    \code{"GCV"} and \code{"ncomp"} (default).
    \code{OCV} and \code{GCV} find the number of components that minimizes 
    the Cross-validation coefficient (\code{ocv} or \code{gcv}). 
    \code{AIC} and \code{BIC} find the number of components that minimizes 
    the Akaike or Bayesian Information Criterion (see \code{\link{AIC}} 
    for more details).  
}
  \item{weights}{
     an optional numeric vector of weights to be used in the fitting process. 
	 By default all individuals have the same weight.  
}
 \item{ncomp}{ 
	 	the number of components to include in the model.
}
  \item{\dots}{
     arguments passed to or from other methods to the low level. Currently not used.
}
}
\details{
  
    Partial least squares (PLS) is a method for constructing
  predictive models when the factors (Z) are many and highly collinear. 
  A PLS model will try to find the multidimensional direction
  in the Z space that explains the maximum multidimensional variance direction 
  in the Y space. \code{dbplsr} is particularly suited when the matrix of 
  predictors has more variables than observations. 
  By contrast, standard regression (\code{dblm}) will fail in these cases.
  
     The various possible ways for inputting the model explanatory 
	information through distances, or their squares, etc., are the 
	same as in \code{\link{dblm}}. 
  
  The number of components to fit is specified with the argument \code{ncomp}.  
  
}
\value{
  A list of class \code{dbplsr} containing the following components: 
 
  \item{residuals }{a list containing the residuals (response minus fitted values)
                   for each iteration.}   
  \item{fitted.values }{a list containing the fitted values for each iteration.}
  \item{fk }{a list containing the scores for each iteration.} 
  \item{bk }{regression coefficients. \code{fitted.values = fk*bk} }
  \item{Pk }{orthogonal projector on the one-dimensional linear space by \code{fk}.} 
  \item{ncomp }{number of components included in the model.}  
  \item{ncomp_opt }{optimum number of components according to the selected method.}  
  \item{weights }{the specified weights.}
  \item{method }{the using method.} 
  \item{y }{the response used to fit the model.}
  \item{Hhat }{the hat matrix projector.}
  \item{G0 }{initial weighted centered inner products matrix of the squared 
             distance matrix.}  
  \item{Gk }{weighted centered inner products matrix in last iteration.}   
  \item{gvar }{total weighted geometric variability.}   
  \item{gvec }{the diagonal entries in \code{G0}.}
  \item{gvar.iter }{ geometric variability for each iteration.}
  \item{ocv }{the ordinary cross-validation estimate of the prediction error.}
  \item{gcv }{the generalized cross-validation estimate of the prediction error.} 
  \item{aic }{the Akaike Value Criterium of the model.} 
  \item{bic }{the Bayesian Value Criterium of the model.}               
  
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
\note{
  When the Euclidean distance is used the \code{dbplsr} model reduces to the 
  traditional partial least squares (\code{plsr}). 
}

\seealso{
  \code{\link{summary.dbplsr}} for summary.\cr
  \code{\link{plot.dbplsr}} for plots.\cr
  \code{\link{predict.dbplsr}} for predictions.
}
\examples{
#require(pls)
library(pls)
data(yarn)
## Default methods:
yarn.dbplsr <- dbplsr(density ~ NIR, data = yarn, ncomp=6, method="GCV")


}