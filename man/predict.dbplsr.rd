\name{predict.dbplsr}
\alias{predict.dbplsr}

\title{
 Predicted values for a dbpls object
}

\description{
    \code{predict.dbplsr} returns the predicted values, obtained by evaluating the 
 Distance-based partial least squares function in the new data (\code{newdata}).
 \code{newdata} can be the values of the explanatory variables of these new 
 cases, the squared distances between these new individuals 
 and the originals ones, or rows of new doubly weighted and centered inner 
 products matrix G.
}
\usage{
\method{predict}{dbplsr}(object,newdata,type="Z",...)
}
                             
\arguments{
  \item{object}{
   an object of class \code{dbplsr}. Result of \code{\link{dbplsr}}.
 }
 \item{newdata}{
      data.frame or matrix which contains the values of Z (if \code{type_var="Z"} 
   and \code{dbplsr} has been called by \code{\link{dbplsr.formula}} format). 
   The squared distances between k new individuals and the original n 
   individuals (only if \code{type_var="D2"} and \code{dbplsr} has been called 
   by \code{\link{dbplsr.dist}} or \code{\link{dbplsr.D2}} format). 
   Finally, the G inner products matrix (if \code{type_var="G" } and \code{dbplsr}
   has been called by \code{\link{dbplsr.Gram}} format).
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
\code{predict.dbplsr} produces a vector of predictions for the k new individuals.
}

\note{
  Look at which way (or \code{type}) was made the \code{dbplsr} call. 
 The parameter \code{type} must be consistent with the data type that is 
 introduced to \code{dbplsr}.     
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
\seealso{
 \code{\link{dbplsr}} for distance-based partial least squares.
}
\examples{          
#require(pls)
# prediction of new observations newdata
library(pls)
data(yarn)
## Default methods:
yarn.dbplsr <- dbplsr(density[1:27] ~ NIR[1:27,], data = yarn, ncomp=6, method="GCV")
pr_yarn_28 <- predict(yarn.dbplsr,newdata=t(as.matrix(yarn$NIR[28,])))
print(pr_yarn_28)
print(yarn$density[28])


}



