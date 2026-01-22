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

#define alloc(n, lb, ub) CALL STACK_ALLOC (n, lb, ub, YLSTACK)
#define alloc2d(n,lb1,lb2,ub1,ub2) CALL STACK_ALLOC (n, lb1, lb2, ub1, ub2, YLSTACK)

#define stack_l4(ydstack,ibl,nbl) ((INT (ibl, 8) - 1) * SIZE (ydstack%IDATA4, 2)) / INT (nbl, 8)
#define stack_u4(ydstack,ibl,nbl) ((INT (ibl, 8)    ) * SIZE (ydstack%IDATA4, 2)) / INT (nbl, 8)
  
#define stack_l8(ydstack,ibl,nbl) ((INT (ibl, 8) - 1) * SIZE (ydstack%ZDATA8, 2)) / INT (nbl, 8)
#define stack_u8(ydstack,ibl,nbl) ((INT (ibl, 8)    ) * SIZE (ydstack%ZDATA8, 2)) / INT (nbl, 8)
  
#endif
