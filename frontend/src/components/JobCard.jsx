import { useState } from 'react';
import {
  Card,
  CardContent,
  Typography,
  Collapse,
  Divider,
  Chip,
  Stack,
  IconButton,
  Box,
} from '@mui/material';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';

function JobCard({ job }) {
  const [expanded, setExpanded] = useState(false);

  return (
    <Card
      sx={{
        borderRadius: '16px',
        boxShadow: '0 4px 12px rgba(0, 0, 0, 0.1)',
        p: 2,
        mb: 2,
        position: 'relative',
        transition: '0.2s',
      }}
    >
      {/* ✅ 제목 + 아이콘 정렬박스 */}
      <Box
        display="flex"
        justifyContent="space-between"
        alignItems="center"
        sx={{ flexWrap: 'nowrap' }}
      >
        {/* ✅ 제목, 회사, 마감일 */}
        <CardContent
          sx={{
            flex: 1,
            paddingRight: 1,
            minWidth: 0,
            cursor: 'pointer',
          }}
          onClick={() => setExpanded(!expanded)}
        >
          <Typography
            variant="h6"
            fontWeight="bold"
            noWrap={!expanded}
            title={job.title}
            sx={{
              whiteSpace: expanded ? 'normal' : 'nowrap',
              overflow: 'hidden',
              textOverflow: 'ellipsis',
            }}
          >
            {job.title}
          </Typography>

          <Typography variant="subtitle2" color="text.secondary">
            {job.company} · {job.location}
          </Typography>
          <Typography variant="body2" mt={1} color="text.secondary">
            📅 마감: {job.description || '미정'}
          </Typography>
        </CardContent>

        {/* ✅ 토글 화살표 */}
        <IconButton
          onClick={() => setExpanded(!expanded)}
          sx={{
            color: 'rgba(0, 0, 0, 0.4)',
            transform: expanded ? 'rotate(180deg)' : 'rotate(0deg)',
            transition: '0.3s',
            flexShrink: 0,
          }}
        >
          <ExpandMoreIcon />
        </IconButton>
      </Box>

      {/* ✅ 상세 내용 확장 영역 */}
      <Collapse in={expanded}>
        <Divider sx={{ my: 1 }} />
        <CardContent>
          <Typography variant="body2" gutterBottom>
            <strong>직무:</strong> {job.job_type || '정보 없음'}
          </Typography>
          <Typography variant="body2" gutterBottom>
            <strong>경력:</strong> {job.experience || '무관'}
          </Typography>

          {Array.isArray(job.tech_stack) && job.tech_stack.length > 0 && (
            <>
              <Typography variant="body2" gutterBottom>
                <strong>기술 스택:</strong>
              </Typography>
              <Stack direction="row" spacing={1} flexWrap="wrap">
                {job.tech_stack.map((tech, idx) => (
                  <Chip
                    key={idx}
                    label={tech.trim()}
                    variant="outlined"
                    size="small"
                  />
                ))}
              </Stack>
            </>
          )}
        </CardContent>
      </Collapse>
    </Card>
  );
}

export default JobCard;
