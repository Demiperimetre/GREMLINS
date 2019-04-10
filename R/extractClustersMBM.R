#' Plot the mesoscopic view  of the estimated MBM
#'
#' #'
#' @param fittedMBM A fitted Generalized BlockModel
#' @param whichModel The index corresponding to the model to plot (default is 1, the best model)
#' @examples
#' npc1 <- 20 # number of nodes per block for functional group 1
#' Q1 <- 3 # blocks   for functional group 1
#' n1 <- npc1 * Q1 # number of nodes for functional group 1
#' Z1 <- diag(Q1)%x%matrix(1,npc1,1)
#' P1 <- matrix(runif(Q1*Q1),Q1,Q1)
#' A <- 1*(matrix(runif(n1*n1),n1,n1)<Z1%*%P1%*%t(Z1)) ## adjacency matrix
#' Agr <- defineNetwork(A,"diradj","FG1","FG1")  # First network
#' npc2 <- 40 #  number of nodes per block for functional group 2
#' Q2 <- 2 # blocks   for functional group 2
#' n2 <- npc2 * Q2 #  number of nodes for functional group 2
#' Z2 <- diag(Q2)%x%matrix(1,npc2,1)
#' P2 <- matrix(runif(Q1*Q2),Q1,Q2)
#' B <- 1*(matrix(runif(n1*n2),n1,n2)<Z1%*%P2%*%t(Z2)) ## incidence matrix
#' Bgr <- defineNetwork(B,"inc","FG1","FG2")
#' res <-   multipartiteBM(list(Agr,Bgr),namesFG = NULL,v_Kmin = 1,v_Kmax = 10,v_Kinit = NULL,verbose = TRUE, save=FALSE)
#' extractClustersMBM (res,whichModel = 1)
#' @export

extractClustersMBM = function(fittedMBM,whichModel = 1){


  dataR6 <- formattingData(fittedMBM$list_Net)
  param <- fittedMBM$fittedModel[[whichModel]]$paramEstim
  vK_estim <- param$v_K
  clusters <- lapply(1:length(vK_estim),function(q){lapply(1:vK_estim[q],function(l){
    namesq <- names(param$Z[[q]])
    if (is.null(namesq)){namesq <- 1:length(param$Z[[q]])}
    clustql <- namesq[param$Z[[q]] == l]
    return(clustql)})})
  names(clusters) <- dataR6$namesFG
  return(clusters)
}
