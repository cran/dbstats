\name{D2toG}
\alias{D2toG}

\title{
  Distance conversion: D2 to G
}
\description{
  Converts \code{D2} class object into \code{Gram} class object.
}
\usage{
  D2toG(D2,weights)
}

\arguments{
  \item{D2}{
      \code{D2} object. Squared distances matrix between individuals.  
}
  \item{weights}{
     an optional numeric vector of weights. By default all individuals 
     have the same weight.  
}
}
\value{
     An object of class \code{Gram} containing the Doubly centered 
     inner product matrix of \code{D2}.
}
\author{
Boj, Eva <evaboj@ub.edu>, Caballe, Adria <adria.caballe@upc.edu>,
Delicado, Pedro <pedro.delicado@upc.edu> and Fortiana, Josep <fortiana@ub.edu>
}
\seealso{
 \code{\link{GtoD2}}\cr 
 \code{\link{disttoD2}}\cr
 \code{\link{D2toDist}}
}
\examples{

X <- matrix(rnorm(100*3),nrow=100)
D2 <- as.matrix(dist(X)^2)
class(D2) <- "D2"
G <- D2toG(D2,weights=NULL)

}



