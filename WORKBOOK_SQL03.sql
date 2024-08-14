/*
	[Additinal SELECT - Option]
*/

-- 1. 학생이름과 주소지를 표시하시오.
-- 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 표시하도록 한다.
SELECT student_name AS "학생 이름", student_address AS "주소지" FROM tb_student
ORDER BY student_name ASC;

-- 2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
SELECT student_name, student_ssn FROM tb_student
WHERE absence_yn = 'Y'
ORDER BY student_ssn DESC;

-- 3. 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오.
-- 단, 출력 헤더에는 "학생이름", "학번", "거주지 주소"가 출력되도록 한다.
SELECT student_name AS "학생이름", student_no AS "학번", student_address AS "거주지 주소" FROM tb_student
WHERE	student_address LIKE '강원도%'
			OR student_address LIKE '경기도%'
			AND SUBSTR(student_no, 1, 1) != 'A'
ORDER BY student_address DESC;

-- 4. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성하시오.
-- (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 내도록하자)
SELECT professor_name, professor_ssn FROM tb_professor
WHERE department_no = '005'
ORDER BY SYSDATE - TO_DATE(SUBSTR(professor_ssn, 1, 6)) DESC;

-- 5. 2004년 2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다.
-- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해보시오.
SELECT student_no, point FROM tb_grade
WHERE	class_no = 'C3118100'
			AND term_no = '200402'
ORDER BY point DESC, student_no;

-- 6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL문을 작성하시오.
SELECT student_no, student_name, department_name
FROM tb_student
JOIN tb_department USING (department_no)
ORDER BY student_name ASC;

-- 7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오.
SELECT class_name, department_name FROM tb_class
JOIN tb_department USING (department_no);

-- 8. 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
SELECT class_name, professor_name FROM tb_class
JOIN tb_class_professor USING (class_no)
JOIN tb_professor USING (professor_no)
ORDER BY professor_name;

-- 9. 8번의 결과 중 '인문사회' 계열에 속한 과목의 교수 이름을 찾으려고 한다. 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.
SELECT class_name, professor_name FROM tb_class
JOIN tb_class_professor USING (class_no)
JOIN tb_professor USING (professor_no)
JOIN tb_department ON (tb_class.department_no = tb_department.department_no)
WHERE category = '인문사회'
ORDER BY professor_name;

-- 10. '음악학과' 학생들의 평점을 구하려고 한다.
-- 음학학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는 SQL 문장을 작성하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
SELECT student_no AS "학번", ROUND(AVG(point), 1) AS "전체 평점"
FROM tb_grade
JOIN tb_student USING (student_no)
JOIN tb_department USING (department_no)
WHERE department_name = '음악학과'
GROUP BY student_no
ORDER BY student_no;