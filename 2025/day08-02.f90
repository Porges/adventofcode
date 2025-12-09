program Day08
  implicit none

  type point; real :: x, y, z; end type
            
  integer, parameter :: N = 1000
  type(point) :: inputs(N)
  real :: dists(N,N)
  integer :: i, j, ncircs, circuits(N), loc(2)

  read(*,*) inputs(:)
  forall (i=1:size(inputs))
    forall (j=1:i)
      dists(i,j) = dist(inputs(i), inputs(j))
    end forall
  end forall
  circuits = [(i, i=1, size(inputs))]
  ncircs = size(circuits)

  do 
    loc = minloc(dists, mask=(dists /= 0))
    dists(loc(1), loc(2)) = 0
    associate (c1 => circuits(loc(1)), c2 => circuits(loc(2)))
      if (c1 /= c2) then
        where (circuits == max(c1, c2)) circuits = min(c1, c2)
        ncircs = ncircs - 1
        if (ncircs == 1) exit
      end if
    end associate
  end do
  print *, int8(inputs(loc(1))%x) * int8(inputs(loc(2))%x)

contains
  pure real function dist(p1, p2)
    type(point), intent(in) :: p1, p2
    dist = (p1%x - p2%x)**2 + (p1%y - p2%y)**2 + (p1%z - p2%z)**2
  end
end program
