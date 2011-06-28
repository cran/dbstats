\name{as.Gram}
\alias{as.Gram}
\alias{is.Gram}

\title{
  Gram objects
}
 \description{
  \code{as.Gram} attempts to turn its argument into a \code{Gram} class object. 
  
  
  \code{is.Gram} tests if its argument is a (strict) \code{Gram} class object. 
}
\usage{
  as.Gram(x)
  
  is.Gram(x)
}

\arguments{
 \item{x}{
  an R object.
}
}
\value{
 A \code{Gram} class object. Weighted centered inner products matrix of the 
    squared distances matrix. 
}
\author{
Boj, Eva <evaboj@ub.edu>, Caballe, Adria <adria.caballe@upc.edu>,
Delicado, Pedro <pedro.delicado@upc.edu> and Fortiana, Josep <fortiana@ub.edu>
}
\seealso{
 \code{\link{D2toG}}, \code{\link{disttoD2}}, \code{\link{D2toDist}} and 
 \code{\link{GtoD2}} for conversions.
}




