void Main()
{
	var s = "19,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,859,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,17,x,x,x,x,x,x,x,x,x,x,x,29,x,373,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37";
	var (t, _) = s.Split(',')
		.Select((x, i) => new { ok = ulong.TryParse(x, out var val), val, offset = (ulong)i })
		.Where(x => x.ok)
	 	.Aggregate(
			(t: 0UL, lcm: 1UL),
			(a, x) =>
			{
				while ((a.t + x.offset) % x.val != 0)
				{
					a.t += a.lcm;
				}
				
				return (a.t, a.lcm * x.val /* all inputs are prime so we can just multiply */);
			});
	
	Console.WriteLine(t);
}
