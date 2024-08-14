 /*
	[서브쿼리]
	- 하나의 SQL문 안에 포함된 또 다른 SELECT문
	- 메인 SQL문을 위해 보조 역할을 하는 쿼리
*/

-- ex )
-- 노옹철 사원과 같은 부서에 속한 사원들 조회
SELECT emp_name FROM employee
WHERE dept_code = (SELECT dept_code FROM employee WHERE emp_name = '노옹철');
-- 전 직원의 평균 급여 보다 더 많은 급여를 받는 사원들의 사번, 이름, 직급 코드, 급여 조회
SELECT emp_id, emp_name, job_code, salary FROM employee
WHERE salary >= (SELECT AVG(salary) FROM employee);


/*
	* 서브쿼리의 구분
	서브쿼리를 수행한 결과값이 몇 행 몇 열로 나오느냐에 따라서 분류
	
	- 단일행 서브쿼리 : 서브쿼리의 조회 결과값이 오로지 1개일 때
	- 다중행 서브쿼리 : 서브쿼리의 조회 결과값이 여러 행일 때 (여러 행 1열)
	- 다중열 서브쿼리 : 서브쿼리의 조회 결과값이 1행이지만 컬럼이 여러 개일 때
	- 다중행 다중열 서브쿼리 : 서브쿼리의 조회 결과값이 여러 행 여러 컬럼일 때
	
	>> 서브쿼리의 결과값에 따라서 서브쿼리 앞 쪽의 연산자가 달라진다.
*/

/*
	1. 단일행 서브쿼리
	서브쿼리의 조회 결과값이 오로지 2개일 때 (1행 1열)
	일반 비교연산자 사용 가능
*/

-- 연습문제 )
-- 1) 전 직원의 평균 급여 보다 급여를 더 적게 받는 사원들의 사원명, 직급코드, 급여 조회
SELECT emp_name, job_code, salary FROM employee
WHERE salary < (SELECT AVG(salary) FROM employee);

-- 2) 최저 급여를 받는 사원의 사번, 이름, 급여, 입사일 조회
SELECT emp_id, emp_name, salary, hire_date FROM employee
WHERE salary = (SELECT MIN(salary) FROM employee);

-- 3) 노옹철 사원의 급여 보다 많이 받는 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT emp_id, emp_name, dept_code, salary FROM employee
WHERE salary > (SELECT salary FROM employee WHERE emp_name = '노옹철');

-- 4) 노옹철 사원의 급여 보다 많이 받는 사원들의 사번, 이름, 부서명, 급여 조회
SELECT emp_id, emp_name, dept_title, salary FROM employee
JOIN department ON (dept_code = dept_id)
WHERE salary >= (SELECT salary FROM employee WHERE emp_name = '노옹철');

-- 5) 부서별 급여 합이 가장 큰 부서의 부서코드, 급여 함 조회
SELECT dept_code, SUM(salary) FROM employee GROUP BY dept_code
HAVING SUM(salary) = (SELECT MAX(SUM(salary)) FROM employee GROUP BY dept_code);

-- 6) '전지연' 사원과 같은 부서의 사람들의 사번, 사원명, 전화번호, 입사일, 부서명 조회 (단, 전지연 사원 제외)
SELECT emp_id, emp_name, phone, hire_date, dept_title FROM employee
JOIN department ON (dept_code = dept_id)
WHERE	dept_code = (SELECT dept_code FROM employee WHERE emp_name = '전지연')
			AND emp_name != '전지연';
			

----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	2. 다중행 서브쿼리
	서브쿼리를 수행한 결과값이 여러 행일 때 (컬럼은 1개)
	
	1) IN (서브쿼리) : 여러 개의 결과값 중에서 한 개라도 일치하는 값이 있다면 조회
	
	2) > ANY (서브쿼리) : 여러 개의 결과값 중에서 한 개라도 클 경우 조회
	3) < ANY (서브쿼리) : 여러 개의 결과값 중에서 한 개라도 작을 경우 조회
	--> 비교대상 > ANY (서브쿼리의 결과값 -> 값1, 값2, 값3 ...)
	
	4) > ALL (서브쿼리) : 여러 개의 모든 결과값들 보다 클 경우 조회
	5) < ALL (서브쿼리) : 여러 개의 모든 결과값들 보다 작을 경우 조회
*/

-- 연습 문제 )
-- 1) 유재식 또는 윤은해 사원과 같은 직급인 사원들의 사번, 사원명, 직급코드, 급여 조회
SELECT emp_id, emp_name, job_code, salary FROM employee
WHERE job_code IN (SELECT job_code FROM employee WHERE emp_name IN ('유재식', '윤은해'));

-- 2) 대리 직급임에도 과장 직급 급여들 중 최소 급여 보다 많이 받는 사원들의 사번, 이름, 직급, 급여 조회
SELECT emp_id, emp_name, job_name, salary FROM employee
JOIN job USING (job_code)
WHERE	job_name = '대리'
			AND salary >  ANY(SELECT salary FROM employee
								JOIN job USING (job_code)
								WHERE job_name = '과장');


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	3. 다중열 서브쿼리
	결과값은 1행이지만 나열된 컬럼 수가 여러 개일 경우
