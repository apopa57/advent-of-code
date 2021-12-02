#!/usr/bin/env node

const fs = require('fs');
const { downloadInput } = require('../common');

const readInput = (filename) => {
  const input = fs.readFileSync(filename).toString();

  return input.trim().split(',').map(line => +line);
};

const run = (program) => {
  let i = 0;
  while (i < program.length) {
    if (program[i] === 1) {
      const input1 = program[program[i+1]];
      const input2 = program[program[i+2]];
      program[program[i+3]] = input1 + input2;
      i += 4;
    }
    if (program[i] === 2) {
      const input1 = program[program[i+1]];
      const input2 = program[program[i+2]];
      program[program[i+3]] = input1 * input2;
      i += 4;
    }
    if (program[i] === 99) {
      break;
    }
  }

  return program[0];
};

const part1 = (input) => {
  const program = [...input]

  program[1] = 12;
  program[2] = 2;

  return run(program);
};

const part2 = (input) => {
  for (let noun = 0; noun <= 99; noun++) {
    for (let verb = 0; verb <= 99; verb++) {
      const program = [...input];

      program[1] = noun;
      program[2] = verb;

      if (run(program) === 19690720) {
        return 100 * noun + verb;
      }
    }
  }

  return -1;
};

const main = async () => {
  // await downloadInput();

  const inputFiles = fs.readdirSync(process.cwd()).filter(file => file.startsWith('input')).sort(file => -file.length).forEach(inputFile => {
    console.log(`\n${inputFile}:`);

    const input = readInput(inputFile);

    console.log(`part1: ${part1(input)}`);
    console.log(`part2: ${part2(input)}`);
  });
};

main();
