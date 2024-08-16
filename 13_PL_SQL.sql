/*
	<PL/SQL>
	PROCEDURE LANGUAGE EXTGENSION TO SQL
	
	오라클 자체에 내장 되어있는 절차적 언어
	SQL 문장 내에서 변수의 정의, 조건(IF), 반복(FOR, WHILE)등을 지원하여 SQL 단점을 보완
	다수의 SQL 문을 한 번에 실행가능
	
	* PL/SQL 구조
	- [선언부] : DECLARE로 시작, 변수나 상수를 선언 및 초기화하는 부분
	- 실행부 : BEGIN으로 시작, SQL문 또는 제어문 등의 로직을 기술하는 부분
	- [예외처리부] : EXCEPTION으로 시작, 예외 발생 시 해결하기 위한 구문
*/

SET SERVEROUTPUT ON;

-- ex ) HELLO ORACLE 출력
BEGIN
	-- System.out.print("HELLO ORACLE")
	DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	1. DECLARE 선언부
	변수 및 상수 선언하는 공간
	일반 타입 변수, 레퍼런스 타입 변수, ROW 타입 변수
	
	1 ) 일반 타입 변수 선언 및 초기화
		[표현식]
		변수명 [CONSTANT] 자료형 [ := 값]
*/

-- ex )
-- 1 ) DECLARE로 선언 및 초기화
DECLARE
	eid		NUMBER;
	ename	VARCHAR2(20);
	pi			CONSTANT NUMBER := 3.14;
BEGIN
	eid := 800;
	ename := '최지원';
	
	DBMS_OUTPUT.PUT_LINE('EID : ' || eid);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ename);
	DBMS_OUTPUT.PUT_LINE('PI : ' || pi);
END;
/

-- 2 ) 입력 받은 값을 출력
DECLARE
	eid		NUMBER;
	ename	VARCHAR2(20);
	pi			CONSTANT NUMBER := 3.14;
BEGIN
	eid := &번호;
	ename := '&이름';
	
	DBMS_OUTPUT.PUT_LINE('EID : ' || eid);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ename);
	DBMS_OUTPUT.PUT_LINE('PI : ' || pi);
END;
/


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	2 ) 레퍼런스 타입 변수 선언 및 초기화 (어떤 타입을 어떤 컬럼의 데이터 타입을 참조하여 그 타입으로 지정)
*/

-- ex ) 
-- 1 ) 사번이 200번인 사원의 사번, 사원명, 급여 조회
DECLARE
	eid		employee.emp_id%TYPE;
	ename	employee.emp_name%TYPE;
	sal			employee.salary%TYPE;
BEGIN
	SELECT emp_id, emp_name, salary
	INTO eid, ename, sal
	FROM employee
	WHERE emp_id = '200';

	DBMS_OUTPUT.PUT_LINE('EID : ' || eid);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ename);
	DBMS_OUTPUT.PUT_LINE('SAL : ' || sal);
END;
/

-- 2 ) 사번을 입력 받아 조회
DECLARE
	eid		employee.emp_id%TYPE;
	ename	employee.emp_name%TYPE;
	sal			employee.salary%TYPE;
BEGIN
	SELECT emp_id, emp_name, salary
	INTO eid, ename, sal
	FROM employee
	WHERE emp_id = '&사번';

	DBMS_OUTPUT.PUT_LINE('EID : ' || eid);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ename);
	DBMS_OUTPUT.PUT_LINE('SAL : ' || sal);
END;
/


--==

/*
	[실습 문제]
	레퍼런스 타입 변수로 EID, ENAME, JCODE, SAL, DTITLE을 선언하고
	각 자료형 EMPLOYEE(EMP_ID, EMP_NAME, JOB_CODE, SALARY), DEPARTMENT(DEPT_TITLE)등을 참조하도록
	사용자가 입력한 사번의 사원의 사번, 사원명, 직급코드, 급여, 부서명 조회 후 각 변수에 담아 출력
*/

DECLARE
	eid		employee.emp_id%TYPE;
	ename	employee.emp_name%TYPE;
	jcode		employee.job_code%TYPE;
	sal			employee.salary%TYPE;
	dtitle		department.dept_title%TYPE;
