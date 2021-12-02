#!/usr/bin/env node

const fs = require('fs');
const { downloadInput } = require('../common');

const readInput = (filename) => {
  const input = fs.readFileSync(filename).toString().trim();

  return input.split('\n').map(line => +line);
};

const part1 = (input) => {
  return input.reduce((acc, mass) => {
    const fuel = (Math.floor(mass / 3) - 2);
    return acc + fuel;
  }, 0);
};

const part2 = (input) => {
  return input.reduce((acc, mass) => {
    let totalFuel = 0;
    let fuel;

    do {
      fuel = (Math.floor(mass / 3) - 2);
      if (fuel > 0) {
        totalFuel += fuel;
        mass = fuel;
      }
    } while (fuel > 0);

    return acc + totalFuel;
  }, 0);
  return input.length;
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
