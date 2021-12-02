const https = require('https');
const fs = require('fs');

const downloadInput = async () => {
  return new Promise((resolve, reject) => {
    const inputFilename = 'input';

    if (fs.existsSync(inputFilename)) {
      console.log(`${inputFilename} already exists`);
      resolve();
      return;
    }

    const tokens = process.cwd().split('/');

    const year = tokens[tokens.length - 2];
    const day = tokens[tokens.length - 1].replace('day', '');
    const url = `https://adventofcode.com/${year}/day/${day}/input`;

    console.log(`downloading input from ${url} to ${inputFilename}`);

    const req = https.get(
      `https://adventofcode.com/${year}/day/${day}/input`,
      {
        port: 443,
        headers: { Cookie: `session=${process.env.session}` },
        timeout: 5000
      },
      (res) => {
        const s = fs.createWriteStream(inputFilename);
        res.pipe(s);

        s.on('finish', () => {
          console.log('input download finished')
          resolve();
        });
      }
    );
  });
}

module.exports = { downloadInput };
