# following geostatistics book by diggle and ribbeiro 2007 
install.packages("sos")
require("sos")
findFn("neural")
findFn("polygon approximation")
??aproximating
?envelope 
??envelope
findFn("approximate polygon")
findFn("remove rows with NA")
class(gambia)
data(gambia)

class(data)
install.packages("spatstat")
require("spatstat")
owin1 = owin(poly = list(x=rev(gambia.borders1$x), y=rev(gambia.borders1$y)))
gambia.map()
plot(owin1)
class(gambia.borders1$x)
findFn("polygon anticlockwise")
ga = as.geodata(gambia, data.col = 7)
points(ga)
?points
summary(gambia)

?as.geodata

install.packages(("polyCub"))
require(polyCub)
gambia.borders2 = xylist(gambia.borders1)
xylist(gambia.borders1, reverse)


plot(owin1)
summary(gambia.borders)
class(gambia.borders)
gambia.borders[1:3,]
help.search("list")
borderlist = as.list.data.frame(gambia.borders)
?list
a = c(1,1,1,1)

class(a)
class(gambia.borders$x)
gambia.borders$x

gambia.borders1 = gambia.borders[!(is.na(gambia.borders$x) | is.na(gambia.borders$y)),]


data(gambia)

#
require(geoR)
require(geoRglm)
elevation = read.geodata("elevation.txt")
data("elevation")
points(elevation, cex.min = 1, cex.max = 4, pt.divide = "quint")
args(points.geodata)

data(package="geoR")
summary(elevation)
plot(elevation, lowess = T)

data("rongelap")
names(rongelap)
summary(rongelap)
points(rongelap, col="grey")
rongwest <- subarea(rongelap, xlim = c(-6100, -5200))
rongwest.z <- zoom.coords(rongwest, xzoom = 3.5, xoff = 1000,  yoff = 3000)
points(rongwest.z, col = "gray", add = T)

rect.coords(rongwest$sub, lty = 2, quiet = T) 
rect.coords(rongwest.z$sub, lty = 2, quiet = T) 
text(-4000, 1100, "western area", cex = 1.5)

data(gambia)
gambia.map()
gambia[1:3,]

data(camg)
mg20 <- as.geodata(camg, data.col = 6)
points(mg20, cex.min = 0.2, cex.max = 1.5, pch = 21)
data(ca20)
polygon(ca20$reg1, lty = 2)
?polygon()
summary(ca20)

summary(gambia)
class(gambia)

polygon(gambia)
summary(rongelap)

class(elevation)
summary(elevation)
?lm()
findFn("analyse residuals of model")
RSiteSearch("analyseandresiduals")
help.search("residuals")
?plot()

str(elevation)
elevation$data
plot(elevation$data, residuals(l1.3))
 
data(parana)
help(parana)
