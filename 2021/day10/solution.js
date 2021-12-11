#!/usr/bin/env node

const fs = require('fs');
const { downloadInput } = require('../common');

const readInput = (filename) => {
  const input = fs.readFileSync(filename).toString().trim();

  return input.split('\n').map(line => line.split(''));
};

const part1 = (input) => {
  const closingParens = {
    '[': ']',
    '(': ')',
    '{': '}',
    '<': '>'
  };

  const points = {
    ']': 57,
    ')': 3,
    '}': 1197,
    '>': 25137,
  };

  let syntaxErrorScore = 0;

  input.forEach(line => {
    const stack = [];

    for (let i = 0; i < line.length; i++) {
      if (line[i] === '(' || line[i] === '[' || line[i] === '{' || line[i] === '<') {
        stack.push(line[i]);
      } else if (line[i] === closingParens[stack[stack.length - 1]]) {
        stack.pop();
      } else {
        // console.log(`${line.join('')} - Expected ${closingParens[stack[stack.length - 1]]} but found ${line[i]} instead`);
        syntaxErrorScore += points[line[i]];
        return;
      }
    }
  });

  return syntaxErrorScore;
};

const part2 = (input) => {

  const closingParens = {
    '[': ']',
    '(': ')',
    '{': '}',
    '<': '>'
  };

  const points = {
    ']': 2,
    ')': 1,
    '}': 3,
    '>': 4,
  };

  const scores = input.map(line => {
    const stack = [];

    for (let i = 0; i < line.length; i++) {
      if (line[i] === '(' || line[i] === '[' || line[i] === '{' || line[i] === '<') {
        stack.push(line[i]);
      } else if (line[i] === closingParens[stack[stack.length - 1]]) {
        stack.pop();
      } else {
        return;
      }
    }

    // console.log(stack.join(''));

    let score = 0;
    for (let j = stack.length - 1; j >= 0; j--) {
      score = score * 5 + points[closingParens[stack[j]]];
    }

    return score;
  }).filter(n => !!n).sort((a, b) => a - b);

  // console.log(scores);

  return scores[(scores.length - 1) / 2];
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