BEGIN
	SELECT emp_id, emp_name, job_code, salary, dept_title
	INTO eid, ename, jcode, sal, dtitle
	FROM employee
	JOIN department ON (dept_code = dept_id)
	WHERE emp_id = '&사번';

	DBMS_OUTPUT.PUT_LINE('EID : ' || eid);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ename);
	DBMS_OUTPUT.PUT_LINE('JCODE : ' || jcode);
	DBMS_OUTPUT.PUT_LINE('SAL : ' || sal);
	DBMS_OUTPUT.PUT_LINE('DTITLE : ' || dtitle);
END;
/


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	3 ) ROW 타입 변수 선언
	테이블의 한 행에 대한 모든 컬럼값을 한 번에 담을 수 있는 변수
	
	[표현식]
	변수명 테이블명%ROWTYPE
*/

-- ex )
DECLARE
	E	employee%ROWTYPE;
BEGIN
	SELECT *
	INTO E
	FROM employee
	WHERE emp_id = '&사번';
	
	DBMS_OUTPUT.PUT_LINE('사원명 : ' || E.emp_name);
	DBMS_OUTPUT.PUT_LINE('급여 : ' || E.salary);
END;
/


--===================================================================================================

/*
	2. BEGIN 실행부
	
	<조건문>
	1 ) IF 조건식 THEN 실행내용 END IF;	(IF문을 단독으로 사용할 때)
	2 ) IF 조건식 THEN 실행내용1 ELSE 실행내용2 END IF;
	3 ) IF 조건식1 THEN 실행내용1 ELSIF 조건식2 THEN 실행내용2 ... [ELSE 실행내용] END IF;
*/

-- ex )
-- 1 ) 입력 받은 사번에 해당하는 사원의 사번, 이름, 급여, 보너스 출력
-- 단, 보너스를 받지 않는 사원은 보너스율 출력 전 '보너스를 지급받지 않는 사원입니다' 출력
DECLARE
	eid		employee.emp_id%TYPE;
	ename	employee.emp_name%TYPE;
	sal			employee.salary%TYPE;
	bonus		employee.bonus%TYPE;
BEGIN
	SELECT emp_id, emp_name, salary, NVL(bonus, 0)
	INTO eid, ename, sal, bonus
	FROM employee
	WHERE emp_id = '&사번';

	DBMS_OUTPUT.PUT_LINE('사번 : ' || eid);
	DBMS_OUTPUT.PUT_LINE('이름 : ' || ename);
	DBMS_OUTPUT.PUT_LINE('급여 : ' || sal);
	IF bonus = 0
		THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다. ');
	ELSE
		DBMS_OUTPUT.PUT_LINE('보너스 : ' || bonus);
	END IF;
END;
/

-- 2 ) ELSE IF
DECLARE
	score	NUMBER;
	grade	VARCHAR2(1);
BEGIN
	score := &점수;
	
	IF score >= 90
		THEN grade := 'A';
	ELSIF score >= 80
		THEN grade := 'B';
	ELSIF score >= 70
		THEN grade := 'C';
	ELSIF score >= 60
		THEN grade := 'D';
	ELSE
		grade := 'F';
	END IF;
	
	DBMS_OUTPUT.PUT_LINE('점수 : ' || score);
	DBMS_OUTPUT.PUT_LINE('성적 : ' || grade);
END;
/
--==

/*
	[실습 문제]
	DECLARE
	- 레퍼런스 변수(EID, ENAME, DTITLE, NCODE)
	- 참조 변수(EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE)
	- 일반 타입 변수(TEAM 문자열) : 국내팀, 해외팀 분리해서 저장
	
	BEGIN
	- 사용자가 입력한 사번의 사원 정보를 가져와 사번, 이름, 부서명, 근무국가코드 조회 후 각 변수에 대입
	- NCODE값이 KO일 경우 -> TEAM -> 국내팀
	- NCODE값이 KO가 아닐 경우 -> TEAM -> 해외팀 대입
	- 사번, 이름, 부서명, 소속(TEAM)을 출력
*/

DECLARE
	eid		employee.emp_id%TYPE;
	ename	employee.emp_name%TYPE;
	dtitle		department.dept_title%TYPE;
	ncode		location.national_code%TYPE;
	TEAM		VARCHAR2(10);
