import React from 'react';
import { Link } from 'react-router-dom';
import { Box, Divider, Stack, Button } from '@mui/material';

import './MainPage.css';
import Header from '../components/Header';

{/*이미지*/}
import mainImage1 from '../assets/main_person1.png';
import mainImage2 from '../assets/main_person2.png';
import mainImage3 from '../assets/main_person3.png';
import mainImage4 from '../assets/main_person4.png';

function MainPage() {
  return (
    <div className="main-container">
      
      <Header />

      {/* 이미지 섹션 */}
      <section className="image-section">
        <div className="image-container">
          <img src={mainImage1} alt="일러스트1" />
          <img src={mainImage2} alt="일러스트2" />
          <img src={mainImage3} alt="일러스트3" />
          <img src={mainImage4} alt="일러스트4" />
        </div>
      </section>

      {/* 메시지 섹션 */}
      <section className="message-section">
        <h2>개발자들 요즘머함?</h2>
        <p>
          자신에게 필요한 기술스택을 추천받고 싶으면 계정을 만들거나
          로그인하세요.
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
