SELECT emp_id, emp_name, salary	-- 3
FROM employee							-- 1
WHERE dept_code IS NULL;			-- 2
-- NULL 을 비교할 때는 IS NULL 또는 IS NOT NULL로 해야한다.

/*
	<ORDER BY 절>
	SELECT로 가장 마지막 줄에 작성, 실행순서 또한 가장 마지막에 실행한다.
	
	[표현법]
	SELECT 조회할 컬럼...
	FROM 조회할 테이블
	WHERE 조건식
	ORDER BY 정렬기준이 될 컬럼 | 별칭 | 컬럼 순번 [ASC | DESC] [NULLS FIRST | NULLS LAST]
	
	- ASC : 오름차순 (작은 값으로 시작해서 값이 점점 커지는 것) -> 정렬 기본값
	- DESC : 내림차순 (큰 값으로 시작해서 값이 점점 줄어드는 것)
	
	-- NULL은 기본적으로 가장 큰 값으로 분류해서 정렬한다.
	- NULLS FIRST : 정렬하고자 하는 컬럼값에 NULL이 있을 경우 해당 데이터의 맨 앞에 배치 (DESC일 때 기본값)
	- NULLS LAST : 정렬하고자 하는 컬럽값에 NULL이 있을 경우 해당 데이터의 맨 마지막에 배치 (ASC일 때 기본값)
*/

SELECT * FROM employee ORDER BY bonus ASC;					-- 기본값이 오름차순(ASC)이므로, 뒤의 ASC를 지워도 같은 결과가 도출된다.
SELECT * FROM employee ORDER BY bonus ASC NULLS FIRST;	-- NULL이 있는 값이 가장 앞에 배치되고, 오름차순으로 정렬된다. (ASC를 지워도 결과 동일)
SELECT * FROM employee ORDER BY bonus DESC;					-- 내림차순. NULLS FIRST가 기본값으로 되어있다.
SELECT * FROM employee ORDER BY bonus DESC, salary ASC;	-- 정렬 기준에 컬럼값이 동일할 경우, 그 다음 차순을 위해서 여러 개의 조건을 제시할 수 있다.

-- 전 사원의 사원명, 연봉(보너스 제외) 조회 (이때 연봉 별 내림차순 정렬)
-- 1) 별칭 사용
SELECT emp_name, (salary * 12) "연봉" FROM employee ORDER BY 연봉 DESC;
-- 2) 순번 사용
SELECT emp_name, (salary * 12) "연봉" FROM employee ORDER BY 2 DESC;		-- 오라클은 전부 1부터 시작한다.

--===================================================================================================

/*
	<함수 FUNCTION>
	전달된 컬럼값을 받아서 함수를 실행한 결과를 반환.
	
	- 단일행 함수 : N개의 값을 읽어들여서 N개의 결과값을 리턴 (매행마다 함수 실행 결과를 반환)
	- 그룹함수 : N개의 값을 읽어들여서 1개의 결과값을 리턴 (그룹을 지어서 그룹별로 함수 실행 결과를 반환)
	
	>> SELECT 절에 단일행 함수랑 그룹함수를 함께 사용하지 못함
	-> 결과 행의 개수가 다르기 때문
	
	>> 함수를 사용할 수 있는 위치 : SELECT, WHERE, ORDER BY, HAVING
*/

--================== <단일행 함수> ======================================================================

/*
	<문자 처리 함수>
	- LENGTH(컬럼 | '문자열') :  해당 문자열의 글자수를 반환
	- LENGTHB(컬럼 | '문자열') : 해당 문자열의 바이트 수를 반환
	
	'최', '나', 'ㄱ' 등 한글은 글자 당 3BYTE
	영문자, 숫자, 특수문자는 글자 당 1BYTE
*/

SELECT LENGTH('오라클'), LENGTHB('오라클') FROM dual;
-- 한글은 글자 당 3 바이트이므로, LENGTHB의 값은 9
SELECT emp_name, LENGTH(emp_name), LENGTHB(emp_name) FROM employee;

--==================================================================

/*
	- INSTR
	문자열로부터 특정 문자의 시작 위치를 찾아서 반환
	
	INSTR(컬럼 | '문자열', '찾고자하는 문자', ['찾을 위치의 시작값, 순번]) -> 결과는 NUMBER
*/

SELECT INSTR('AABABRL', 'B', 1) FROM dual;		-- 찾을 위치 시작값 1, 순번 1 => 기본값 (문자열의 맨 앞에서부터 찾는다.)
SELECT INSTR('AABABRL', 'B', -1) FROM dual;		-- 찾는 건 뒤에서부터 찾아주나, 위치는 순차 그대로 나온다.
SELECT INSTR('AABABRL', 'B', 1, 2) FROM dual;		-- 순번을 제시하려면 위치의 시작값을 표시해야한다.

