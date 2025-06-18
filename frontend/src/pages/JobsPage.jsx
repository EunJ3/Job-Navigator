import { useState, useEffect } from 'react';
import {
  TextField,
  InputAdornment,
  IconButton,
  Button,
  Box,
  Container,
} from '@mui/material';
import SearchIcon from '@mui/icons-material/Search';

import Header from '../components/Header';
import JobCard from '../components/JobCard';
import Pagination from '../components/Pagination';
import JobFilter from '../components/JobFilter';

function Jobs() {
  const [jobs, setJobs] = useState([]);
  const [search, setSearch] = useState('');
  const [input, setInput] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const jobsPerPage = 10;

  const [filters, setFilters] = useState({
    job_type: '',
    location: '',
    experience: '',
  });

  useEffect(() => {
    fetch(`${import.meta.env.VITE_API_BASE_URL}/jobs`)
      .then((res) => res.json())
      .then(setJobs)
      .catch(console.error);
  }, []);

  const handleSearch = () => {
    setSearch(input);
    setCurrentPage(1);
  };

  // 필터
  const filtered = jobs.filter((job) => {
    const matchesSearch =
      job.title.toLowerCase().includes(search.toLowerCase()) ||
      job.company.toLowerCase().includes(search.toLowerCase());

    const matchesType = !filters.job_type || job.job_type === filters.job_type;
    const matchesLocation =
      !filters.location || job.location.includes(filters.location);
    const matchesExperience =
      !filters.experience || job.experience === filters.experience;

    return matchesSearch && matchesType && matchesLocation && matchesExperience;
  });

  const indexOfLast = currentPage * jobsPerPage;
  const indexOfFirst = indexOfLast - jobsPerPage;
  const currentJobs = filtered.slice(indexOfFirst, indexOfLast);

  const totalPages = Math.ceil(filtered.length / jobsPerPage);
  const pageGroup = Math.floor((currentPage - 1) / 5);
  const start = pageGroup * 5 + 1;

  return (
    <>
      <Header />
      <Container maxWidth="md" sx={{ mt: 4 }}>
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

        <JobFilter filters={filters} onChange={setFilters} />

        <Box display="flex" flexWrap="wrap" justifyContent="center" gap={3}>
          {currentJobs.map((job) => (
            <Box key={job.id} sx={{ width: 400 }}>
              <JobCard job={job} />
            </Box>
          ))}
        </Box>

        <Pagination
          currentPage={currentPage}
          totalPages={totalPages}
          onPageChange={setCurrentPage}
        />
      </Container>
    </>
  );
}

export default Jobs;
