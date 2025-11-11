#ifndef _STACK_N
#define _STACK_N

#define USE_STACK

#ifdef __GFORTRAN__
#undef USE_STACK
#endif

USE ABOR1_ACC_MOD
USE PARKIND1, ONLY : JPRB
USE ISO_C_BINDING, ONLY : C_LOC, C_F_POINTER

#define temp(t, n, s) t, POINTER, CONTIGUOUS, DIMENSION s :: n

#define assoc(p,q) IP_##p##_ = LOC(q)

#define nullptr(p) IP_##p##_ = 0

#define alloc4(n, s, l) CALL C_F_POINTER(C_LOC(YSTACK%ZDATA4(1,YLSTACK%L4+1)), n, SHAPE=s); n l => n; YLSTACK%L4=YLSTACK%L4+(SIZE(n,KIND=8)/SIZE(YSTACK%ZDATA4,1));IF(YLSTACK%L4>YLSTACK%U4)CALL ABOR1_ACC(__FILE__)

#define alloc8(n, s, l) CALL C_F_POINTER(C_LOC(YSTACK%ZDATA8(1,YLSTACK%L8+1)), n, SHAPE=s); n l => n; YLSTACK%L8=YLSTACK%L8+(SIZE(n,KIND=8)/SIZE(YSTACK%ZDATA8,1));IF(YLSTACK%L8>YLSTACK%U8)CALL ABOR1_ACC(__FILE__)


#define stack_l4(ydstack,ibl,nbl) ((INT (ibl, 8) - 1) * SIZE (ydstack%ZDATA4, 2)) / INT (nbl, 8)
#define stack_u4(ydstack,ibl,nbl) ((INT (ibl, 8)    ) * SIZE (ydstack%ZDATA4, 2)) / INT (nbl, 8)
  
#define stack_l8(ydstack,ibl,nbl) ((INT (ibl, 8) - 1) * SIZE (ydstack%ZDATA8, 2)) / INT (nbl, 8)
#define stack_u8(ydstack,ibl,nbl) ((INT (ibl, 8)    ) * SIZE (ydstack%ZDATA8, 2)) / INT (nbl, 8)
  
#endif
