#!/usr/bin/env node

const fs = require('fs');
const { downloadInput } = require('../common');

const readInput = (filename) => {
  const input = fs.readFileSync(filename).toString().trim();

  return input.split('\n').map(line => {
    const [s1, s2] = line.split(' | ');
    return {
      uniquePatterns: s1.split(' ').map(s => s.split('').sort().join('')),
      output: s2.split(' ').map(s => s.split('').sort().join(''))
    };
  });
};

const part1 = (input) => {
  let count = 0;

  for (let i = 0; i < input.length; i++) {
    count += input[i].output.filter(s => [2, 3, 4, 7].includes(s.length)).length;
  }

  return count;
};

const decode = (({ uniquePatterns, output }) => {
  const number = new Map();
  const letters = [];

  const toLetterSet = (s) => new Set(s.split(''));

  const intersectionCount = (s1, s2) => [...s1].filter(elt => s2.has(elt)).length;

  uniquePatterns.sort((a, b) => a.length - b.length).forEach(entry => {
    const letterSet = toLetterSet(entry);

    if (entry.length === 2) {
      number[entry] = 1;
      letters[1] = letterSet;
    } else if (entry.length === 3) {
      number[entry] = 7;
      letters[7] = letterSet;
    } else if (entry.length === 4) {
      number[entry] = 4;
      letters[4] = letterSet;
    } else if (entry.length === 5) {
      if (intersectionCount(letterSet, letters[1]) === 2) {
        number[entry] = 3;
      } else if (intersectionCount(letterSet, letters[4]) === 3) {
        number[entry] = 5;
      } else {
        number[entry] = 2;
      }
    } else if (entry.length === 6) {
      if (intersectionCount(letterSet, letters[7]) === 2) {
        number[entry] = 6;
      } else if (intersectionCount(letterSet, letters[4]) === 4) {
        number[entry] = 9;
      } else {
        number[entry] = 0;
      }
    } else {
      number[entry] = 8;
    }
  });

  return number[output[0]] * 1000 + number[output[1]] * 100 + number[output[2]] * 10 + number[output[3]];
});

const part2 = (input) => {
  return input.reduce((acc, entry) => acc + decode(entry), 0);
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
