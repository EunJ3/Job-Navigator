// src/components/Header.jsx
import { Link } from 'react-router-dom';
import { Box, Divider, Stack, Button } from '@mui/material';
import logoImg from '../assets/logo.png';
import './Header.css';

export default function Header() {
  return (
    <>
      <header className="header">
        <Link to="/">
          <img src={logoImg} alt="로고" className="logo" />
        </Link>
        <div className="auth-links">
          <Link to="/login">로그인</Link>
        </div>
      </header>

      <Box>
        <Divider />
        <Stack direction="row" spacing={4} justifyContent="center" sx={{ my: 1 }}>
          {[
            { label: '트렌드 분석', link: '/trend' },
            { label: '채용 공고', link: '/jobs' },
            { label: '이력서 분석', link: '/resume' },
          ].map(({ label, link }) => (
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