--=====================================================================

/*
	- SUBSTR
	문자열에서 특정 문자열을 추출해서 반환
	
	[표현법]
	SUBSTR(STRING, POSITION, [LENGTH])
	- STRING : 문자타입 컬럽 | '문자열'
	- POSOTION : 문자열 추출할 시작 위치값
	- LENGTH : 추출할 문자 개수 (생략하면 시작값부터 끝까지 추출)
*/

SELECT SUBSTR('HEYHEYSOMLIKEITHOT', 7) FROM dual;		-- 7번째 위치부터 끝까지 추출
SELECT SUBSTR('HEYHEYSOMLIKEITHOT', 5, 2) FROM dual;		-- 5번째 위치부터 문자 2개 추출
SELECT SUBSTR('HEYHEYSOMLIKEITHOT', 1, 6) FROM dual;
SELECT SUBSTR('HEYHEYSOMLIKEITHOT', -8, 3) FROM dual;	-- 뒤에서 8번째 위치부터 문자 3개 추출

-- emp_no에서 특정 자리 수만을 반환 받아 성별로 분류하기
SELECT emp_name, emp_no, SUBSTR(emp_no, 8, 1) AS "성별" FROM employee;

-- 사원들 중 여사원들만 EMP_NAME, EMP_NO 조회
SELECT emp_name, emp_no FROM employee WHERE SUBSTR(emp_no, 8, 1) = '2' OR SUBSTR(emp_no, 8, 1) = '4' ORDER BY emp_name;

-- 함수 중첩 사용 가능
-- 1) 이메일의 아이디 부분 추출
-- 2) 사원 목록에서 사원명, 이메일, 아이디 조회
SELECT emp_name, email, SUBSTR(email, 1, INSTR(email, '@') - 1) "ID" FROM employee;

--=============================================================================

/*
	- LPAD / RPAD
	문자열을 조회할 때 통일감 있게 조회하고자 할 때 사용
	
	[표현법]
	LPAD / RPAD (STRING , 최종적으로 반환할 문자열의 길이, [덧붙이고자 하는 문자])
	
	문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 붙여서 최종 N길이만큼의 문자열을 반환
*/

-- 20만큼의 길이 중 EMAIL 컬럼 값은 오른쪽으로 정렬하고 나머지 부분은 공백으로 채운다.
SELECT emp_name, LPAD(email, 20) FROM employee;

-- 사원들의 사원명, 주민등록 번호 조회 ("701011-1XXXXXXXX")
SELECT emp_name, RPAD(SUBSTR(emp_no, 1, 8), 14, 'X') FROM employee;
SELECT emp_name, SUBSTR(emp_no, 1, 8) || 'XXXXXX' FROM employee;

--===========================================================================

/*
	- LTRIM / RTIRM
	문자열에서 특정 문자를 제거한 나머지를 반환
	
	[표현법]
	LTRIM / RTIRM ( STRING, [제거하고자 하는 문자들])
	
	문자열의 왼쪽 혹은 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거한 나머지 문자열 반환
*/

SELECT LTRIM('              K K G           ') FROM dual;
SELECT LTRIM('ABCDEFG', 'ABC') FROM dual;
SELECT RTRIM('234929340KH38283994', '29340') FROM dual;

/*
	- TRIM
	문자열의 앞 / 뒤 / 양쪽에 있는 지정한 문자들을 제거한 나머지 문자열을 반환
	TRIM([LEADING] | [TRALLING] | BOTH] 제거하고 하는 문자열 FROM 문자열

*/


--===================================================================================================

/*
	[형변환 함수]
	* TO_CHAR : 숫자 타입 또는 날짜 타입의 값을 문자 타입으로 변환 시켜주는 함수
	
	[표현법]
	TO_CHAR(숫자 | 문자, [포맷])
*/

