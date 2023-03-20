module stdnormal
    implicit none
    
    contains
    
! Generates an array of std. normal variates using Box-Muller transform
! Does not use rejection sampling or trigonometric functions
! If 'force' is present and is .true., the variates are shifted and scaled to produce perfect mean and s.d.
 subroutine random_stdnormal(z, force)
    logical, intent(in), optional :: force
    double precision, dimension(:), intent(out) :: z
    double precision, dimension(2*((size(z)+1)/2)), target :: u ! Always of even size >= size(z)
    double precision, dimension(:), pointer :: u1, u2
    integer :: z_size, u1_size, z_diff_u1_size
    double precision :: z_mean, z_sd

    call random_number(u) ! Harvest uniform random number from [0,1]
    u = 2*u-1 ! Transform into uniform random number from [-1,1]

    u1 => u(:size(u)/2) ! u1 refers to the first half of array u
    z_size = size(z)
    u1_size = size(u1) ! Also equals the size of u2 by the way
    z_diff_u1_size = z_size - u1_size
    u2 => u(u1_size+1:) ! u2 refers to the second half of array u
    ! u2 = u2*0.987 ! This somehow gives a better fit. Try it!!
    
    z(:u1_size) = 2/(1 + u2*u2)
    z(u1_size+1:) = sign(z(:z_diff_u1_size) - 1, u1(:z_diff_u1_size))
    u1 = sqrt(-log(u1*u1))
    z(:u1_size) = z(:u1_size)*u2*u1
    z(u1_size+1:) = z(u1_size+1:)*u1(:z_diff_u1_size)
    
    shift_and_scale: if (present(force)) then
        if (.not. force) exit shift_and_scale
        z_mean = sum(z)/z_size
        z_sd = sqrt(sum(z*z)/z_size - z_mean*z_mean)
        z = (z - z_mean)/z_sd
    end if shift_and_scale
end subroutine random_stdnormal
end module stdnormal
