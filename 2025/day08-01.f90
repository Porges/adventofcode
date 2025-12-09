program Day08
  implicit none

  type point; real :: x, y, z; end type
            
  integer, parameter :: N = 1000
  type(point) :: inputs(N)
  real :: dists(N,N)
  integer :: i, j, prod, circuits(N), loc(2)
  integer, allocatable :: circsizes(:)

  read(*,*) inputs(:)
  forall (i=1:size(inputs))
    forall (j=1:i)
      dists(i,j) = dist(inputs(i), inputs(j))
    end forall
  end forall
  circuits = [(i, i=1, size(inputs))]
  
  do i=1,1000
    loc = minloc(dists, mask=(dists /= 0))
    dists(loc(1), loc(2)) = 0
    associate (c1 => circuits(loc(1)), c2 => circuits(loc(2)))
      if (c1 /= c2) where (circuits == max(c1, c2)) circuits = min(c1, c2)
    end associate
  end do

  circsizes = [(count(circuits == i), i=1, maxval(circuits))]
  prod = 1
  do i=1,3
    prod = prod * maxval(circsizes)
    circsizes(maxloc(circsizes)) = 0
  end do
  print *, prod

contains
  pure real function dist(p1, p2)
    type(point), intent(in) :: p1, p2
    dist = (p1%x - p2%x)**2 + (p1%y - p2%y)**2 + (p1%z - p2%z)**2
  end
end program
