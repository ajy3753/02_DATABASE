/*
	[데이터 정의 언어]
	오라클에서 제공하는 객체를 새로 만들고(CREATE), 구조를 변경하고(ALTER), 구조 자체를 삭제(DELETE)하는 언어
	즉, 실제 데이터값이 아닌 규칙 자체를 정의하는 언어.

	오라클에서 객체(구조) : 테이블, 뷰, 시퀀스
								  인덱스, 패키지, 트리거
								  프로시저, 함수, 동의어, 사용자
*/

/*
	<CREATE>
	객체를 새로 생성하는 구문.
	
	1. 테이블 생성
	- 테이블이란 :	행과 열로 구성되는 가장 기본적인 데이터베이스 객체
						모든 데이터들은 테이블을 통해서 저장된다.
						(DBMS 용어 중 하나로, 데이터를 일종의 표 형태로 표현한 것)
						
	[표현식]
	CREATE TABLE 테이블명 (
		컬럼명 자료형(크기),
		컬럼명 자료형(크기),
		컬렴명 자료형,
		...
	);
	
	* 자료형
	- 문자 : CHAR(바이트크기) | VARCHAR2(바이트크기) -> 반드시 크기 지정을 해줘야함
	1) CHAR : 최대 2000 바이트까지 지정 가능 / 고정길이 (고정된 글자 수의 데이터가 담길 경우 사용)
	2) VARCHAR2 : 최대 4000 바이트까지 지정 가능 / 가변길이 (몇 글자의 데이터가 들어올 지 모르는 경우 사용)
	- 숫자 : NUMBER
	- 날짜 : DATE
*/

-- ex ) 회원에 대한 데이터를 담기 위한 테이블 MEMBER 생성
CREATE TABLE MEMBER (
	MEM_NO		NUMBER,
	MEM_ID			VARCHAR2(20),		-- 가변길이
	MEM_PWD		VARCHAR(20),
	MEM_NAME		VARCHAR(20),
	GENDER			CHAR(3),				-- 고정길이
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE
);

SELECT * FROM member;


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	2. 컬럼에 주석달기 (컬럼에 대한 간단한 설명)
	
	[표현법]
	COMMENT ON COLUMN 테이블명.컬러명 IS '주석 내용';
	-> 잘못 작성 시, 새로 수정하면 된다. (덮어쓰기 가능)
*/

-- ex ) MEMBER 테이블의 컬럼에 주석 달기
COMMENT ON COLUMN member.mem_no IS '회원번호';
COMMENT ON COLUMN member.mem_id IS '회원아이디';
COMMENT ON COLUMN member.mem_pwd IS '회원비밀번호';
COMMENT ON COLUMN member.mem_name IS '회원명';
COMMENT ON COLUMN member.gender IS '성별(남/여)';
COMMENT ON COLUMN member.phone IS '전화번호';
COMMENT ON COLUMN member.email IS '이메일';
COMMENT ON COLUMN member.mem_date IS '회원가입일';

/*
	* 테이블을 삭제하고자 할 때 : DROP TABLE 테이블명;
*/

-- ex ) MEMBER 테이블 삭제
DROP TABLE member;

/*
	* 테이블에 데이터를 삽입할 때 : INSERT 사용
	
	[표현법]
	INSERT INTO 테이블명 VALUES(컬럼값1, 컬럼값2, 컬럼값3, ...);
	-> 컬럼값은 테이블의 컬럼 순차대로, 타입에 맞는 값을 입력해야한다.
	-> 중복값이 가능하므로, 같은 SQL문을 실행 시 덮어쓰기가 아니라 새로운 데이터로 삽입된다.
*/

-- ex ) MEMBER 테이블에 데이터 삽입
INSERT INTO member VALUES (1, 'user1', 'pass1', '홍길동', '남', '010-1111-2222', 'hong@gil.com', '24/08/12');


--===================================================================================================

