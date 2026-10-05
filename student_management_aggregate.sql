-- ====================================================================
-- BÀI THỰC HÀNH: SỬ DỤNG CÁC HÀM THÔNG DỤNG & GROUP BY TRONG SQL
-- CSDL: QuanLySinhVien
-- ====================================================================

-- Bước 1: Chọn cơ sở dữ liệu làm việc
USE QuanLySinhVien;

-- --------------------------------------------------------------------
-- Bước 2: Hiển thị số lượng sinh viên ở từng nơi
-- --------------------------------------------------------------------
SELECT 
    Address, 
    COUNT(StudentId) AS 'Số lượng học viên'
FROM Student
GROUP BY Address;

-- --------------------------------------------------------------------
-- Bước 3: Tính điểm trung bình các môn học của mỗi học viên
-- --------------------------------------------------------------------
SELECT 
    S.StudentId, 
    S.StudentName, 
    AVG(M.Mark) AS 'DiemTrungBinh'
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName;

-- --------------------------------------------------------------------
-- Bước 4: Hiển thị những bạn học viên có điểm trung bình lớn hơn 15
-- (Sử dụng HAVING để lọc sau khi đã gom nhóm)
-- --------------------------------------------------------------------
SELECT 
    S.StudentId, 
    S.StudentName, 
    AVG(M.Mark) AS 'DiemTrungBinh'
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(M.Mark) > 15;

-- --------------------------------------------------------------------
-- Bước 5: Hiển thị thông tin các học viên có điểm trung bình lớn nhất
-- (Sử dụng HAVING kết hợp toán tử >= ALL với Subquery)
-- --------------------------------------------------------------------
SELECT 
    S.StudentId, 
    S.StudentName, 
    AVG(M.Mark) AS 'DiemTrungBinh'
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(M.Mark) >= ALL (
    SELECT AVG(Mark) 
    FROM Mark 
    GROUP BY StudentId
);