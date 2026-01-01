-- 🌍 Language table
CREATE TABLE Language (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

-- 📚 Proficiency level table
CREATE TABLE ProficiencyLevel (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

-- 🎯 Learning goals
CREATE TABLE LearningGoal (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- 🎨 Topics
CREATE TABLE Topic (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- 🧑‍🎓 User table (đã thêm topic_id, bỏ UserTopic)
CREATE TABLE User (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  language_id INT NOT NULL,
  proficiency_level_id INT NOT NULL,
  topic_id INT NOT NULL,  -- 🆕 mỗi người 1 chủ đề
  FOREIGN KEY (language_id) REFERENCES Language(id),
  FOREIGN KEY (proficiency_level_id) REFERENCES ProficiencyLevel(id),
  FOREIGN KEY (topic_id) REFERENCES Topic(id)
);

-- 🔁 User - LearningGoal (vẫn giữ nguyên vì là n-n)
CREATE TABLE UserLearningGoal (
  user_id INT NOT NULL,
  learning_goal_id INT NOT NULL,
  PRIMARY KEY (user_id, learning_goal_id),
  FOREIGN KEY (user_id) REFERENCES User(id),
  FOREIGN KEY (learning_goal_id) REFERENCES LearningGoal(id)
);

-- 🌍 Language
INSERT INTO Language (name) VALUES 
('English'), 
('Japanese'), 
('Spanish');

-- 📚 ProficiencyLevel
INSERT INTO ProficiencyLevel (name) VALUES 
('Beginner'), 
('Intermediate'), 
('Advanced');

-- 🎯 LearningGoal
INSERT INTO LearningGoal (name) VALUES 
('Luyện giao tiếp mỗi ngày'), 
('Chuẩn bị phỏng vấn'), 
('Luyện phát âm');

-- 🎨 Topic
INSERT INTO Topic (name) VALUES 
('Du lịch'), 
('Phim ảnh'), 
('Công nghệ'),
('Sách'),
('Giải trí'),
('Lịch sử'),
('Văn hóa');

-- 🧑‍🎓 User (giả định id các bảng trên là 1,2,3 theo thứ tự thêm)
INSERT INTO User (name, email, language_id, proficiency_level_id, topic_id) VALUES 
('Alice', 'alice@example.com', 1, 2, 3),   -- English, Intermediate, Công nghệ
('Bob', 'bob@example.com', 2, 1, 1),       -- Japanese, Beginner, Du lịch
('Charlie', 'charlie@example.com', 3, 3, 2); -- Spanish, Advanced, Phim ảnh

-- 🔁 UserLearningGoal
INSERT INTO UserLearningGoal (user_id, learning_goal_id) VALUES 
(1, 1),  -- Alice - Luyện giao tiếp mỗi ngày
(1, 2),  -- Alice - Chuẩn bị phỏng vấn
(2, 1),  -- Bob - Luyện giao tiếp mỗi ngày
(3, 3);  -- Charlie - Luyện phát âm
