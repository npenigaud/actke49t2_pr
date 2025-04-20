!MNH_LIC Copyright 1995-2021 CNRS, Meteo-France and Universite Paul Sabatier
!MNH_LIC This is part of the Meso-NH software governed by the CeCILL-C licence
!MNH_LIC version 1. See LICENSE, CeCILL-C_V1-en.txt and CeCILL-C_V1-fr.txt
!MNH_LIC for details. version 1.
!-----------------------------------------------------------------
!     ##################
      MODULE MODD_TURB_n
!     ##################
!> @file
!!****  *MODD_TURB$n* - declaration of turbulence scheme free parameters
!!
!!    PURPOSE
!!    -------
!       The purpose of this declarative module is to declare the
!     variables that may be set by namelist for the turbulence scheme
!
!!
!!**  IMPLICIT ARGUMENTS
!!    ------------------
!!      None 
!!
!!    REFERENCE
!!    ---------
!!      Book2 of documentation of Meso-NH (module MODD_PARAMn)
!!          
!!    AUTHOR
!!    ------
!!	    J. Cuxart and J. Stein       * I.N.M. and Meteo France*
!!
!!    MODIFICATIONS
!!    -------------
!!      Original    January 9, 1995                   
!!      J.Cuxart    February 15, 1995 add the switches for diagnostic storages
!!      J.M. Carriere May  15, 1995 add the subgrid condensation
!!      M. Tomasini Jul  05, 2001 add the subgrid autoconversion
!!      P. Bechtold Feb 11, 2002    add switch for Sigma_s computation
!!      P. Jabouille Apr 4, 2002    add switch for Sigma_s convection
!!      V. Masson    Nov 13 2002    add switch for SBL lengths
!!                   May   2006    Remove KEPS
!!      C.Lac        Nov 2014      add terms of TKE production for LES diag
!!  Philippe Wautelet: 05/2016-04/2018: new data structures and calls for I/O
!!      D. Ricard     May 2021      add the switches for Leonard terms
!!    JL Redelsperger  03/2021   Add O-A flux for auto-coupled LES case
!!      S. Riette June 2023: add LSMOOTH_PRANDTL, XMINSIGS and XBL89EXP/XUSRBL89
!!
!-------------------------------------------------------------------------------
!
!*       0.   DECLARATIONS
!             ------------
!
USE MODD_PARAMETERS, ONLY: JPMODELMAX
IMPLICIT NONE

TYPE TURB_t
! 
! 
  REAL               :: XIMPL       !< implicitness degree for the vertical terms of the turbulence scheme
  REAL               :: XTKEMIN     !< mimimum value for the TKE                                  
  REAL               :: XCED        !< Constant for dissipation of Tke                            
  REAL               :: XCTP        !< Constant for temperature and vapor pressure-correlations
  REAL               :: XCSHF       !< constant for the sensible heat flux 
  REAL               :: XCHF        !< constant for the humidity flux 
  REAL               :: XCTV        !< constant for the temperature variance
  REAL               :: XCHV        !< constant for the humidity variance
  REAL               :: XCHT1       !< first ct. for the humidity-temperature correlation
  REAL               :: XCHT2       !< second ct. for the humidity-temperature correlation
  REAL               :: XCPR1       !< first ct. for the turbulent Prandtl numbers
  REAL               :: XCADAP      !< Coefficient for ADAPtative mixing length
  CHARACTER (LEN=4)  :: CTURBLEN    !< type of length used for the closure:
                                    !! 'BL89' Bougeault and Lacarrere scheme;
                                    !! 'DELT' length = ( volum) ** 1/3
  CHARACTER (LEN=4)  :: CTURBDIM    !< dimensionality of the turbulence scheme:
                                    !! '1DIM' for purely vertical computations;
                                    !! '3DIM' for computations in the 3 directions
  LOGICAL            :: LTURB_FLX   !< logical switch for the storage of all the turbulent fluxes
  LOGICAL            :: LTURB_DIAG  !< logical switch for the storage of some turbulence related diagnostics
  LOGICAL            :: LSIG_CONV   !< Switch for computing Sigma_s due to convection
!
  LOGICAL            :: LHARAT      !< if true RACMO turbulence is used
  LOGICAL            :: LBL89TOP    !< if true modification in BL89 at PBL top   
  LOGICAL            :: LRMC01      !< Switch for computing separate mixing and dissipative length in the SBL
                                    !! according to Redelsperger, Mahe & Carlotti 2001
  CHARACTER(LEN=4)   :: CTOM        !< type of Third Order Moments:
                                    !! 'NONE' none;
                                    !! 'TM06' Tomas Masson 2006

!  REAL, DIMENSION(:,:), POINTER :: XBL_DEPTH=>NULL() ! BL depth for TOMS computations
!  REAL, DIMENSION(:,:), POINTER :: XSBL_DEPTH=>NULL()! SurfaceBL depth for RMC01 computations
!  REAL, DIMENSION(:,:,:), POINTER :: XWTHVMF=>NULL()! Mass Flux vert. transport of buoyancy
  REAL, DIMENSION(:,:,:), POINTER :: XDYP=>NULL()     !< Dynamical production of Kinetic energy
  REAL, DIMENSION(:,:,:), POINTER :: XTHP=>NULL()     !< Thermal production of Kinetic energy
  REAL, DIMENSION(:,:,:), POINTER :: XTR=>NULL()      !< Transport production of Kinetic energy
  REAL, DIMENSION(:,:,:), POINTER :: XDISS=>NULL()    !< Dissipation of Kinetic energy
  REAL, DIMENSION(:,:,:), POINTER :: XLEM=>NULL()     !< Mixing length
  REAL, DIMENSION(:,:,:), POINTER :: XSSUFL_C=>NULL() !< O-A interface flux for u
  REAL, DIMENSION(:,:,:), POINTER :: XSSVFL_C=>NULL() !< O-A interface flux for v
  REAL, DIMENSION(:,:,:), POINTER :: XSSTFL_C=>NULL() !< O-A interface flux for theta
  REAL, DIMENSION(:,:,:), POINTER :: XSSRFL_C=>NULL() !< O-A interface flux for vapor
  LOGICAL            :: LLEONARD      !< logical switch for the computation of the Leornard Terms
  REAL               :: XCOEFHGRADTHL !< coeff applied to thl contribution
  REAL               :: XCOEFHGRADRM  !< coeff applied to mixing ratio contribution
  REAL               :: XALTHGRAD  !< altitude from which to apply the Leonard terms
  LOGICAL            :: LGOGER ! < logical switch for the computation of the Goger Terms
  REAL               :: XSMAG  ! < dimensionless Smagorinsky constant
  REAL               :: XCLDTHOLD  !< cloud threshold to apply the Leonard terms:
                                   !!  negative value to apply everywhere;
                                   !!  0.000001 applied only inside the clouds ri+rc > 10**-6 kg/kg
  REAL               :: XLINI      !< initial value for BL mixing length
  LOGICAL            :: LROTATE_WIND !< .TRUE. to rotate wind components
  LOGICAL            :: LTKEMINTURB  !< set a minimum value for the TKE in the turbulence scheme
  LOGICAL            :: LPROJQITURB  !< project the rt tendency on rc/ri
  LOGICAL            :: LSMOOTH_PRANDTL !< .TRUE. to smooth prandtl functions
  REAL               :: XMINSIGS     !< minimum value for SIGS computed by the turbulence scheme
  REAL               :: XBL89EXP, XUSRBL89 !< exponent on final BL89 length
!  
END TYPE TURB_t


END
