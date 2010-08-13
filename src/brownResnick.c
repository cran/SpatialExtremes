#include "header.h"

void brownresnickfull(double *data, double *dist, int *nSite, int *nObs, int *weighted,
		      double *weights, double *locs, double *scales, double *shapes,
		      double *range, double *smooth, int *fitmarge, double *dns){
  /*This is the Brown-Resnick model. It computes the pairwise
    log-likelihood */
  
  const int nPairs = *nSite * (*nSite - 1) / 2;
  int i;
  double *jac, *rho, *frech;

  jac = (double *)R_alloc(*nSite * *nObs, sizeof(double));
  rho = (double *)R_alloc(nPairs, sizeof(double));
  frech = (double *)R_alloc(*nSite * *nObs, sizeof(double));

  //Some preliminary steps: Valid points?
  if (*fitmarge){
    for (i=0;i<*nSite;i++){
      if ((scales[i] <= 0) || (shapes[i] <= -1)){
	*dns = MINF;
	return;
      }
    }
  }
   
  //Stage 0: Compute the covariance at each location
  *dns = brownResnick(dist, nPairs, *range, *smooth, rho);

  if (*dns != 0.0)
    return;
    
  //Stage 1: Transformation to unit Frechet
  if (*fitmarge){
    *dns = gev2frech(data, *nObs, *nSite, locs, scales, shapes,
		     jac, frech);

    if (*dns != 0.0)
      return;
    
    if (*weighted)
      *dns = wlpliksmith(frech, rho, jac, *nObs, *nSite, weights);

    else
      *dns = lpliksmith(frech, rho, jac, *nObs, *nSite);
  }
    
  else {
    memset(jac, 0, *nSite * *nObs * sizeof(double));
   
    if (*weighted)
      *dns = wlpliksmith(data, rho, jac, *nObs, *nSite, weights);

    else
      *dns = lpliksmith(data, rho, jac, *nObs, *nSite);
  }  
  
  if (!R_FINITE(*dns))
    *dns = MINF;

  return;

}

void brownresnickdsgnmat(double *data, double *dist, int *nSite, int *nObs, int *weighted,
			 double *weights, double *locdsgnmat, double *locpenmat, int *nloccoeff,
			 int *npparloc, double *locpenalty, double *scaledsgnmat, double *scalepenmat,
			 int *nscalecoeff, int *npparscale, double *scalepenalty, double *shapedsgnmat,
			 double *shapepenmat, int *nshapecoeff, int *npparshape, double *shapepenalty,
			 int *usetempcov, double *tempdsgnmatloc, double *temppenmatloc,
			 int *ntempcoeffloc, int *nppartempcoeffloc, double *temppenaltyloc,
			 double *tempdsgnmatscale, double *temppenmatscale, int *ntempcoeffscale,
			 int *nppartempcoeffscale, double *temppenaltyscale, double *tempdsgnmatshape,
			 double *temppenmatshape, int *ntempcoeffshape, int *nppartempcoeffshape,
			 double *temppenaltyshape, double *loccoeff, double *scalecoeff,
			 double *shapecoeff, double *tempcoeffloc, double *tempcoeffscale,
			 double *tempcoeffshape,double *range, double *smooth, double *dns){
  /* This is the Brown-Resnick model The GEV parameters are defined
     using a polynomial response surface */
  
  const int nPairs = *nSite * (*nSite - 1) / 2;
  int flag = usetempcov[0] + usetempcov[1] + usetempcov[2];
  double *jac, *rho, *locs, *scales, *shapes, *frech, *trendlocs, *trendscales, *trendshapes;

  jac = (double *)R_alloc(*nObs * *nSite, sizeof(double));
  rho = (double *)R_alloc(nPairs, sizeof(double));
  locs = (double *)R_alloc(*nSite, sizeof(double));
  scales = (double *)R_alloc(*nSite, sizeof(double));
  shapes = (double *)R_alloc(*nSite, sizeof(double));
  frech = (double *)R_alloc(*nObs * *nSite, sizeof(double));
  
  //Stage 1: Compute the covariance at each location
  *dns = brownResnick(dist, nPairs, *range, *smooth, rho);

  if (*dns != 0.0)
    return;
    
  //Stage 2: Compute the GEV parameters using the design matrix
  *dns = dsgnmat2Param(locdsgnmat, scaledsgnmat, shapedsgnmat, loccoeff, scalecoeff, shapecoeff,
		       *nSite, *nloccoeff, *nscalecoeff, *nshapecoeff, locs, scales, shapes);

  if (flag){
    int i, j;
    trendlocs = (double *)R_alloc(*nObs, sizeof(double));
    trendscales = (double *)R_alloc(*nObs, sizeof(double));
    trendshapes = (double *)R_alloc(*nObs, sizeof(double));

    dsgnmat2temptrend(tempdsgnmatloc, tempdsgnmatscale, tempdsgnmatshape, tempcoeffloc,
		      tempcoeffscale, tempcoeffshape, *nSite, *nObs, usetempcov, *ntempcoeffloc,
		      *ntempcoeffscale, *ntempcoeffshape, trendlocs, trendscales, trendshapes);

    for (i=*nSite;i--;)
      for (j=*nObs;j--;)
	if (((scales[i] + trendscales[j]) <= 0) || ((shapes[i] + trendshapes[j]) <= -1)){
	  *dns = MINF;
	  return;
	}
  }

  else if (*dns != 0.0)
    return;

  //Stage 3: Transformation to unit Frechet
  if (flag)
    *dns = gev2frechTrend(data, *nObs, *nSite, locs, scales, shapes, trendlocs, trendscales,
			  trendshapes, jac, frech);
  
  else
    *dns = gev2frech(data, *nObs, *nSite, locs, scales, shapes, jac, frech);

  if (*dns != 0.0)
    return;
    
  if (*weighted)
    *dns = wlpliksmith(frech, rho, jac, *nObs, *nSite, weights);

  else
    *dns = lpliksmith(frech, rho, jac, *nObs, *nSite);
  //Stage 5: Removing the penalizing terms (if any)
  // 1- For the location parameter
  if (*locpenalty > 0)
    *dns -= penalization(locpenmat, loccoeff, *locpenalty, *nloccoeff, *npparloc);
  
  // 2- For the scale parameter
  if (*scalepenalty > 0)    
    *dns -= penalization(scalepenmat, scalecoeff, *scalepenalty, *nscalecoeff, *npparscale);
  
  // 3- For the shape parameter
  if (*shapepenalty > 0)
    *dns -= penalization(shapepenmat, shapecoeff, *shapepenalty, *nshapecoeff, *npparshape);

  // 4- Doing the same thing for the temporal component
  if (*temppenaltyloc > 0)
    *dns -= penalization(temppenmatloc, tempcoeffloc, *temppenaltyloc, *ntempcoeffloc,
			 *nppartempcoeffloc);

  if (*temppenaltyscale > 0)
    *dns -= penalization(temppenmatscale, tempcoeffscale, *temppenaltyscale, *ntempcoeffscale,
			 *nppartempcoeffscale);

  if (*temppenaltyshape > 0)
    *dns -= penalization(temppenmatshape, tempcoeffshape, *temppenaltyshape, *ntempcoeffshape,
			 *nppartempcoeffshape);

  return;
  
}