/*
	<제약 조건>
	- 원하는 데이터값(유효한 형식의 값)만 유지하기 위해서 특정 컬럼에 설정하는 제약
	- 데이터 무결성 보장을 목적으로 한다.
	- 제약 조건을 부여하는 방식은 크게 2가지가 있다. (컬럼 레벨 방식, 테이블 레벨 방식)
	
	1) 컬럼 레벨 방식 : 컬럼 생성 시 타입과 제약 조건을 한 번에 선언
	2) 테이블 레벨 방식 : 컬럼을 생성한 후 마지막에 제약 조건을 따로 선언
	
	종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/

/*
	* NOT NULL
	해당 컬럼에 반드시 값이 존재해야만 할 경우 (즉, 절대 NULL이 들어오면 안 되는 경우)
	삽입 / 수정 시 NULL값을 허용하지 않도록 제한.
	NOT NULL 제약 조건은 무조건 컬럼 레벨 방식으로만 가능하다.
*/

-- ex ) 제약 조건이 있는 테이블 MEM_NOTNULL 생성
CREATE TABLE MEM_NOTNULL (
	MEM_NO		NUMBER			NOT NULL,
	MEM_ID			VARCHAR2(20)		NOT NULL,
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20),
	GENDER			CHAR(3),
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE
);

-- NOT NULL 테스트
INSERT INTO mem_notnull VALUES (1, 'user1', 'pass1', '홍길동', '남', '010-1111-2222', 'gill.@dong.net', '24/08/12');
INSERT INTO mem_notnull VALUES (2, 'user2', 'pass2', '심청', NULL, NULL, NULL, NULL);
INSERT INTO mem_notnull VALUES (3, NULL, 'pass3', '놀부', NULL, NULL, NULL, NULL);		-- 의도했던 대로 오류가 발생한다. (NOT NULL 제약 조건 위배)


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	* UNIQUE
	컬럼값에 중복값을 제한하는 제약 조건이다. 해당 컬럼에 중복된 값이 들어가서는 안 될 경우 사용한다.
	삽입 / 수정 시 기존에 있는 데이터값 중 중복값이 있을 경우 오류를 발생시킨다.
*/

-- ex ) 제약 조건이 있는 테이블 MEM_UNIQUE 생성
CREATE TABLE MEM_UNIQUE (
	MEM_NO		NUMBER			NOT NULL,
	MEM_ID			VARCHAR2(20)		NOT NULL	UNIQUE,		-- 제약 조건의 순서는 상관없다
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20),
	GENDER			CHAR(3),
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE
	-- UNIQUE(MEM_ID)	-> 테이블 레벨 방식
);

-- UNIQUE 테스트
INSERT INTO mem_unique VALUES (1, 'user1', 'pass1', '홍길동', '남', '010-1111-2222', 'gill.@dong.net', '24/08/12');
INSERT INTO mem_unique VALUES (2, 'user2', 'pass2', '심청', NULL, NULL, NULL, NULL);
INSERT INTO mem_unique VALUES (3, 'user1', 'pass3', '놀부', '남', '010-1111-2323', 'gamja@bubu.com', '24/08/12');
-- 오류 발생 (UNIQUE 제약 조건 위배)

-- > 오류 조건을 제약 조건명으로 알려준다.
-- > 쉽게 파악하기 어렵다
-- > 제약 조건 부여 시 제약 조건명을 지정할 수 있다. (지정하지 않으면 시스템에서 자동으로 부여한다.)


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	* 제약 조건 부여 시 제약 조건명까지 부여하는 방법
	
	[컬럼 레벨 방식]
	CREATE TABLE 테이블명 (
		컬럼명 자료형 (CONSTRAINT 제약조건명) 제약 조건
	)
	
	[테이블 레벨 방식]
	CREATE TABLE 테이블명 (
		컬럼명 자료형,
		컬럼명 자료형,
		(CONSTRAINT 제약조건명) 제약조건(컬럼명)
	)
	
	-> 괄호는 생략 가능하다.
	-> 생성된 제약조건명은 다른 테이블에서 사용 불가능 (테이블 전체를 통들어 중복 불가능)
