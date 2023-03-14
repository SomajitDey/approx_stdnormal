program main
    use stdnormal, only: random_stdnormal
    use iso_fortran_env, only: compiler_version
    implicit none
    
    double precision, dimension(:), allocatable :: z
    integer :: i, size_z, dat_fd
    character(len=*), parameter :: dat_fname='variates.dat'
    
    print'(/,a,/)', 'How many std normal deviates do you want?'
    read*, size_z
    allocate(z(size_z))
    
    call random_stdnormal(z)
    
    open(newunit=dat_fd, file=dat_fname, status='replace')
        dump: do i=1,size_z
            write(dat_fd,*) z(i)
        end do dump
    close(dat_fd)
    print'(/,a,1x,a)', 'Variates dumped at', dat_fname
    print'(/,a,/,a,/)', 'Compiler version: ', compiler_version()
end program main
