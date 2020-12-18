package main

import (
  "bufio"
  "fmt"
  "os"
  "strconv"
  "strings"
)

var funcs = []func(int, int) int {
  func (x int, y int) int { return x + y },
  func (x int, y int) int { return x * y },
}

func interpret(ns []int) {
  for at := 0; at < len(ns); at += 4 {
    if (ns[at] == 99) { return }
    ns[ns[at+3]] = funcs[ns[at]-1](ns[ns[at+1]], ns[ns[at+2]])
  }
}

func main() {
  input := bufio.NewScanner(os.Stdin)
  for input.Scan() {
    var numbers []int
    for _, field := range strings.Split(input.Text(), ",") {
      number, err := strconv.Atoi(field)
      if err != nil {
        fmt.Println(err)
        os.Exit(1)
      }

      numbers = append(numbers, number)
    }

    numbers[1] = 12
    numbers[2] = 2

    interpret(numbers)
    fmt.Println(numbers[0])
  }
}
