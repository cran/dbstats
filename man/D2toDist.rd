\name{D2toDist}
\alias{D2toDist}

\title{
      Distance conversion: D2 to dist
}
\description{
  Converts \code{D2} class object into \code{dist} class object.
}
\usage{
  D2toDist(D2)
}

\arguments{
   \item{D2}{
      \code{D2} object. Squared distances matrix between individuals.
}
}
\value{
     An object of class \code{dist}. See function \code{\link{dist}} for 
     details.
}
\author{
Boj, Eva <evaboj@ub.edu>, Caballe, Adria <adria.caballe@upc.edu>,
Delicado, Pedro <pedro.delicado@upc.edu> and Fortiana, Josep <fortiana@ub.edu>
}
\seealso{
 \code{\link{GtoD2}}\cr
 \code{\link{D2toG}}\cr 
 \code{\link{disttoD2}}
}
\examples{

X <- matrix(rnorm(100*3),nrow=100)
distance <- daisy(X,"manhattan")
D2 <- disttoD2(distance)
distance2 <- D2toDist(D2)

}



