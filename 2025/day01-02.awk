BEGIN { AT = 50 }
/L/ { DIR = -1 }
/R/ { DIR = +1 }
{ TICKS = substr($1, 2) }
{ while (TICKS-->0) { HITS += (AT+=DIR)%100 == 0 } }
END { print HITS }
