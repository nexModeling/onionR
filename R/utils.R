getTmpDir <- function(){
  username <- Sys.info()[["effective_user"]];
  newtmpdir <- normalizePath(file.path(rootTmpDir(),paste0("onionR-",username),format(Sys.time(), "%Y-%m-%d-%H-%M-%S",tz="GMT")),mustWork = FALSE)
  dir.create(newtmpdir, showWarnings = FALSE, recursive = TRUE)
  return(newtmpdir)
}

rootTmpDir <- function() {
  tm <- Sys.getenv(c('TMPDIR', 'TMP', 'TEMP'))
  d <- which(file.info(tm)$isdir & file.access(tm, 2) == 0)
  if (length(d) > 0) {
    res <- tm[[d[1]]]
  } else if (.Platform$OS.type == 'windows') {
    res <- Sys.getenv('R_USER')
  } else res <- '/tmp'
  return(res)
}

action <-function(namespace=NULL,fun=NULL,args=NULL){
  FUN <- getFromNamespace(x=fun, ns=namespace)
  assign("res",do.call(FUN,args))
  return(res)
}

saveFile <- function(x,xname,path,format="rda"){
  assign("myValues",x)
  do.call("save",list(obj="myValues", file=normalizePath(file.path(path,paste0(xname,".",format)),mustWork = FALSE)))
}
