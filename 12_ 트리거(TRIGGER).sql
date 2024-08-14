/*
	<트리거>
	내가 지정한 테이블에 INSERT, UPDATE, DELETE 등 DML문에 의한 변경사항이 생길 때
	자동으로 매번 실행할 내용을 미리 정의해둘 수 있다.
	
	ex )
	- 회원 탈퇴 시 기존의 회원 테이블에서 데이터를 DELETE한 후, 곧바로 탈퇴한 회원들만 따로 보관하는 테이블에 자동으로 INSERT 시킨다.
	- 신고횟수가 일정 수를 넘겼을 때 묵시적으로 해당 회원을 블랙리스트로 처리한다.
	- 입출고에 대한 데이터 기록(INSERT)이 될 때마다 해당 상품에 대한 재고수량을 매번 수정(UPDATE)한다.
	
	* 트리거의 종류
	- SQL문의 실행시기에 따른 분류
	- BRFORE TRIGGER : 지정한 테이블에 이벤트가 발생되기 전에 트리거를 실행
	- AFTER TRIGGER : 지정한 테이블에 이벤트가 발생된 후 트리거 실행
	
	* SQL문에 의해 영향을 받는 각 행에 따른 종류
	- 문장 트리거 : 이벤트가 발생한 SQL에 대해 딱 한 번만 트리거 실행
	- 행 트리거 : 해당 SQL문을 실행할 때마다 매번 트리거 실행 (FOR EACH ROW 옵션 기술해야함)
		-> OLD : BEFORE UPDATE(수정 전 자료), BEFORE DELETE(삭제 전 자료)
		-> NEW : AFTER INSERT(추가된 자료), AFTER UPDATE(수정 후 자료)
	
	* 트리거 생성 구문
	
	[표현식]
	CREATE [OR REPLACE] TRIGGER 트리거명
	BEFORE | AFTER	INSERT | UPDATE | DELETE	ON 테이블명
	[FOR EACH ROW]
	[DECLARE 변수선언]
	BEGIN
		실행내용(묵시적으로 위에 이벤트가 발생했을 때 실행할 구문);
	[EXCEPTION 예외처리]
	END;
	/
*/

-- ex )
-- [선행 작업] SERVEROUPUT 실행
SET SERVEROUTPUT ON;

-- employee 테이블에 새로운 행이 INSERT 될 때마다 자동으로 문장이 출력되는 트리거 정의
CREATE OR REPLACE TRIGGER trg_01
AFTER INSERT ON employee
BEGIN
	DBMS_OUTPUT.PUT_LINE('신입사원님 안녕하세요.');
END;
/

INSERT INTO employee (emp_id, emp_name, emp_no, dept_code, job_code, hire_date)
VALUES (903, '간장', '111111-1111111', 'D7', 'J7', SYSDATE);


----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 연습 문제
-- 1 ) 상품에 대한 데이터를 보관할 테이블(TB_PRODUCT) 생성
CREATE TABLE tb_product (
	pcode	NUMBER		PRIMARY KEY,
	pname	VARCHAR2(30)	NOT NULL,
	brand		VARCHAR2(30)	NOT NULL,
	price		NUMBER,
	stock		NUMBER DEFAULT 0
);

-- 2 ) 상품번호 중복 안 되게끔 매번 새로운 번호를 발생시키는 시퀀스 생성
CREATE SEQUENCE seq_pcode
START WITH 200
INCREMENT BY 5;

-- 샘플 데이터
INSERT INTO tb_product VALUES (seq_pcode.NEXTVAL, '갤럭시24', '삼성', 1500000, DEFAULT);
INSERT INTO tb_product VALUES (seq_pcode.NEXTVAL, '아이폰15', '애플', 1300000, 10);
INSERT INTO tb_product VALUES (seq_pcode.NEXTVAL, '샤오미8', '샤오미', 800000, 20);

COMMIT;

-- 3 ) 상품 입출고 상세 이력 테이블 생성(TB_PRODETAIL)
CREATE TABLE TB_PRODETAIL (
	decore	NUMBER	PRIMARY KEY,
	pcode	NUMBER	REFERENCE tb_product,
	pdate		DATE			NOT NULL,
	amount	NUMBER	NOT NULL,
	status		CHAR(6)		CHECK (status IN ('입고', '출고'))
);

--