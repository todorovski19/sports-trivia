import { useState, useEffect, useCallback } from 'react';

const API = process.env.REACT_APP_API_URL || 'http://localhost:4000';
const TIMER_SECONDS = 20;

const CATEGORIES = [
  { label: '🏆 All Sports', value: 'All' },
  { label: '⚽ Soccer', value: 'Football' },
  { label: '🏀 Basketball', value: 'Basketball' },
  { label: '⚾ Baseball', value: 'Baseball' },
  { label: '🏈 NFL', value: 'American Football' },
  { label: '🏎️ Formula 1', value: 'Formula 1' },
  { label: '🎾 Tennis', value: 'Tennis' },
  { label: '🏒 NHL', value: 'Hockey' },
  { label: '🏅 Olympics', value: 'Olympics' },
];

function getPoints(secondsLeft) {
  return Math.max(10, Math.round((secondsLeft / TIMER_SECONDS) * 100));
}

function getCategoryEmoji(category) {
  const map = {
    Football: '⚽', Basketball: '🏀', Tennis: '🎾', 'Formula 1': '🏎️',
    Olympics: '🏅', Cricket: '🏏', 'American Football': '🏈', Baseball: '⚾',
    Golf: '⛳', Swimming: '🏊', Boxing: '🥊', Athletics: '🏃', Cycling: '🚴',
    Rugby: '🏉', Hockey: '🏒', Volleyball: '🏐', 'General Sports': '🏆',
  };
  return map[category] || '🏆';
}

