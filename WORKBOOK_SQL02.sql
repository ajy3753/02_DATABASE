/*
	[Additional SELECT - 함수]
*/

-- 1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 순으로 표시하는 SQL 문장을 작성하시오.
-- (단, 헤더는 "학번", "이름", "입혁년도"가 표시되도록 한다.)
SELECT student_no AS "학번", student_name AS "이름", TO_CHAR(entrance_date, 'YYYY-MM-DD') AS "입학 년도" FROM tb_student
ORDER BY entrance_date ASC;

-- 2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다. 그 교수의 이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해보자.
-- (* 이때 올바르게 작성한 SQL 문장의 결과 값이 에상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)
SELECT professor_name, professor_ssn FROM tb_professor
WHERE LENGTH(professor_name) != 3;

-- 3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오.
-- 단, 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오.
-- (단, 교수 중 2000년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 한다. 나이는 '만'으로 계산한다.)
SELECT	professor_name AS "교수이름",
			EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(professor_ssn, 1, 6), 'RR/MM/DD')) AS "나이"
FROM tb_professor
WHERE SUBSTR(professor_ssn, 8, 1) IN ('1', '3')
ORDER BY 나이 ASC;

-- 4 . 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 출력 헤더는 "이름"이 찍히도록 한다. (성이 2자인 교수는 없다고 가정하시오)
SELECT SUBSTR(professor_name, 2) AS "이름" FROM tb_professor;

-- 5. 춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼 것인가?
-- 이때, 19살에 입학하면 재수를 하지 않은 것으로 간주한다.
SELECT student_no, student_name FROM tb_student
WHERE EXTRACT(YEAR FROM entrance_date) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(student_ssn, 1, 6))) > 18;

-- 6. 2020년 크리스마스는 무슨 요일인가?
SELECT TO_CHAR(TO_DATE(20201225), 'DAY') AS "2020년 크리스마스" FROM dual;

-- 7. TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD')은 각각 몇 년 몇 월 며칠을 의미할까?
-- 또 TO_DATE('99/10/11', 'RR/MM/DD'), TO_DATE('49/10/11', 'RR/MM/DD')은 각각 몇 년 몇 월 며칠을 의미할까?
SELECT	TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'), 'YYYY"년" MM"월" DD"일"'),
			TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'), 'YYYY"년" MM"월" DD"일"')
FROM dual;

SELECT	TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'), 'YYYY"년" MM"월" DD"일"'),
			TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'), 'YYYY"년" MM"월" DD"일"')
FROM dual;

-- 8. 춘 기술대학교의 2000년도 이후 입학자들은 학번이 A로 시작하게 되어있다.
-- 2000년도 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
SELECT student_no, student_name FROM tb_student
WHERE SUBSTR(student_no, 1, 1) != 'A';

-- 9. 학번이 A517178인 한아름 학생의 학점 총 평점을 구하는 SQL문을 작성하시오.
-- 단, 이때 출력화면의 헤더는 "평점"이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
SELECT ROUND(AVG(point), 1) AS "평점"
FROM  tb_grade
WHERE student_no = 'A517178';

-- 10. 학과별 학생 수를 구하여 "학과번호", "학생수(명)"의 형태로 만들어 결과값이 출력되도록 하시오.
SELECT department_no AS "학과번호", COUNT(department_no) AS "학생수(명)"
FROM tb_department
JOIN tb_student USING (department_no)
GROUP BY department_no
ORDER BY department_no;

-- 11. 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는지 알아내는 SQL문을 작성하시오.
SELECT COUNT(*) FROM tb_student WHERE coach_professor_no IS NULL;

-- 12. 학번이 A112113인 김고운 학생의 연도 별 평점을 구하는 SQL문을 작성하시오.
-- 단, 이때 출력화면의 헤더는 "년도", "연도 별 평점"이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한 자리까지만 표시한다.
SELECT SUBSTR(term_no, 1, 4) AS "년도", ROUND(AVG(point), 1) "연도 별 평점"
FROM tb_grade
WHERE student_no = 'A112113'
GROUP BY SUBSTR(term_no, 1, 4);

-- 13. 학과 별 휴학생 수를 파악하고자 한다. 학과번호와 휴학생 수를 표시하는 SQL 문장을 작성하시오.
SELECT department_no AS "학과코드명", COUNT(absence_yn) AS "휴학생 수"
FROM tb_student
WHERE absence_yn = 'Y'
GROUP BY department_no
ORDER BY department_no;

-- 14. 춘 대학교에 다니는 동명이인 학생들의 이름을 찾고자 한다. 어떤 SQL 문장을 사용하면 가능하겠는가?
SELECT student_name, COUNT(*) FROM tb_student
GROUP BY student_name
HAVING COUNT(*) > 1;

-- 15. 학번이 A112113인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점, 총평점을 구하는 SQL문을 작성하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
SELECT SUBSTR(term_no, 1, 4) AS "년도", SUBSTR(term_no, 5, 2) AS "학기", ROUND(AVG(point), 1)
FROM tb_grade
WHERE student_no = 'A112113'
GROUP BY term_no
ORDER BY term_no;