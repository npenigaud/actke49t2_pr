!MNH_LIC Copyright 1995-2019 CNRS, Meteo-France and Universite Paul Sabatier
!MNH_LIC This is part of the Meso-NH software governed by the CeCILL-C licence
!MNH_LIC version 1. See LICENSE, CeCILL-C_V1-en.txt and CeCILL-C_V1-fr.txt
!MNH_LIC for details. version 1.
!-----------------------------------------------------------------
!     ######spl
      MODULE MODD_PARAM_ICE_n
!     #####################
!> @file
!!      *MODD_PARAM_ICE_n* - declaration of the control parameters for the
!!                           mixed phase cloud parameterization
!!
!!    PURPOSE
!!    -------
!!      The purpose of this declarative module is to define the set of space
!!    and time control parameters for the microphysics.
!!
!!    IMPLICIT ARGUMENTS
!!    ------------------
!!      None
!!
!!    REFERENCE
!!    ---------
!!      Book2 of documentation of Meso-NH (module MODD_PARAM_ICE)
!!
!!    AUTHOR
!!    ------
!!     J.-P. Pinty   *Laboratoire d'Aerologie*
!!
!!    MODIFICATIONS
!!    -------------
!!
!!    -  Original      14/12/95
!!    -  Jan 2015 S. Riette: new ICE3/ICE4 parameters
!!    -  01/10/16 (C.Lac)  Add droplet deposition for fog
!!
!-------------------------------------------------------------------------------
!
!*       0.   DECLARATIONS
!             ------------
!
USE MODD_PARAMETERS, ONLY: JPMODELMAX
IMPLICIT NONE
!
TYPE PARAM_ICE_t
LOGICAL :: LWARM       !< When .TRUE. activates the formation of rain by
                       !! the warm microphysical processes
LOGICAL :: LSEDIC      !< TRUE to enable the droplet sedimentation
LOGICAL :: LDEPOSC     !< TRUE to enable cloud droplet deposition
REAL    :: XVDEPOSC    !< Droplet deposition velocity
!
CHARACTER(LEN=4) :: CPRISTINE_ICE !< Pristine ice type PLAT, COLU or BURO
CHARACTER(LEN=4) :: CSEDIM        !< Sedimentation calculation mode      
!
LOGICAL :: LRED       !< To use modified ICE3/ICE4 to reduce time step dependency
LOGICAL :: LFEEDBACKT !< When .TRUE. feed back on temperature is taken into account
LOGICAL :: LEVLIMIT   !< When .TRUE. water vapour pressure is limited by saturation
LOGICAL :: LNULLWETG  !< When .TRUE. graupel wet growth is activated with null rate (to allow water shedding)
LOGICAL :: LWETGPOST  !< When .TRUE. graupel wet growth is activated with positive temperature (to allow water shedding)
LOGICAL :: LNULLWETH  !< Same as LNULLWETG but for hail
LOGICAL :: LWETHPOST  !< Same as LWETGPOST but for hail
CHARACTER(LEN=4) :: CSNOWRIMING !< OLD or M90 for Murakami 1990 formulation
REAL :: XFRACM90      !< Fraction used for the Murakami 1990 formulation
INTEGER :: NMAXITER_MICRO   !< Maximum number of iterations for mixing ratio or time splitting
REAL :: XMRSTEP       !< maximum mixing ratio step for mixing ratio splitting
LOGICAL :: LCONVHG    !< TRUE to allow the conversion from hail to graupel
LOGICAL :: LCRFLIMIT  !< True to limit rain contact freezing to possible heat exchange
!
REAL :: XTSTEP_TS     !< Approximative time step for time-splitting (0 for no time-splitting)
!
CHARACTER(LEN=80) :: CSUBG_RC_RR_ACCR !< subgrid rc-rr accretion
CHARACTER(LEN=80) :: CSUBG_RR_EVAP    !< subgrid rr evaporation
CHARACTER(LEN=80) :: CSUBG_PR_PDF     !< pdf for subgrid precipitation
CHARACTER(LEN=4)  :: CSUBG_AUCV_RC    !< type of subgrid rc->rr autoconv. method
CHARACTER(LEN=80) :: CSUBG_AUCV_RI    !< type of subgrid ri->rs autoconv. method
CHARACTER(LEN=80) :: CSUBG_MF_PDF     !< PDF to use for MF cloud autoconversions
!
LOGICAL :: LADJ_BEFORE !< must we perform an adjustment before rain_ice call
LOGICAL :: LADJ_AFTER  !< must we perform an adjustment after rain_ice call
LOGICAL :: LSEDIM_AFTER !< sedimentation done before (.FALSE.) or after (.TRUE.) microphysics
!
REAL :: XSPLIT_MAXCFL   !< Maximum CFL number allowed for SPLIT scheme
LOGICAL :: LSNOW_T      !< Snow parameterization from Wurtz (2021)
!
LOGICAL :: LPACK_INTERP !< To pack arrays before computing the different interpolations (kernels and other)
LOGICAL :: LPACK_MICRO  !< To pack arrays before computing the process tendencies
!
INTEGER :: NPROMICRO    !< Size of cache-blocking bloc (0 to deactivate)
!
LOGICAL :: LCRIAUTI     !< .T. to compute XACRIAUTI and XBCRIAUTI (from XCRIAUTI and XT0CRIAUTI);
                        !! .F. to compute XT0CRIAUTI (from XCRIAUTI and XBCRIAUTI)
REAL :: XCRIAUTI_NAM    !< Minimum value for the ice->snow autoconversion threshold
REAL :: XT0CRIAUTI_NAM  !< Threshold temperature (???) for the ice->snow autoconversion threshold
REAL :: XBCRIAUTI_NAM   !< B barameter for the ice->snow autoconversion 10**(aT+b) law
REAL :: XACRIAUTI_NAM   !< A barameter for the ice->snow autoconversion 10**(aT+b) law
REAL :: XCRIAUTC_NAM    !< Threshold for liquid cloud -> rain autoconversion (kg/m**3)
REAL :: XRDEPSRED_NAM   !< Tuning factor of sublimation of snow
REAL :: XRDEPGRED_NAM   !< Tuning factor of sublimation of graupel
!
LOGICAL :: LOCND2       !< Logical switch to separate liquid and ice
REAL, DIMENSION(40) :: XFRMIN_NAM
!
END TYPE PARAM_ICE_t
!
END
