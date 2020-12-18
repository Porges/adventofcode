package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

// There is a very nice monoidal solution to this problem.
//
// It is not to be found here.

type Baggage map[string]map[string]int

var outer *regexp.Regexp = regexp.MustCompile("^(?P<outer>.*?) bags")
var inner *regexp.Regexp = regexp.MustCompile("(?P<count>\\d+) (?P<inner>.*?) bag")

func ParseBaggage(file *os.File) Baggage {
	baggage := make(Baggage)

	s := bufio.NewScanner(file)
	for s.Scan() {
		line := s.Text()

		owner := outer.FindStringSubmatch(line)[1]
		inners := make(map[string]int)
		for _, match := range inner.FindAllStringSubmatch(line, -1) {
			var err error
			inners[match[2]], err = strconv.Atoi(match[1])
			if err != nil {
				panic(err)
			}
		}

		baggage[owner] = inners
	}

	return baggage
}

func (b Baggage) CanContain(outer string, inner string) bool {
	for i := range b[outer] {
		if i == inner || b.CanContain(i, inner) {
			return true
		}
	}

	return false
}

func (b Baggage) CountCanContain(name string) int {
	containables := 0
	for outer := range b {
		if b.CanContain(outer, name) {
			containables++
		}
	}

	return containables
}

func (b Baggage) MustContainCount(name string) int {
	count := 0
	for i, c := range b[name] {
		count += (b.MustContainCount(i) + 1) * c
	}

	return count
}

func main() {
	baggage := ParseBaggage(os.Stdin)

	myBag := "shiny gold"
	fmt.Printf("%v\n", baggage.CountCanContain(myBag))
	fmt.Printf("%v\n", baggage.MustContainCount(myBag))
}
