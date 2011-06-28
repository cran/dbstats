\name{as.D2}
\alias{as.D2}
\alias{is.D2}

\title{
  D2 objects
}
 \description{
  \code{as.D2} attempts to turn its argument into a \code{D2} class object.


  \code{is.D2} tests if its argument is a (strict) \code{D2} class object.
}
\usage{
  as.D2(x)

  is.D2(x)
}

\arguments{
 \item{x}{
  an R object.
}
}
\value{
     An object of class \code{D2} containing the squared distances 
     matrix between individuals.
}

\author{
Boj, Eva <evaboj@ub.edu>, Caballe, Adria <adria.caballe@upc.edu>,
Delicado, Pedro <pedro.delicado@upc.edu> and Fortiana, Josep <fortiana@ub.edu>
}
\seealso{
 \code{\link{D2toG}}, \code{\link{disttoD2}}, \code{\link{D2toDist}} and 
 \code{\link{GtoD2}} for conversions.
}

