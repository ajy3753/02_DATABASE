/*
	<VIEW 뷰>
	SELECT문(쿼리문)을 저장해둘 수 있는 객체
	자주 사용하는 SELECT문을 저장해두면 긴 SELECT문을 매번 다시 기술할 필요 없이 사용할 수 있다.
	임시 테이블 같은 존재로 실제 데이터가 담겨있는 건 아니다. -> 논리 테이블
	
	1. VIEW 생성방법
	VIEW는 객체이기 때문에 CREATE문으로 만든다.
	
	[표현식]
	CREATE VIEW 뷰명 AS 서브쿼리;
	SELECT * FROM 뷰명;		-> 뷰가 서브쿼리로 실행된다
	CREATE OR REPLACE VIEW 뷰명 AS 서브쿼리;	-> 같은 이름의 뷰가 존재할 때는 덮어쓰기, 없으면 새로 생성
	
	 ※ 계정에 VIEW 생성 권한 주는 법 : GRANT CREATE VIEW TO 계정명;
*/

-- ex )
-- 1 ) 한국에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회하는 뷰 생성
CREATE VIEW VW_EMPLOYEE
AS (
	SELECT emp_id, emp_name, dept_title, salary, national_name FROM employee
	JOIN department ON (dept_code = dept_id)
	JOIN location ON (location_id = local_code)
	JOIN national USING (national_code)
	WHERE national_name = '한국'
);

SELECT * FROM VW_EMPLOYEE;

-- 2 ) 러시아에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS (
	SELECT emp_id, emp_name, dept_title, salary, national_name FROM employee
	JOIN department ON (dept_code = dept_id)
	JOIN location ON (location_id = local_code)
	JOIN national USING (national_code)
	WHERE national_name = '러시아'
);

SELECT * FROM vw_employee;


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	* 뷰 컬럼에 별칭 부여
	서브쿼리의 SELECT절에 함수식이나 산술연산식이 기술되어있다면 반드시 별칭을 부여해야한다.
*/

-- ex ) 컬럼에 별칭을 부여하여 근무년수가 20년 이상인 사원을 조회하는 뷰 생성
CREATE OR REPlACE VIEW VW_EMP_JOB
AS (
	SELECT	emp_id, emp_name, job_name,
				DECODE(SUBSTR(emp_no, 8, 1), '1', '남', '2', '여') AS "성별",
				EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM hire_date) AS "근무년수"
	FROM employee
	JOIN job USING (job_code)
);

SELECT * FROM vw_emp_job WHERE 근무년수 >= 20;


--===================================================================================================

/*
	2. VIEW 삭제
	테이블과 마찬가지로 DROP을 사용한다.
	
	[표현법]
	DROP VIEW 뷰명;
*/

-- ex ) 생성한 뷰 삭제하기
DROP VIEW vw_employee;
DROP VIEW vw_emp_job;

--===================================================================================================

/*
	3. VIEW DML
	생성된 뷰를 통해서 DML(INSERT, UPDATE, DELETE) 사용 가능
	뷰를 통해서 조작하게 되면 실제 데이터가 담겨있는 테이블에 반영된다.
	
	* DML 명령어로 조작이 불가능한 경우
	1 ) 뷰에 정의되어있지 않은 컬럼을 조작하려고 하는 경우
	2 ) 뷰에 정의되어있지 않은 컬럼 중에 베이스테이블 상에 NOT NULL 제약조건이 지정되어있는 경우
	3 ) 산술연산식이나 함수식을 사용한 경우
	4 ) 그룹함수나 GROUP BY 절을 포함한 경우
	5 ) DISTINCT 구문이 포함된 경우
	6 ) JOIN을 이용해서 여러 테이블을 연결 시켜놓은 경우
	
	- 대부분 뷰는 조회를 목적으로 생성된다. 뷰를 통한 DML은 안 쓰는 게 좋다.
*/

-- ex )
CREATE OR REPLACE VIEW vw_job
AS SELECT job_code, job_name FROM job;

-- 1 ) 뷰를 통해 INSERT
INSERT INTO vw_job VALUES ('J8', '인턴');

-- 2 ) 뷰를 통해 UPDATE
UPDATE vw_job SET job_name = '알바' WHERE job_code = 'J8';

-- 3 ) 뷰를 통해 DELETE
DELETE vw_job WHERE job_name = '알바';


--===================================================================================================

/*
	4. VIEW 옵션
	
	[상세표현식]
	CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰명
	AS 서브쿼리
	[WITH CHECK OPTION]
	[WITH READ ONLY];
	
	1 ) OR REPLACE : 기존에 동일한 뷰가 있을 시 내용을 갱신하고, 없을 경우 새로 생성한다.
	2 ) FORCE | NOFORCE
		- FORCE : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 생성되도록 한다.
		- NOFORCE : 서브쿼리에 기술된 테이블이 존재하는 테이블이여야만 한다. (기본값)
	3 ) WITH CHECK OPTION : DML시 서브쿼리에 기술된 조건에 부합한 값으로만 DML이 가능하도록 한다.
	4 ) WITH READ ONLY : 뷰에 대해서 조회만 가능하도록 설정한다.
*/

-- ex )
-- 1 ) FORCE
CREATE OR REPLACE NOFORCE VIEW vw_emp
AS SELECT tcode, tname, tcontent FROM tt;
-- > 테이블이 존재하지 않아 경우 컴파일 오류가 발생한다

-- 2) NOFORCE
CREATE OR REPLACE FORCE VIEW vw_emp
AS SELECT tcode, tname, tcontent FROM tt;
-- > 테이블이 존재하지 않아도 컴파일 오류와 함께 뷰가 생성된다.

-- 3 ) WITH CHECK OPTION
CREATE OR REPLACE VIEW vw_emp
AS (
	SELECT * FROM employee
	WHERE salary >= 30000000
) WITH CHECK OPTION;

UPDATE vw_emp SET salary = 20000000 WHERE emp_id = 200;
-- > 뷰의 서브쿼리 조건에 맞지 않으므로 수정이 되지 않는다

-- 4 ) WITH READ ONYL
CREATE OR REPLACE VIEW vw_emp
AS (
	SELECT emp_id, emp_name, bonus FROM employee
	WHERE bonus iS NOT NULL
) WITH READ ONLY;

SELECT * FROM vw_emp;