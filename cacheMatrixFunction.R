# this function takes in a matrix and returns a list of three objects:
# (1) a get.mat function to retrieve the matrix object
# (2) a set.inverse function that takes in a matrix and sets it as an object called inverse
# (3) a get.inverse function that returns the inverse object
makeCacheMatrix <- function(mat = matrix()) {
  inverse <- NULL
  get.mat <- function() mat
  set.inverse <- function(temp.inverse) inverse <<- temp.inverse
  get.inverse <- function() inverse
  list(get.mat = get.mat,
       set.inverse = set.inverse,
       get.inverse = get.inverse)
}

# this function takes in a list of the form from makeCacheMatrix and returns the inverse of the matrix
# in that object if it exists and if is NULL then it computes the inverse of the matrix in that object
# note it assumes the matrix in the object above has a valid inverse
cacheSolve <- function(x, ...) {
  inverse <- x$get.inverse()
  if(!is.null(inverse)) {
    message("getting cached inverse")
    return(inverse)
  }
  mat <- x$get.mat()
  inverse <- solve(mat)
  x$set.inverse(inverse)
  inverse
}