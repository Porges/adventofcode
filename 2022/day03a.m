	set sum=0
	for  read line quit:$zeof  set sum=sum+$$processline(line)
	write sum,!
	halt

processline(line)
	set len=$Length(line)/2
	for i=1:1:len set c=$Extract(line,i,i) q:$Find(line,c,len+1)
	quit $$translate(c)

translate(c)
	set alphabet="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	quit $Find(alphabet,c)-1
