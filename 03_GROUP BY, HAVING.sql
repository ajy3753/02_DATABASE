/*
	<GROUP BY 절>
	그룹기준을 제시할 수 있는 구문 (해당 그룹 기준 별로 여러 그룹으로 묶을 수 있음)
	여러 개의 값들을 하나의 그룹으로 묶어서 처리하는 목적으로 사용
*/

-- ex )
SELECT SUM(salary) FROM employee;													-- 전체 사원을 하나의 그룹으로 묶어서 총합을 구한 것
SELECT dept_code, SUM(salary) FROM employee GROUP BY dept_code;		-- 각 부서별 급여 총합
SELECT dept_code, COUNT(*) FROM employee GROUP BY dept_code;			-- 각 부서별 사원 수

-- GROUP BY가 들어갔을 때 코드 실행 순서
SELECT dept_code, COUNT(*), SUM(salary)		-- 3
FROM employee										-- 1
GROUP BY dept_code								-- 2
ORDER BY dept_code;								-- 4 ORDER BY가 무조건 마지막에 실행 -> 정렬은 마지막에 해주는 것이 아니면 의미X

-- 연습 문제 ) 각 직급별 총 사원수, 보너스를 받는 사람 수, 급여 합, 평균 급여, 최저 급여, 최고 급여 (정렬: 직급 오름차순)
SELECT	COUNT(*) "총 사원 수",
			COUNT(bonus) "보너스를 받는 사람 수",
			SUM(salary), AVG(salary),
			MIN(salary) "최저 급여",
			MAX(salary) "최고 급여"
FROM employee GROUP BY dept_code;


--===================================================================================================

/*
	[HAVING 절]
	그룹에 대한 조건을 제시할 때 사용되는 구문 (주로 그룹함수식을 가지고 조건을 만든다.)
*/

-- ex )
-- 각 부서별 평균 급여 (부서코드, 평균 급여)
SELECT dept_code, ROUND(AVG(salary)) FROM employee GROUP BY dept_code;
-- 각 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT dept_code, ROUND(AVG(salary)) FROM employee GROUP BY dept_code HAVING AVG(salary) >= 3000000;
-- 직급별 직급코드, 총 급여합 (단, 직급별 급여합이 1000만원 이상인 직금만 조회)
SELECT job_code, SUM(salary) FROM employee GROUP BY job_code HAVING sum(salary) >= 10000000;
-- 부서별 보너스를 받는 사원이 없는 부서의 부서코드
SELECT dept_code FROM employee GROUP BY dept_code HAVING COUNT(bonus) = 0;


--===================================================================================================

/*
	SELECT * | 조회하고 싶은 컬럼들 | 함수식 | 산술연산
	FROM  조회하고 싶은 테이블 | DUAL
	GROUP BY 그룹의 기준이 되는 컬럼 | 함수식
	HAVING 조건식
	ORDER BY 컬럼 | 별칭 | 순서 [ASC | DESC] [NULLS FIRST | NULLS LAST]
*/


--===================================================================================================

/*
	[집합 연산자]
	여러개의 쿼리문을 하나의 쿼리문으로 만드는 연산자
	
	- UNION : OR | 합집합 (두 쿼리문 수행한 결과값을 더한다)
	- INTERSECT :   AND | 교집합 (두 쿼리문의 수행한 결과값에 중복된 결과값) 4
	
*/