IN: aoc2025.day5

: overlap? ( i1 i2 -- ? )
  { [ [ first ] [ last ] bi* <= ]
    [ [ last ] [ first ] bi* >= ] } 2&& ;

: merge ( i1 i2 -- i' )
  [ overlap? ] 2check
    [ [ [ first ] bi@ min ] [ [ last ] bi@ max ] 2bi 2array 1array ]
    [ 2array ] if ;

: merge-into ( ranges i -- ranges' )
  over empty?
    [ suffix ]
    [ over last swap merge [ but-last ] dip append ] if ;

: load-data ( -- inputs ranges )
  read-lines { "" } split1
  [ dec> ] map swap
  [ "-" split1 [ dec> ] bi@ 2array ] map sort
  { } [ merge-into ] reduce ;

: day5-part1 ( inputs ranges -- count )
  '[ _ [ over 1array overlap? ] any? nip ] filter length ;

: day5-part2 ( ranges -- count )
  [ [ last ] [ first ] bi - 1 + ] map sum ;

load-data [ day5-part1 . ] [ nip day5-part2 . ] 2bi
