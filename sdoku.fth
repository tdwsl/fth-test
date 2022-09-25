\ sudoku generator in forth

create grid 9 9 * allot
create blanks 9 allot
variable seed
create buf 80 allot

: rand ( n -- n )
  seed @ swap mod dup seed @ + 1+ seed ! 1+ ;

: enter-seed ( -- )
  0 buf 80 accept dup 0= if exit then 0 do buf i + c@ + loop seed ! ;

: fill-grid ( -- )
  9 rand grid 3 0 do
    3 0 do
      9 0 do 2dup c! 1+ swap 9 mod 1+ swap loop
      swap 2 + 9 mod 1+ swap loop
    swap 9 mod 1+ swap
  loop 2drop ;

: swap-row ( n n -- )
  9 0 do 2dup 9 * grid + i + swap 9 * grid + i + 2dup
    c@ swap c@ rot c! swap c! loop drop drop ;

: swap-column ( n n -- )
  9 0 do 2dup i 9 * + grid + swap i 9 * + grid + 2dup
    c@ swap c@ rot c! swap c! loop drop drop ;

: shuffle-once ( n -- )
  dup 2 * 9 / 3 mod 3 * over 3 mod over + rot
  2 mod 0= if swap-row else swap-column then ;

: shuffle-grid ( n -- )
  0 do 100 rand shuffle-once loop ;

: print-grid ( -- )
  grid
  3 0 do 3 0 do 3 0 do 3 0 do
    dup c@ dup 0= if drop [char] - emit space else . then
    1+ loop space loop cr loop cr loop drop ;

: grid-cell ( n -- n )
  dup 3 / 3 mod over 27 / 3 * + ;

: cell-test ( -- )
  0 3 0 do 3 0 do 3 0 do 3 0 do
    dup grid-cell . 1+
  loop space loop cr loop cr loop drop ;

: add-blank ( n -- tf )
  grid-cell blanks + dup c@ 7 < if
    swap grid + dup c@ if 0 swap c! 1
      swap dup c@ 1+ swap c!
    else 2drop 0 then
  else 2drop 0 then ;

: add-blanks ( n -- )
  blanks 9 0 do 0 over c! 1+ loop drop
  81 rand swap begin over add-blank
    if 1- swap drop 9 rand 9 * 9 rand + swap
    else swap 4 rand + 81 mod swap then dup 0= until drop drop ;

." Enter a random word: " enter-seed cr
fill-grid
120 shuffle-grid
40 10 rand + add-blanks
print-grid
bye