export default function App() {
  const [screen, setScreen] = useState('home');
  const [playerName, setPlayerName] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [questions, setQuestions] = useState([]);
  const [current, setCurrent] = useState(0);
  const [score, setScore] = useState(0);
  const [timeLeft, setTimeLeft] = useState(TIMER_SECONDS);
  const [selected, setSelected] = useState(null);
  const [correct, setCorrect] = useState(null);
  const [leaderboard, setLeaderboard] = useState([]);
  const [loading, setLoading] = useState(false);
  const [pointsEarned, setPointsEarned] = useState(null);

  const goToNext = useCallback(() => {
    setSelected(null);
    setCorrect(null);
    setPointsEarned(null);
    setTimeLeft(TIMER_SECONDS);
    if (current + 1 >= questions.length) {
      setScreen('result');
    } else {
      setCurrent(c => c + 1);
    }
  }, [current, questions.length]);

  useEffect(() => {
    if (screen !== 'quiz' || selected !== null) return;
    if (timeLeft <= 0) {
      setSelected('TIMEOUT');
      setCorrect(false);
      setTimeout(goToNext, 1500);
      return;
    }
    const t = setTimeout(() => setTimeLeft(t => t - 1), 1000);
    return () => clearTimeout(t);
  }, [screen, timeLeft, selected, goToNext]);

  async function startGame() {
    if (!playerName.trim()) return;
    setLoading(true);
    const checkRes = await fetch(`${API}/api/check-name/${encodeURIComponent(playerName.trim())}`);
    const checkData = await checkRes.json();
    if (checkData.exists) {
      alert(`The name "${playerName}" is already taken! Please choose a different name.`);
      setLoading(false);
      return;
    }
    const url = selectedCategory === 'All'
      ? `${API}/api/questions`
      : `${API}/api/questions?category=${encodeURIComponent(selectedCategory)}`;
    const res = await fetch(url);
    const data = await res.json();
    setQuestions(data);
    setCurrent(0);
    setScore(0);
    setTimeLeft(TIMER_SECONDS);
    setSelected(null);
    setCorrect(null);
    setLoading(false);
    setScreen('quiz');
  }

  async function handleAnswer(option) {
    if (selected) return;
    setSelected(option);
    const q = questions[current];
    const res = await fetch(`${API}/api/answer`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ questionId: q.id, answer: option }),
    });
    const data = await res.json();
    setCorrect(data.correct);
    if (data.correct) {
      const pts = getPoints(timeLeft);
      setPointsEarned(pts);
      setScore(s => s + pts);
    }
    setTimeout(goToNext, 1800);
  }

  async function saveAndShowLeaderboard() {
    await fetch(`${API}/api/leaderboard`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ playerName, score, totalQuestions: questions.length }),
    });
    fetchLeaderboard();
    setScreen('leaderboard');
  }

  async function fetchLeaderboard() {
    const res = await fetch(`${API}/api/leaderboard`);
    const data = await res.json();
    setLeaderboard(data);
  }

  const timerPct = (timeLeft / TIMER_SECONDS) * 100;
  const timerColor = timeLeft > 10 ? '#22c55e' : timeLeft > 5 ? '#f59e0b' : '#ef4444';

  // HOME
  if (screen === 'home') return (
    <div style={styles.page}>
      <div style={{ ...styles.card, maxWidth: 560 }}>
        <div style={{ fontSize: 64, marginBottom: 8 }}>🏆</div>
        <h1 style={styles.title}>Sports Trivia</h1>
        <p style={styles.subtitle}>15 random questions · 20 seconds each · Score by speed!</p>

        <p style={{ color: '#94a3b8', fontSize: 13, marginBottom: 10, alignSelf: 'flex-start' }}>Select a category:</p>
        <div style={styles.catGrid}>
          {CATEGORIES.map(cat => (
            <button
              key={cat.value}
              style={{
                ...styles.catBtn,
                background: selectedCategory === cat.value ? '#2563eb' : '#1e293b',
                border: selectedCategory === cat.value ? '2px solid #3b82f6' : '2px solid #334155',
                color: selectedCategory === cat.value ? '#fff' : '#94a3b8',
              }}
              onClick={() => setSelectedCategory(cat.value)}
            >
              {cat.label}
            </button>
          ))}
        </div>

        <input
          style={styles.input}
          placeholder="Enter your name..."
          value={playerName}
          onChange={e => setPlayerName(e.target.value)}
          onKeyDown={e => e.key === 'Enter' && startGame()}
          maxLength={20}
        />
        <button style={styles.btn} onClick={startGame} disabled={loading || !playerName.trim()}>
          {loading ? 'Loading...' : '▶ Start Game'}
        </button>
        <button style={{ ...styles.btn, background: '#334155', marginTop: 8 }} onClick={() => { fetchLeaderboard(); setScreen('leaderboard'); }}>
          🏆 Leaderboard
        </button>
      </div>
    </div>
  );

  // QUIZ
  if (screen === 'quiz') {
    const q = questions[current];
    const options = ['A', 'B', 'C', 'D'];
    const optTexts = [q.option_a, q.option_b, q.option_c, q.option_d];

    return (
      <div style={styles.page}>
        <div style={{ ...styles.card, maxWidth: 640 }}>
          <div style={styles.quizHeader}>
            <span style={styles.qCounter}>Q {current + 1} / {questions.length}</span>
            <span style={styles.scorePill}>Score: {score}</span>
            <span style={{ ...styles.badge, background: '#1e293b' }}>
              {getCategoryEmoji(q.category)} {q.category}
            </span>
          </div>

          <div style={styles.timerWrap}>
            <div style={{ ...styles.timerBar, width: `${timerPct}%`, background: timerColor }} />
          </div>
          <div style={{ textAlign: 'center', fontSize: 13, color: timerColor, marginBottom: 16, fontWeight: 600 }}>
            {timeLeft}s remaining {pointsEarned ? `· +${pointsEarned} pts!` : ''}
          </div>

          <p style={styles.question}>{q.question}</p>

          <div style={styles.optionsGrid}>
            {options.map((opt, i) => {
              let bg = '#1e293b';
              if (selected) {
                if (opt === selected && correct) bg = '#16a34a';
                else if (opt === selected && !correct) bg = '#dc2626';
                else if (correct === false && opt === q.correct_answer) bg = '#16a34a';
              }
              return (
                <button
                  key={opt}
                  style={{ ...styles.optBtn, background: bg }}
                  onClick={() => handleAnswer(opt)}
                  disabled={!!selected}
                >
                  <span style={styles.optLabel}>{opt}</span>
                  {optTexts[i]}
                </button>
              );
            })}
          </div>

          {selected === 'TIMEOUT' && (
            <p style={{ color: '#f59e0b', textAlign: 'center', marginTop: 8 }}>⏰ Time's up!</p>
          )}
        </div>
      </div>
    );
  }

  // RESULT
  if (screen === 'result') {
    const max = questions.length * 100;
    const pct = Math.round((score / max) * 100);
    const emoji = pct >= 80 ? '🏆' : pct >= 60 ? '🥈' : pct >= 40 ? '🥉' : '😅';
    return (
      <div style={styles.page}>
        <div style={styles.card}>
          <div style={{ fontSize: 72 }}>{emoji}</div>
          <h2 style={styles.title}>Game Over!</h2>
          <p style={{ color: '#94a3b8', marginBottom: 4 }}>Well played, {playerName}!</p>
          <div style={styles.scoreBig}>{score}</div>
          <p style={{ color: '#64748b', marginBottom: 24 }}>points out of {max} possible</p>
          <button style={styles.btn} onClick={saveAndShowLeaderboard}>🏆 Save & View Leaderboard</button>
          <button style={{ ...styles.btn, background: '#334155', marginTop: 8 }} onClick={startGame}>🔄 Play Again</button>
          <button style={{ ...styles.btn, background: '#1e293b', marginTop: 8 }} onClick={() => setScreen('home')}>🏠 Home</button>
        </div>
      </div>
    );
  }

  // LEADERBOARD
  if (screen === 'leaderboard') return (
    <div style={styles.page}>
      <div style={{ ...styles.card, maxWidth: 500 }}>
        <div style={{ fontSize: 48 }}>🏆</div>
        <h2 style={styles.title}>Leaderboard</h2>
        <p style={{ color: '#64748b', marginBottom: 20, fontSize: 13 }}>Top 10 all-time scores</p>
        {leaderboard.length === 0 ? (
          <p style={{ color: '#475569' }}>No scores yet. Be the first!</p>
        ) : (
          leaderboard.map((entry, i) => (
            <div key={i} style={{ ...styles.lbRow, background: i === 0 ? '#1e3a1e' : '#1e293b' }}>
              <span style={styles.lbRank}>{i === 0 ? '🥇' : i === 1 ? '🥈' : i === 2 ? '🥉' : `#${i + 1}`}</span>
              <span style={{ flex: 1, fontWeight: 500 }}>{entry.player_name}</span>
              <span style={{ color: '#facc15', fontWeight: 700 }}>{entry.score} pts</span>
            </div>
          ))
        )}
        <button style={{ ...styles.btn, marginTop: 24 }} onClick={startGame}>▶ Play</button>
        <button style={{ ...styles.btn, background: '#334155', marginTop: 8 }} onClick={() => setScreen('home')}>🏠 Home</button>
      </div>
    </div>
  );
}

