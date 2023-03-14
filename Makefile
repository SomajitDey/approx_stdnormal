FC := gfortran

.PHONY : all

all : stdnormal.f90 main.f90
	@ $(FC) $^
	@ ./a.out
	@ rm -f a.out *.mod *.o