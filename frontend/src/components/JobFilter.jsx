import { useState } from 'react';
import {
  Box,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Typography,
  Stack,
} from '@mui/material';
import { useMediaQuery, useTheme } from '@mui/material';

const JobFilter = ({ filters, onChange }) => {
  const theme = useTheme();
  const isMobile = useMediaQuery(theme.breakpoints.down('sm'));

  const [localFilters, setLocalFilters] = useState(filters);

  const handleChange = (key, value) => {
    const updated = { ...localFilters, [key]: value };
    setLocalFilters(updated);
    onChange(updated);
  };

  return (
    <Box sx={{ mb: 4, px: 2, textAlign: 'left' }}>
      <Stack
        direction="row"
        spacing={2}
        sx={{ flexWrap: 'wrap', justifyContent: 'flex-start', padding: 0 }}
      >
        {/* 직무유형 */}
        <FormControl sx={{ flex: 1, minWidth: 0, maxWidth: 120 }} size="small">
          <InputLabel>직무유형</InputLabel>
          <Select
            value={localFilters.job_type || ''}
            onChange={(e) => handleChange('job_type', e.target.value)}
            label="직무유형"
          >
            <MenuItem value="">전체</MenuItem>
            <MenuItem value="frontend">프론트엔드</MenuItem>
            <MenuItem value="backend">백엔드</MenuItem>
            <MenuItem value="mobile">모바일</MenuItem>
            <MenuItem value="ai">AI</MenuItem>
            <MenuItem value="ml">ML</MenuItem>
            <MenuItem value="cloud">클라우드</MenuItem>
            <MenuItem value="language">언어</MenuItem>
            <MenuItem value="database">데이터베이스</MenuItem>
            <MenuItem value="design">디자인</MenuItem>
          </Select>
        </FormControl>

        {/* 지역 */}
        <FormControl sx={{ flex: 1, minWidth: 0, maxWidth: 120 }} size="small">
          <InputLabel>지역</InputLabel>
          <Select
            value={localFilters.location || ''}
            onChange={(e) => handleChange('location', e.target.value)}
            label="지역"
            sx={{}}
          >
            <MenuItem value="">전체</MenuItem>
            {[
              '서울',
              '경기',
              '인천',
              '대전',
              '부산',
              '광주',
              '대구',
              '울산',
              '세종',
              '강원',
              '충북',
              '충남',
              '전북',
              '전남',
              '경북',
              '경남',
              '제주',
            ].map((region) => (
              <MenuItem key={region} value={region}>
                {region}
              </MenuItem>
            ))}
          </Select>
        </FormControl>

        {/* 경력 */}
        <FormControl sx={{ flex: 1, minWidth: 0, maxWidth: 120 }} size="small">
          <InputLabel>경력</InputLabel>
          <Select
            value={localFilters.experience || ''}
            onChange={(e) => handleChange('experience', e.target.value)}
            label="경력"
            sx={{}}
          >
            <MenuItem value="">전체</MenuItem>
            <MenuItem value="무관">무관</MenuItem>
            <MenuItem value="신입">신입</MenuItem>
            <MenuItem value="1~3년">1~3년</MenuItem>
            <MenuItem value="3~5년">3~5년</MenuItem>
            <MenuItem value="5년 이상">5년 이상</MenuItem>
          </Select>
        </FormControl>
      </Stack>
    </Box>
  );
};

export default JobFilter;
