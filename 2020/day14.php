<?php

$mask1 = function($x) { return $x; };
$mem1 = [];

$mask2 = function($x) { return $x; };
$mem2 = [];

while (($line = fgets(STDIN)) !== false) {  
  preg_match("/mask\s*=\s*([10X]+)|mem\[(\d+)\]\s*=\s*(\d+)/", $line, $matches);
  if ($matches[1]) {
    $mask1 = decode_mask1($matches[1]);
    $mask2 = decode_mask2($matches[1]);
  } else {
    $mem1[$matches[2]] = $mask1($matches[3]);

    foreach ($mask2($matches[2]) as $index) {
      $mem2[$index] = $matches[3];
    }
  }
}

# Part 1
echo array_sum($mem1) . "\n";

# Part 2
echo array_sum($mem2) . "\n";

function decode_mask1($mask) {
  return function($x) use ($mask) {
    $bin = str_pad(base_convert($x, 10, 2), strlen($mask), '0', STR_PAD_LEFT);
    for ($i = 0; $i < strlen($mask); ++$i) {
      if ($mask[$i] !== 'X') {
        $bin[$i] = $mask[$i];
      }
    }

    return base_convert($bin, 2, 10);
  };
}

function decode_mask2($mask) {
  return function($x) use ($mask) {
    $bin = str_pad(base_convert($x, 10, 2), strlen($mask), '0', STR_PAD_LEFT);
    for ($i = 0; $i < strlen($mask); ++$i) {
      if ($mask[$i] !== '0') {
        $bin[$i] = $mask[$i];
      }
    }

    foreach (expand($bin) as $inner) {
      yield base_convert($inner, 2, 10);
    }
  };
}

function expand($x, $i = 0) {
  if ($i >= strlen($x)) {
    yield $x;
    return;
  }

  if ($x[$i] !== 'X') {
    yield from expand($x, $i+1);
  } else {
    $x[$i] = '1';
    yield from expand($x, $i+1);

    $x[$i] = '0';
    yield from expand($x, $i+1);
  }
}
