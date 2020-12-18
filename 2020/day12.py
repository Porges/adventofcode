import operator
import re
import sys

def r90(d):
      return (d[1], -d[0])


class Ship:
    def __init__(self):
        self.at = (0, 0)
        self.delta = (1, 0)
        self.dirs = {
            'N': lambda n: self.go((0, 1), n),
            'E': lambda n: self.go((1, 0), n),
            'W': lambda n: self.go((-1, 0), n),
            'S': lambda n: self.go((0, -1), n),
            'F': lambda n: self.go(self.delta, n),
            'L': lambda n: self.rotate(-n),
            'R': lambda n: self.rotate(n),
        }

    def go(self, d, n):
        self.at = tuple(map(operator.add, self.at, [n*x for x in d]))

    def rotate(self, n):
        while n < 0:
            n = 360+n
        for _ in range(n//90):
            self.delta = r90(self.delta)

    def decode(self, input):
        m = re.search('(\w)(\d+)', input)
        self.dirs[m.group(1)](int(m.group(2)))

class ShipAndWaypoint:
    def __init__(self):
        self.at = (0,0)
        self.waypoint = (10, 1)
        self.dirs = {
            'N': lambda n: self.go_waypoint((0, 1), n),
            'E': lambda n: self.go_waypoint((1, 0), n),
            'W': lambda n: self.go_waypoint((-1, 0), n),
            'S': lambda n: self.go_waypoint((0, -1), n),
            'F': lambda n: self.go_ship(self.waypoint, n),
            'L': lambda n: self.rotate_waypoint(-n),
            'R': lambda n: self.rotate_waypoint(n),
        }

    def go_waypoint(self, d, n):
        self.waypoint = tuple(map(operator.add, self.waypoint, [n*x for x in d]))

    def go_ship(self, d, n):
        self.at = tuple(map(operator.add, self.at, [n*x for x in d]))

    def rotate_waypoint(self, n):
        while n < 0:
            n = 360+n
        for _ in range(n//90):
            self.waypoint = r90(self.waypoint)

    def decode(self, input):
        m = re.search('(\w)(\d+)', input)
        self.dirs[m.group(1)](int(m.group(2)))

s = Ship()
s2 = ShipAndWaypoint()
for line in sys.stdin.readlines():
    s.decode(line)
    s2.decode(line)

# Part 1
print(abs(s.at[0]) + abs(s.at[1]))

# Part 2
print(abs(s2.at[0]) + abs(s2.at[1]))
