\ prime factors in forth

: is-prime ( n -- tf )
  dup 1 = if drop -1 exit then
  1 begin 1+ 2dup 2dup mod 0= rot rot = or until
  = ;

: next-prime ( n -- n )
  begin 1+ dup is-prime until ;

: prime-factors ( n -- )
  dup is-prime if . cr exit then
  1 begin next-prime 2dup mod 0= until
  dup . [char] x emit space / recurse ;

: main ( -- )
  101 1 do i dup . [char] = emit space prime-factors loop ;
main bye