-- 숫자 -> 문자
SELECT TO_CHAR(1234) FROM dual;
SELECT TO_CHAR(12, '99999') FROM dual;							-- 9의 자릿수만큼 공간 확보, 오른쪽 정렬
SELECT TO_CHAR(12, '00000') FROM dual;							-- 0의 자릿수만큼 공간 확보, 빈칸을 0으로 채움
SELECT TO_CHAR(123456789, 'L999999999') FROM dual;			-- 현재 설정된 나라의 로컬 화폐 단위로 나타남 (단, 자릿수가 모자라면 #로 깨져서 나옴)
SELECT TO_CHAR(123456789, 'L999,999,999') FROM dual;		-- 3자리 마다 쉼표 찍기

-- 날짜 -> 문자
SELECT SYSDATE FROM dual;
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM dual;
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM dual;						-- AM, PM 상관없이 형식을 정해주는 것이기에 결과는 동일
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM dual;						-- 24시간
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM dual;			-- DY : 요일 약자 표기 (ex. 수요일 -> 수)
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM dual;
SELECT TO_CHAR(SYSDATE, 'MM DD YYYY') FROM dual;
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') FROM dual;		-- 한글을 사용해서 표기 시, " "로 입력

-- ex ) 사원들의 이름, 입사 날짜(0000년 00월 00일) 조회
SELECT emp_name, TO_CHAR(hire_date, 'YYYY"년" MM"월" DD"일"') "입사 날짜" FROM employee;

-- 년도와 관련된 포맷
SELECT TO_CHAR(SYSDATE, 'YYYY'),
		  TO_CHAR(SYSDATE, 'YY'),
		  TO_CHAR(SYSDATE, 'RRRR'),		-- RR룰이 따로 존재한다 (거의 사용X)
		  TO_CHAR(SYSDATE, 'YEAR')		-- 영문으로 날짜 표기
FROM dual;

-- ex )
SELECT hire_date, TO_CHAR(hire_date, 'YYYY'), TO_CHAR(hire_date, 'YEAR') FROM employee;

-- 월과 관련된 포맷
SELECT	TO_CHAR(SYSDATE, 'MM'),
			TO_CHAR(SYSDATE, 'MON'),
			TO_CHAR(SYSDATE, 'MONTH')
FROM dual;

-- 일에 관련된 포맷
SELECT	TO_CHAR(SYSDATE, 'DDD'),		-- 오늘이 이번 년도 기준으로 몇 번째 일수인지 표시
			TO_CHAR(SYSDATE, 'DD'),		-- 오늘 일자 (두 자리)
			TO_CHAR(SYSDATE, 'D')			-- 요일 -> 숫자 변환. 일요일이 1이 된다. (ex. 수 -> 4)
FROM dual;

-- 요일을 나타내는 포맷
SELECT	TO_CHAR(SYSDATE, 'DAY'),
			TO_CHAR(SYSDATE, 'DY')
FROM dual;


--===================================================================================================

/*
	TO_DATE : 숫자 타입 또는 문자 타입을 날짜 타입으로 변경하는 함수
	
	[표현법]
	TO_DATE(숫자 | 문자. [포맷])
*/

SELECT TO_DATE(19961102) FROM dual;
SELECT TO_DATE(241229) FROM dual;			-- 년도를 뜻하는 앞부분 2자리가 50 미만이면 자동으로 20XX으로, 50년 이상은 19XX로 설정된다.
SELECT TO_DATE(981031) FROM dual;

SELECT TO_DATE(080704) FROM dual;			-- 숫자 -> 날짜 변환 시, 0으로 시작할 수 없다
SELECT TO_DATE('080704') FROM dual;			-- 숫자열 앞부분이 0일 때는 ' ' 사용

SELECT TO_DATE('020505 120500') FROM dual;									-- 시간까지 표기할 때는 형식을 지정해주어야 한다.
SELECT TO_DATE('020505 120500', 'YYMMDD HH24MISS') FROM dual;


--===================================================================================================

/*
	TO_NUMBER : 문자 타입의 데이터를 숫자 타입으로 변환 시켜주는 함수
	
	[표현법]
	TO_NUMBER(문자, [포맷])
*/

SELECT TO_NUMBER('010401') FROM dual;

SELECT '10000' + '50000' FROM dual;		-- 산술 연산자를 쓸 경우 자동으로 형변환
SELECT '10,000' + '50,000' FROM dual;		-- 문자열에 숫자 외의 다른 문자가 들어있을 경우엔 자동으로 변환되지 않는다
SELECT TO_NUMBER('10,000', '99,999') + TO_NUMBER('50,000', '99,000') FROM dual;


--===================================================================================================

/*
	[NULL 처리 함수]
	* NVL : 컬럼에 NULL 값이 있으면 지정한 값을 대신 보여주는 함수
	* NVL2 : 컬럼에 값이 존재할 경우 반환값과, NULL일 경우 반환값을 각각 지정하여 보여주는 함수
	* NULLIF : 두 값이 일치하면 NULL, 일치하지 않으면 비교대상1을 반환하는 함수
	
	[표현법]
	- NVL(컬럼, 해당 컬럼이 NULL일 경우 보여줄 값)
	- NVL2(컬럼, 반환값1, 반환값2)
	- NULLIF(비교대상1, 비교대상2)
*/

