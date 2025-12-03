def top_half(x):
    x = str(x)
    return int(x[0:len(x)//2] or '0')

def invalid_ids(start, end):
    n = int(2 * str(top_half(start)))
    while n <= end:
        if n >= start: yield n
        n = int(2 * str(top_half(n) + 1))

total = 0
for ids in input().split(','):
    start, end = map(int, ids.split('-'))
    total += sum(invalid_ids(start, end))

print(total)
