\name{swissalt}
\docType{data}
\alias{swissalt}
\title{Elevation in Switzerland}
\usage{data(swissalt)}
\description{
  Data required for plotting a Switzerland map with elevation.
  }
\format{This data set contains three R objects. 'alt.mat' is a 192 by
  115 matrix giving the elevation at the grid points defined by
  'lon.vec' and 'lat.vec'.}
\examples{
data(swissalt)

layout(matrix(c(1,2), 1), width = c(3.5,1))
mar <- rep(0, 4)
op <- par(mar = mar)
breaks <- seq(0, 2000, by = 250)
image(lon.vec, lat.vec, alt.mat, col = terrain.colors(length(breaks) - 1),
      xaxt = "n", yaxt = "n", bty = "n", xlab = "", ylab = "", xlim =
c(480, 840), ylim = c(58, 300))
swiss(add = TRUE, city = TRUE)

##Heat bar
mar <- c(3, 3, 3, 4)
par(las = 1, mar = mar)

plot.new()
plot.window(xlim = c(0, 1), ylim = range(breaks), xaxs = "i", 
            yaxs = "i")
rect(0, breaks[-length(breaks)], 1, breaks[-1], col = terrain.colors(length(breaks) - 1),
     border = NA)
axis(4, at = breaks[-length(breaks)])
box()
title("Elevation\n(meters)")
par(op)
}
\author{Mathieu Ribatet}
\keyword{datasets}
