BEGIN { AT = 50 }
/L/ { DIR = -1 }
/R/ { DIR = +1 }
{ AT += DIR * substr($1, 2) }
AT%100 == 0 { HITS += 1 }
END { print HITS }
