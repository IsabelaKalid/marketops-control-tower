import fs from 'node:fs';
import path from 'node:path';

const projectRoot = path.resolve(path.dirname(new URL(import.meta.url).pathname), '..');
const sourcePath = path.join(projectRoot, 'database', '002_seed_demo.sql');
const outputDir = path.join(projectRoot, 'database', 'seed_chunks');
const maxChunkBytes = 180_000;

const source = fs.readFileSync(sourcePath, 'utf8');
const bodyStart = source.indexOf('begin;') + 'begin;'.length;
const bodyEnd = source.lastIndexOf('\ncommit;');
if (bodyStart < 0 || bodyEnd < bodyStart) throw new Error('Seed transaction boundaries were not found.');

const blocks = source.slice(bodyStart, bodyEnd).trim().split(/\n\n+/).filter(Boolean);
const chunks = [];
let current = [];
let currentBytes = 0;

for (const block of blocks) {
  const blockBytes = Buffer.byteLength(block, 'utf8') + 2;
  if (current.length && currentBytes + blockBytes > maxChunkBytes) {
    chunks.push(current);
    current = [];
    currentBytes = 0;
  }
  current.push(block);
  currentBytes += blockBytes;
}
if (current.length) chunks.push(current);

fs.mkdirSync(outputDir, { recursive: true });
for (const name of fs.readdirSync(outputDir)) {
  if (/^\d{2}_seed_part_\d{2}\.sql$/.test(name) || name === '99_validate.sql' || name === 'README.txt') {
    fs.unlinkSync(path.join(outputDir, name));
  }
}

chunks.forEach((chunk, index) => {
  const number = String(index + 1).padStart(2, '0');
  const content = [
    `-- Demo seed part ${number} of ${String(chunks.length).padStart(2, '0')}. Run files in numeric order.`,
    'begin;',
    '',
    ...chunk.flatMap(statement => [statement, '']),
    'commit;',
    '',
  ].join('\n');
  fs.writeFileSync(path.join(outputDir, `${number}_seed_part_${number}.sql`), content, 'utf8');
});

fs.writeFileSync(path.join(outputDir, '99_validate.sql'), `select\n  (select count(*) from public.orders) as orders,\n  (select count(*) from public.order_items) as order_items,\n  (select count(*) from public.logistics) as logistics;\n`, 'utf8');

fs.writeFileSync(path.join(outputDir, 'README.txt'), [
  'MARKETOPS DEMO DATABASE SEED',
  '',
  '1. The database schema must already exist.',
  '2. Run every numbered seed file in ascending order.',
  '3. Run 99_validate.sql last.',
  '4. Expected result: orders=285, order_items=300, logistics=300.',
  '5. These files contain only synthetic demonstration data.',
  '',
].join('\n'), 'utf8');

console.log(`Created ${chunks.length} chunks (maximum ${maxChunkBytes} bytes each).`);
