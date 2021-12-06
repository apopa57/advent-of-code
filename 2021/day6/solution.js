#!/usr/bin/env node

const fs = require('fs');
const { downloadInput } = require('../common');

const readInput = (filename) => {
  const input = fs.readFileSync(filename).toString().trim();

  return input.split(',').map(s => +s);
};

const simulate = (input, numDays) => {
  let counts = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  input.forEach(n => {
    counts[n] += 1
  });

  for (let i = 0; i < numDays; i++) {
    let newCounts = [];

    newCounts[8] = counts[0];
    for (let j = 0; j < 8; j++) {
      newCounts[j] = counts[j+1];
    }
    newCounts[6] += counts[0];

    counts = newCounts;
  }

  return counts.reduce((acc, n) => acc + n, 0);
};

const part1 = (input) => {
  return simulate(input, 80);
};

const part2 = (input) => {
  return simulate(input, 256);
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
