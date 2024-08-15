/*
    [DML]
*/

-- 1. 과목유형 테이블(TB_CLASS_TYPE)에 아래와 같은 데이터를 입력하시오.
INSERT INTO tb_class_type VALUES (1, '전공필수');
INSERT INTO tb_class_type VALUES (2, '전공선택');
INSERT INTO tb_class_type VALUES (3, '교양필수');
INSERT INTO tb_class_type VALUES (4, '교양선택');
INSERT INTO tb_class_type VALUES (5, '논문지도');
COMMIT;

-- 2. 춘 기술대학교 학생들의 정보가 포함되어있는 학생일반정보 테이블을 만들고자 한다. 아래 내용을 참고하여 적절한 SQL문을 작성하시오. (서브쿼리를 이용하시오.)
CREATE TABLE tb_학생일반정보
AS SELECT student_no, student_name, student_address FROM tb_student;

-- 3. 국어국문학과 학생들의 정보만이 포함되어있는 학과 정보 테이블을 만들고자 한다.
-- 아래 내용을 참고하여 적절한 SQL문을 작성하시오. (힌트: 방법은 다양함, 소신껏 작성하시오.)
CREATE TABLE tb_국어국문학과
AS (
    SELECT student_no, student_name, SUBSTR(student_ssn, 1, 4) AS "출생년도", professor_name, department_name
    FROM tb_student
    LEFT JOIN tb_professor ON (coach_professor_no = professor_no)
    JOIN tb_department ON (tb_student.department_no = tb_department.department_no)
    WHERE department_name = '국어국문학과'
);

-- 4. 현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용할 SQL문을 작성하시오.
-- (단, 반올림을 사용하여 소수점 자릿수는 생기지 않도록 한다.)
UPDATE tb_department
SET capacity = (capacity * 1.1)
WHERE open_yn = 'Y';

-- 5. 학번 A413042인 박건우 학생의 주소가 "서울시 종로구 숭인동 181-21"로 변경되었다고 한다. 주소지를 정정하기 위해 사용할 SQL 문을 작성하시오.
UPDATE tb_student SET student_address = '서울시 종로구 숭인동 181-21' WHERE student_no = 'A413042';

-- 6.  주민등록번호 보호법에 따라 학생정보 테이블에서 주민번호 뒷자리를 저장하지 않기로 결정하였다. 이 내용을 반영할 적절한 SQL 문장을 작성하시오.
UPDATE tb_student
SET student_ssn = SUBSTR(student_ssn, 1, 6);

-- 7. 의학과 김명훈 학생은 2005년 1학기에 자신이 수강한 '피부생리학' 점수가 잘못되었다는 것을 발견하고는 정정을 요청하였다.
-- 담당 교수의 확인 받은 결과 해당 과목의 학점을 3.5로 변경키로 결정되었다. 적절한 SQL 문을 작성하시오.
UPDATE tb_grade SET point = 3.5
WHERE student_no = (
                                            SELECT student_no
                                            FROM tb_student
                                            JOIN tb_department USING (department_no)
                                            WHERE student_name = '김명훈' AND department_name = '의학과'
)
 AND class_no = (
                                    SELECT class_no
                                    FROM tb_class
                                    WHERE class_name = '피부생리학'
);

-- 8. 성적 테이블(TB_GRADE)에서 휴학생들의 성적 항목을 제거하시오.
DELETE FROM tb_grade
WHERE student_no IN (
                                            SELECT student_no
                                            FROM tb_student
                                            WHERE absence_yn = 'Y'
);

ROLLBACK;