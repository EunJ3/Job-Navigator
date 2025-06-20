// 📄 파일: src/components/SocialLoginButton.jsx
import React, { useEffect } from "react";
import { useNavigate } from "react-router-dom";

const GOOGLE_CLIENT_ID = import.meta.env.VITE_GOOGLE_CLIENT_ID;
const NAVER_CLIENT_ID = import.meta.env.VITE_NAVER_CLIENT_ID;
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

export default function SocialLoginButton({ setUserInfo }) {
  const navigate = useNavigate();

  useEffect(() => {
    // ✅ Google 초기화
    if (window.google && GOOGLE_CLIENT_ID) {
      window.google.accounts.id.initialize({
        client_id: GOOGLE_CLIENT_ID,
        callback: handleGoogleLogin,
      });
      window.google.accounts.id.renderButton(
        document.getElementById("google-login-btn"),
        { theme: "outline", size: "large", width: "250" }
      );
    }

    // ✅ Naver 초기화
    if (window.naver && NAVER_CLIENT_ID) {
      const naverLogin = new window.naver.LoginWithNaverId({
        clientId: NAVER_CLIENT_ID,
        callbackUrl: `${window.location.origin}/login`,
        isPopup: false,
        loginButton: { color: "green", type: 3, height: "50" },
      });
      naverLogin.init();
    }

    // ✅ URL에서 토큰 추출 → 유저 정보 요청
    const urlParams = new URLSearchParams(window.location.search);
    const token = urlParams.get("token");

    if (token) {
      localStorage.setItem("access_token", token);

      // 👉 유저 정보 조회
      fetch(`${API_BASE_URL}/api/v1/auth/verify-token`, {
        method: "GET",
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
        .then((res) => res.json())
        .then((user) => {
          localStorage.setItem("userInfo", JSON.stringify(user));
          setUserInfo(user);
          console.log("✅ 로그인 성공:", user);
          navigate("/");
        })
        .catch((err) => {
          console.error("❌ 유저 정보 조회 실패:", err);
          navigate("/");
        });
    }
  }, []);

  const handleGoogleLogin = async (response) => {
    const id_token = response.credential;
    try {
      const res = await fetch(`${API_BASE_URL}/api/v1/auth/google-login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id_token_str: id_token }),
      });
      const data = await res.json();
      console.log("✅ 구글 로그인 성공:", data);
      localStorage.setItem("access_token", data.access_token);
      localStorage.setItem("userInfo", JSON.stringify(data));
      setUserInfo(data);
      navigate("/");
    } catch (err) {
      console.error("❌ 구글 로그인 실패:", err);
    }
  };

  const handleKakaoLogin = () => {
    window.location.href = `${API_BASE_URL}/api/v1/auth/kakao-login`;
  };

  return (
    <div className="flex flex-col items-center space-y-4">
      <div id="google-login-btn" />
      <div id="naverIdLogin" />
      <button
        onClick={handleKakaoLogin}
        className="w-[250px] bg-yellow-300 text-black py-2 rounded"
      >
        카카오 로그인
      </button>
    </div>
  );
}
