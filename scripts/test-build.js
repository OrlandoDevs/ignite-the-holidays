import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

let errors = 0;

function test(description, fn) {
  try {
    fn();
    console.log('✓', description);
  } catch (error) {
    console.error('✗', description);
    console.error('  ', error.message);
    errors++;
  }
}

console.log('\nRunning build tests...\n');

test('index.html exists', () => {
  const indexPath = path.join(__dirname, '../index.html');
  if (!fs.existsSync(indexPath)) {
    throw new Error('index.html was not generated');
  }
});

test('index.html contains reveal.js scripts', () => {
  const indexPath = path.join(__dirname, '../index.html');
  const content = fs.readFileSync(indexPath, 'utf8');

  if (!content.includes('reveal.js')) {
    throw new Error('index.html does not contain reveal.js references');
  }
});

test('index.html contains slide sections', () => {
  const indexPath = path.join(__dirname, '../index.html');
  const content = fs.readFileSync(indexPath, 'utf8');

  if (!content.includes('<section')) {
    throw new Error('index.html does not contain any slide sections');
  }
});

test('slides/list.json exists', () => {
  const listPath = path.join(__dirname, '../slides/list.json');
  if (!fs.existsSync(listPath)) {
    throw new Error('slides/list.json does not exist');
  }
});

test('slides/list.json is valid JSON', () => {
  const listPath = path.join(__dirname, '../slides/list.json');
  const content = fs.readFileSync(listPath, 'utf8');
  JSON.parse(content);
});

test('all slides in list.json exist', () => {
  const listPath = path.join(__dirname, '../slides/list.json');
  const slides = JSON.parse(fs.readFileSync(listPath, 'utf8'));

  slides.forEach((slide) => {
    const slideFile = Array.isArray(slide) ? slide[0] : slide;
    const slideFileName = typeof slideFile === 'string' ? slideFile : slideFile.filename;

    if (slideFileName) {
      const slidePath = path.join(__dirname, '../slides', slideFileName);
      if (!fs.existsSync(slidePath)) {
        throw new Error(`Slide file ${slideFileName} does not exist`);
      }
    }
  });
});

test('templates/_index.html exists', () => {
  const templatePath = path.join(__dirname, '../templates/_index.html');
  if (!fs.existsSync(templatePath)) {
    throw new Error('templates/_index.html does not exist');
  }
});

test('templates/_section.html exists', () => {
  const templatePath = path.join(__dirname, '../templates/_section.html');
  if (!fs.existsSync(templatePath)) {
    throw new Error('templates/_section.html does not exist');
  }
});

test('index.html references node_modules (not bower_components)', () => {
  const indexPath = path.join(__dirname, '../index.html');
  const content = fs.readFileSync(indexPath, 'utf8');

  if (content.includes('bower_components')) {
    throw new Error('index.html still references bower_components instead of node_modules');
  }

  if (!content.includes('node_modules')) {
    throw new Error('index.html does not reference node_modules');
  }
});

console.log(`\n${errors === 0 ? '✓ All tests passed!' : `✗ ${errors} test(s) failed`}`);
process.exit(errors > 0 ? 1 : 0);
