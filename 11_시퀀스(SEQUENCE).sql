/*
	<시퀀스 SEQUENCE>
	자동으로 번호를 발생시켜주는 역할을 하는 객체
	정수값을 순차적으로 일정하게 증가시키면서 생성해준다.
	
	ex ) 회원번호, 사원번호, 게시글 번호 등
*/

/*
	1. 시퀀스 객체 생성
	
	[표현식]
	CREATE SEQUENCE 시퀀스명
	[START WITH 시작숫자]	-> 처음 발생시킬 시작값 지정 (기본값 1)
	[INCREMENT BY 숫자] 	-> 몇 씩 증가시킬 건지 지정 (기본값 1)
	[MAXVALUE 숫자]			-> 최대값 지정 (기본값이 있으나 매우 크므로 고려X)
	[MINVALUE 숫자]			-> 최소값 지정 (기본값 1)
	[CYCLE | NOCYCLE]		-> 값 순환 여부 (기본값 NOCYCEL)
	[CACHE | NOCACHE]		-> 캐시 메모리 할당 (기본값 CACHE 20)
	
	* 캐시 메모리
	미리 발생될 값들을 생성해서 저장해두는 공간
	매번 호출될 때마다 새로운 번호를 생성하는 게 아니라 캐시 메모리 공간에 미리 생성된 값들을 가져다 쓸 수 있다. (속도가 빨라진다.)
	
	* 자주 쓰는 약어
	- 테이블명 : TB_
	- 시퀀스 : SEQ_
	- 트리거 : TRG_
*/

-- ex )
CREATE SEQUENCE seq_test;

CREATE SEQUENCE seq_empno
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

-- [참고] 현재 계정이 소유한 시퀀스들의 구조를 보고 싶을 때
SELECT * FROM user_sequences;


--===================================================================================================

/*
	2. 시퀀스 사용
	
	시퀀스명.CURRVAL : 현재 시퀀스 값 (마지막으로 성공한 NEXTVAL의 수행값)
	시퀀스명.NEXTVAL : 시컨스값에 일정한 값을 증가시켜 발생한 값 (현재 시퀀스 값에 INCREMENT BY 값만큼 증가한 값)
*/

-- ex )
SELECT seq_empno.CURRVAL FROM dual;
-- > NEXTVAL을 한 번도 수행하지 않은 상태로 CURRVAL을 사용할 수 없음
-- > CURRVAL은 마지막으로 성공한 NEXTVAL의 값을 저장해서 보여주는 임시값이기 때문

SELECT seq_empno.NEXTVAL FROM dual;	-- 300
SELECT seq_empno.NEXTVAL FROM dual;	-- 305
SELECT seq_empno.NEXTVAL FROM dual;	-- 310
SELECT seq_empno.NEXTVAL FROM dual;	-- 315로 최대값 310을 넘겨, 오류 발생

SELECT seq_empno.CURRVAL FROM dual;	-- 저장된 값은 최대값인 310 (최대값을 넘긴 NEXTVAL은 실행X)

--===================================================================================================

/*
	3. 시퀀스의 구조 변경
	
	ALTER SEQUENCE 시퀀스명
	[INCREMENT BY 숫자]
	[MAXVALUE 숫자]
	[MINVALUE 숫자]
	[CYCLE | NOCYCLE]
	[CACHE 바이트크기 | NOCACHE]
	
	* START WITH은 변경 불가
*/

ALTER SEQUENCE seq_empno
INCREMENT BY 10
MAXVALUE 400;

SELECT seq_empno.NEXTVAL FROM dual;


--===================================================================================================

/*
	4. 시퀀스 삭제
	
	[표현법]
	DROP SEQUENCE 시퀀스명;
*/

-- ex )
DROP SEQUENCE seq_empno;