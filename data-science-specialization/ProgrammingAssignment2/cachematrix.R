## This group of functions caches the inverse of a matrix 
## so that the inverse of the matrix is readily available if
## the inverse needs to be calculated again.

## The following function caches the inverse of the passed 
## special "matrix" to be utilized by the function cacheSolve

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  
  set <- function(y){
    x <<- y
    m <<- NULL
  }
  
  get <- function() x
  
  setinverse <- function(solve) m<<- solve
  
  getinverse <- function() m
  list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}


## The following function calculates the inverse of the special "matrix"
## by first checking to see if the inverse of the special "matrix" has
## already been calculated with makeCacheMatrix.  If not, then cacheSolve
## will calculate the inverse of the special "matrix" with the built in R
## function solve().

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m <- x$getinverse()
  if(!is.null(m)){
    message("getting cached data")
    return(m)
  }
  
  data <- x$get()
  m <- solve(data, ...)
  x$setinverse(m)
  m
}
