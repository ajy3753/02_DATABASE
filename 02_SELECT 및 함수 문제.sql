/*
	[KH 연습문제]
*/

-- 1. JOB 테이블의 모든 정보 조회
SELECT * FROM job;

-- 2. JOB 테이블의 직급 이름 조회
SELECT job_name FROM job;

-- 3. DEPARTMENT 테이블의 모든 정보 조회
SELECT * FROM department;

-- 4. EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 고용일 조회
SELECT emp_name, email, phone, hire_date FROM employee;

-- 5. EMPLOYEE 테이블의 고용일, 사원명, 월급 조회
SELECT hire_date, emp_name, salary FROM employee;

-- 6. EMPLOYEE 테이블에서 사원명, 연봉, 총수령액(보너스 포함), 실수령액(총수령액 - (연봉*세금 3%)) 조회
SELECT	emp_name,
			salary * 12 "연봉",
			(salary + salary * NVL(bonus, 0)) * 12 "총수령액",
			(salary + salary * NVL(bonus, 0)) * 12 - (salary * 12 * 0.03) "실수령액"
FROM employee;

-- 7. EMPLOYEE 테이블에서 SAL_LEVEL이 S1인 사원의 이름, 월급, 고용일, 연락처 조회
SELECT emp_name, salary, hire_date, phone FROM employee WHERE salary >= 6000000 AND salary <= 100000000;

-- 8. EMPLOYEE 테이블에서 실수령액(6번 참고)이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
SELECT emp_name, salary, (salary + salary * NVL(bonus, 0)) * 12 - (salary * 12 * 0.03) "실수령액", hire_date
FROM employee WHERE (salary + salary * NVL(bonus, 0)) * 12 - (salary * 12 * 0.03) >= 50000000;

-- 9. EMPLOYEE 테이블에서 월급이 4000000 이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
SELECT * FROM employee WHERE salary >= 4000000 AND job_code = 'J2';

-- 10. EMPLOYEE 테이블에서 DEPT_CODE가 D9 이거나 D5인 사원 중 고용일이 02년 1월 1일 보다 빠른 사원의 이름, 부서코드, 고용일 조회
SELECT emp_name, dept_code, hire_date FROM employee
WHERE dept_code IN ('D9', 'D5') AND hire_date < '02/01/01';

-- 11. EMPLOYEE 테이블에서 고용일이 90/01/01 ~ 01/01/01인 사원의 전체 내용을 조회
SELECT * FROM employee WHERE hire_date >= '90/01/01' AND hire_date <= '01/01/01';

-- 12. EMPLOYEE 테이블에서 이름 끝이 '연'으로 끝나는 사원의 이름 조회
SELECT emp_name FROM employee WHERE emp_name LIKE '%연';

-- 13. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
SELECT emp_name, phone FROM employee WHERE SUBSTR(phone, 1, 3) != '010';

-- 14. EMPLOYEE 테이블에서 메일주소 '_'의 앞이 4글자이면서, DEPT_CODE가 D9 또는 D6이고,
-- 고용일이 90/01/01 ~ 00/12/01 이고, 급여가 270만 이상인 사원의 전체를 조회
SELECT * FROM employee
WHERE	INSTR(email, '_', 1) = 3 AND
			dept_code IN ('D9', 'D6') AND
			hire_date >= '90/01/01' AND hire_date <= '00/12/01' AND
			salary >= 2700000;

-- 15. EMPLOYEE 테이블에서 사원명과 직원의 주민번호를 이용하여 생년, 생월, 생일 조회
SELECT	emp_name,
			SUBSTR(emp_no, 1, 2) "생년",
			SUBSTR(emp_no, 3, 2) "생월",
			SUBSTR(emp_no, 5, 2) "생일"
FROM employee;

-- 16. EMPLOYEE 테이블에서 사원명, 주민번호 조회 (단, 주민번호는 생년월일만 보이게 하고, '-' 다음 값은 '*'로 바꾸기)
SELECT emp_name, RPAD(SUBSTR(emp_no, 1, 7), 14, '*') FROM employee;

