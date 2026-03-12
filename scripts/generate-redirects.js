#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const distDir = path.resolve(__dirname, '../dist');
const redirects = [];

function collectPresentationPaths(dir, relativePath = '') {
  if (!fs.existsSync(dir)) return;

  const entries = fs.readdirSync(dir, { withFileTypes: true });

  for (const entry of entries) {
    if (!entry.isDirectory() || entry.name === 'assets') continue;

    const subDir = path.join(dir, entry.name);
    const relPath = relativePath ? `${relativePath}/${entry.name}` : entry.name;
    const hasIndex = fs.existsSync(path.join(subDir, 'index.html'));

    if (hasIndex) {
      redirects.push(`/${relPath}/*  /${relPath}/index.html  200`);
    }

    collectPresentationPaths(subDir, relPath);
  }
}

collectPresentationPaths(distDir);

redirects.push('/*  /index.html  200');

const content = redirects.join('\n') + '\n';
fs.writeFileSync(path.join(distDir, '_redirects'), content);

console.log(`✅ Generated _redirects with ${redirects.length} rules:`);
console.log(content);
