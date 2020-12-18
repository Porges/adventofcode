      program Day11
        implicit none
        integer, parameter :: N = 100

        character, dimension(0:N+1,0:N+1) :: seating=' '
        integer, dimension(N, N) :: counts
        integer :: i, j, ios
        logical :: changed = .true.
        character(N) :: line

        do i=1,N
                read (*, '(A)', iostat=ios) line
                if (ios /= 0) exit
                seating(i, 1:N) = [(line(j:j),j=1,N)]
        end do

        do while (changed)
            ! write (*, "(*(A))") ((seating(i,j),j=1,N),new_line("A"),i=1,N)
            changed = .false.
            do i=1,N
                do j=1,N
                    counts(i, j) = count(seating(i-1:i+1, j-1:j+1) .eq. '#')
                end do
            end do
            do i=1,N
                do j=1,N
                    if (seating(i, j) .eq. 'L' .and. counts(i,j) .eq. 0) then
                        seating(i, j) = '#'
                        changed = .true.
                    else if (seating(i, j) .eq. '#' .and. counts(i,j) .ge. 5) then
                        seating(i, j) = 'L'
                        changed = .true.
                    end if
                end do
            end do
        end do

      print *, count(seating .eq. '#')
      end program
