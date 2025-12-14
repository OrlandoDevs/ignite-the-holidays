import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

function processSection(slide) {
  if (typeof slide === 'string') {
    const isHtml = slide.indexOf('.html') !== -1;
    const dataAttr = isHtml ? 'data-html' : 'data-markdown';
    return `    <section ${dataAttr}="slides/${slide}"></section>`;
  }

  if (slide && typeof slide === 'object' && !Array.isArray(slide)) {
    const attrs = Object.entries(slide.attr || {})
      .map(([key, val]) => `${key}="${val}"`)
      .join(' ');

    if (slide.filename) {
      const isHtml = slide.filename.indexOf('.html') !== -1;
      const dataAttr = isHtml ? 'data-html' : 'data-markdown';
      return `    <section ${attrs} ${dataAttr}="slides/${slide.filename}"></section>`;
    }
    return `    <section ${attrs}></section>`;
  }

  return '';
}

function buildIndex() {
  console.log('Building index.html...');

  try {
    const indexTemplate = fs.readFileSync(path.join(__dirname, '../templates/_index.html'), 'utf8');

    const slides = JSON.parse(fs.readFileSync(path.join(__dirname, '../slides/list.json'), 'utf8'));

    let sectionsHtml = '';
    slides.forEach((slide) => {
      if (Array.isArray(slide)) {
        sectionsHtml += '                <section>\n';
        slide.forEach((verticalSlide) => {
          sectionsHtml += `${processSection(verticalSlide)}\n`;
        });
        sectionsHtml += '                </section>\n';
      } else {
        sectionsHtml += `${processSection(slide)}\n`;
      }
    });

    const startMarker = '<% _.forEach(slides, function(slide) { %>';
    const endMarker = '<% }); %>';

    const startIdx = indexTemplate.indexOf(startMarker);
    if (startIdx === -1) {
      throw new Error('Could not find template start marker in _index.html');
    }

    let endIdx = indexTemplate.lastIndexOf(endMarker);
    if (endIdx <= startIdx) {
      throw new Error('Could not find template end marker in _index.html');
    }
    endIdx += endMarker.length;

    const html =
      indexTemplate.substring(0, startIdx) + sectionsHtml.trim() + indexTemplate.substring(endIdx);

    fs.writeFileSync(path.join(__dirname, '../index.html'), html, 'utf8');

    console.log('✓ index.html built successfully');
  } catch (error) {
    console.error('Error building index.html:', error.message);
    process.exit(1);
  }
}

// Convert file path to file URL for cross-platform compatibility
const scriptPath = fileURLToPath(import.meta.url);
const runPath = path.resolve(process.argv[1]);

if (scriptPath === runPath) {
  buildIndex();
}

export { buildIndex };
