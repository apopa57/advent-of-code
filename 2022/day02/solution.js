#!/usr/bin/env node

const fs = require('fs');
const { downloadInput } = require('../common');

const readInput = (filename) => {
  const input = fs.readFileSync(filename).toString();

  return input.split('\n').map(line => line.split(' '));
};

const result = {};

result.rock = {};
result.paper = {};
result.scissors = {};

result.rock.rock = 'draw';
result.rock.paper = 'win';
result.rock.scissors = 'loss';
result.paper.rock = 'loss';
result.paper.paper = 'draw';
result.paper.scissors = 'win';
result.scissors.rock = 'win';
result.scissors.paper = 'loss';
result.scissors.scissors = 'draw';
result.rock.loss = 'scissors';
result.rock.draw = 'rock';
result.rock.win = 'paper';
result.paper.loss = 'rock';
result.paper.draw = 'paper';
result.paper.win = 'scissors';
result.scissors.loss = 'paper';
result.scissors.draw = 'scissors';
result.scissors.win = 'rock';

const score = {};

score.rock = 1;
score.paper = 2;
score.scissors = 3;
score.loss = 0;
score.draw = 3;
score.win = 6;

const part1 = (input) => {
  const translate = {
    A: 'rock',
    B: 'paper',
    C: 'scissors',
    X: 'rock',
    Y: 'paper',
    Z: 'scissors',
  };

  let sum = 0;
  for (let i=0; i<input.length-1; i++) {
    const them = translate[input[i][0]];
    const me = translate[input[i][1]];

    sum += (score[me] + score[result[them][me]]);
  }
  return sum;
};

const part2 = (input) => {
  const translate = {
    A: 'rock',
    B: 'paper',
    C: 'scissors',
    X: 'loss',
    Y: 'draw',
    Z: 'win',
  };

  let sum = 0;
  for (let i=0; i<input.length-1; i++) {
    const them = translate[input[i][0]];
    const expectedResult = translate[input[i][1]];
    const me = result[them][expectedResult];

    sum += (score[me] + score[result[them][me]]);
  }
  return sum;
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
