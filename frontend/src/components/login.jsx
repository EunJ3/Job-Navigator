import React, { useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import './Login.css';

export default function Login() {
  const location = useLocation();
  const query = new URLSearchParams(location.search);
  const error = query.get('error');

  // 페이지 진입 시 body에 클래스 부여 → 배경색 구분
  useEffect(() => {
    document.body.classList.add('login-page');
    return () => {
      document.body.classList.remove('login-page');
    };
  }, []);

  const login = () => {
    // 일반 로그인 처리 로직
  };

  const naverLogin = () => {
    window.location.href = 'http://localhost:8081/oauth2/authorization/naver';
  };

  const googleLogin = () => {
    window.location.href = 'http://localhost:8081/oauth2/authorization/google';
  };

  const kakaoLogin = () => {
    window.location.href = 'http://localhost:8081/oauth2/authorization/kakao';
  };

  return (
    <div className="root">
      <div className="login-container">
        <h1>
          <img src="/dd.PNG" alt="요즘마함 로고" style={{ height: '50px' }} />
        </h1>

        <label htmlFor="id">아이디</label>
        <input type="text" id="id" placeholder="ID" required />
        <label htmlFor="password">비밀번호</label>
        <input type="password" id="password" placeholder="Password" required />
        <button className="login-btn" onClick={login}>
          로그인
        </button>

        <div className="btn-group2">
          <div style={{ display: 'flex', justifyContent: 'space-between' }}>
            <button className="sign">회원가입</button>
            <button className="search">아이디/비밀번호 찾기</button>
          </div>
          <div>
            <label>-----------------간편 로그인----------------</label>
            <div className="total">
              <button className="naver" onClick={naverLogin}>
                <img src="/naver.PNG" alt="naver" />
              </button>
              <button className="google" onClick={googleLogin}>
                <img src="https://developers.google.com/identity/images/g-logo.png" alt="google" />
              </button>
              <button className="talk" onClick={kakaoLogin}>
                <img src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png" alt="kakao" />
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
