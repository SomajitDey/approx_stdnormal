module stdnormal
    implicit none
    
    contains
    
! Std normal variate generation using box-muller transform
! But not using polar rejection or trigonometric functions
 subroutine random_stdnormal(z) 
    double precision, dimension(:), intent(out) :: z
    double precision, dimension(2*((size(z)+1)/2)), target :: u ! Always of even size >= size(z)
    double precision, dimension(:), pointer :: u1, u2
    integer :: u1_size,diff_z_size

    call random_number(u) ! Harvest uniform random number from [0,1]
    u = 2*u-1 ! Transform into uniform random number from [-1,1]

    u1 => u(:size(u)/2) ! u1 refers to the first half of array u
    u1_size = size(u1) ! Also equals the size of u2 by the way
    diff_z_size = size(z) - u1_size
    u2 => u(u1_size+1:) ! u2 refers to the second half of array u
    
    z(:u1_size) = 2/(1 + u2*u2)
    z(u1_size+1:) = sign(z(:diff_z_size) - 1, u1(:diff_z_size))
    u1 = sqrt(-2*log(abs(u1)))
    z(:u1_size) = z(:u1_size)*u2*u1
    z(u1_size+1:) = z(u1_size+1:)*u1(:diff_z_size)
end subroutine random_stdnormal
end module stdnormal
