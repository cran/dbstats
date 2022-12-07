\name{dbglm}
\alias{dbglm}
\alias{dbglm.formula}
\alias{dbglm.dist}
\alias{dbglm.D2}
\alias{dbglm.Gram}
\alias{print.dbglm}

\title{
      Distance-based generalized linear models                                                                 
}
\description{
    \code{dbglm} is a variety of generalized linear model where explanatory 
   information is coded as distances between individuals. These distances 
   can either be computed from observed explanatory variables or directly 
   input as a squared distances matrix. 

   Response and link function as in the \code{glm} function for ordinary 
   generalized linear models.
   
   
   Notation convention: in distance-based methods we must distinguish 
   \emph{observed explanatory variables} which we denote by Z or z, from 
   \emph{Euclidean coordinates} which we denote by X or x. For explanation
   on the meaning of both terms see the bibliography references below.
}
\usage{

\method{dbglm}{formula}(formula, data, family=gaussian, method ="GCV", full.search=TRUE,...,
        metric="euclidean", weights, maxiter=100, eps1=1e-10,
        eps2=1e-10, rel.gvar=0.95, eff.rank=NULL, offset, mustart=NULL, range.eff.rank) 
   
\method{dbglm}{dist}(distance,y,family=gaussian, method ="GCV", full.search=TRUE, weights,
        maxiter=100,eps1=1e-10,eps2=1e-10,rel.gvar=0.95,eff.rank=NULL,
        offset,mustart=NULL, range.eff.rank,...)
                
\method{dbglm}{D2}(D2,y,...,family=gaussian, method ="GCV", full.search=TRUE, weights,maxiter=100,
        eps1=1e-10,eps2=1e-10,rel.gvar=0.95,eff.rank=NULL,offset,
        mustart=NULL, range.eff.rank)

\method{dbglm}{Gram}(G,y,...,family=gaussian, method ="GCV", full.search=TRUE, weights,maxiter=100,
        eps1=1e-10,eps2=1e-10,rel.gvar=0.95,eff.rank=NULL,
        offset,mustart=NULL, range.eff.rank)              
}              
\arguments{

 \item{formula}{
      an object of class \code{\link{formula}}. A formula of the form \code{y~Z}.
	 This argument is a remnant of the \code{\link{glm}} function, 
	 kept for compatibility.
}
 \item{data}{
      an optional data frame containing the variables in the model 
	 (both response and explanatory variables, either
	 the observed ones, Z, or a Euclidean configuration X). 	  
}
 \item{y}{
     (required if no formula is given as the principal argument). 
	 Response (dependent variable) must be numeric, factor, matrix or data.frame.
}
  \item{distance}{
      a \code{dist} or \code{dissimilarity} class object. See functions
	 \code{\link{dist}} in the package \code{stats} and \code{\link{daisy}} 
	 in the package \code{cluster}.
}
  \item{D2}{
      a \code{D2} class object.  Squared distances matrix between individuals.  
	 See the Details section in \code{\link{dblm}} to learn the usage.
}
  \item{G}{
      a \code{Gram} class object. Doubly centered inner product matrix of the 
    squared distances matrix \code{D2}. See details in \code{\link{dblm}}.
}
  \item{family}{
      a description of the error distribution and link function to be used 
	  in the model. 
	  This can be a character string naming a family function, a family 
	  function or the result of a call to a family function. 
	  (See \code{\link{family}} for details of family functions.)
}

  \item{metric}{
      metric function to be used when computing distances from observed 
	  explanatory variables. 
	  One of \code{"euclidean"} (the default), \code{"manhattan"}, 
	  or \code{"gower"}. 
}
  \item{weights}{
       an optional numeric vector of prior weights to be used in the 
	   fitting process. 
	   By default all individuals have the same weight.  
}
   \item{method}{
      sets the method to be used in deciding the \emph{effective rank}, 
	  which is defined as the number of linearly independent Euclidean 
	  coordinates used in prediction. 
	  There are five different methods: \code{"AIC"}, \code{"BIC"}, 
	   \code{"GCV"}(default), \code{"eff.rank"} and 
	  \code{"rel.gvar"}.
     \code{GCV} take the effective rank minimizing 
	  a cross-validatory quantity. 
      \code{AIC} and \code{BIC} take the effective rank minimizing,
	  respectively, the Akaike or Bayesian Information Criterion 
	  (see \code{\link{AIC}} for more details). 
}
  \item{full.search}{sets which optimization procedure will be used to
	minimize the modelling criterion specified in \code{method}.
    Needs to be specified only if \code{method} is \code{"AIC"}, 
	\code{"BIC"} or \code{"GCV"}. 
    If \code{full.search=TRUE}, \emph{effective rank} is set to its
	global best value, after evaluating the criterion for all possible ranks.
	Potentially too computationally expensive.
    If \code{full.search=FALSE}, the \code{\link{optimize}} function 
	is called. Then computation time is shorter, but the result may be 
	found a local minimum. 
      
}  
  \item{maxiter}{
      maximum number of iterations in the iterated \code{dblm} algorithm. 
	  (Default = 100) 
}
  \item{eps1}{
      stopping criterion 1, \code{"DevStat"}: convergence tolerance \code{eps1}, 
	  a positive (small) number; 
	  the iterations converge when \code{|dev - dev_{old}|/(|dev|) < eps1}.
      Stationarity of deviance has been attained.
}
  \item{eps2}{
      stopping criterion 2, \code{"mustat"}: convergence tolerance \code{eps2},
	  a positive (small) number; 
	  the iterations converge when \code{|mu - mu_{old}|/(|mu|) < eps2}.
      Stationarity of fitted.values \code{mu} has been attained.
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
  \item{offset}{
      this can be used to specify an a priori known component to be included
	  in the linear predictor during fitting. This should be NULL or 
      a numeric vector of length equal to the number of cases.
}
  \item{mustart}{
      starting values for the vector of means.  
}              
  \item{range.eff.rank}{
      vector of size two defining the range of values for the effective rank with which the dblm iterations
      will be evaluated (must be specified when \code{method} is \code{"AIC"}, \code{"BIC"} or \code{"GCV"}). The range should 
      be restrict between \code{c(1,n-1)}.   
}      
 
  \item{\dots}{
    arguments passed to or from other methods to the low level. 
}
}
\details{   
    The various possible ways for inputting the model explanatory 
	information through distances, or their squares, etc., are the 
	same as in \code{\link{dblm}}. 
	
	For gamma distributions, the domain of the canonical link function 
	is not the same as the permitted range of the mean. In particular, 
	the linear predictor might be negative, obtaining an impossible 
	negative mean. Should that event occur, \code{dbglm} stops with
	an error message. Proposed alternative is to use a non-canonical link 
	function.
 
}
\value{
  A list of class \code{dbglm} containing the following components: 
 
  \item{residuals}{the \code{working} residuals, that is the \code{dblm}
		residuals in the last iteration of \code{dblm} fit.}
  
  \item{fitted.values}{the fitted mean values, results of final \code{dblm} 
	iteration.}
  
  \item{family }{the \code{\link{family}} object used. }
  
  \item{deviance}{measure of discrepancy or badness of fit. Proportional to 
		twice the difference between the maximum achievable log-likelihood and
        that achieved by the current model.}
  
  \item{aic.model }{a version of Akaike's Information Criterion. Equal to minus
					twice the maximized log-likelihood plus twice the number of
					parameters. Computed by the aic component of the family. 
					For binomial and Poison families the dispersion is fixed at
					one and the number of parameters is the number of coefficients. 
          For gaussian, Gamma and inverse gaussian families the dispersion is 
          estimated from the residual deviance, and the number of parameters is 
          the number of coefficients plus one. For a gaussian family the MLE 
          of the dispersion is used so this is a valid value of AIC, but for
          Gamma and inverse gaussian families it is not. For families fitted by 
          quasi-likelihood the value is NA. }
          
   \item{bic.model }{a version of the Bayessian Information Criterion. Equal to 
          minus twice the maximized log-likelihood plus the logarithm of the 
          number of observations by the number of parameters (see, e.g.,
          Wood 2006).}
          
   \item{gcv.model }{a version of the Generalized Cross-Validation Criterion. We
         refer to Wood (2006) pp. 177-178 for details.}
         
  \item{null.deviance }{the deviance for the null model. The null model will 
		include the offset, and an intercept if there is one in the model. 
		Note that this will be incorrect if the link function depends on 
		the data other than through the fitted mean: specify a zero offset 
		to force a correct calculation.}
  
  \item{iter }{number of Fisher scoring (\code{dblm}) iterations.}

  \item{prior.weights }{the original weights.}
  
  \item{weights }{the \code{working} weights, that are the weights in the 
				last iteration of \code{dblm} fit.}
  
  \item{df.residual }{the residual degrees of freedom.}

  \item{df.null }{ 	the residual degrees of freedom for the null model.}

  \item{y }{ the response vector used.}
  
  \item{convcrit }{convergence criterion. One of: \code{"DevStat"} 
		(stopping criterion 1), \code{"muStat"} (stopping criterion 2), 
		\code{"maxiter"} (maximum allowed number of iterations 
		has been exceeded).}

  \item{H }{hat matrix projector of the last \code{dblm} iteration.}
  
  \item{rel.gvar }{the relative geometric variabiliy in the last \code{dblm} iteration.}

  \item{eff.rank }{the \code{working} effective rank, that is the \code{eff.rank}
		in the last \code{dblm} iteration.}
		
  \item{varmu }{vector of estimated variance of each observation.}
		
  \item{dev.resids }{deviance residuals}
	
  \item{call }{the matched call.} 
	
  Objects of class \code{"dbglm"} are actually of class 
  \code{c("dbglm", "dblm")}, inheriting the \code{\link{plot.dblm}} method
   from class \code{"dblm"}.
   
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

Wood SN (2006). \emph{Generalized Additive Models: An Introduction with R}. Chapman & Hall,
Boca Raton.

}
\author{
Boj, Eva <evaboj@ub.edu>, Caballe, Adria <adria.caballe@upc.edu>,
Delicado, Pedro <pedro.delicado@upc.edu> and Fortiana, Josep <fortiana@ub.edu>
}
\note{
	When the Euclidean distance is used the \code{dbglm} model reduces 
	to the generalized linear  model (\code{glm}).  
}

\seealso{
  \code{\link{summary.dbglm}} for summary.\cr
  \code{\link{plot.dbglm}} for plots.\cr
  \code{\link{predict.dbglm}} for predictions.\cr
  \code{\link{dblm}} for distance-based linear models.
}
\examples{
## CASE POISSON
z <- rnorm(100)
y <- rpois(100, exp(1+z))
glm1 <- glm(y ~z, family = poisson(link = "log"))
D2 <- as.matrix(dist(z))^2
class(D2) <- "D2"
dbglm1 <- dbglm(D2,y,family = poisson(link = "log"), method="rel.gvar")

plot(z,y)
points(z,glm1$fitted.values,col=2)
points(z,dbglm1$fitted.values,col=3)
sum((glm1$fitted.values-y)^2)
sum((dbglm1$fitted.values-y)^2)

## CASE BINOMIAL
y <- rbinom(100, 1, plogis(z))
# needs to set a starting value for the next fit
glm2 <- glm(y ~z, family = binomial(link = "logit"))
D2 <- as.matrix(dist(z))^2
class(D2) <- "D2"
dbglm2 <- dbglm(D2,y,family = binomial(link = "logit"), method="rel.gvar")

plot(z,y)
points(z,glm2$fitted.values,col=2)
points(z,dbglm2$fitted.values,col=3)
sum((glm2$fitted.values-y)^2)
sum((dbglm2$fitted.values-y)^2)
}