*/

-- 연습 문제 )
-- 1) 하이유 사원과 같은 부서코드, 같은 직급 코드에 해당하는 사원들 조회 (사원명, 부서코드, 직급코드, 입사일)
SELECT emp_name, dept_code, job_code, hire_date FROM employee
WHERE (dept_code, job_code) = (SELECT dept_code, job_code FROM employee WHERE emp_name = '하이유');

-- 2) 박나라 사원과 같은 직급코드, 같은 사수를 가지고 있는 사원들의 사번, 사원명, 직급코드, 사수번호 조회
SELECT emp_id, emp_name, job_code, manager_id FROM employee
WHERE	(job_code, manager_id) = (SELECT job_code, manager_id FROM employee WHERE emp_name = '박나라')
			AND emp_name != '박나라';

			
----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	4. 다중행 다중열 서브쿼리
	서브쿼리의 조회 결과값이 여러 행 여러 열일 경우
*/

-- 연습문제 )
-- 1) 각 직급별 최소급여를 받는 사원 조회 (사번, 사원명, 직급코드, 급여)
SELECT emp_id, emp_name, job_code, salary FROM employee
WHERE (job_code, salary) IN (SELECT job_code, MIN(salary) FROM employee GROUP BY job_code);

-- 2) 각 부서별 최고 급여를 받는 사원들의 사번, 사원명, 부서코드, 급여 조회
SELECT emp_id, emp_name, dept_code, salary FROM employee
WHERE (dept_code, salary) IN (SELECT dept_code, MAX(salary) FROM employee GROUP BY dept_code)
ORDER BY dept_code;


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	5. 인라인 뷰
	FROM 절에 서브쿼리를 작성하는 것
	서브쿼리를 수행한 결과를 마치 테이블처럼 사용
	
	- 주로 사용하는 예 >> TOP-N 분석 : 상위 몇 개만 조회
*/

-- 연습문제 )
-- 1) 사원들의 사번, 이름, 보너스 포함 연봉, 부서코드 조회 (단, 보너스 포함 연봉은 NULL이 되면 안되고 3000만원 이상인 사원들만 조회)
SELECT emp_id, emp_name, (salary + (salary * NVL(bonus, 0))) * 12 "연봉", dept_code FROM employee
WHERE (salary + (salary * NVL(bonus, 0))) * 12 >= 30000000
ORDER BY 연봉 DESC;

-- 2) 전 직원 중 급여가 가장 높은 5명만 조회 (순위, 사원명, 급여)
-- ROWNUM : 오라클에서 제공하는 컬럼, 조회된 순서대로 1부터 순번을 부여한다.
SELECT ROWNUM, emp_name, salary
FROM (SELECT emp_name, salary FROM employee ORDER BY salary DESC)
WHERE ROWNUM <= 5;

-- 3) 가장 최근에 입사한 사원 5명 조회 (사원명, 급여, 입사일)
SELECT emp_name, salary, hire_date
FROM (SELECT * FROM employee ORDER BY hire_date DESC)
WHERE ROWNUM <= 5;

-- 4) 부서별 평균 급여가 높은 3개의 부서 조회 (부서코드, 평균 급여)
SELECT dept_code, "평균 급여"
FROM (SELECT dept_code, ROUND(AVG(salary)) "평균 급여" FROM employee GROUP BY dept_code ORDER BY AVG(salary) DESC)
WHERE ROWNUM <= 3;


-- 실습 문제 )
-- 1) 부서 별 급여 합계가 전체 급여의 총합보다 20% 많은 부서의 부서명, 부서별 급여 합계 조회

-- 2) 나이 상 가장 막내의 사원 코드, 사원명, 나이, 부서명, 직급명 조회
SELECT emp_id, emp_name, dept_title, job_name FROM employee
JOIN department ON (dept_code = dept_id)
JOIN job USING (job_code);


--===================================================================================================

/*
	* 순위를 매기는 함수 (WINDOW FUNCTION)
	RANK() OVER(정렬기준) | DANSE_RANK() OVER(정렬기준)
	
	- RANK() OVER(정렬기준) : 동일한 순위 이후의 등수를 동일한 인원 수 만큼 건너뛰고 순위계산
	- DANSE_RANK() OVER(정렬기준) : 동일한 순위가 있다고해도 그 다음 등수를 무조건 1씩 증가
	
	※ 무조건 SELECT절에서만 사용
*/

-- 연습 문제 )
-- 1) 급여가 높은 순서대로 순위를 매겨서 조회 (이름, 급여, 순위)
SELECT emp_name, salary, RANK() OVER(ORDER BY salary DESC) "순위" FROM employee;

-- 2) 급여가 높은 순서대로 5명만 조회
SELECT * FROM (SELECT emp_name, salary, RANK() OVER(ORDER BY salary DESC) "순위" FROM employee)
WHERE "순위" <= 5;