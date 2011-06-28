\name{predict.ldblm}
\alias{predict.ldblm}
\alias{print.predict.ldblm}

\title{
 Predicted values for a ldblm object
}

\description{
 \code{predict.ldblm} returns the predicted values, obtained by evaluating
  the local distance-based linear model in the new data 
  (\code{newdata2}), using \code{newdata1} to estimate the "kernel weights".
 }
 
\usage{                                  
\method{predict}{ldblm}(object,newdata1,newdata2=newdata1,
        new.k.knn=3,type="Z",...)
}

\arguments{
  \item{object}{
   an object of class \code{ldblm}. Result of \code{\link{ldblm}}.
 }
 \item{newdata1}{
       data.frame or matrix which contains the values of Z 
    (if \code{type_var="Z"} and \code{ldblm} has been called by 
    \code{\link{ldblm.formula}} format), the squared distances between 
    k new individuals and the original n individuals (only if \code{type="D2"}
    and \code{ldblm} has been called by \code{\link{ldblm.dist}} format), 
    and the G inner products matrix (if \code{type="G"}  and 
    \code{ldblm} has been called by \code{\link{ldblm.Gram}} format).
    \code{newdata1} is used to compute kernels and local weights.
 }
  \item{newdata2}{
      the same logic as \code{newdata1}.
   \code{newdata2} is used to compute the Distance-based Regressions with
   (\code{\link{dblm}}). If \code{newdata2}=NULL, \code{newdata2 <- newdata1}.
}
  \item{new.k.knn}{
     setting a minimum bandwidth in order to check that a candidate bandwidth h
   doesn't contains DB linear models with only one observation.
   If \code{new.h.knn=NULL}, takes the distance that includes the 3 nearest
   neighbors for each new individual row. 
 }
  \item{type}{
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
  A list of class \code{predict.ldblm} containing the following components: 
 
  \item{fit }{predicted values for the k new individuals.}
  \item{newS }{matrix (with dimension (k,n)) of weights used to compute the predictions.} 
}
\note{
    Look at which way (or \code{type}) was made the \code{ldblm} call. 
    The parameter \code{type} must be consistent with the data type that 
    is introduced to \code{ldblm}.    
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
 \code{\link{ldblm}} for local distance-based linear models.
}
\examples{

# example to use of the predict.ldblm function

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

D<-as.matrix(dist(Z))
D2<-D^2

newdata1<-0

ldblm1<-ldblm(y~Z,kind.of.kernel=1,method="GCV",noh=3,k.knn=3)
pr1<-predict(ldblm1,newdata1)
print(pr1)
plot(Z,y)
points(0,pr1$fit,col=2)
abline(v=0,col=2)
abline(h=pr1$fit,col=2)

}



