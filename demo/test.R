library(onionR)

devtool::install_github("nexmodeling/ddd")
library(ddd)

mysnow <- block(namefield="snow",namespace="dddSnow",pathRes="~/")
mysnow$do("init.snow",args=list(method="manual",isoil=0,gisoil=0,spd=0,wcd=0,sca=0,nsno=0,alfa=0,ny=0,snowfree=0))
mysnow$save("test")
rm(mysnow)

mysnow <- block(namefield="snow",namespace="dddSnow",pathRes="~/")
mysnow$load(path="~/test/")
mysnow$values()
