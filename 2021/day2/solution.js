#!/usr/bin/env node

const fs = require('fs');
const { downloadInput } = require('../common');

const readInput = (filename) => {
  const input = fs.readFileSync(filename).toString();

  return input.split('\n');
};

const part1 = (input) => {
  let horizontalPosition = 0;
  let depth = 0;

  input.forEach(instruction => {
    if (instruction.startsWith('forward')) {
      horizontalPosition += +instruction.replace('forward ', '');
    } else if (instruction.startsWith('down')) {
      depth += +instruction.replace('down ', '');
    } else if (instruction.startsWith('up')) {
      depth -= +instruction.replace('up ', '');
    }
  });

  return horizontalPosition * depth;
};

const part2 = (input) => {
  let horizontalPosition = 0;
  let depth = 0;
  let aim = 0;

  input.forEach(instruction => {
    if (instruction.startsWith('forward')) {
      horizontalPosition += +instruction.replace('forward ', '');
      depth += (aim * +instruction.replace('forward ', ''));
    } else if (instruction.startsWith('down')) {
      aim += +instruction.replace('down ', '');
    } else if (instruction.startsWith('up')) {
      aim -= +instruction.replace('up ', '');
    }
  });

  return horizontalPosition * depth;
};

const main = async () => {
  await downloadInput();

  const inputFiles = fs.readdirSync(process.cwd()).filter(file => file.startsWith('input')).sort(file => -file.length).forEach(inputFile => {
    console.log(`\n${inputFile}:`);

    const input = readInput(inputFile);

    console.log(`part1: ${part1(input)}`);
    console.log(`part2: ${part2(input)}`);
  });
};

main();
