import pg from 'pg';
const pool = new pg.Pool({ connectionString: process.env.POSTGRES_URL });

const sample = [
  ['General', 'easy', 'Capital of France?', ['Paris', 'Rome', 'Madrid', 'Berlin'], 0],
  ['Science', 'easy', 'H2O is?', ['Hydrogen', 'Oxygen', 'Water', 'Helium'], 2],
];

for (const [category, difficulty, body, choices, correct_index] of sample) {
  await pool.query(
    'INSERT INTO questions(category,difficulty,body,choices,correct_index) VALUES ($1,$2,$3,$4,$5)',
    [category, difficulty, body, choices, correct_index]
  );
}
await pool.end();
console.log('Seeded.');
