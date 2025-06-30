-- users 테이블
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  social_provider VARCHAR(50),
  social_id VARCHAR(255),
  email VARCHAR(255),
  name VARCHAR(100),
  profile_image VARCHAR(1000),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT uq_users_social UNIQUE (social_provider, social_id)
);

-- resumes 테이블
CREATE TABLE resumes (
  resume_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(user_id),
  file_path VARCHAR(500),
  extracted_keywords JSONB,
  job_category VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- roadmaps 테이블
CREATE TABLE roadmaps (
  roadmap_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(user_id),
  resume_id INT REFERENCES resumes(resume_id),
  generated_roadmap JSONB,
  similarity_score FLOAT,
  target_job_category VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- jobs 테이블 (기존 jumpit_jobs)
CREATE TABLE jobs (
  job_post_id SERIAL PRIMARY KEY,
  source VARCHAR(50),
  title VARCHAR(500),
  company VARCHAR(255),
  location VARCHAR(100),
  experience VARCHAR(100),
  description TEXT,
  tech_stack JSONB,
  job_category VARCHAR(100),
  url VARCHAR(1000) UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- user_favorite_posts 테이블
CREATE TABLE user_favorite_posts (
  favorite_job_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(user_id),
  job_post_id INT REFERENCES jobs(job_post_id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT uq_favorite UNIQUE (user_id, job_post_id)
);

-- tech_trends 테이블
CREATE TABLE tech_trends (
  trend_id SERIAL PRIMARY KEY,
  keyword VARCHAR(100) NOT NULL,
  job_category VARCHAR(100),
  count INT NOT NULL,
  trend_date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
