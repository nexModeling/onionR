#' block
#'
#' block
#' @param namefield name of the field
#' @param namespace namespace of the package
#' @param pathRes path of the results
#' @keywords onionR
#' @export
block <- function(namefield,namespace,pathRes) {

   myBlockEnv    <- environment()
   pathDir       <- pathRes
   myNamefield   <- namefield
   myNamespace   <- namespace
   myValues      <- NULL
   #myModel       <- NULL
   act           <- action
   svF           <- saveFile

   blockL <- list(
     env        = myBlockEnv,
     namefield  = function() {return(get("myNamefield",myBlockEnv))},
     namespace  = function() {return(get("myNamespace",myBlockEnv))},
     values     = function() {return(get("myValues",myBlockEnv))},
     do     = function(fun,args) {
       assign("res",act(namespace=myNamespace,fun=fun,args=args))
       assign("myValues",res,myBlockEnv)
       invisible()
     },
     load   = function(path) {
       path <- normalizePath(file.path(path,paste0(myNamefield,".rda")),mustWork = FALSE)
       load(path, envir=myBlockEnv)
       invisible()
     },
     save       = function(name){
       path <- normalizePath(file.path(pathDir,name),mustWork = FALSE)
       dir.create(path, showWarnings = FALSE, recursive = TRUE)
       svF(x=myValues,xname=myNamefield,path=path,format="rda")}
   )

   assign('this',blockL,envir=myBlockEnv)
   class(blockL) <- append("block","list")
   return(blockL)

}
