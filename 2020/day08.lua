defns = {
  acc = function(arg) return 1, arg end,
  nop = function() return 1, 0 end,
  jmp = function(arg) return arg, 0 end,
}

function run_program(program) 
  local executed, ix, acc = {}, 1, 0
  while true do
    if executed[ix] then
      return false, acc -- LOOPED
    end

    executed[ix] = true

    local r = program[ix]
    if r == nil then
      return true, acc -- HALTED
    end

    local dIx, dAcc = defns[r.cmd](r.arg)
    ix, acc = ix + dIx, acc + dAcc
  end
end

program = {}

for line in io.lines("day08.txt") do
 for cmd, arg in line:gmatch("(%w+) ([+-]%d+)") do
  program[#program+1] = { cmd = cmd, arg = arg }
 end
end

function part1(program)
  local _, result = run_program(program)
  return result
end

print(part1(program))

function part2(program)
  local flip = { nop = "jmp", jmp = "nop" }
  for insn=1,#program do
    local original = program[insn].cmd
    local flipped = flip[original]
    if flipped ~= nil then
      program[insn].cmd = flipped
      local halted, result = run_program(program)
      if halted then return result end
    end

    program[insn].cmd = original
  end
end

print(part2(program))
