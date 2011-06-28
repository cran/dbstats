\name{GtoD2}
\alias{GtoD2}

\title{
  Distance conversion: dist to D2
}
 \description{
  Converts \code{Gram} class object into \code{D2} class object
}
\usage{
  GtoD2(G)
}

\arguments{
  \item{G}{
      \code{Gram} class object. Weighted centered inner products matrix of the 
    squared distances matrix. 
}
}
\value{
     An object of class \code{D2} containing the squared distances matrix 
     between individuals.
}

\author{
Boj, Eva <evaboj@ub.edu>, Caballe, Adria <adria.caballe@upc.edu>,
Delicado, Pedro <pedro.delicado@upc.edu> and Fortiana, Josep <fortiana@ub.edu>
}
\seealso{
 \code{\link{D2toG}}\cr 
 \code{\link{disttoD2}}\cr 
 \code{\link{D2toDist}}
}
\examples{

X <- matrix(rnorm(100*3),nrow=100)
D2 <- as.matrix(dist(X)^2)
class(D2) <- "D2"
G <- D2toG(D2,weights=NULL)
class(G) <- "Gram"
D22 <- GtoD2(G)


}
