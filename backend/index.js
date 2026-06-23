const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
app.use(cors());
app.use(express.json());

const pool = new Pool({
  host: process.env.DB_HOST || 'db',
  port: process.env.DB_PORT || 5432,
  database: process.env.DB_NAME || 'trivia_db',
  user: process.env.DB_USER || 'trivia_user',
  password: process.env.DB_PASSWORD || 'trivia_pass',
});

// Get 15 random questions
app.get('/api/questions', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT id, question, option_a, option_b, option_c, option_d, category FROM questions ORDER BY RANDOM() LIMIT 15'
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch questions' });
  }
});

// Check answer
app.post('/api/answer', async (req, res) => {
  const { questionId, answer } = req.body;
  try {
    const result = await pool.query(
      'SELECT correct_answer FROM questions WHERE id = $1',
      [questionId]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Question not found' });
    }
    const correct = result.rows[0].correct_answer === answer;
    res.json({ correct, correctAnswer: result.rows[0].correct_answer });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to check answer' });
  }
});

// Submit score to leaderboard
app.post('/api/leaderboard', async (req, res) => {
  const { playerName, score, totalQuestions } = req.body;
  try {
    await pool.query(
      'INSERT INTO leaderboard (player_name, score, total_questions) VALUES ($1, $2, $3)',
      [playerName, score, totalQuestions]
    );
    res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to save score' });
  }
});

// Get leaderboard
app.get('/api/leaderboard', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT player_name, score, total_questions, created_at FROM leaderboard ORDER BY score DESC LIMIT 10'
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch leaderboard' });
  }
});

// Check if player name already exists
app.get('/api/check-name/:name', async (req, res) => {
  const { name } = req.params;
  try {
    const result = await pool.query(
      'SELECT COUNT(*) FROM leaderboard WHERE LOWER(player_name) = LOWER($1)',
      [name]
    );
    const exists = parseInt(result.rows[0].count) > 0;
    res.json({ exists });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to check name' });
  }
});

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok' });
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Backend running on port ${PORT}`);
});