*/

-- ex ) 제약 조건명이 있는 테이블 MEM_CONSTRAINT 생성
CREATE TABLE MEM_CONSTRAINT (
	MEM_NO		NUMBER			CONSTRAINT MEMNO_NT		NOT NULL,
	MEM_ID			VARCHAR2(20)		CONSTRAINT MEMID_NT		NOT NULL,
	MEM_PWD		VARCHAR(20)		CONSTRAINT MEMPWD_NT		NOT NULL,
	MEM_NAME		VARCHAR(20)		CONSTRAINT MEMNAME_NT	NOT NULL,
	GENDER			CHAR(3),
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE,
	CONSTRAINT MEMID_UQ UNIQUE(MEM_ID)
);

-- 제약조건명 테스트 (오류 발생 시 해당하는 제약 조건명이 출력)
INSERT INTO mem_constraint VALUES (1, 'user1', 'pass1', '홍길동', '남', '010-1111-2222', 'gill.@dong.net', '24/08/12');
INSERT INTO mem_constraint VALUES (2, NULL, 'pass2', '심청', NULL, NULL, NULL, NULL);
INSERT INTO mem_constraint VALUES (3, 'user1', 'pass3', '놀부', '남', '010-1111-2323', 'gamja@bubu.com', '24/08/12');


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	* CHECK (조건식)
	해당 컬럼에 들어올 수 있는 값에 대한 조건을 제시할 수 있다.
	삽입 / 수정 시 CHECK 조건에 만족하는 데이터값만 담길 수 있다.
	단, NULL은 값이 없다는 뜻이기 때문에 가능하다. (NOT NULL 제약 조건이 있을 시엔 불가능)
*/

-- ex ) MEM_CHECK 테이블 생성
CREATE TABLE MEM_CHECK (
	MEM_NO		NUMBER			NOT NULL,
	MEM_ID			VARCHAR2(20)		NOT NULL,
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20)		NOT NULL,
	GENDER			CHAR(3)				CHECK(GENDER IN ('남', '여')),	-- 남, 여, NULL값만 들어갈 수 있다
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE
);

-- CHECK 테스트
INSERT INTO mem_check VALUES (1, 'user1', 'pass1', '홍길동', '남', '010-1111-2222', 'gill.@dong.net', '24/08/12');
INSERT INTO mem_check VALUES (2, 'user2', 'pass2', '심청', NULL, NULL, NULL, NULL);
INSERT INTO mem_check VALUES (3, 'user3', 'pass3', '놀부', '감', NULL, NULL, NULL);		-- 오류 발생 (CHECK 조건 위배)


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	* PRIMARY KEY (기본키) 제약 조건
	테이블에서 각 행(ROW)을 식별하기위해 사용될 컬럼에 부여하는 제약조건 (식별자 역할)
	한 테이블 당 오직 1개만 설정 가능
	PRIMARY KEY -> NOT NULL + UNIQUE
	
	ex ) 회원번호, 학번, 부서코드, 직급코드, 주민번호, 주문번호, 예약번호 등
*/

-- ex ) MEM_PRI 테이블 생성
CREATE TABLE MEM_PRI (
	MEM_NO		NUMBER			CONSTRAINT MEMNO_OK PRIMARY KEY,
	MEM_ID			VARCHAR2(20)		NOT NULL,
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20)		NOT NULL,
	GENDER			CHAR(3)				CHECK(GENDER IN ('남', '여')),
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE
);

