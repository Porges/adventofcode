def top_nth(x, n):
    x = str(x)
    return int(x[0:len(x)//n] or '0')

def invalid_ids(start, end):
    invalid = set()
    for d in range(2, len(str(end)) + 1):
        n = int(d * str(top_nth(start, d)))
        while n <= end:
            if n >= start: invalid.add(n)
            n = int(d * str(top_nth(n, d) + 1))
    return invalid

total = 0
for ids in input().split(','):
    start, end = map(int, ids.split('-'))
    total += sum(invalid_ids(start, end))

print(total)
