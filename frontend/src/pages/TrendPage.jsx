import { useState, useEffect } from 'react';
import { backendTrendMock } from '../mock/trendsBackend'; // 데이터 불러오기

function TrendPage() {
  const [trendData, setTrendData] = useState(null);

  useEffect(() => {
    setTrendData(backendTrendMock);
  }, []);

  if (!trendData) {
    return <div>Loading...</div>;
  }

  return (
    <div>
      <main style={{ padding: '2rem' }}>
        <h2>트렌드 분석 페이지</h2>
        <div>
          <h3>{trendData.role} 트렌드</h3>
          <p>{trendData.summary}</p>
          <ul>
            {trendData.technologies.map((tech, index) => (
              <li key={index}>
                <strong>{tech.name}</strong> - {tech.percentage}% ({tech.count}개 채용공고)
              </li>
            ))}
          </ul>
        </div>
      </main>
    </div>
  );
}

export default TrendPage;
