// 📄 파일명: src/components/Header.jsx
import { Link, useNavigate } from 'react-router-dom';
import {
  Box,
  Divider,
  Stack,
  Button,
  Avatar,
  IconButton,
  Menu,
  MenuItem,
} from '@mui/material';
import { useState } from 'react';
import logoImg from '../assets/logo.png';
import './Header.css';

export default function Header({ userInfo, setUserInfo }) {
  const navigate = useNavigate();
  const [anchorEl, setAnchorEl] = useState(null);

  const handleLogout = () => {
    localStorage.removeItem("userInfo");
    setUserInfo(null);
    navigate('/');
  };

  const handleMenuOpen = (event) => setAnchorEl(event.currentTarget);
  const handleMenuClose = () => setAnchorEl(null);

  return (
    <>
      <header className="header">
        <Link to="/">
          <img src={logoImg} alt="로고" className="logo" />
        </Link>

        <div className="auth-links">
          {userInfo ? (
            <>
              <IconButton onClick={handleMenuOpen}>
                <Avatar
                  src={userInfo.profile_image}
                  alt="프로필"
                  sx={{ width: 36, height: 36 }}
                />
              </IconButton>
              <Menu
                anchorEl={anchorEl}
                open={Boolean(anchorEl)}
                onClose={handleMenuClose}
              >
                <MenuItem onClick={() => { handleMenuClose(); navigate('/mypage'); }}>
                  마이페이지
                </MenuItem>
                <MenuItem onClick={() => { handleMenuClose(); handleLogout(); }}>
                  로그아웃
                </MenuItem>
              </Menu>
            </>
          ) : (
            <Link to="/login">로그인</Link>
          )}
        </div>
      </header>

      <Box>
        <Divider />
        <Stack direction="row" spacing={4} justifyContent="center" sx={{ my: 1 }}>
          {[{ label: '트렌드 분석', link: '/trend' },
            { label: '채용 공고', link: '/jobs' },
            { label: '이력서 분석', link: '/resume' }].map(({ label, link }) => (
            <Button
              key={link}
              component={Link}
              to={link}
              variant="text"
              sx={{
                backgroundColor: 'transparent',
                color: '#333333',
                fontSize: 15,
                fontWeight: 600,
                '&:hover': { color: '#1976d2' },
              }}
            >
              {label}
            </Button>
          ))}
        </Stack>
        <Divider />
      </Box>
    </>
  );
}
