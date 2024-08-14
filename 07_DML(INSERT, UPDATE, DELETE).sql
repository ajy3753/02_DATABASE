/*
	DQL (QUERY 데이터 정의어) : SELECT
	DML (MANIPULATION 데이터 조작어) : INSERT, UPDATE, DELETE
	DDL (DEFINITION 데이터 정의어) : CREATE, ALTER, DROP
	DCL (CONTROL 데이터 제어어) : GRANT, REVOKE
	TCL (TRANSACTION 트랜잭션 제어어) : COMMIT, ROLLBACK
	
	<DML>
	데이터 조작 언어
	테이블 값을 삽입(INSERT), 수정(UPDATE), 삭제(DELETE) 하는 구문
*/

/*
	1. INSERT
	테이블에 새로운 행을 추가하는 구문
	
	[표현식]
	1 ) INSERT INTO 테이블명 VALUES (값, 값, 값 ...... );
	테이블의 모든 컬럼에 대한 값을 직접 제시해서 한 행을 INSERT 하고자 할 때
	컬럼의 순번을 지켜서 VALUES에 맞는 타입의 값을 나열해야함
	-> 부족하게 값을 제시하거나, 값을 더 많이 제시한 경우 에러 발생
	
	2 ) INSERT INTO 테이블명 (컬럼, 컬럼, 컬럼 ... ) VALUES (값, 값, 값 ...);
	테이블에 내가 선택한 컬럼에 대한 값만 INSERT할 때 사용
	그래도 한 행 단위로 추가되기 때문에 선택 안 된 컬럼은 기본적으로 NULL이 들어감
	-> NOT NULL 제약 조건이 있는 컬럼은 오류가 발생하므로, 반드시 값을 넣어주어야 한다.
	-> 기본값이 지정되어 있으면 NULL이 아닌 기본값이 들어감
*/

-- ex )
-- 1 ) 전체 컬럼값 INSERT
INSERT INTO employee VALUES (900, '소금', '880919-1234567', 'LAVYYY@NICO.COM', '01012345678', 'D7', 'J5', 4000000, 0.2, 200, SYSDATE, NULL, 'N');
-- 2 ) 일부 컬럼값 INSERT
INSERT INTO employee (emp_id, emp_name, emp_no, job_code, hire_date) VALUES (901, '설탕', '440701-1234567', 'J7', SYSDATE);

SELECT * FROM employee;


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	3 ) INSERT INTO 테이블명 (서브쿼리);
	VALUES에 직접 값을 명시하는 것 대신 서브쿼리로 조회된 값을 통째로 INSERT 가능
*/

-- ex ) EMP_01 테이블을 만들어 서브쿼리로 데이터 INSERT
CREATE TABLE EMP_01 (
	EMP_ID		NUMBER,
	EMP_NAME	VARCHAR2(20),
	DEPT_TITLE	VARCHAR2(20)
);

INSERT INTO emp_01 (SELECT emp_id, emp_name, dept_title FROM employee LEFT JOIN department ON (dept_code = dept_id));

SELECT * FROM emp_01;


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	2. INSERT ALL
	두 개 이상의 테이블에 각각 INSERT 할 때
	이때 사용되는 서브쿼리가 동일한 경우
	
	[표현식]
	INSERT ALL
	INTO 테이블명1 VALUES (컬럼, 컬럼, 컬럼 ... )
	VALUES (값, 값, 값 ... )
	서브쿼리;
*/

-- ex )
-- 1 ) EMPLOYEE 테이블 컬럼을 복사한 EMP_DEPT, EMP_MANAGER 테이블 생성
CREATE TABLE EMP_DEPT
AS (
	SELECT emp_id, emp_name, dept_code, hire_date
	FROM employee
	WHERE 1 = 0
);

CREATE TABLE EMP_MANAGER
AS (
	SELECT emp_id, emp_name, manager_id
	FROM employee
	WHERE 1 = 0
);

-- 2 ) 서브쿼리를 이용하여 두 테이블에 동시에 INSERT
INSERT ALL
	INTO emp_dept VALUES (emp_id, emp_name, dept_code, hire_date)
	INTO emp_manager VALUES (emp_id, emp_name, manager_id)
		(
			SELECT emp_id, emp_name, dept_code, hire_date, manager_id
			FROM employee
			WHERE dept_code = 'D1'
		);
		
SELECT * FROM emp_dept;
SELECT * FROM emp_manager;


--===================================================================================================

/*
	3. UPDATE
	테이블에 기록되어있는 기존의 데이터를 수정하는 구문
	
	[표현법]
	UPDATE 테이블멸 SET 컬럼 = '값';
	
	[WHERE 조건] -> 생략 시 전체 모든 행의 데이터가 변경
	※ UPDATE 시에도 제약 조건을 잘 확인해야 한다.
*/

-- ex )
CREATE TABLE DEPT_TABLE
AS (SELECT * FROM department);

UPDATE dept_table
SET dept_title = '전략기획팀'
WHERE dept_id = 'D9';


--===================================================================================================

/*
	3 ) 컬럼 / 제약조건명 / 테이블명 변경
	
	- 컬럼명 변경 : RENAME COLUMN 기존 컬럼명 TO 바꿀 컬럼명
	
	- 제약 조건명 변경 : RENAME CONSTRAINT 기존 제약 조건명 TO 바꿀 제약 조건명
	
	- 테이블명 변경 : RENAME TO 바꿀테이블명
*/

----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	TRUNCATE : 테이블 초기화
*/