-- PRIMARY KEY 테스트
INSERT INTO mem_pri VALUES (1, 'user1', 'pass1', '홍길동', '남', '010-1111-2222', 'gill.@dong.net', '24/08/12');
INSERT INTO mem_pri VALUES (2, 'user2', 'pass2', '심청', NULL, NULL, NULL, NULL);
INSERT INTO mem_pri VALUES (2, 'user3', 'pass3', '놀부', '남', '010-1111-2323', 'gamja@bubu.com', '24/08/12');	-- 오류 발생 (기본키 위배 - UNIQUE)
INSERT INTO mem_pri VALUES (4, NULL, 'pass4', '팥쥐', '여', '010-8888-8888', NULL, NULL);							-- 오류 발생 (기본키 위배 - NOT NULL)


/*
	* 복합키 : 두 개의 컬럼을 동시에 하나의 PRIMARY KEY로 지정하는 것
	컬럼 1개만 설정했을 때와 다르게 컬럼 두 개를 하나의 기본키로 보기 때문에, 두 값 중 하나만 다를 지라도 다른 값으로 취급한다.
	
	ex )
	(A, B)와 (A, A), (B, A), (B, B)는 모두 다른 값으로 취급한다. (기본키 위배 X)
	(A, B)가 이미 존재하는 상황에서 (A, B)를 또 삽입할 수는 없다. (기본키 위배 O)
*/

-- ex ) MEM_PR2I 테이블 생성
CREATE TABLE MEM_PRI2 (
	MEM_NO		NUMBER,
	MEM_ID			VARCHAR2(20),
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20)		NOT NULL,
	GENDER			CHAR(3)				CHECK(GENDER IN ('남', '여')),
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE,
	PRIMARY KEY(MEM_NO, MEM_ID)
);

-- 복합키 테스트
INSERT INTO mem_pri2 VALUES (1, 'user1', 'pass1', '홍길동', '남', '010-1111-2222', 'gill.@dong.net', '24/08/12');
INSERT INTO mem_pri2 VALUES (2, 'user2', 'pass2', '심청', NULL, NULL, NULL, NULL);
INSERT INTO mem_pri2 VALUES (3, 'user2', 'pass3', '놀부', '남', '010-1111-2323', 'gamja@bubu.com', '24/08/12');
INSERT INTO mem_pri2 VALUES (1, 'user4', 'pass4', '팥쥐', '여', '010-8888-8888', NULL, NULL);
INSERT INTO mem_pri3 VALUES (3, 'user2', 'pass5', '변사또', '남', NULL, NULL, NULL, NULL);		-- 오류 발생 (기본키 위배)


----------------------------------------------------------------------------------------------------------------------------------------------------------------


/*
	* FOREIGN KEY (외래키) 제약 조건
	다른 테이블에 존재하는 값만 들어와야되는 특정 컬럼에 부여하는 제약 조건.
	참조하는 테이블에 존재하는 값만 입력 가능하다.
	-> 주로 FOREIGIN KEY 제약조건으로 인해 테이블간 관계가 형성된다.
	-> 두 테이블의 관계는 1 : N 관계로, 1쪽이 부모 테이블 N이 자식 테이블 (참조되는 쪽이 부모 테이블)
	
	[컬럼 레벨 방식]
	컬럼명 자료형 REFERENCES 참조할 테이블명[참조할 컬럼명]
	
	[테이블 레벨 방식]
	FOREIGN KEY(컬럼명) REFERNECES 참조할 테이블명[참조할 컬럼명]
	
	-> 참조할 컬럼명 생략 시, 참조할 테이블의 PRIMARY KEY로 지정된 컬럼이 자동 매칭된다.
*/

-- ex )
-- 1) 참조할 테이블 MEM_GRADE 생성
CREATE TABLE MEM_GRADE (
	GRADE_CODE	NUMBER			PRIMARY KEY,
	GRADE_NAME	VARCHAR2(15)		NOT NULL
);

INSERT INTO mem_grade VALUES(10, '일반회원');
INSERT INTO mem_grade VALUES(20, '우수회원');
INSERT INTO mem_grade VALUES(30, '최우수회원');

