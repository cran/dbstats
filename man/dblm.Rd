\name{dblm}
\alias{dblm}
\alias{dblm.formula}
\alias{dblm.dist}
\alias{dblm.D2}
\alias{dblm.Gram}
\alias{print.dblm}

\title{
      Distance-based linear model
}
\description{
    \code{dblm} is a variety of linear model where explanatory information 
   is coded as distances between individuals. These distances can either 
   be computed from observed explanatory variables or directly input as 
   a squared distances matrix. The response is a continuous variable as 
   in the ordinary linear model. Since distances can be computed from a mixture 
   of continuous and qualitative explanatory variables or, 
   in fact, from more general quantities, \code{dblm} is a proper extension of 
   \code{lm}.
                                        
   Notation convention: in distance-based methods we must distinguish 
   \emph{observed explanatory variables} which we denote by Z or z, from 
   \emph{Euclidean coordinates} which we denote by X or x. For explanation
   on the meaning of both terms see the bibliography references below.
   
  }
\usage{

\method{dblm}{formula}(formula,data,...,metric="euclidean",method="OCV",full.search=TRUE,
        weights,rel.gvar=0.95,eff.rank)

\method{dblm}{dist}(distance,y,...,method="OCV",full.search=TRUE,
        weights,rel.gvar=0.95,eff.rank)

\method{dblm}{D2}(D2,y,...,method="OCV",full.search=TRUE,weights,rel.gvar=0.95,
        eff.rank)
              
\method{dblm}{Gram}(G,y,...,method="OCV",full.search=TRUE,weights,rel.gvar=0.95,
        eff.rank)
}

