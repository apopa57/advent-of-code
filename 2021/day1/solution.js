#!/usr/bin/env node

const fs = require('fs');
const { downloadInput } = require('../common');

const readInput = (filename) => {
  const input = fs.readFileSync(filename).toString();

  return input.split('\n').map(line => +line);
};

const part1 = (input) => {
  const depths = input;

  let numDepthIncreases = 0;
  for (let i=0; i<depths.length; i++) {
    if (depths[i] > depths[i-1]) {
      numDepthIncreases++
    }
  }

  return numDepthIncreases;
};

const part2 = (input) => {
  const depths = input;

  let numDepthIncreases = 0;
  let previousWindowSum = depths[0] + depths[1] + depths[2];
  for (let i=3; i<depths.length; i++) {
    const currentWindowSum = previousWindowSum + depths[i] - depths[i-3];

    if (currentWindowSum > previousWindowSum) {
      numDepthIncreases += 1;
    }

    previousWindowSum = currentWindowSum;
  }

  return numDepthIncreases;
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
