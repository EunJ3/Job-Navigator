// 📄 파일: src/pages/LoginPage.jsx
import React from "react";
import SocialLoginButton from "../components/SocialLoginButton";

export default function LoginPage({ setUserInfo }) {
  return (
    <div className="flex flex-col items-center justify-center h-screen bg-gray-50 px-4">
      <h1 className="text-2xl font-bold mb-6">소셜 로그인</h1>
      <div className="w-full max-w-xs">
        {/* ✅ 로그인 성공 시 상태 업데이트 가능하도록 prop 전달 */}
        <SocialLoginButton setUserInfo={setUserInfo} />
      </div>
    </div>
  );
}
