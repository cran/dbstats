\name{disttoD2}
\alias{disttoD2}

\title{
  Distance conversion: dist to D2
}
\description{
  Converts \code{dist} or \code{dissimilarity} class object into \code{D2} class object.
}
\usage{
  disttoD2(distance)
}

\arguments{
    \item{distance}{
      \code{dist} or \code{dissimilarity} class object. See functions
	  \code{\link{dist}} in the package \code{stats} and \code{\link{daisy}}
	  in the package \code{cluster}.
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
 \code{\link{GtoD2}}\cr 
 \code{\link{D2toG}}\cr 
 \code{\link{D2toDist}}
}
\examples{

X <- matrix(rnorm(100*3),nrow=100)
distance<-daisy(X,"manhattan")
D2 <- disttoD2(distance)

}



