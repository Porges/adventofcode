	set sum=0
	for  do
	. read line1 write:$zeof sum,! quit:$zeof
	. read line2
	. read line3
	. set sum=sum+$$processlines(line1,line2,line3)

processlines(l1,l2,l3)
	for i=1:1:$Length(l1) set c=$Extract(l1,i,i) q:$Find(l2,c)&$Find(l3,c)
	quit $$translate(c)

translate(c)
	set alphabet="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	quit $Find(alphabet,c)-1