-- 2) MEM_GRADE를 참조하는 MEM_FOR 테이블 생성
CREATE TABLE MEM_FOR (
	MEM_NO		NUMBER			PRIMARY KEY,
	MEM_ID			VARCHAR2(20)		NOT NULL	UNIQUE,
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20)		NOT NULL,
	GENDER			CHAR(3)				CHECK(GENDER IN ('남', '여')),
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE,
	GRADE_ID		NUMBER,
	FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

-- 외래키 테스트
INSERT INTO mem_for VALUES (1, 'user1', 'pass1', '홍길동', '남', '010-1111-2222', 'gill.@dong.net', '24/08/12', NULL);
INSERT INTO mem_for VALUES (2, 'user2', 'pass2', '심청', NULL, NULL, NULL, NULL, NULL);
INSERT INTO mem_for VALUES (3, 'user3', 'pass3', '놀부', '남', '010-1111-2323', 'gamja@bubu.com', '24/08/12', 10);
INSERT INTO mem_for VALUES (4, 'user4', 'pass4', '팥쥐', '여', '010-8888-8888', NULL, NULL, 40);		-- 오류 발생 (FOREIGIN KEY 존재하지 않음)


/*
	-> 자식 테이블에서 이미 사용하고 있는 값이 있을 경우,
	-> 부모 테이블에 해당 컬럼값의 삭제가 불가능한 "삭제 제한" 옵션이 걸려있다.
	
	* 삭제 옵션
	자식 테이블 생성 시 외래키 제약 조건을 부여하면서 삭제 옵션 지정 가능
	
	- ON DELETE RESTRICTED (기본값) : 삭제 제한 옵션, 자식 데이터로부터 쓰이는 부모 데이터는 삭제 불가능
	- ON DELETE SET NULL : 부모 데이터 삭제 시 해당 데이터를 사용하고 있는 자식 데이터의 해당 컬럼값을 NULL로 변경
	- ON DELETE CASCADE : 부모 데이터 삭제 시 해당 데이터를 사용하고 있는 자식 데이터도 같이 전부 삭제
*/

-- ex )
DELETE FROM mem_grade WHERE grade_code = 10;		-- MEM_FOR 테이블에서 10이라는 값을 참조하여 사용하고 있기 때문에 삭제 불가능

-- 1 ) ON DELETE SET NULL
-- 삭제 옵션이 있는 MEM_FOR 테이블을 삭제 후 새로 생성
DROP TABLE mem_for;

CREATE TABLE MEM_FOR (
	MEM_NO		NUMBER			PRIMARY KEY,
	MEM_ID			VARCHAR2(20)		NOT NULL	UNIQUE,
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20)		NOT NULL,
	GENDER			CHAR(3)				CHECK(GENDER IN ('남', '여')),
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE,
	GRADE_ID		NUMBER,
	FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
);

INSERT INTO mem_for VALUES (1, 'user1', 'pass1', '홍길동', '남', '010-1111-2222', 'gill.@dong.net', '24/08/12', NULL);
INSERT INTO mem_for VALUES (2, 'user2', 'pass2', '심청', NULL, NULL, NULL, NULL, 30);
INSERT INTO mem_for VALUES (3, 'user3', 'pass3', '놀부', '남', '010-1111-2323', 'gamja@bubu.com', '24/08/12', 20);
INSERT INTO mem_for VALUES (4, 'user4', 'pass4', '팥쥐', '여', '010-8888-8888', NULL, NULL, 10);

-- 삭제 옵션 테스트
DELETE FROM mem_grade WHERE grade_code = 10;
SELECT * FROM mem_for;		-- GRADE_CODE에 10값을 가지고 있던 '팥쥐'의 GRADE_CODE 값이 NULL로 변경

-- 2 ) ON DELETE CASCADE
-- MEM_GRADE와 MEM_FOr 테이블을 새로 생성
INSERT INTO mem_grade VALUES(10, '일반회원');
DROP TABLE mem_for;

