import { useState, useEffect } from 'react';
import {
  TextField,
  InputAdornment,
  Button,
  Box,
  Container,
} from '@mui/material';
import SearchIcon from '@mui/icons-material/Search';

import JobCard from '../components/JobCard';
import Pagination from '../components/Pagination';
import JobFilter from '../components/JobFilter';

function Jobs() {
  const [jobs, setJobs] = useState([]);
  const [totalCount, setTotalCount] = useState(0);
  const [search, setSearch] = useState('');
  const [input, setInput] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const jobsPerPage = 10;

  const [filters, setFilters] = useState({
    job_type: '',
    location: '',
    experience: '',
  });

  // ✅ 서버에 페이지 + 필터 + 검색 쿼리 요청
  useEffect(() => {
    const params = new URLSearchParams({
      page: currentPage,
      size: jobsPerPage,
    });

    if (filters.job_type) params.append('job_type', filters.job_type);
    if (filters.location) params.append('location', filters.location);
    if (search) params.append('tech_stack', search); // 또는 'keyword', 'query' 등 변경 가능

    fetch(`${import.meta.env.VITE_API_BASE_URL}/api/v1/jobs?${params.toString()}`)
      .then((res) => res.json())
      .then((data) => {
        setJobs(data.items);
        setTotalCount(data.total_count);
      })
      .catch(console.error);
  }, [currentPage, filters, search]);

  const handleSearch = () => {
    setSearch(input);
    setCurrentPage(1);
  };

  const totalPages = Math.ceil(totalCount / jobsPerPage);

  return (
    <Container maxWidth="md" sx={{ mt: 4 }}>
      {/* 🔍 검색 입력 */}
      <Box
        display="flex"
        alignItems="center"
        justifyContent="center"
        gap={1}
        sx={{ mb: 3 }}
      >
        <TextField
          sx={{
            width: '85%',
            boxShadow: '0 4px 4px rgba(0, 0, 0, 0.1)',
            '& .MuiOutlinedInput-root': {
              '& fieldset': {
                borderColor: '#888',
              },
              '& .MuiInputBase-input::placeholder': {
                color: '#444',
                opacity: 1,
              },
            },
          }}
          fullWidth
          variant="outlined"
          placeholder="채용공고 제목 및 회사를 입력하세요..."
          value={input}
          onChange={(e) => setInput(e.target.value)}
          InputProps={{
            startAdornment: (
              <InputAdornment position="start">
                <SearchIcon />
              </InputAdornment>
            ),
          }}
        />
        <Button
          variant="contained"
          onClick={handleSearch}
          sx={{ height: '45px', width: '70px' }}
        >
          검색
        </Button>
      </Box>

      {/* 🎯 필터 선택 */}
      <JobFilter filters={filters} onChange={setFilters} />

      {/* 📝 채용공고 카드 */}
      <Box display="flex" flexWrap="wrap" justifyContent="center" gap={3}>
        {jobs.map((job) => (
          <Box key={job.id} sx={{ width: 400 }}>
            <JobCard job={job} />
          </Box>
        ))}
      </Box>

      {/* ⏩ 페이지네이션 */}
      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={setCurrentPage}
      />
    </Container>
  );
}

export default Jobs;
