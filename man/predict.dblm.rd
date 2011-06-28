\name{predict.dblm}
\alias{predict.dblm}

\title{
 Predicted values for a dblm object
}

\description{
    \code{predict.dblm} returns the predicted values, obtained by evaluating the 
 distance regression function in the new data (\code{newdata}).
 \code{newdata} can be the values of the explanatory variables of these new 
 cases, the squared distances between these new individuals 
 and the originals ones, or rows of new doubly weighted and centered inner 
 products matrix G.
 }
 
\usage{
\method{predict}{dblm}(object,newdata,type="Z",...)
}

\arguments{
  \item{object}{
   an object of class \code{dblm}. Result of \code{\link{dblm}}.
 }
 \item{newdata}{
      data.frame or matrix which contains the values of Z (if \code{type_var="Z"} 
   and \code{dblm} has been called by \code{\link{dblm.formula}} format). 
   The squared distances between k new individuals and the original n 
   individuals (only if \code{type_var="D2"} and \code{dblm} has been called 
   by \code{\link{dblm.dist}} or \code{\link{dblm.D2}} format). 
   Finally, the G inner products matrix (if \code{type_var="G" } and \code{dblm}
   has been called by \code{\link{dblm.Gram}} format).
}
  \item{type}{
     set de type of newdata. Can be \code{"Z"} if newdata 
   contains the values of the explanatory variables, \code{"D2"} if 
   contains the squared distances matrix or \code{"G"} if contains the 
   inner products matrix.      
 }
 \item{\dots}{
    currently not used.
 }
}

\value{
\code{predict.dblm} produces a vector of predictions for the k new individuals.
}

\note{
  Look at which way (or \code{type}) was made the \code{dblm} call. 
 The parameter \code{type} must be consistent with the data type that is 
 introduced to \code{dblm}.    
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
 \code{\link{dblm}} for distance-based linear models.
}
\examples{

# prediction of new observations newdata
n <- 100
p <- 3
k <- 5

Z <- matrix(rnorm(n*p),nrow=n)
b <- matrix(runif(p)*k,nrow=p)
s <- 1
e <- rnorm(n)*s
y <- Z\%*\%b + e

D<-dist(Z)
D2<-disttoD2(D)
D2_train<-D2[1:90,1:90]
class(D2_train)<-"D2"

dblm1<-dblm.D2(y[1:90],D2_train)

newdata<-D2[91:100,1:90]
predict(dblm1,newdata,type="D2")


}



