\name{dbstats-package}
\alias{dbstats-package}
\alias{dbstats}
\docType{package}
\title{
  Distance-based statistics (dbstats)
}
\description{
	This package contains functions for distance-based prediction methods. 
  
	These are methods for prediction where predictor information is coded
	as a matrix of distances between individuals. 
   
	In the currently implemented methods the response is a univariate variable
	as in the ordinary linear model or in the generalized linear model.
   
	Distances can either be directly input as an interdistances matrix,
	a squared interdistances matrix, an inner-products matrix 
	(see \code{\link[dbstats]{GtoD2}}) or computed from observed 
	explanatory variables. 

	Notation convention: in distance-based methods we must distinguish 
	\emph{observed explanatory variables} which we denote by Z or z, from 
	\emph{Euclidean coordinates} which we denote by X or x. For explanation
	on the meaning of both terms see the bibliography references below.

	Observed explanatory variables z are possibly a mixture of continuous and 
	qualitative explanatory variables or more general quantities.
                                        
	\pkg{dbstats} does not provide specific functions for computing distances,
	depending instead on other functions and packages, such as:
	\itemize{
  
	\item \code{\link[stats]{dist}} in the \pkg{stats} package.
	
	\item \code{\link[proxy]{dist}} in the \pkg{proxy} package. When the 
	\pkg{proxy} package is loaded, its \code{\link[proxy]{dist}} function 
	supersedes the one in the \pkg{stats} package.
  
	\item \code{\link[cluster]{daisy}} in the \pkg{cluster} package. 
	Compared to both instances of \code{\link{dist}} above whose input must be 
	numeric variables, the main feature of \code{\link[cluster]{daisy}} is 
	its ability to handle other variable types as well (e.g. nominal, ordinal, 
	(a)symmetric binary) even when different types occur in the same data set.
	
	Actually the last statement is not hundred percent true: it refers only to
	the default behaviour of both \code{\link{dist}} functions, whereas the 
	\code{\link[proxy]{dist}} function in the \pkg{proxy} package can 
	evaluate distances between observations with a user-provided function, 
	entered as a parameter, hence it can deal with any type of data. See the
	examples in \code{\link[proxy]{pr_DB}}.

	  
	}
	
	Functions of \pkg{dbstats} package:  \cr
    
    Linear and local linear models with a continuous response: 
    \itemize{
    \item \code{\link{dblm}} for distance-based linear models.
    \item \code{\link{ldblm}} for local distance-based linear models.
    \item \code{\link{dbplsr}} for distance-based partial least squares.   \cr
    }

    
	Generalized linear and local generalized linear models with a numeric response:
    \itemize{
    \item \code{\link{dbglm}} for distance-based generalized linear models.
    \item \code{\link{ldbglm}} for local distance-based generalized linear models.  
    }
	
}
\details{
\tabular{ll}{
Package: \tab dbstats\cr
Type: \tab Package\cr
Version: \tab 1.0.1\cr
Date: \tab 2011-06-21\cr
License: \tab 	GPL-2\cr
LazyLoad: \tab yes\cr     
}

}
\author{
Boj, Eva <evaboj@ub.edu>, Caballe, Adria <adria.caballe@upc.edu>, Delicado, 
 Pedro <pedro.delicado@upc.edu> and Fortiana, Josep <fortiana@ub.edu>

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


