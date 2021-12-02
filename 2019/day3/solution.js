#!/usr/bin/env node

const fs = require('fs');
const { downloadInput } = require('../common');

const readInput = (filename) => {
  const input = fs.readFileSync(filename).toString();

  return input.trim().split('\n').map(line => line.split(','));
};

const points = (path) => {
  const m = new Map();

  let numStepsFromOrigin = 0;
  const position = { x: 0, y: 0 };

  path.forEach(elt => {
    let dx, dy;

    if (elt.startsWith('R')) {
      dx = 1;
      dy = 0;
    } else if (elt.startsWith('U')) {
      dx = 0;
      dy = 1;
    } else if (elt.startsWith('L')) {
      dx = -1;
      dy = 0;
    } else if (elt.startsWith('D')) {
      dx = 0;
      dy = -1;
    }

    let count = +elt.replace(/\D/, '');

    for (let i = 0; i < count; i++) {
      position.x += dx;
      position.y += dy;
      numStepsFromOrigin += 1;

      const key = `${position.x},${position.y}`;

      if (!m.has(key)) {
        m.set(`${position.x},${position.y}`, numStepsFromOrigin);
      }
    }
  });

  return m;
};

const part1 = (input) => {
  const points0 = points(input[0]);
  const points1 = points(input[1]);

  let minDistance = 999999999999;
  [...points0.keys()].forEach(coord => {
    if (points1.has(coord)) {
      const [x, y] = coord.split(',').map(n => +n);
      const distanceFromCenter = Math.abs(x) + Math.abs(y);

      minDistance = Math.min(minDistance, distanceFromCenter);
    }
  });

  return minDistance;
};

const part2 = (input) => {
  const points0 = points(input[0]);
  const points1 = points(input[1]);

  let minDistance = 999999999999;
  [...points0.keys()].forEach(coord => {
    if (points1.has(coord)) {
      const distanceFromCenter = points0.get(coord) + points1.get(coord);

      minDistance = Math.min(minDistance, distanceFromCenter);
    }
  });

  return minDistance;
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
