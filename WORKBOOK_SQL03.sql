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

-- 11. 학번이 A313047인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기 위한 학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 이때 사용할 SQL 문을 작성하시오.
-- 단, 출력헤더는 "학과이름", "학생이름", "지도교수이름"으로 출력되도록 한다.
SELECT department_name AS "학과이름", student_name AS "학생이름", professor_name AS "지도교수이름"
FROM tb_student
JOIN tb_department USING (department_no)
JOIN tb_professor ON (coach_professor_no = professor_no)
WHERE student_no = 'A313047';

-- 12. 2007년도에 '인간관계론' 과목을 수강한 학생을 찾아 학생 이름과 수강하기를 표시하는 SQL 문장을 작성하시오.
SELECT student_name, term_no FROM tb_grade
JOIN tb_student USING (student_no)
JOIN tb_class USING (class_no)
WHERE SUBSTR(term_no, 1, 4) = '2007'
            AND class_name = '인간관계론';
            
-- 13. 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아 그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
SELECT class_name, department_name FROM tb_department
LEFT JOIN tb_professor USING (department_no)
JOIN tb_class USING (department_no)
WHERE category = '예체능'
            AND professor_no IS NULL;
            
-- 14. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다.
-- 학생이름과 지도교수 이름을 찾고 만일 지도 교수가 없는 학생일 경우 "지도교수 미지정"으로 표시하도록 하는 SQL 문을 작성하시오.
-- 단, 출력헤더는 "학생이름", "지도교수"로 표시하며 고학번 학생이 먼저 표시되도록 한다.
SELECT student_name AS "학생 이름", NVL(professor_name, '지도교수 미지정') AS "지도교수"
FROM tb_student
JOIN tb_department USING (department_no)
LEFT JOIN tb_professor ON (coach_professor_no = professor_no)
WHERE department_name = '서반아어학과'
ORDER BY student_no;

-- 15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과이름, 평점을 출력하는 SQL 문을 작성하시오.
SELECT 학번, student_name AS "이름", department_name AS "학과이름", 평점
FROM (
    SELECT student_no AS "학번", ROUNd(AVG(point), 10) AS "평점"
    FROM tb_grade
    GROUP BY student_no
    HAVING AVG(point) >= 4
)
JOIN tb_student ON (학번 = tb_student.student_no)
JOIN tb_department USING (department_no)
WHERE absence_yn = 'N'
ORDER BY student_no;

-- 16. 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.
SELECT class_no, class_name, AVG
FROM (
    SELECT class_no, ROUND(AVG(point), 10) AS "AVG"
    FROM tb_grade
    GROUP BY class_no
)
JOIN tb_class USING (class_no)
JOIN tb_department USING (department_no)
WHERE department_name = '환경조경학과'
            AND class_type LIKE '전공%'
ORDER BY class_no;

-- 17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL 문을 작성하시오.
SELECT student_name, student_address
FROM tb_student
JOIN tb_department USING (department_no)
WHERE department_no = (SELECT department_no FROM tb_student WHERE student_name = '최경희');

-- 18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 문을 작성하시오.
SELECT *
FROM (
    SELECT student_no, student_name
    FROM tb_student
    JOIN tb_grade USING (student_no)
    JOIN tb_department USING (department_no)
    WHERE department_name = '국어국문학과'
    GROUP BY student_no, student_name
    ORDER BY AVG(point) DESC
) WHERE ROWNUM <= 1;

-- 19. 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 학과 별 전공과목 평점을 파악하기 위한 적절한 SQL 문을 찾아내시오.
-- 단, 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고, 평점은 소수점 한 자리까지만 반올림하여 표시되도록 한다.
SELECT department_name AS "계열 학과명", ROUND(AVG(point), 1) AS "전공평점"
FROM tb_grade
JOIN tb_class USING (class_no)
JOIN tb_department USING (department_no)
GROUP BY department_name;