import { Routes, Route } from 'react-router-dom';

import MainPage from './pages/MainPage';
import Login from './components/Login';
import Jobs from './pages/JobsPage';
import TrendPage from './pages/TrendPage';
import ResumeAnalysisPage from './pages/ResumeAnalysisPage';

import './global.css';

function App() {
  return (
    <Routes>
      <Route path="/" element={<MainPage />} />
      <Route path="/login" element={<Login />} />
      <Route path="/jobs" element={<Jobs />} />
      <Route path="/trend" element={<TrendPage />} />
      <Route path="/resume" element={<ResumeAnalysisPage />} />
    </Routes>
  );
}

export default App;