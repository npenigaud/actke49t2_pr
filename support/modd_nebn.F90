!MNH_LIC Copyright 1994-2014 CNRS, Meteo-France and Universite Paul Sabatier
!MNH_LIC This is part of the Meso-NH software governed by the CeCILL-C licence
!MNH_LIC version 1. See LICENSE, CeCILL-C_V1-en.txt and CeCILL-C_V1-fr.txt  
!MNH_LIC for details. version 1.
!     ######spl
      MODULE MODD_NEB_n
!     #############################
!> @file
!!****  *MODD_NEB_n* - Declaration of nebulosity constants
!!
!!    PURPOSE
!!    -------
!!      The purpose of this declarative module is to declare some
!!      constants for nebulosity calculation
!
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
!!       S. Riette (Meteo France)
!!
!!    MODIFICATIONS
!!    -------------
!!      Original    24 Aug 2011
!-------------------------------------------------------------------------------
!
!*       0.   DECLARATIONS
!             ------------
!
USE MODD_PARAMETERS, ONLY: JPMODELMAX
IMPLICIT NONE
!
TYPE NEB_t
  REAL          :: XTMINMIX   !< minimum temperature of mixed phase
  REAL          :: XTMAXMIX   !< maximum temperature of mixed phase
  LOGICAL       :: LHGT_QS    !< Switch for height dependent VQSIGSAT
  CHARACTER(LEN=1) :: CFRAC_ICE_ADJUST     !< ice fraction for adjustments
  CHARACTER(LEN=1) :: CFRAC_ICE_SHALLOW_MF !< ice fraction for shallow_mf
  REAL               :: VSIGQSAT      !< coeff applied to qsat variance contribution
  CHARACTER(LEN=80)  :: CCONDENS      !< subrgrid condensation PDF
  CHARACTER(LEN=4)   :: CLAMBDA3      !< lambda3 choice for subgrid cloud scheme
  LOGICAL            :: LSTATNW       !< updated full statistical cloud scheme
  LOGICAL            :: LSIGMAS       !< Switch for using Sigma_s from turbulence scheme
  LOGICAL            :: LSUBG_COND    !< Switch for subgrid condensation 
END TYPE NEB_t

END
