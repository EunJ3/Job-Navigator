import { Stack, IconButton, Button } from '@mui/material';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import ChevronRightIcon from '@mui/icons-material/ChevronRight';

function Pagination({ currentPage, totalPages, onPageChange }) {
  const pageGroup = Math.floor((currentPage - 1) / 5);
  const startPage = pageGroup * 5 + 1;
  const endPage = Math.min(startPage + 4, totalPages);

  const visiblePages = Array.from(
    { length: endPage - startPage + 1 },
    (_, i) => startPage + i
  );

  return (
    <Stack direction="row" spacing={1} justifyContent="center" mt={4} mb={4}>
      {startPage > 1 && (
        <IconButton onClick={() => onPageChange(startPage - 1)} color="primary">
          <ChevronLeftIcon />
        </IconButton>
      )}
      {visiblePages.map((page) => (
        <Button
          key={page}
          variant={page === currentPage ? 'contained' : 'outlined'}
          onClick={() => onPageChange(page)}
          sx={{ minWidth: '40px' }}
        >
          {page}
        </Button>
      ))}
      {endPage < totalPages && (
        <IconButton onClick={() => onPageChange(endPage + 1)} color="primary">
          <ChevronRightIcon />
        </IconButton>
      )}
    </Stack>
  );
}

export default Pagination;
