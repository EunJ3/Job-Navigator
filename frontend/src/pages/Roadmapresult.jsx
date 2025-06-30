import { useLocation } from "react-router-dom";

export default function RoadmapResult() {
  const location = useLocation();
  const result = location.state;

  return (
    <div>
      <h2>분석 결과</h2>
      <pre>{JSON.stringify(result, null, 2)}</pre>
    </div>
  );
}
