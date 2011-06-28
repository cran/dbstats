\name{predict.dbglm}
\alias{predict.dbglm}

\title{
 Predicted values for a dbglm object
}

\description{
    \code{predict.dbglm} returns the predicted values, obtained by tested the 
  generalized distance regression function in the new data (\code{newdata}). 
 }
 
\usage{
\method{predict}{dbglm}(object,newdata,type.pred=c("link", "response"),
        type.var="Z",...)
}

\arguments{
  \item{object}{
   an object of class \code{dbglm}. Result of \code{\link{dbglm}}.
 }
  \item{newdata}{
 data.frame or matrix which contains the values of Z (if \code{type.var="Z"}. 
The squared distances between k new individuals and the original n individuals (only if \code{type.var="D2"}). 
Finally, the G inner products matrix (if \code{type.var="G"}).

 }
  \item{type.pred}{
     the type of prediction (required). The default \code{"link"} is on the scale 
   of the linear predictors; the alternative \code{"response"} is on the scale 
   of the response variable. 
 }
  \item{type.var}{
     set de type of newdata. Can be \code{"Z"} if newdata 
   contains the values of the explanatory variables, \code{"D2"} if 
   contains the squared distances matrix or \code{"G"} if contains the 
   inner products matrix.    
 }
 \item{\dots}{
        arguments passed to or from other methods to the low level. 
 }
}

\details{
    The predicted values may be the expected mean values of response for the new 
 data (\code{type.pred="response"}), or the linear predictors evaluated in the 
 estimated \code{dblm} of the last iteration.
 
    In classical linear models the mean and the linear predictor are the same 
 (makes use of the identity link). However, other distributions such as 
 Poisson or binomial, the link could change. It's easy to get the predicted 
 mean values, as these are calculated by the inverse link of linear predictors. 
 See \code{\link{family}} to view how to use \code{linkfun} and \code{linkinv}.    
}

\value{
\code{predict.dbglm} produces a vector of predictions for the k new individuals.
}

\note{
    Look at which way (or \code{type.var}) was made the dbglm call.
  The parameter \code{type.var} must be consistent with the data type 
  that is introduced to \code{dbglm}.    
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
 \code{\link{dbglm}} for distance-based generalized linear models.\cr
}
\examples{

z <- rnorm(100)
y <- rpois(100, exp(1+z))
glm1 <- glm(y ~z, family=quasi("identity"))
dbglm1 <- dbglm(y~z,family=quasi("identity"), method="rel.gvar")

newdata<-0

pr1 <- predict(dbglm1,newdata,type.pred="response",type.var="Z")
print(pr1)
plot(z,y)
points(z,dbglm1$fitt,col=2)
points(0,pr1,col=2)
abline(v=0,col=2)
abline(h=pr1,col=2)

}



