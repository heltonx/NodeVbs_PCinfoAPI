const express = require('express');
const { exec } = require('child_process');
const path = require('path');
const app = express();
const port = 3000;

const vbscriptPath = path.join(__dirname, 'computerinfo.vbs');

app.get('/computerinfo', (req, res) => {
  exec(`cscript //NoLogo "${vbscriptPath}"`, { encoding: 'utf8' }, (error, stdout) => {
    if (error) {
      console.error(error);
      res.status(500).send('Error retrieving computer information.');
      return;
    }

    try {
      const computerInfo = JSON.parse(stdout.trim());
      res.json(computerInfo);
    } catch (parseError) {
      console.error(parseError);
      res.status(500).send('Error parsing computer information.');
    }
  });
});

app.listen(port, () => {
  console.log(`API server is running on port ${port}`);
});
