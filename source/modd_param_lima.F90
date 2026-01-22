!MNH_LIC Copyright 2013-2021 CNRS, Meteo-France and Universite Paul Sabatier
!MNH_LIC This is part of the Meso-NH software governed by the CeCILL-C licence
!MNH_LIC version 1. See LICENSE, CeCILL-C_V1-en.txt and CeCILL-C_V1-fr.txt
!MNH_LIC for details. version 1.
!-------------------------------------------------------------------------------
!     ######################
      MODULE MODD_PARAM_LIMA
!     ######################
!> @file
!!      *MODD_PARAM_LIMA* - declaration of the control parameters
!!                               for use in the LIMA scheme.
!!
!!    PURPOSE
!!    -------
!!      The purpose of this declarative module is to declare the microphysical
!!    constants. This includes the descriptive parameters for the raindrop 
!!    and the parameters relevant of the dimensional distributions.
!!
!!
!!
!!    IMPLICIT ARGUMENTS
!!    ------------------
!!      None 
!!
!!    AUTHOR
!!    ------
!!	J.-P. Pinty  *Laboratoire d'Aerologie*
!!      S.    Berthet    * Laboratoire d'Aerologie*
!!      B.    Vié        * Laboratoire d'Aerologie*
!!
!!    MODIFICATIONS
!!    -------------
!!      Original             ??/??/13 
!!      C. Barthe            14/03/2022  add CIBU and RDSF
!!
!-------------------------------------------------------------------------------
!
USE MODD_PARAMETERS, ONLY : JPLIMACCNMAX, JPLIMAIFNMAX
!
IMPLICIT NONE
!
TYPE PARAM_LIMA_t
LOGICAL :: LLIMA_DIAG             ! Compute diagnostics for concentration /m3
!
LOGICAL :: LPTSPLIT               ! activate time-splitting technique by S. Riette
LOGICAL :: LFEEDBACKT             ! recompute tendencies if T changes sign
INTEGER :: NMAXITER               ! maximum number of iterations
REAL    :: XMRSTEP                ! maximum change in mixing ratio allowed before recomputing tedencies
REAL    :: XTSTEP_TS              ! maximum time for the sub-time-step
!
!*       1.   COLD SCHEME
!             -----------
!
! 1.1 Cold scheme configuration
!
LOGICAL :: LNUCL                  ! TRUE to enable ice nucleation
LOGICAL :: LSEDI                  ! TRUE to enable pristine ice sedimentation
LOGICAL :: LHHONI                 ! TRUE to enable freezing of haze particules
LOGICAL :: LMEYERS                ! TRUE to use Meyers nucleation
LOGICAL :: LCIBU                  ! TRUE to use collisional ice breakup
LOGICAL :: LRDSF                  ! TRUE to use rain drop shattering by freezing
INTEGER :: NMOM_I                 ! Number of moments for pristine ice
INTEGER :: NMOM_S                 ! Number of moments for snow
INTEGER :: NMOM_G                 ! Number of moments for graupel
INTEGER :: NMOM_H                 ! Number of moments for hail
!
! 1.2 IFN initialisation
!
INTEGER          :: NMOD_IFN               ! Number of IFN modes
REAL, DIMENSION(JPLIMAIFNMAX) :: XIFN_CONC ! Ref. concentration of IFN(#/L)
LOGICAL          :: LIFN_HOM               ! True for z-homogeneous IFN concentrations
CHARACTER(LEN=8) :: CIFN_SPECIES           ! Internal mixing species definitions
CHARACTER(LEN=8) :: CINT_MIXING            ! Internal mixing type selection (pure DM1 ...)
INTEGER          :: NMOD_IMM               ! Number of CCN modes acting by immersion
INTEGER          :: NIND_SPECIE            ! CCN acting by immersion are considered pure
                                           ! IFN of either DM = 1, BC = 2 or O = 3
INTEGER, DIMENSION(:), ALLOCATABLE :: NIMM            ! Link between CCN and IMM modes
INTEGER, DIMENSION(:), ALLOCATABLE :: NINDICE_CCN_IMM ! ??????????
INTEGER                            :: NSPECIE         ! Internal mixing number of species
REAL, DIMENSION(:),    ALLOCATABLE :: XMDIAM_IFN      ! Mean diameter of IFN modes
REAL, DIMENSION(:),    ALLOCATABLE :: XSIGMA_IFN      ! Sigma of IFN modes
REAL, DIMENSION(:),    ALLOCATABLE :: XRHO_IFN        ! Density of IFN modes 
REAL, DIMENSION(:,:),  ALLOCATABLE :: XFRAC           ! Composition of each IFN mode
REAL, DIMENSION(:),    ALLOCATABLE :: XFRAC_REF       ! AP compostion in Phillips 08
!
! 1.3 Ice characteristics
!
LOGICAL :: LSNOW_T                     ! TRUE to enable snow param. after Wurtz 2021
LOGICAL :: LMURAKAMI                   ! snow + liq -> graupel after Murakami (as in RAIN_ICE_RED)
CHARACTER(LEN=4) :: CPRISTINE_ICE_LIMA ! Pristine type PLAT, COLU or BURO
CHARACTER(LEN=4) :: CHEVRIMED_ICE_LIMA ! Heavily rimed type GRAU or HAIL
REAL                   :: XALPHAI,XNUI,    & ! Pristine ice   distribution parameters
                          XALPHAS,XNUS,    & ! Snow/aggregate distribution parameters
                          XALPHAG,XNUG       ! Graupel        distribution parameters
!
! 1.4 Phillips (2013) nucleation parameterization
!
INTEGER              :: NPHILLIPS     ! =8 for Phillips08, =13 for Phillips13
!
REAL, DIMENSION(4)   :: XT0       ! Threshold of T in H_X for X={DM1,DM2,BC,O} [K]
REAL, DIMENSION(4)   :: XDT0      ! Range in T for transition of H_X near XT0 [K]
REAL, DIMENSION(4)   :: XDSI0     ! Range in Si for transition of H_X near XSI0
REAL                 :: XSW0      ! Threshold of Sw in H_X 
REAL                 :: XRHO_CFDC ! Air density at which CFDC data were reported [kg m**3]
REAL, DIMENSION(4)   :: XH        ! Fraction<<1 of aerosol for X={DM,BC,O}
REAL, DIMENSION(4)   :: XAREA1    ! Total surface of all aerosols in group X with
                                  ! diameters between 0.1 and 1 µm, for X={DM1,DM2,BC,O} [m**2 kg**-1]
REAL                 :: XGAMMA    ! Factor boosting IN concentration due to 
                                        ! bulk-liquid modes
!
REAL, DIMENSION(4)   :: XTX1      ! Threshold of T in Xi for X={DM1,DM2,BC,O} [K]
REAL, DIMENSION(4)   :: XTX2      ! Threshold of T in Xi for X={DM1,DM2,BC,O} [K]
!
REAL,DIMENSION(:), ALLOCATABLE :: XABSCISS, XWEIGHT ! Gauss quadrature method 
INTEGER                        :: NDIAM             ! Gauss quadrature accuracy 
!
! 1.5 Meyers (1992) nucleation parameterization
!
REAL      :: XFACTNUC_DEP,XFACTNUC_CON  ! Amplification factor for IN conc.
                                        !   DEP refers to DEPosition mode
                                        !   CON refers to CONtact    mode
!
! 1.6 Collisional Ice Break Up parameterization
!
REAL      :: XNDEBRIS_CIBU              ! Number of ice crystal debris produced
                                        ! by the break up of aggregate particles
!
!-------------------------------------------------------------------------------
!
!
!*       2.   WARM SCHEME
!             -----------
!
! 2.1 Warm scheme configuration
!
LOGICAL :: LACTI         ! TRUE to enable CCN activation
LOGICAL :: LSEDC         ! TRUE to enable the droplet sedimentation
LOGICAL :: LACTIT        ! TRUE to enable the usage of dT/dt in CCN activation
LOGICAL :: LDEPOC        ! Deposition of rc at 1st level above ground
LOGICAL :: LACTTKE       ! TRUE to take into account TKE in W for activation
LOGICAL :: LADJ          ! TRUE for adjustment procedure + Smax (false for diagnostic supersaturation)
LOGICAL :: LSPRO         ! TRUE for prognostic supersaturation                     
LOGICAL :: LKHKO         ! TRUE for Scu simulation (replicates the previous KHKO scheme)                     
LOGICAL :: LKESSLERAC    ! TRUE for Kessler autoconversion (if NMOM_C=1)
!
INTEGER :: NMOM_C        ! Number of moments for cloud droplets
INTEGER :: NMOM_R        ! Number of moments for rain drops
!
! 2.2 CCN initialisation
!
INTEGER                             :: NMOD_CCN         ! Number of CCN modes
REAL, DIMENSION(JPLIMACCNMAX)       :: XCCN_CONC        ! CCN conc.  (#/cm3)
LOGICAL                             :: LCCN_HOM         ! True for z-homogeneous CCN concentrations
CHARACTER(LEN=8)                    :: CCCN_MODES       ! CCN modes characteristics (Jungfraujoch ...)
REAL, DIMENSION(:), ALLOCATABLE     :: XR_MEAN_CCN,   & ! Mean radius of CCN modes
                                       XLOGSIG_CCN,   & ! Log of geometric dispersion of the CCN modes
                                       XRHO_CCN         ! Density of the CCN modes
REAL, DIMENSION(:), ALLOCATABLE     :: XKHEN_MULTI,   & ! Parameters defining the CCN activation
                                       XMUHEN_MULTI,  & ! spectra for a multimodal aerosol distribution
                                       XBETAHEN_MULTI   ! 
REAL, DIMENSION(:,:,:), ALLOCATABLE :: XCONC_CCN_TOT    ! Total aerosol number concentration
REAL, DIMENSION(:),     ALLOCATABLE :: XLIMIT_FACTOR    ! compute CHEN ????????????
!
! 2.3 Water particles characteristics
!
REAL          :: XALPHAR,XNUR,       & ! Raindrop      distribution parameters
                 XALPHAC,XNUC          ! Cloud droplet distribution parameters
!
! 2.4 CCN activation
!
CHARACTER(LEN=3)      :: HPARAM_CCN = 'CPB'   ! Parameterization of the CCN activation
CHARACTER(LEN=3)      :: HINI_CCN             ! Initialization type of CCN activation
CHARACTER(LEN=10), DIMENSION(JPLIMACCNMAX) :: HTYPE_CCN ! 'M' or 'C' CCN type
REAL                  :: XFSOLUB_CCN,       & ! Fractionnal solubility of the CCN
                         XACTEMP_CCN,       & ! Expected temperature of CCN activation
                         XAERDIFF, XAERHEIGHT ! For the vertical gradient of aerosol distribution
!
! Cloud droplet deposition
!
REAL :: XVDEPOC
!
!-------------------------------------------------------------------------------
!
!
!*       3.   BELOW CLOUD SCAVENGING
!             ----------------------
!
LOGICAL :: LSCAV           ! TRUE for aerosol scavenging by precipitations 
LOGICAL :: LAERO_MASS      ! TRUE to compute the total aerosol mass scavenging rate 
!
INTEGER :: NDIAMR = 20     ! Max Number of droplet for quadrature method  
INTEGER :: NDIAMP = 20     ! Max Number of aerosol particle for quadrature method  
!
REAL    :: XT0SCAV = 293.15  ! [K]
REAL    :: XTREF = 273.15    ! [K]
REAL    :: XNDO = 8.*1.0E6   ! [/m**4]
!
!-------------------------------------------------------------------------------
!
!
!*       4.   ATMOSPHERIC & OTHER PARAMETERS
!             ------------------------------
!
REAL    :: XMUA0     = 1.711E-05  ![Pa.s] Air Viscosity at T=273.15K
REAL    :: XT_SUTH_A = 110.4      ![K] Sutherland Temperature for Air
REAL    :: XMFPA0    = 6.6E-08    ![m] Mean Free Path of Air under standard conditions
!
REAL    :: XVISCW = 1.0E-3        ![Pa.s] water viscosity at 20°C
! Correction
!REAL    :: XRHO00 = 1.292        !rho on the floor    [Kg/m**3]
REAL    :: XRHO00 = 1.2041        !rho at P=1013.25 and T=20°C
!
REAL    :: XCEXVT                     ! air density fall speed correction
!
REAL, DIMENSION(:), ALLOCATABLE :: XRTMIN ! Min values of the mixing ratios
REAL, DIMENSION(:), ALLOCATABLE :: XCTMIN ! Min values of the drop concentrations
!
!
! Sedimentation variables
!
INTEGER,DIMENSION(7)   :: NSPLITSED
REAL,DIMENSION(7)      :: XLB
REAL,DIMENSION(7)      :: XLBEX
REAL,DIMENSION(7)      :: XD
REAL,DIMENSION(7)      :: XFSEDR
REAL,DIMENSION(7)      :: XFSEDC
END TYPE PARAM_LIMA_t
!
END
