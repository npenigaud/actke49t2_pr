!MNH_LIC Copyright 1994-2014 CNRS, Meteo-France and Universite Paul Sabatier
!MNH_LIC This is part of the Meso-NH software governed by the CeCILL-C licence
!MNH_LIC version 1. See LICENSE, CeCILL-C_V1-en.txt and CeCILL-C_V1-fr.txt
!MNH_LIC for details. version 1.
!-----------------------------------------------------------------
!-----------------------------------------------------------------
!     #############################
      MODULE MODD_PARAM_MFSHALL_n
!     #############################
!> @file
!!      *MODD_PARAM_MFSHALL_n* - Declaration of Mass flux scheme free parameters
!!
!!    PURPOSE
!!    -------
!!    The purpose of this declarative module is to declare the
!!    variables that may be set by namelist for the mass flux scheme
!!
!!    IMPLICIT ARGUMENTS
!!    ------------------
!!      None 
!!
!!    REFERENCE
!!    ---------
!!      
!!          
!!    AUTHOR
!!    ------
!!       S. Malardel, J. Pergaud (Meteo France)      
!!
!!    MODIFICATIONS
!!    -------------
!!      Original    01/02/07
!!      10/16 R.Honnert Update with AROME
!!      01/2019 R.Honnert add parameters for the reduction of mass-flux surface closure with resolution
!-------------------------------------------------------------------------------
!
!*       0.   DECLARATIONS
!             ------------
!
USE MODD_PARAMETERS, ONLY: JPMODELMAX
IMPLICIT NONE

TYPE PARAM_MFSHALL_t

REAL               :: XIMPL_MF     !< degre of implicitness
      
CHARACTER (LEN=4)  :: CMF_UPDRAFT  !< Type of Mass Flux Scheme
                                   !! 'NONE' if no parameterization 
CHARACTER (LEN=4)  :: CMF_CLOUD    !< Type of cloud scheme associated

                                     
LOGICAL       :: LMIXUV      !< True if mixing of momentum
LOGICAL       :: LMF_FLX     !< logical switch for the storage of the mass flux fluxes
REAL          :: XALP_PERT   !< coefficient for the perturbation of
                             !! theta_l and r_t at the first level of the updraft
REAL          ::    XABUO    !< coefficient of the buoyancy term in the w_up equation
REAL          ::    XBENTR   !< coefficient of the entrainment term in the w_up equation
REAL          ::    XBDETR   !< coefficient of the detrainment term in the w_up equation
REAL          ::    XCMF     !< coefficient for the mass flux at the first level of the updraft (closure)
REAL          :: XENTR_MF    !< entrainment constant (m/Pa) = 0.2 (m) 
REAL          :: XCRAD_MF    !< cloud radius in cloudy part
REAL          :: XENTR_DRY   !< coefficient for entrainment in dry part 
REAL          :: XDETR_DRY   !< coefficient for detrainment in dry part
REAL          :: XDETR_LUP   !< coefficient for detrainment in dry part
REAL          :: XKCF_MF     !< coefficient for cloud fraction
REAL          :: XKRC_MF     !< coefficient for convective rc
REAL          :: XTAUSIGMF
REAL          :: XPRES_UV    !< coefficient for pressure term in wind mixing
REAL          :: XALPHA_MF   !< coefficient for cloudy fraction
REAL          :: XSIGMA_MF   !< coefficient for sigma computation
REAL          :: XFRAC_UP_MAX!< maximum Updraft fraction
!
REAL          :: XA1         !< Parameter for Rio et al (2010) formulation for entrainment and detrainment (RHCJ10)
REAL          :: XB          !!
REAL          :: XC          !!
REAL          :: XBETA1      !!
!
REAL          :: XR          !< Parameter for closure assumption of Hourdin et al (2002): aspect ratio of updraft
!
LOGICAL       :: LGZ         !< Grey Zone Surface Closure
REAL          :: XGZ         !< Tuning of the surface initialisation for Grey Zone
!
LOGICAL       :: LTHETAS_MF      !< .TRUE. to use ThetaS1 instead of ThetaL
REAL          :: XLAMBDA_MF      !< Thermodynamic parameter: Lambda to compute ThetaS1 from ThetaL

END TYPE PARAM_MFSHALL_t


END
