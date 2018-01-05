(TeX-add-style-hook
 "SpatialExtremesGuide"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("book" "a4paper" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8")))
   (TeX-run-style-hooks
    "latex2e"
    "book"
    "bk11"
    "SpatialExtremes"
    "inputenc")
   (TeX-add-symbols
    "cleardoublepage")
   (LaTeX-add-labels
    "cha:introduction"
    "sec:what-spat-pack"
    "sec:obta-pack"
    "cha:an-introduction-max"
    "eq:maxstab-def"
    "eq:CDFFrechet"
    "sec:smiths-char"
    "eq:smithChar"
    "eq:smith"
    "fig:Smith2sim"
    "eq:svdSigma"
    "sec:schl-char"
    "eq:SchlatherChar"
    "eq:schlather"
    "fig:covariances"
    "fig:Schlather2sim"
    "fig:anisoCovFun"
    "eq:ellipticalCorrFun"
    "cha:uncond-simul-rand"
    "sec:simul-gauss-proc"
    "sec:direct-approach"
    "eq:directDecomp"
    "sec:circ-embedd-meth"
    "sec:turning-bands-method"
    "eq:turningBandsdDimTo1dim"
    "eq:tbmOperator"
    "eq:tbmOperatordim2"
    "eq:tbmOperatordim3"
    "eq:1"
    "eq:vdcBin"
    "eq:vdcSphere"
    "eq:bochner"
    "eq:contSpectral"
    "fig:tbm"
    "sec:simul-max-stable"
    "thm:simMaxStab"
    "eq:simMaxStab"
    "eq:simMaxStab2"
    "eq:simPoissProc"
    "subsec:sim-smith-model"
    "eq:SmithChar2"
    "eq:defFiniteBallSmith"
    "fig:rmaxstabSmith"
    "subsec:sim-schlather-model"
    "cha:spatial-depend-max"
    "eq:variogram"
    "sec:extremal-coefficient"
    "eq:extcoeff"
    "eq:MEVD"
    "eq:extCoeffVfun"
    "eq:extcoeffPairwise"
    "fig:extCoeffModels"
    "eq:llikSTNaive"
    "eq:extCoeffSmith"
    "fig:extCoeffST-Smith"
    "sec:madogram-based"
    "sec:madogram"
    "eq:madogram"
    "eq:mado2ExtCoeff"
    "fig:madogram"
    "eq:madogramEstim"
    "eq:madogramEstimBinned"
    "eq:extCoeffEstMado"
    "fig:madoExtCoeff"
    "sec:f-madogram"
    "eq:F-madogram"
    "fig:F-madogram"
    "eq:F-madogramEstim"
    "eq:F-mado2ExtCoeff"
    "eq:extCoeff2F-mado"
    "eq:abs2max"
    "eq:extCoeffEstF-mado"
    "sec:lambda-madogram"
    "eq:lambda-madogram"
    "eq:lambda-madogramVfun"
    "eq:Vfun2lambda-mado"
    "eq:lambda-madogramEst"
    "eq:VfunEst"
    "fig:lambda-mado"
    "chat:fit-maxstab-frech"
    "sec:least-squares"
    "eq:extCoeffLeastSquares"
    "sec:pairwise-likelihood"
    "eq:lplik"
    "sec:misspecification"
    "eq:LLNMissMLE"
    "eq:KullbackLeibler"
    "eq:MLEMissp"
    "eq:Hessian"
    "eq:VarScore"
    "eq:gradlplik"
    "eq:lplikAsymp"
    "sec:assess-uncert"
    "eq:Jest"
    "cha:model-selection"
    "sec:take-inform-crit"
    "eq:KLAverageOverPsiHat"
    "eq:AIC"
    "eq:TIC"
    "sec:likel-ratio-stat"
    "eq:likRatio"
    "sec:adjust-chi2-distr"
    "eq:likRatioMissp"
    "sec:adjust-comp-likel"
    "eq:lclik"
    "eq:adjustMatrix"
    "eq:8"
    "cha:fit-maxstab-gev"
    "eq:Y2Frech"
    "eq:GEV2Frech"
    "eq:frech2GEV"
    "eq:mapGEV2Frech"
    "eq:lplikGEV"
    "sec:response-surfaces"
    "sec:line-regr-models"
    "eq:LM"
    "eq:least-square"
    "eq:betahatLeastSquare"
    "eq:hatMatrix"
    "sec:semipar-regr"
    "eq:semiparModel"
    "eq:decompBasis"
    "eq:decompBasis2"
    "fig:knotsEffect"
    "fig:smoothingParamEffect"
    "eq:constraintLeastSquare"
    "eq:beta.hatPspline"
    "eq:fitted.valuesPspline"
    "eq:smootherMatrix"
    "eq:crossValidation"
    "eq:crossValidationInPractice"
    "eq:generalizedCrossValidationInPractice"
    "fig:CVandGCV"
    "sec:build-resp-surf"
    "eq:spatgev"
    "eq:llikSpatGEV"
    "eq:spatGEVStdErr"
    "cha:conclusion"
    "cha:p-splines-with"
    "sec:model-definition"
    "eq:p-splineGeneralDef"
    "eq:p-splineRadialBasis"
    "eq:pLeastSquaresRadialBasis"
    "sec:fast-computation-p")
   (LaTeX-add-bibliographies
    "./references")
   (LaTeX-add-index-entries
    "max-stable!process"
    "Fr\\'echet!unit"
    "rainfall-storm process"
    "Poisson
  process"
    "intensity measure"
    "max-stable!property"
    "distance!Mahanalobis"
    "eigen-decomposition"
    "eigenvalues"
    "distance!Euclidean"
    "covariance function!Whittle--Mat\\'ern"
    "covariance function!cauchy"
    "covariance function!powered exponential"
    "covariance function!bessel"
    "covariance function!range"
    "covariance function!smooth"
    "covariance function!elliptical"
    "variogram"
    "extremal coefficient"
    "extremal coefficient!function"
    "madogram"
    "madogram!$F$-madogram"
    "madogram!$\\lambda$-madogram"
    "least squares"
    "pairwise-likelihood"
    "misspecification"
    "Kullback--Leibler discrepancy"
    "standard errors"
    "score equation"
    "information criterion!AIC"
    "information criterion!TIC"
    "likelihood ratio statistic"
    "Jacobian"
    "design matrix"
    "linear model"
    "hat matrix"
    "degrees of freedom"
    "p-splines"
    "smoothing parameter"
    "smoother matrix"
    "cross-validation"
    "cross-validation!generalized"))
 :latex)

