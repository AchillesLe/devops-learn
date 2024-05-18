const express = require('express')
const app = express()
const port = 3000
const path = require('path');
const fs = require('fs');

app.use(express.static('public'))

app.get('/', (req, res) => {
  console.log('host.docker.internal', hostname);
  res.sendFile(__dirname + '/public/index.html');
})

function getRandomColor() {
  const letters = '0123456789ABCDEF';
  let color = '#';
  for (let i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}

const indexHtmlPath = path.join(__dirname, 'public', 'index.html');
fs.readFile(indexHtmlPath, 'utf8', (err, data) => {
  if (err) console.error('Error reading index.html:', err);

  const newText = `<h1 id="welcome" style="color: ${getRandomColor()};">`
  const modifiedData = data.replace(/<h1 id="welcome" style="color:.*?;">/, newText)
  fs.writeFile(indexHtmlPath, modifiedData, 'utf-8', (err) => {
    if (err) console.error('Error write index.html:', err);
  })
})


app.listen(port, () => {
  console.log(`server is running on port ${port}`);
})

// function sleep(ms) {
//   return new Promise((resolve) => setTimeout(resolve, ms))
// }

// async function main() {
//   console.log("before sleep");
//   await sleep(15000)
//   console.log("after sleep")
//   process.exit(101)
// }

// main();