\arguments{

 \item{formula}{
      an object of class \code{\link{formula}}. A formula of the form \code{y~Z}.
	  This argument is a remnant of the \code{\link{lm}} function, 
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
	  \code{\link{dist}} in the package \code{stats} and \code{\link[cluster]{daisy}} 
	  in the package \code{cluster}.
}
  \item{D2}{
      a \code{D2} class object. Squared distances matrix between individuals.  

}
  \item{G}{
      a \code{Gram} class object. Doubly centered inner product matrix  of the 
    squared distances matrix \code{D2}. 

}
  \item{metric}{
      metric function to be used when computing distances from observed 
	  explanatory variables. 
	  One of \code{"euclidean"} (default), \code{"manhattan"}, 
	  or \code{"gower"}. 
}
  \item{method}{
      sets the method to be used in deciding the \emph{effective rank}, 
	  which is defined as the number of linearly independent Euclidean 
	  coordinates used in prediction. 
	  There are six different methods: \code{"AIC"}, \code{"BIC"}, 
	  \code{"OCV"} (default), \code{"GCV"}, \code{"eff.rank"} and 
	  \code{"rel.gvar"}.
      \code{OCV} and \code{GCV} take the effective rank minimizing 
	  a cross-validatory quantity (either \code{ocv} or \code{gcv}). 
      \code{AIC} and \code{BIC} take the effective rank minimizing,
	  respectively, the Akaike or Bayesian Information Criterion 
	  (see \code{\link{AIC}} for more details). 
	  The optimizacion procedure to be used in the above four methods
	  can be set with the \code{full.search} optional parameter.
	  
	  When method is \code{eff.rank}, the effective rank is explicitly
	  set by the user through the \code{eff.rank} optional parameter 
	  which, in this case,   becomes mandatory.
	  
      When method is \code{rel.gvar}, the fraction of the data 
	  \emph{geometric variability} for model fitting is explicitly
	  set by the user through the \code{rel.gvar} optional parameter which, 
	  in this case,  becomes mandatory.
}
    \item{full.search}{sets which optimization procedure will be used to
  	minimize the modelling criterion specified in \code{method}.
      Needs to be specified only if \code{method} is \code{"AIC"}, 
  	\code{"BIC"}, \code{"OCV"} or \code{"GCV"}. 
      If \code{full.search=TRUE}, \emph{effective rank} is set to its
  	global best value, after evaluating the criterion for all possible ranks.
  	Potentially too computationally expensive.
      If \code{full.search=FALSE}, the \code{\link{optimize}} function 
  	is called. Then computation time is shorter, but the result may be 
  	found a local minimum. 
        
  }  
  \item{weights}{
     an optional numeric vector of weights to be used in the fitting process. 
	 By default all individuals have the same weight.  
}
 \item{rel.gvar}{
      relative geometric variability (real between 0 and 1). Take the 
	  lowest effective rank with a relative geometric variability higher 
      or equal to \code{rel.gvar}. Default value (\code{rel.gvar=0.95}) 
	  uses a 95\% of the total variability.
      Applies only \code{rel.gvar} if \code{method="rel.gvar"}.
}
 \item{eff.rank}{
      integer between 1 and the number of observations minus one. 
  	  Number of Euclidean coordinates used for model fitting. Applies only  
	  if \code{method="eff.rank"}.  
}
  \item{\dots}{
     arguments passed to or from other methods to the low level. 
}
}
\details{
    The \code{dblm} model uses the distance matrix between individuals 
	to find an appropriate prediction method. 
    There are many ways to compute and calculate this matrix, besides
	the three included as parameters in this function. 
    Several packages in R also study this problem. In particular 
	\code{\link{dist}} in the package \code{stats} and \code{\link[cluster]{daisy}}
   in the package	\code{cluster} (the three metrics in \code{dblm} call
  the \code{daisy} function).
	
    Another way to enter a distance matrix to the model is through an object 
	of class \code{"D2"} (containing the squared distances matrix).
    An object of class \code{"dist"} or \code{"dissimilarity"} can 
	easily be transformed into one of class \code{"D2"}. See \code{\link{disttoD2}}.
    Reciprocally, an object of class \code{"D2"} can be transformed into one 
  of class \code{"dist"}. See \code{\link{D2toDist}}.
  
   S3 method Gram uses the Doubly centered inner product matrix G=XX'.
  Its also easily to transformed into one of class \code{"D2"}. 
  See \code{\link{D2toG}} and \code{\link{GtoD2}}.
  
    The weights array is adequate when responses for different individuals
	have different variances. In this case the weights array should be 
	(proportional to) the reciprocal of the variances vector.  
   
    When using method \code{method="eff.rank"} or \code{method="rel.gvar"},
	a compromise between possible consequences of a bad choice has to be 
	reached. If the rank is too large, the model can be overfitted, possibly 
	leading to an increased prediction error for new cases 
	(even though R2 is higher). On the other hand, a small rank suggests  
	a model inadequacy (R2 is small).  The other four methods are less error 
	prone (but still they do not guarantee good predictions). 
  
}
\value{
  A list of class \code{dblm} containing the following components: 
 
  \item{residuals }{the residuals (response minus fitted values).} 
  \item{fitted.values }{the fitted mean values.}
  \item{df.residuals }{the residual degrees of freedom.}
  \item{weights }{the specified weights.}
  \item{y }{the response used to fit the model.}
  \item{H }{the hat matrix projector.}
  \item{call }{the matched call.} 
  \item{rel.gvar }{the relative geometric variabiliy, used to fit the model.}
  \item{eff.rank }{the dimensions chosen to estimate the model.}
  \item{ocv }{the ordinary cross-validation estimate of the prediction error.}
  \item{gcv }{the generalized cross-validation estimate of the prediction error.} 
  \item{aic }{the Akaike Value Criterium of the model (only if \code{method="AIC"}).} 
  \item{bic }{the Bayesian Value Criterium of the model (only if \code{method="BIC"}).}
 }
\references{

Boj E, Caballe, A., Delicado P, Esteve, A., Fortiana J (2016). \emph{Global and local distance-based generalized linear models}.
	TEST 25, 170-195.

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
\note{
  When the Euclidean distance is used the \code{dblm} model reduces to the linear 
  model (\code{lm}). 
}

\seealso{
  \code{\link{summary.dblm}} for summary.\cr
  \code{\link{plot.dblm}} for plots.\cr
  \code{\link{predict.dblm}} for predictions.\cr
  \code{\link{ldblm}} for distance-based local linear models.
}
\examples{
# easy example to illustrate usage of the dblm function
n <- 100
p <- 3
k <- 5

Z <- matrix(rnorm(n*p),nrow=n)
b <- matrix(runif(p)*k,nrow=p)
s <- 1
e <- rnorm(n)*s
y <- Z\%*\%b + e

D<-dist(Z)

dblm1 <- dblm(D,y)
lm1 <- lm(y~Z)
# the same fitted values with the lm
mean(lm1$fitted.values-dblm1$fitted.values)

}
