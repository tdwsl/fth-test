( simple voronoi cells program )
 \ seems to have some inconsistent behaviour
  \ and doesn't really work on my forth interpreter

70 constant w
20 constant h
create cellmap w h * allot
create points 2 12 * allot
create cellchars 12 allot
variable seed
0 value a

char . cellchars c!
char # cellchars 1+ c!
char : cellchars 2 + c!
char 0 cellchars 3 + c!
char " cellchars 4 + c!
char ~ cellchars 5 + c!
char a cellchars 6 + c!
char - cellchars 7 + c!
char = cellchars 8 + c!
char + cellchars 9 + c!
char ' cellchars 10 + c!
char % cellchars 11 + c!

: rand ( n -- n )
  seed @ over - 1+ seed !
  seed @ swap mod ;

: strsum ( addr len -- n )
  0 rot rot 0 do dup c@ rot + swap 1+ loop drop ;

: add-points ( -- )
  12 0 do points i 2 * + dup w rand swap c! h rand swap 1+ c! loop ;

: distance ( x y x y -- n )
  rot swap - dup 2swap - dup * rot rot * + ;

: closest-point ( x y -- n )
  0 to a
  12 0 do
    points i 2 * + dup c@ swap 1+ c@ 2over distance >r 2dup r> rot rot
    points a 2 * + dup c@ swap 1+ c@ 2swap distance
    < if i to a then loop 2drop a ;

: fill-map ( -- )
  w h * 0 do i w mod i w / closest-point cellchars + c@ cellmap i + c! loop ;

: print-map ( -- )
  w h * 0 do cellmap i + c@ emit i 1+ w mod 0= if cr then loop ;

." Enter a word: "
create buf 80 allot
buf 80 accept buf swap strsum
seed ! cr
add-points
fill-map
print-map
bye
