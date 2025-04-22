
#ifdef USE_OPENACC
#define GPU_ATTACH(x)        !$acc enter data attach (x)
#define GPU_CREATE(x)        !$acc enter data create (x)
#define GPU_DELETE(x)        !$acc exit data delete (x)
#define GPU_DETACH(x)        !$acc exit data detach (x)
#define GPU_UPDATE_DEVICE(x) !$acc update device (x)
#endif

#ifdef USE_OPENMP
#define GPU_ATTACH(x)        !$OMP TARGET ENTER DATA MAP (TO:x)
#define GPU_CREATE(x)        !$OMP TARGET ENTER DATA MAP (ALLOC:x)
#define GPU_DELETE(x)        !$OMP TARGET EXIT DATA MAP (DELETE:x)
#define GPU_DETACH(x)        !
#define GPU_UPDATE_DEVICE(x) !$OMP TARGET UPDATE TO (x)
#endif