-- ex ) NVL
SELECT emp_name, NVL(bonus, 0) FROM employee;
SELECT emp_name, (salary + (salary * NVL(bonus, 0))) * 12 FROM employee;

-- ex ) NVL2
SELECT emp_name, bonus, NVL2(bonus, 'O', 'X') FROM employee;

-- ex ) NULLIF
SELECT NULLIF('123', '123') FROM dual;
SELECT NULLIF('123', '456') FROM dual;


--===================================================================================================

/*
	[선택 함수]
	* DECODE : 비교하고자 하는 대상과 비교값들을 비교하여, 그에 맞는 결과값을 반환하는 함수
	
	[표현법]
	DECODE(비교하고자 하는 대상(컬럼, 연산식, 함수식), 비교값1, 결과값1, 비교값2, 결과값2 ...)
*/

-- ex )
SELECT	emp_id, emp_name, emp_no,
			DECODE(SUBSTR(emp_no, 8, 1), '1', '남', '2', '여', '3', '남', '4', '여', '외계인') AS "성별"	-- 일치하는 비교값이 없을 경우, 가장 마지막 결과값을 따른다.
FROM employee;

-- 연습 문제 ) 직원의 성명, 기존 급여, 인상된 급여 조회하기
-- J7인 사원은 급여를 10% 인상 (salary * 1.1)
-- J6인 사원은 급여를 15% 인상 (salary * 1.15)
-- J5인 사원은 급여를 20% 인상 (salary * 1.2)
-- 그 외 사원은 급여를 5% 인상 (salary * 1.05)
SELECT emp_name, salary, (salary * DECODE(job_code, 'J7', 1.1, 'J6', 1.15, 'J5', 1.2, 1.05)) "인상된 급여" FROM employee;

/*
	* CASE WHEN THEN : IF, IF~ELSE와 같은 역할
	
	[표현법]
	CASE
			WHEN 조건식1 THEN 결과값1
			WHEN 조건식2 THEN 결과값2
			...
			ELSE 결과값
	END

*/

-- ex )
SELECT	emp_name, salary,
			CASE
					WHEN salary >= 5000000 THEN '고급'
					WHEN salary >= 3500000 THEN '중급'
					ELSE '초급'
			END
FROM employee;


--===================================================================================================

/*
	[그룹 함수]
	
	1. SUM(숫자타입컬럼) : 해당 컬럼에 속하는 모든 값들의 총 합계를 구해서 반환해주는 합수
*/

-- ex )
SELECT SUM(salary) FROM employee;

-- 연습 문제 )
-- 1. 남자 사원들의 총 급여
SELECT SUM(salary) FROM employee WHERE SUBSTR(emp_no, 8, 1) IN ('1', '3');
-- 2. 부서코드가 D5인 사원들의 총 연봉(급여 * 12)
SELECT SUM(salary * 12) FROM employee WHERE dept_code = 'D5';

/*
	2. AVG(NUMBER) : 해당 컬럼값들의 평균을 구해서 반환
*/

-- ex )
SELECT ROUND(AVG(salary)) FROM employee;

/*
	3. MIN(모든타입가능) : 해당 컬럼값 중 가장 작은 값을 구해서 반환
*/

-- ex )
SELECT MIN(emp_name), MIN(salary), MIN(hire_date) FROM employee;

/*
	4. MAX(모든타입가능) : 해당 컬럼값 중 가장 큰 값을 구해서 반환
*/

-- ex )
SELECT MAX(emp_name), MAX(salary), MAX(hire_date) FROM employee;

/*
	5. COUNT(* | 컬럼 | DISTINCT 컬럼) : 해당 조건에 맞는 행의 개수를 세서 반환
	- COUNT(*) : 조회된 결과에 모든 행의 개수를 세서 반환
	- COUNT(컬럼) : 제시한 해당 컬럼값 중 NULL을 제외한 행의 수를 세서 반환
	- COUNT(DISTINCT 컬럼) : 해당 컬럼값 중 중복값을 제외한 행의 개수를 세서 반환
*/

-- ex )
SELECT COUNT(*) "전체 사원 수" FROM employee;
SELECT COUNT(bonus) "보너스를 받는 사원 수" FROM employee;

-- 연습 문제 ) 현재 사원들이 총 몇 개의 부서에 분포되어 있는 지를 구해라
SELECT COUNT(DISTINCT dept_code) FROM employee;