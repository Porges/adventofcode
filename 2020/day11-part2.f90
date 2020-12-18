      program Day11
        implicit none
        integer, parameter :: N = 100

        character, dimension(N,N) :: seating=' '
        integer, dimension(N, N) :: counts
        integer :: i, j, k, ios
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
                    counts(i, j) = count( &
                                 [ spots(seating(i+1:, j)) &
                                 , spots(seating(i-1:1:-1, j)) &
                                 , spots(seating(i, j+1:)) &
                                 , spots(seating(i, j-1:1:-1)) &
                                 , spots([(seating(i+k,j+k),k=1,min(N-i,N-j))]) &
                                 , spots([(seating(i-k,j+k),k=1,min(i-1,N-j))]) &
                                 , spots([(seating(i+k,j-k),k=1,min(N-i,j-1))]) &
                                 , spots([(seating(i-k,j-k),k=1,min(i-1,j-1))]) &
                                 ])
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

      contains
              ! does the seat spot an occupied seat in the given
              ! direction?
              pure logical function spots(arr)
                implicit none
                character, dimension(:), intent(in) :: arr
                integer, dimension(1) :: occupied, empty

                occupied = findloc(arr, '#')
                empty = findloc(arr, 'L')

                if (occupied(1) .eq. 0) then ! no occupied seat
                        spots = .false.
                else if (empty(1) .eq. 0) then ! no empty seat
                        spots = .true.
                else
                        ! is the occupied seat closer than the empty
                        ! one?
                        spots = occupied(1) .lt. empty(1)
                end if
              end function
      end program