CREATE TABLE MEM_FOR (
	MEM_NO		NUMBER			PRIMARY KEY,
	MEM_ID			VARCHAR2(20)		NOT NULL	UNIQUE,
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20)		NOT NULL,
	GENDER			CHAR(3)				CHECK(GENDER IN ('남', '여')),
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE,
	GRADE_ID		NUMBER,
	FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO mem_for VALUES (1, 'user1', 'pass1', '홍길동', '남', '010-1111-2222', 'gill.@dong.net', '24/08/12', NULL);
INSERT INTO mem_for VALUES (2, 'user2', 'pass2', '심청', NULL, NULL, NULL, NULL, 30);
INSERT INTO mem_for VALUES (3, 'user3', 'pass3', '놀부', '남', '010-1111-2323', 'gamja@bubu.com', '24/08/12', 20);
INSERT INTO mem_for VALUES (4, 'user4', 'pass4', '팥쥐', '여', '010-8888-8888', NULL, NULL, 10);

-- 삭제 옵션 테스트
DELETE FROM mem_grade WHERE grade_code = 10;
SELECT * FROM mem_for;	-- GRADE_CODE에 10값을 가지고 있던 '팥쥐'의 값이 전부 삭제


--===================================================================================================

/*
	<DEFAULT 기본값>
	컬럼을 선정하지 않고 INSERT 시 NULL이 아닌 기본값을 INSERT 하고자 할 때, 세팅해 둘 수 있는 값.
	(제약 조건은 아니므로, 제약 조건의 앞쪽에 작성한다.)
	
	[표현법]
	컬럼명 자료형 DEFAULR 기본값
*/

-- ex ) MEM_DEF 테이블 생성
CREATE TABLE MEM_DEF (
	MEM_NO		NUMBER			PRIMARY KEY,
	MEM_NAME		VARCHAR2(20)		NOT NULL,
	MEM_AGE		NUMBER,
	HOBBY			VARCHAR2(20)		DEFAULT '없음',
	ENROLLDATE	DATE					DEFAULT SYSDATE
);

-- 기본값 테스트
INSERT INTO mem_def VALUES (1, '홍길동', 30, '도둑질', '19/08/06');
INSERT INTO mem_def VALUES (2, '심청', 15, NULL, NULL);
INSERT INTO mem_def VALUES (3, '놀부', 45, DEFAULT, DEFAULT);	-- 기본값으로 설정해둔 값이 자동으로 들어간다.
INSERT INTO mem_def (mem_no, mem_name) VALUES (4, '팥쥐');		-- 선택하지 않은 컬럼에는 NULL, 기본값이 설정된 컬럼에는 기본값이 들어간다.


--===================================================================================================

/*
	<테이블 복제 방법>
	CREATE문을 사용하면서 복사할 테이블과 데이터를 선택해 복사할 수 있다.
	
	[표현법]
	CREATE TABLE 테이블명 AS (복사할 테이블 데이터 SELECT문);
*/

-- ex ) EMPLOYEE 테이블 복사
CREATE TABLE EMPLOYEE_COPY AS (SELECT * FROM employee);


--===================================================================================================

/*
	<테이블 수정>
	
	1. 테이블이 다 생성된 후에 뒤늦게 제약조건을 추가하는 방법
	ALTER TABLE 테이블명 변경할내용
	
	- PRIMARY KEY : ALTER TALBE 테이블명 ADD PRIMARY KEY(컬럼명);
	- FOREIGN KEY : ALTER TABLE 테이블명 ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[컬럼명];
	- UNIQUE : ALTER TABLE 테이블명 ADD UNIQUE(컬럼명);
	- CHECK : ALTER TALBE 테이블명 ADD CHECK(컬럼에 대한 조건식);
	- NOT NULL : ALTER TABLE 테이블명 NODIFY 컬럼명 NOT NULL;
*/

-- ex )
ALTER TABLE employee ADD FOREIGN KEY(dept_code) REFERENCES department;
ALTER TABLE employee ADD MODIFY emp_no NOT NULL;		-- 이미 NOT NULL 조건이 설정되어있기에 오류 발생