#!/usr/bin/env node

const fs = require('fs');
const { downloadInput } = require('../common');

const readInput = (filename) => {
  const input = fs.readFileSync(filename).toString();

  return input.split('\n');
};

const part1 = (input) => {
  let sum = 0, max = 0;
  for (let i=0; i<input.length; i++) {
    if (input[i] === '') {
      max = (sum > max) ? sum : max;
      sum = 0;
    } else {
      sum += Number(input[i]);
    }
  }
  return max;
};

const part2 = (input) => {
  let sums = [], sum = 0;
  for (let i=0; i<input.length; i++) {
    if (input[i] === '') {
      sums.push(sum)
      sum = 0;
    } else {
      sum += Number(input[i]);
    }
  }

  sums.sort((a, b) => a < b ? 1 : -1);

  return sums[0] + sums[1] + sums[2];
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
