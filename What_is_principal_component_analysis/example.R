# First, I generate a set of points (in \mathbb{R}^2).
# I’ve chosen a low dimension so that pictures can be drawn that are compatible with some of the examples above. 
# Comments following commands appear after the # character.

set.seed(2)             #sets the seed for random number generation.
x <- 1:100              #creates a vector x with numbers from 1 to 100
ex <- rnorm(100, 0, 30) #100 normally distributed rand. nos. w/ mean=0, s.d.=30
ey <- rnorm(100, 0, 30) # " " 
y <- 30 + 2 * x         #sets y to be a vector that is a linear function of x
x_obs <- x + ex         #adds "noise" to x
y_obs <- y + ey         #adds "noise" to y
P <- cbind(x_obs,y_obs) #places points in matrix
plot(P,asp=1,col=1) 	#plot points
points(mean(x_obs),mean(y_obs),col=3, pch=19) #show center

# At this point a full PCA analysis can be undertaken in R using the command “prcomp”, 
# but in order to illustrate the algorithm I show all the steps below:

M <- cbind(x_obs-mean(x_obs),y_obs-mean(y_obs))#centered matrix
MCov <- cov(M)          #creates covariance matrix

# Note that the covariance matrix is proportional to the matrix $M^tM$. Next I turn to computation of the principal axes:

eigenValues <- eigen(MCov)$values       #compute eigenvalues
eigenVectors <- eigen(MCov)$vectors     #compute eigenvectors

d <- svd(M)$d          #the singular values
v <- svd(M)$v          #the right singular vectors

# The right singular vectors are the eigenvectors of M^tM.  Next I plot the principal axes:

lines(x_obs,eigenVectors[2,1]/eigenVectors[1,1]*M[x]+mean(y_obs),col=8)

# This shows the first principal axis. Note that it passes through the mean as expected. 
# The ratio of the eigenvectors gives the slope of the axis. Next

lines(x_obs,eigenVectors[2,2]/eigenVectors[1,2]*M[x]+mean(y_obs),col=8)

# shows the second principal axis, which is orthogonal to the first (recall that the matrix V^t in the 
# singular value decomposition is orthogonal). This can be checked by noting that the second principal axis is also

lines(x_obs,-1/(eigenVectors[2,1]/eigenVectors[1,1])*M[x]+mean(y_obs),col=8)

# as the product of orthogonal slopes is -1. Next, I plot the projections of the points onto the first principal component:

trans <- (M%*%v[,1])%*%v[,1] #compute projections of points
P_proj <- scale(trans, center=-cbind(mean(x_obs),mean(y_obs)), scale=FALSE) 
points(P_proj, col=4,pch=19,cex=0.5) #plot projections
segments(x_obs,y_obs,P_proj[,1],P_proj[,2],col=4,lty=2) #connect to points
