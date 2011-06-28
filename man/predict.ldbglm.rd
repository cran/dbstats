\name{predict.ldbglm}
\alias{predict.ldbglm}
\alias{print.predict.ldbglm}

\title{
 Predicted values for a ldbglm object
}

\description{
 \code{predict.ldbglm} returns the predicted values, obtained by evaluating
  the local distance-based generalized linear model in the new data 
  (\code{newdata2}), using \code{newdata1} to estimate the "kernel weights".
 }
 
\usage{
\method{predict}{ldbglm}(object,newdata1,newdata2=newdata1,
        new.k.knn=3,type.pred=c("link","response"),
        type.var="Z",...)
}

\arguments{
  \item{object}{
   an object of class \code{ldbglm}. Result of \code{\link{ldbglm}}.
 }
 \item{newdata1}{
 data.frame or matrix which contains the values of Z (if \code{type.var="Z"}. 
The squared distances between k new individuals and the original n individuals (only if \code{type.var="D2"}). 
Finally, the G inner products matrix (if \code{type.var="G"}). \code{newdata1} is used to compute kernels and local weights.
 }
  \item{newdata2}{
     the same logic as \code{newdata1}.
   \code{newdata2} is used to compute the distance-based generalized regressions 
   with (\code{\link{dbglm}}). If \code{newdata2}=NULL, \code{newdata2 <- newdata1}.
 }
  \item{new.k.knn}{
     setting a minimum bandwidth in order to check that a candidate bandwidth h
   doesn't contains DB linear models with only one observation.
   If \code{new.h.knn=NULL}, takes the distance that includes the 3 nearest
   neighbors for each new individual row. 
 }
  \item{type.pred}{
    the type of prediction (required). The default \code{link} is on the 
    scale of the linear predictors; the alternative \code{"response"} 
    is on the scale of the response variable. 
 } 
  \item{type.var}{
      set de type of the newdata paramater. Can be \code{"Z"} if newdata
    contains the values of the explanatory variables, \code{"D2"} if contains 
    the squared distances matrix or \code{"G"} if contains the inner 
    products matrix. 
 }
 \item{\dots}{
       arguments passed to or from other methods to the low level. 
 }
}
\value{                
  A list of class \code{predict.ldbglm} containing the following components: 
 
  \item{fit }{predicted values for the k new individuals.}
  \item{newS }{matrix (with dimension (k,n)) of weights used to compute the predictions.} 
}
\note{
 Look at which way (or \code{type.var}) was made the \code{ldbglm} call. The parameter 
 \code{type.var} must be consistent with the data type that is introduced 
 to \code{ldbglm}.    
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
 \code{\link{ldbglm}} for local distance-based generalized linear models.
}
\examples{

# example to use of the predict.ldbglm function
 z <- rnorm(100)
 y <- rpois(100, exp(1+z))
 glm5 <- glm(y ~z, family=quasi("identity"))
 ldbglm5 <- ldbglm(dist(z),y=y,family=quasi("identity"),noh=3)
 plot(z,y)
 points(z,glm5$fitt,col=2)
 points(z,ldbglm5$fitt,col=3)

 pr_ldbglm5 <- predict(ldbglm5,as.matrix(dist(z)^2),type.pred="response",type.var="D2")
 max(pr_ldbglm5$fit-ldbglm5$fitt)

}