BEGIN
	SELECT emp_id, emp_name, dept_title, national_code
	INTO eid, ename, dtitle, ncode
	FROM employee
	JOIN department ON (dept_code = dept_id)
	JOIN location ON (location_id = local_code)
	WHERE emp_id = '&사번';
	
	IF ncode = 'KO'
		THEN team := '국내팀';
	ELSE
		team := '해외팀';
	END IF;
	
	DBMS_OUTPUT.PUT_LINE('사번 : ' || eid);
	DBMS_OUTPUT.PUT_LINE('이름 : ' || ename);
	DBMS_OUTPUT.PUT_LINE('부서 : ' || dtitle);
	DBMS_OUTPUT.PUT_LINE('소속 : ' || team);
END;
/


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	2. 반복문
	
	1 ) BASIC LOOP
	
	[표현법]
	LOOP
		반복적으로 실행할 구문
		* 반복문을 빠져나갈 수 있는 구문
	END LOOP;
	
	* 반복문을 빠져나갈 수 있는 구문
	1 ) IF 조건식 THEN EXIT; END IF;
	2 ) EXIT WHEN 조건식;
*/

-- ex ) 변수 i가 10이 되면 반복문 종료
DECLARE
	i	NUMBER := 0;
BEGIN
	LOOP
		DBMS_OUTPUT.PUT_LINE(I);
		IF i = 10 THEN EXIT; END IF;
		
		i := i + 1;
	END LOOP;
END;
/


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	2 ) FOR LOOP문
	DECLARE 변수 선언 없이 사용가능한 반복문
	
	[표현식]
	FOR 변수 IN 초기값..최종값
	LOOP
		반복적으로 실행할 문장;
	END LOOP;
*/

-- ex )
-- 1 ) DECLARE 없이 변수 i를 통한 반복문 실행
BEGIN
	FOR i IN 1..5
	LOOP
		DBMS_OUTPUT.PUT_LINE(i);
	END LOOP;
END;
/

-- 2 ) REVERSE로 거꾸로 출력
BEGIN
	FOR i IN REVERSE 1..5
	LOOP
		DBMS_OUTPUT.PUT_LINE(i);
	END LOOP;
END;
/

-- 3 ) test 테이블을 만들어 1부터 100까지 INSERT하는 반복문 작성
DROP TABLE test;

CREATE TABLE test(
	tno	NUMBER	PRIMARY KEY,
	tdate	DATE
);

CREATE SEQUENCE seq_tno;

BEGIN
	FOR i in 1..100
	LOOP
		INSERT INTO test VALUES (seq_tno.NEXTVAL, SYSDATE);
	END LOOP;
END;
/

SELECT * FROM test;


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	3 ) WHILE LOOP
	
	[표현식]
	WHILE 반복문이 실행될 조건
	LOOP
		반복 수행할 작업;
	END LOOP;
*/

-- ex )
DECLARE
	i	NUMBER := 0;
BEGIN
	WHILE i < 10
	LOOP
		DBMS_OUTPUT.PUT_LINE(i);
		i := i + 1;
	END LOOP;
END;
/


--===================================================================================================

/*
	3. 예외처리부
	예외(EXCEPTION) : 실행 중 발생하는 오류
	
	EXCEPTION
		WHEN 예외명1 THEN 처리구문1;
		WHEN 예외명2 THEN 처리구문2;
		...
	
	* 시스템 예외 (오라클에서 미리 정의해 둔 예외)
	- NO_DATE_FOUND : SELECT한 결과가 한 행도 없을 때
	- TOO_MANY_ROWS : SELECT한 결과가 여러 행일 경우
	- ZERO_DIVIDE : 0으로 나눌 때
	- DUP_VAL_ON_INDEX : UNIQUE 제약 조건 위해
*/

-- ex ) 사용자가 입력한 수로 나눗셈한 결과를 출력
DECLARE
	result	NUMBER;
BEGIN
	result := 10/&숫자;
	
	DBMS_OUTPUT.PUT_LINE('결과 : ' || result);
EXCEPTION
	-- WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('나누기 연산 시 0으로 나눌 수 없습니다.');
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('나누기 연산 시 0으로 나눌 수 없습니다.');
END;
/