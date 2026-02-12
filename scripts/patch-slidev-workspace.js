#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const patches = [
  // Patch 1: Reverse directory sort order
  {
    files: [
      path.join(__dirname, '../node_modules/slidev-workspace/dist/plugin-slides.js'),
      path.join(__dirname, '../node_modules/slidev-workspace/dist/cli.js')
    ],
    original: '.sort((a, b) => a.localeCompare(b))',
    replacement: '.sort((a, b) => b.localeCompare(a))',
    description: 'directory sort order'
  },
  // Patch 2: Add date sorting in UI
  {
    files: [
      path.join(__dirname, '../node_modules/slidev-workspace/src/preview/components/SlideDeck.vue')
    ],
    original: `  if (!searchTerm.value) return result;
  return result.filter(`,
    replacement: `  // Sort by date (newest first)
  result = result.sort((a, b) => {
    const dateA = new Date(a.date);
    const dateB = new Date(b.date);
    return dateB - dateA;
  });

  if (!searchTerm.value) return result;
  return result.filter(`,
    description: 'UI date sorting'
  },
  // Patch 3: Reverse category sorting
  {
    files: [
      path.join(__dirname, '../node_modules/slidev-workspace/src/preview/components/SlideDeck.vue')
    ],
    original: `  return [
    {
      name: "All",
      count: slidesCount.value,
    },
    ...categories,
  ];`,
    replacement: `  // Sort categories in reverse order (2025 -> 2024 -> 2023)
  const sortedCategories = categories.sort((a, b) => b.name.localeCompare(a.name));

  return [
    {
      name: "All",
      count: slidesCount.value,
    },
    ...sortedCategories,
  ];`,
    description: 'category reverse sorting'
  }
];

let totalSuccess = 0;
let totalAlreadyPatched = 0;

patches.forEach(({ files, original, replacement, description }) => {
  console.log(`\n📦 Patching ${description}...`);
  
  files.forEach((filePath) => {
    try {
      if (!fs.existsSync(filePath)) {
        console.warn(`⚠️  File not found: ${filePath}`);
        return;
      }

      let content = fs.readFileSync(filePath, 'utf8');
      const fileName = path.basename(filePath);
      
      if (content.includes(original)) {
        content = content.replace(original, replacement);
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`   ✅ Successfully patched ${fileName}`);
        totalSuccess++;
      } else if (content.includes(replacement)) {
        console.log(`   ✅ ${fileName} is already patched`);
        totalAlreadyPatched++;
      } else {
        console.warn(`   ⚠️  Could not find pattern in ${fileName}`);
      }
    } catch (error) {
      console.error(`   ❌ Failed to patch ${path.basename(filePath)}:`, error.message);
      process.exit(1);
    }
  });
});

console.log(`\n🎉 All patches completed: ${totalSuccess} updated, ${totalAlreadyPatched} already patched`);

