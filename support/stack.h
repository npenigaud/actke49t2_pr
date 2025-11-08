#ifndef _STACK_N
#define _STACK_N

#define USE_STACK

#ifdef __GFORTRAN__
#undef USE_STACK
#endif

USE ABOR1_ACC_MOD
USE PARKIND1, ONLY : JPRB
USE ISO_C_BINDING, ONLY : C_PTR, C_F_POINTER

#ifdef USE_STACK

#define temp(t, n, s) t, POINTER, CONTIGUOUS, DIMENSION s :: n

#define alloc(n) IP_##n##_=YLSTACK%L;YLSTACK%L=YLSTACK%L+MAX(JPRB,KIND(n))*SIZE(n);IF(YLSTACK%L>YLSTACK%U)CALL ABOR1_ACC(__FILE__)

#define assoc(p,q) IP_##p##_ = LOC(q)

#define nullptr(p) IP_##p##_ = 0

#define alloc4(n, s, l) CALL C_F_POINTER(TRANSFER(YLSTACK%L4, CPTR), n, SHAPE=s); n l => n; YLSTACK%L4=YLSTACK%L4+4*SIZE(n);IF(YLSTACK%L4>YLSTACK%U4)CALL ABOR1_ACC(__FILE__)

#define alloc8(n, s, l) CALL C_F_POINTER(TRANSFER(YLSTACK%L8, CPTR), n, SHAPE=s); n l => n; YLSTACK%L8=YLSTACK%L8+8*SIZE(n);IF(YLSTACK%L8>YLSTACK%U8)CALL ABOR1_ACC(__FILE__)


#define malign(p,k) ((((p)+(k)-1)/(k)) * (k))

#define stack_l4(ydstack,ibl,nbl) malign(LOC (ydstack%ZDATA4 (1,1,1,1)) + ((INT (ibl, 8) - 1) * SIZE (ydstack%ZDATA4) * KIND (ydstack%ZDATA4)) / INT (nbl, 8), ydstack%IALIGN) 
#define stack_u4(ydstack,ibl,nbl)        LOC (ydstack%ZDATA4 (1,1,1,1)) + ((INT (ibl, 8)    ) * SIZE (ydstack%ZDATA4) * KIND (ydstack%ZDATA4)) / INT (nbl, 8)
  
#define stack_l8(ydstack,ibl,nbl) malign(LOC (ydstack%ZDATA8 (1,1,1,1)) + ((INT (ibl, 8) - 1) * SIZE (ydstack%ZDATA8) * KIND (ydstack%ZDATA8)) / INT (nbl, 8), ydstack%IALIGN) 
#define stack_u8(ydstack,ibl,nbl)        LOC (ydstack%ZDATA8 (1,1,1,1)) + ((INT (ibl, 8)    ) * SIZE (ydstack%ZDATA8) * KIND (ydstack%ZDATA8)) / INT (nbl, 8)
  
#else

#define temp(t, n, s) t, TARGET, DIMENSION s :: n

#define alloc(n)

#define assoc(p,q) CALL ABOR1_ACC (__FILE__)

#define nullptr(p) CALL ABOR1_ACC (__FILE__)

#define malign(p,k) ((((p)+(k)-1)/(k)) * (k))

#define stack_l4(ydstack,ibl,nbl) 0
#define stack_u4(ydstack,ibl,nbl) 0
  
#define stack_l8(ydstack,ibl,nbl) 0
#define stack_u8(ydstack,ibl,nbl) 0

#endif
  
#endif
