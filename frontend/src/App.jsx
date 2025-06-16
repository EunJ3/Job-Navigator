import { Routes, Route } from 'react-router-dom';

import Jobs from './Jobs';
import MainPage from './components/MainPage';
import Login from './components/Login';

function App() {
  return (
    <Routes>
      <Route path="/" element={<MainPage />} />
      <Route path="/jobs" element={<Jobs />} />
      <Route path="/login" element={<Login />} />
    </Routes>
  );
}

export default App;