const styles = {
  page: {
    minHeight: '100vh', background: '#0f172a', display: 'flex',
    alignItems: 'center', justifyContent: 'center', padding: 16,
    fontFamily: 'system-ui, sans-serif', color: '#f1f5f9',
  },
  card: {
    background: '#1e293b', borderRadius: 20, padding: '40px 32px',
    width: '100%', maxWidth: 480, boxShadow: '0 25px 50px rgba(0,0,0,0.5)',
    display: 'flex', flexDirection: 'column', alignItems: 'center', textAlign: 'center',
  },
  title: { fontSize: 28, fontWeight: 700, margin: '8px 0', color: '#f8fafc' },
  subtitle: { color: '#94a3b8', fontSize: 14, marginBottom: 20 },
  badge: { background: '#334155', borderRadius: 99, padding: '4px 10px', fontSize: 12, color: '#cbd5e1' },
  catGrid: {
    display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)',
    gap: 8, width: '100%', marginBottom: 20,
  },
  catBtn: {
    padding: '10px 6px', borderRadius: 10, fontSize: 12,
    fontWeight: 600, cursor: 'pointer', transition: 'all 0.15s',
  },
  input: {
    width: '100%', padding: '12px 16px', borderRadius: 10, border: '1px solid #334155',
    background: '#0f172a', color: '#f1f5f9', fontSize: 16, marginBottom: 12,
    boxSizing: 'border-box', outline: 'none',
  },
  btn: {
    width: '100%', padding: '14px', borderRadius: 10, border: 'none',
    background: '#2563eb', color: '#fff', fontSize: 16, fontWeight: 600,
    cursor: 'pointer', transition: 'opacity 0.2s',
  },
  quizHeader: {
    display: 'flex', justifyContent: 'space-between', alignItems: 'center',
    width: '100%', marginBottom: 16, flexWrap: 'wrap', gap: 8,
  },
  qCounter: { background: '#334155', borderRadius: 99, padding: '4px 12px', fontSize: 13, fontWeight: 600 },
  scorePill: { background: '#1d4ed8', borderRadius: 99, padding: '4px 12px', fontSize: 13, fontWeight: 600, color: '#bfdbfe' },
  timerWrap: { width: '100%', height: 8, background: '#334155', borderRadius: 99, overflow: 'hidden', marginBottom: 6 },
  timerBar: { height: '100%', borderRadius: 99, transition: 'width 1s linear, background 0.3s' },
  question: { fontSize: 18, fontWeight: 600, lineHeight: 1.5, marginBottom: 20, color: '#f8fafc' },
  optionsGrid: { display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10, width: '100%' },
  optBtn: {
    padding: '14px 10px', borderRadius: 10, border: '1px solid #334155',
    color: '#f1f5f9', fontSize: 14, cursor: 'pointer', textAlign: 'left',
    display: 'flex', alignItems: 'flex-start', gap: 8, lineHeight: 1.4, transition: 'background 0.2s',
  },
  optLabel: { background: '#334155', borderRadius: 6, padding: '2px 8px', fontWeight: 700, fontSize: 13, flexShrink: 0 },
  scoreBig: { fontSize: 72, fontWeight: 800, color: '#facc15', lineHeight: 1 },
  lbRow: {
    display: 'flex', alignItems: 'center', gap: 12, padding: '12px 16px',
    borderRadius: 10, marginBottom: 8, width: '100%', boxSizing: 'border-box',
  },
  lbRank: { fontSize: 18, width: 32, textAlign: 'center' },
};
