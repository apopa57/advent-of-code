#!/usr/bin/env node

const fs = require('fs');
const { downloadInput } = require('../common');

const readInput = (filename) => {
  const input = fs.readFileSync(filename).toString();

  return input.split('\n');
};

const priority = (c) => {
  if ('a' <= c && c <= 'z') {
    return c.charCodeAt(0) - 'a'.charCodeAt(0) + 1;
  } else {
    return c.charCodeAt(0) - 'A'.charCodeAt(0) + 27;
  }
};

const stringToCharacterArray = (s) => {
  let chars = [];
  for (let i=0; i<s.length; i++) {
    chars.push(s[i]);
  }

  return new Set(chars);
};

const intersect = (s1, s2) => {
  return new Set([...s1].filter(elt => s2.has(elt)));
};

const part1 = (input) => {
  let prioritySum = 0;

  for (let i=0; i<input.length-1; i++) {
    const rucksack = input[i];
    const n = rucksack.length;
    const compartment1= stringToCharacterArray(rucksack.slice(0, n/2));
    const compartment2= stringToCharacterArray(rucksack.slice(n/2));
    const commonItem = [...intersect(compartment1, compartment2)][0];

    prioritySum += priority(commonItem);
  }
  return prioritySum;
};

const part2 = (input) => {
  let prioritySum = 0;

  for (let i=0; i<input.length-1; i+=3) {
    const rucksack1 = stringToCharacterArray(input[i]);
    const rucksack2 = stringToCharacterArray(input[i+1]);
    const rucksack3 = stringToCharacterArray(input[i+2]);
    console.log({ rucksack1, rucksack2, rucksack3 });
    const commonItem = [...intersect(rucksack1, intersect(rucksack2, rucksack3))][0];

    prioritySum += priority(commonItem);
  }

  return prioritySum;
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