-- 17. EMPLOYEE 테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
-- (단, 각 별칭은 근무일수1, 근무일수2가 되도록 하고 모두 정수(내림), 양수가 되도록 처리)
SELECT	emp_name,
			FLOOR(hire_date - SYSDATE) * (-1) "근무일수1",
			FLOOR(SYSDATE - hire_date) "근무일수2"
FROM employee;

-- 18. EMPLOYEE 테이블에서 사번이 홀수인 직원들의 정보 모두 조회
SELECT * FROM employee WHERE MOD(emp_id, 2) = 1;

-- 19. EMPLOYEE 테이블에서 근무연수가 20년 이상인 직원 정보 조회
SELECT * FROM employee WHERE TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(TO_DATE(hire_date), 'YYYY') >= 20;

-- 20. EMPLOYEE 테이블에서 사원명, 급여 조회 (단, 급여는 '\9,000,000 형식으로 표시)
SELECT emp_name, TO_CHAR(salary, 'L999,999,999') FROM employee;

-- 21. EMPLOYEE 테이블에서 직원명, 부서코드, 생년월일, 나이(만) 조회
-- (단, 생년월인은 주민번호에서 추출해서 00년 00월 00일로 출력되게 하며, 나이는 주민번호에서 출력해서 날짜 데이터로 변환한 다음 계산)
SELECT	emp_name,
			dept_code,
			TO_CHAR(TO_DATE(SUBSTR(emp_no, 1, 6)), 'YYYY"년" MM"월" DD"일"') "생년월일",
			FLOOR((SYSDATE - TO_DATE(SUBSTR(emp_no, 1, 6))) / 365) || '세' "나이(만)"
FROM employee;

-- 22. EMPLOYEE 테이블에서 부서코드가 D5, D6, D9인 사원만 조회하되 D5면 총무부, D6이면 기획부, D9면 영업부로 처리
-- (단, 부서코드 오름차순으로 정렬)
SELECT	emp_name,
			dept_code,
			DECODE(dept_code, 'D5', '총무부', 'D6', '기획부', 'D9', '영업부')
FROM employee
WHERE dept_code IN ('D5', 'D6', 'D9') ORDER BY dept_code;

-- 23. EMPLOYEE 테이브에서 사번이 201인 사원명, 주민번호 앞자리, 주민번호 뒷자리, 주민번호 앞자리와 뒷자리의 합 조회
SELECT	emp_name,
			SUBSTR(emp_no, 1, 6) "주민번호 앞자리",
			SUBSTR(emp_no, 8, 7) "주민번호 뒷자리",
			SUBSTR(emp_no, 1, 6) + SUBSTR(emp_no, 8, 7) "주민번호 합"
FROM employee WHERE emp_id = 201;

-- 24. EMPLOYEE 테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉 합 조회
SELECT	emp_name, dept_code,
			((salary + (salary * NVL(bonus, 0))) * 12) "연봉"
FROM employee WHERE dept_code = 'D5';

-- 25. EMPLOYEE 테이블에서 직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수 조회
-- 전체 직원 수 / 2001년 / 2002년 / 2003년 / 2004년
SELECT	COUNT(*) "전체 직원 수",
			SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), '2001', 1, 0)) "2001년 입사 수",
			SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), '2002', 1, 0)) "2002년 입사 수",
			SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), '2003', 1, 0)) "2003년 입사 수",
			SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), '2004', 1, 0)) "2004년 입사 수"
FROM employee;

SELECT	COUNT(*) "전체 직원 수",
			COUNT(DECODE(EXTRACT(YEAR FROM hire_date), '2001', 1, NULL)) "2001년 입사 수",
			COUNT(DECODE(EXTRACT(YEAR FROM hire_date), '2002', 1, NULL)) "2002년 입사 수",
			COUNT(DECODE(EXTRACT(YEAR FROM hire_date), '2003', 1, NULL)) "2003년 입사 수",
			COUNT(DECODE(EXTRACT(YEAR FROM hire_date), '2004', 1, NULL)) "2004년 입사 수"
FROM employee;

