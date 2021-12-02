#!/usr/bin/env node

const fs = require('fs');
const { downloadInput } = require('../common');

const readInput = (filename) => {
  const input = fs.readFileSync(filename).toString();

  // TODO
  return input;
};

const part1 = (input) => {
  // TODO
  return input.length;
};

const part2 = (input) => {
  // TODO
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
