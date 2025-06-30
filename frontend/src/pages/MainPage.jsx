// 📄 파일명: src/pages/MainPage.jsx

import React from 'react';
import { Link } from 'react-router-dom';
import { Button } from '@mui/material';

import './MainPage.css';

function MainPage() {
  return (
    <div className="main-container">
      {/* 이미지 섹션 */}
      <section className="image-section">
        <div className="image-container">
          <img src="/main_person1.png" alt="일러스트1" />
          <img src="/main_person2.png" alt="일러스트2" />
          <img src="/main_person3.png" alt="일러스트3" />
          <img src="/main_person4.png" alt="일러스트4" />
        </div>
      </section>

      {/* 메시지 섹션 */}
      <section className="message-section">
        <h2>개발자들 요즘머함?</h2>
        <p>
          자신에게 필요한 기술스택을 추천받고 싶으면{' '}
          <br className="mobile-break"></br>계정을 만들거나 로그인하세요.
        </p>
        <Button
          className="shake-button"
          component={Link}
          to="/resume"
          variant="contained"
          sx={{
            mt: 4,
            backgroundColor: '#3a82f7',
            color: '#fff',
            fontWeight: 'bold',
            fontSize: '1rem',
            px: 4,
            py: 1.5,
            borderRadius: '8px',
            '&:hover': {
              backgroundColor: '#5a6fd3',
            },
          }}
        >
          취업 가능한지 알려드림 →
        </Button>
      </section>
    </div>
  );
}

export default MainPage;
