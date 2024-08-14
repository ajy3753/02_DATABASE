/*
	[������ ���� ���]
	����Ŭ���� �����ϴ� ��ü�� ���� �����(CREATE), ������ �����ϰ�(ALTER), ���� ��ü�� ����(DELETE)�ϴ� ���
	��, ���� �����Ͱ��� �ƴ� ��Ģ ��ü�� �����ϴ� ���.

	����Ŭ���� ��ü(����) : ���̺�, ��, ������
								  �ε���, ��Ű��, Ʈ����
								  ���ν���, �Լ�, ���Ǿ�, �����
*/

/*
	<CREATE>
	��ü�� ���� �����ϴ� ����.
	
	1. ���̺� ����
	- ���̺��̶� :	��� ���� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
						��� �����͵��� ���̺��� ���ؼ� ����ȴ�.
						(DBMS ��� �� �ϳ���, �����͸� ������ ǥ ���·� ǥ���� ��)
						
	[ǥ����]
	CREATE TABLE ���̺�� (
		�÷��� �ڷ���(ũ��),
		�÷��� �ڷ���(ũ��),
		�÷Ÿ� �ڷ���,
		...
	);
	
	* �ڷ���
	- ���� : CHAR(����Ʈũ��) | VARCHAR2(����Ʈũ��) -> �ݵ�� ũ�� ������ �������
	1) CHAR : �ִ� 2000 ����Ʈ���� ���� ���� / �������� (������ ���� ���� �����Ͱ� ��� ��� ���)
	2) VARCHAR2 : �ִ� 4000 ����Ʈ���� ���� ���� / �������� (�� ������ �����Ͱ� ���� �� �𸣴� ��� ���)
	- ���� : NUMBER
	- ��¥ : DATE
*/

-- ex ) ȸ���� ���� �����͸� ��� ���� ���̺� MEMBER ����
CREATE TABLE MEMBER (
	MEM_NO		NUMBER,
	MEM_ID			VARCHAR2(20),		-- ��������
	MEM_PWD		VARCHAR(20),
	MEM_NAME		VARCHAR(20),
	GENDER			CHAR(3),				-- ��������
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE
);

SELECT * FROM member;


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	2. �÷��� �ּ��ޱ� (�÷��� ���� ������ ����)
	
	[ǥ����]
	COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ� ����';
	-> �߸� �ۼ� ��, ���� �����ϸ� �ȴ�. (����� ����)
*/

-- ex ) MEMBER ���̺��� �÷��� �ּ� �ޱ�
COMMENT ON COLUMN member.mem_no IS 'ȸ����ȣ';
COMMENT ON COLUMN member.mem_id IS 'ȸ�����̵�';
COMMENT ON COLUMN member.mem_pwd IS 'ȸ����й�ȣ';
COMMENT ON COLUMN member.mem_name IS 'ȸ����';
COMMENT ON COLUMN member.gender IS '����(��/��)';
COMMENT ON COLUMN member.phone IS '��ȭ��ȣ';
COMMENT ON COLUMN member.email IS '�̸���';
COMMENT ON COLUMN member.mem_date IS 'ȸ��������';

/*
	* ���̺��� �����ϰ��� �� �� : DROP TABLE ���̺��;
*/

-- ex ) MEMBER ���̺� ����
DROP TABLE member;

/*
	* ���̺� �����͸� ������ �� : INSERT ���
	
	[ǥ����]
	INSERT INTO ���̺�� VALUES(�÷���1, �÷���2, �÷���3, ...);
	-> �÷����� ���̺��� �÷� �������, Ÿ�Կ� �´� ���� �Է��ؾ��Ѵ�.
	-> �ߺ����� �����ϹǷ�, ���� SQL���� ���� �� ����Ⱑ �ƴ϶� ���ο� �����ͷ� ���Եȴ�.
*/

-- ex ) MEMBER ���̺� ������ ����
INSERT INTO member VALUES (1, 'user1', 'pass1', 'ȫ�浿', '��', '010-1111-2222', 'hong@gil.com', '24/08/12');


--===================================================================================================

/*
	<���� ����>
	- ���ϴ� �����Ͱ�(��ȿ�� ������ ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
	- ������ ���Ἲ ������ �������� �Ѵ�.
	- ���� ������ �ο��ϴ� ����� ũ�� 2������ �ִ�. (�÷� ���� ���, ���̺� ���� ���)
	
	1) �÷� ���� ��� : �÷� ���� �� Ÿ�԰� ���� ������ �� ���� ����
	2) ���̺� ���� ��� : �÷��� ������ �� �������� ���� ������ ���� ����
	
	���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/

/*
	* NOT NULL
	�ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ��� (��, ���� NULL�� ������ �� �Ǵ� ���)
	���� / ���� �� NULL���� ������� �ʵ��� ����.
	NOT NULL ���� ������ ������ �÷� ���� ������θ� �����ϴ�.
*/

-- ex ) ���� ������ �ִ� ���̺� MEM_NOTNULL ����
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

-- NOT NULL �׽�Ʈ
INSERT INTO mem_notnull VALUES (1, 'user1', 'pass1', 'ȫ�浿', '��', '010-1111-2222', 'gill.@dong.net', '24/08/12');
INSERT INTO mem_notnull VALUES (2, 'user2', 'pass2', '��û', NULL, NULL, NULL, NULL);
INSERT INTO mem_notnull VALUES (3, NULL, 'pass3', '���', NULL, NULL, NULL, NULL);		-- �ǵ��ߴ� ��� ������ �߻��Ѵ�. (NOT NULL ���� ���� ����)


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	* UNIQUE
	�÷����� �ߺ����� �����ϴ� ���� �����̴�. �ش� �÷��� �ߺ��� ���� ������ �� �� ��� ����Ѵ�.
	���� / ���� �� ������ �ִ� �����Ͱ� �� �ߺ����� ���� ��� ������ �߻���Ų��.
*/

-- ex ) ���� ������ �ִ� ���̺� MEM_UNIQUE ����
CREATE TABLE MEM_UNIQUE (
	MEM_NO		NUMBER			NOT NULL,
	MEM_ID			VARCHAR2(20)		NOT NULL	UNIQUE,		-- ���� ������ ������ �������
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20),
	GENDER			CHAR(3),
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE
	-- UNIQUE(MEM_ID)	-> ���̺� ���� ���
);

-- UNIQUE �׽�Ʈ
INSERT INTO mem_unique VALUES (1, 'user1', 'pass1', 'ȫ�浿', '��', '010-1111-2222', 'gill.@dong.net', '24/08/12');
INSERT INTO mem_unique VALUES (2, 'user2', 'pass2', '��û', NULL, NULL, NULL, NULL);
INSERT INTO mem_unique VALUES (3, 'user1', 'pass3', '���', '��', '010-1111-2323', 'gamja@bubu.com', '24/08/12');
-- ���� �߻� (UNIQUE ���� ���� ����)

-- > ���� ������ ���� ���Ǹ����� �˷��ش�.
-- > ���� �ľ��ϱ� ��ƴ�
-- > ���� ���� �ο� �� ���� ���Ǹ��� ������ �� �ִ�. (�������� ������ �ý��ۿ��� �ڵ����� �ο��Ѵ�.)


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	* ���� ���� �ο� �� ���� ���Ǹ���� �ο��ϴ� ���
	
	[�÷� ���� ���]
	CREATE TABLE ���̺�� (
		�÷��� �ڷ��� (CONSTRAINT �������Ǹ�) ���� ����
	)
	
	[���̺� ���� ���]
	CREATE TABLE ���̺�� (
		�÷��� �ڷ���,
		�÷��� �ڷ���,
		(CONSTRAINT �������Ǹ�) ��������(�÷���)
	)
	
	-> ��ȣ�� ���� �����ϴ�.
	-> ������ �������Ǹ��� �ٸ� ���̺��� ��� �Ұ��� (���̺� ��ü�� ���� �ߺ� �Ұ���)
*/

-- ex ) ���� ���Ǹ��� �ִ� ���̺� MEM_CONSTRAINT ����
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

-- �������Ǹ� �׽�Ʈ (���� �߻� �� �ش��ϴ� ���� ���Ǹ��� ���)
INSERT INTO mem_constraint VALUES (1, 'user1', 'pass1', 'ȫ�浿', '��', '010-1111-2222', 'gill.@dong.net', '24/08/12');
INSERT INTO mem_constraint VALUES (2, NULL, 'pass2', '��û', NULL, NULL, NULL, NULL);
INSERT INTO mem_constraint VALUES (3, 'user1', 'pass3', '���', '��', '010-1111-2323', 'gamja@bubu.com', '24/08/12');


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	* CHECK (���ǽ�)
	�ش� �÷��� ���� �� �ִ� ���� ���� ������ ������ �� �ִ�.
	���� / ���� �� CHECK ���ǿ� �����ϴ� �����Ͱ��� ��� �� �ִ�.
	��, NULL�� ���� ���ٴ� ���̱� ������ �����ϴ�. (NOT NULL ���� ������ ���� �ÿ� �Ұ���)
*/

-- ex ) MEM_CHECK ���̺� ����
CREATE TABLE MEM_CHECK (
	MEM_NO		NUMBER			NOT NULL,
	MEM_ID			VARCHAR2(20)		NOT NULL,
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20)		NOT NULL,
	GENDER			CHAR(3)				CHECK(GENDER IN ('��', '��')),	-- ��, ��, NULL���� �� �� �ִ�
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE
);

-- CHECK �׽�Ʈ
INSERT INTO mem_check VALUES (1, 'user1', 'pass1', 'ȫ�浿', '��', '010-1111-2222', 'gill.@dong.net', '24/08/12');
INSERT INTO mem_check VALUES (2, 'user2', 'pass2', '��û', NULL, NULL, NULL, NULL);
INSERT INTO mem_check VALUES (3, 'user3', 'pass3', '���', '��', NULL, NULL, NULL);		-- ���� �߻� (CHECK ���� ����)


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	* PRIMARY KEY (�⺻Ű) ���� ����
	���̺��� �� ��(ROW)�� �ĺ��ϱ����� ���� �÷��� �ο��ϴ� �������� (�ĺ��� ����)
	�� ���̺� �� ���� 1���� ���� ����
	PRIMARY KEY -> NOT NULL + UNIQUE
	
	ex ) ȸ����ȣ, �й�, �μ��ڵ�, �����ڵ�, �ֹι�ȣ, �ֹ���ȣ, �����ȣ ��
*/

-- ex ) MEM_PRI ���̺� ����
CREATE TABLE MEM_PRI (
	MEM_NO		NUMBER			CONSTRAINT MEMNO_OK PRIMARY KEY,
	MEM_ID			VARCHAR2(20)		NOT NULL,
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20)		NOT NULL,
	GENDER			CHAR(3)				CHECK(GENDER IN ('��', '��')),
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE
);

-- PRIMARY KEY �׽�Ʈ
INSERT INTO mem_pri VALUES (1, 'user1', 'pass1', 'ȫ�浿', '��', '010-1111-2222', 'gill.@dong.net', '24/08/12');
INSERT INTO mem_pri VALUES (2, 'user2', 'pass2', '��û', NULL, NULL, NULL, NULL);
INSERT INTO mem_pri VALUES (2, 'user3', 'pass3', '���', '��', '010-1111-2323', 'gamja@bubu.com', '24/08/12');	-- ���� �߻� (�⺻Ű ���� - UNIQUE)
INSERT INTO mem_pri VALUES (4, NULL, 'pass4', '����', '��', '010-8888-8888', NULL, NULL);							-- ���� �߻� (�⺻Ű ���� - NOT NULL)


/*
	* ����Ű : �� ���� �÷��� ���ÿ� �ϳ��� PRIMARY KEY�� �����ϴ� ��
	�÷� 1���� �������� ���� �ٸ��� �÷� �� ���� �ϳ��� �⺻Ű�� ���� ������, �� �� �� �ϳ��� �ٸ� ���� �ٸ� ������ ����Ѵ�.
	
	ex )
	(A, B)�� (A, A), (B, A), (B, B)�� ��� �ٸ� ������ ����Ѵ�. (�⺻Ű ���� X)
	(A, B)�� �̹� �����ϴ� ��Ȳ���� (A, B)�� �� ������ ���� ����. (�⺻Ű ���� O)
*/

-- ex ) MEM_PR2I ���̺� ����
CREATE TABLE MEM_PRI2 (
	MEM_NO		NUMBER,
	MEM_ID			VARCHAR2(20),
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20)		NOT NULL,
	GENDER			CHAR(3)				CHECK(GENDER IN ('��', '��')),
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE,
	PRIMARY KEY(MEM_NO, MEM_ID)
);

-- ����Ű �׽�Ʈ
INSERT INTO mem_pri2 VALUES (1, 'user1', 'pass1', 'ȫ�浿', '��', '010-1111-2222', 'gill.@dong.net', '24/08/12');
INSERT INTO mem_pri2 VALUES (2, 'user2', 'pass2', '��û', NULL, NULL, NULL, NULL);
INSERT INTO mem_pri2 VALUES (3, 'user2', 'pass3', '���', '��', '010-1111-2323', 'gamja@bubu.com', '24/08/12');
INSERT INTO mem_pri2 VALUES (1, 'user4', 'pass4', '����', '��', '010-8888-8888', NULL, NULL);
INSERT INTO mem_pri3 VALUES (3, 'user2', 'pass5', '�����', '��', NULL, NULL, NULL, NULL);		-- ���� �߻� (�⺻Ű ����)


----------------------------------------------------------------------------------------------------------------------------------------------------------------


/*
	* FOREIGN KEY (�ܷ�Ű) ���� ����
	�ٸ� ���̺� �����ϴ� ���� ���;ߵǴ� Ư�� �÷��� �ο��ϴ� ���� ����.
	�����ϴ� ���̺� �����ϴ� ���� �Է� �����ϴ�.
	-> �ַ� FOREIGIN KEY ������������ ���� ���̺� ���谡 �����ȴ�.
	-> �� ���̺��� ����� 1 : N �����, 1���� �θ� ���̺� N�� �ڽ� ���̺� (�����Ǵ� ���� �θ� ���̺�)
	
	[�÷� ���� ���]
	�÷��� �ڷ��� REFERENCES ������ ���̺��[������ �÷���]
	
	[���̺� ���� ���]
	FOREIGN KEY(�÷���) REFERNECES ������ ���̺��[������ �÷���]
	
	-> ������ �÷��� ���� ��, ������ ���̺��� PRIMARY KEY�� ������ �÷��� �ڵ� ��Ī�ȴ�.
*/

-- ex )
-- 1) ������ ���̺� MEM_GRADE ����
CREATE TABLE MEM_GRADE (
	GRADE_CODE	NUMBER			PRIMARY KEY,
	GRADE_NAME	VARCHAR2(15)		NOT NULL
);

INSERT INTO mem_grade VALUES(10, '�Ϲ�ȸ��');
INSERT INTO mem_grade VALUES(20, '���ȸ��');
INSERT INTO mem_grade VALUES(30, '�ֿ��ȸ��');

-- 2) MEM_GRADE�� �����ϴ� MEM_FOR ���̺� ����
CREATE TABLE MEM_FOR (
	MEM_NO		NUMBER			PRIMARY KEY,
	MEM_ID			VARCHAR2(20)		NOT NULL	UNIQUE,
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20)		NOT NULL,
	GENDER			CHAR(3)				CHECK(GENDER IN ('��', '��')),
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE,
	GRADE_ID		NUMBER,
	FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

-- �ܷ�Ű �׽�Ʈ
INSERT INTO mem_for VALUES (1, 'user1', 'pass1', 'ȫ�浿', '��', '010-1111-2222', 'gill.@dong.net', '24/08/12', NULL);
INSERT INTO mem_for VALUES (2, 'user2', 'pass2', '��û', NULL, NULL, NULL, NULL, NULL);
INSERT INTO mem_for VALUES (3, 'user3', 'pass3', '���', '��', '010-1111-2323', 'gamja@bubu.com', '24/08/12', 10);
INSERT INTO mem_for VALUES (4, 'user4', 'pass4', '����', '��', '010-8888-8888', NULL, NULL, 40);		-- ���� �߻� (FOREIGIN KEY �������� ����)


/*
	-> �ڽ� ���̺��� �̹� ����ϰ� �ִ� ���� ���� ���,
	-> �θ� ���̺� �ش� �÷����� ������ �Ұ����� "���� ����" �ɼ��� �ɷ��ִ�.
	
	* ���� �ɼ�
	�ڽ� ���̺� ���� �� �ܷ�Ű ���� ������ �ο��ϸ鼭 ���� �ɼ� ���� ����
	
	- ON DELETE RESTRICTED (�⺻��) : ���� ���� �ɼ�, �ڽ� �����ͷκ��� ���̴� �θ� �����ʹ� ���� �Ұ���
	- ON DELETE SET NULL : �θ� ������ ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽ� �������� �ش� �÷����� NULL�� ����
	- ON DELETE CASCADE : �θ� ������ ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽ� �����͵� ���� ���� ����
*/

-- ex )
DELETE FROM mem_grade WHERE grade_code = 10;		-- MEM_FOR ���̺��� 10�̶�� ���� �����Ͽ� ����ϰ� �ֱ� ������ ���� �Ұ���

-- 1 ) ON DELETE SET NULL
-- ���� �ɼ��� �ִ� MEM_FOR ���̺��� ���� �� ���� ����
DROP TABLE mem_for;

CREATE TABLE MEM_FOR (
	MEM_NO		NUMBER			PRIMARY KEY,
	MEM_ID			VARCHAR2(20)		NOT NULL	UNIQUE,
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20)		NOT NULL,
	GENDER			CHAR(3)				CHECK(GENDER IN ('��', '��')),
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE,
	GRADE_ID		NUMBER,
	FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
);

INSERT INTO mem_for VALUES (1, 'user1', 'pass1', 'ȫ�浿', '��', '010-1111-2222', 'gill.@dong.net', '24/08/12', NULL);
INSERT INTO mem_for VALUES (2, 'user2', 'pass2', '��û', NULL, NULL, NULL, NULL, 30);
INSERT INTO mem_for VALUES (3, 'user3', 'pass3', '���', '��', '010-1111-2323', 'gamja@bubu.com', '24/08/12', 20);
INSERT INTO mem_for VALUES (4, 'user4', 'pass4', '����', '��', '010-8888-8888', NULL, NULL, 10);

-- ���� �ɼ� �׽�Ʈ
DELETE FROM mem_grade WHERE grade_code = 10;
SELECT * FROM mem_for;		-- GRADE_CODE�� 10���� ������ �ִ� '����'�� GRADE_CODE ���� NULL�� ����

-- 2 ) ON DELETE CASCADE
-- MEM_GRADE�� MEM_FOr ���̺��� ���� ����
INSERT INTO mem_grade VALUES(10, '�Ϲ�ȸ��');
DROP TABLE mem_for;

CREATE TABLE MEM_FOR (
	MEM_NO		NUMBER			PRIMARY KEY,
	MEM_ID			VARCHAR2(20)		NOT NULL	UNIQUE,
	MEM_PWD		VARCHAR(20)		NOT NULL,
	MEM_NAME		VARCHAR(20)		NOT NULL,
	GENDER			CHAR(3)				CHECK(GENDER IN ('��', '��')),
	PHONE			VARCHAR(13),
	EMAIL				VARCHAR(50),
	MEM_DATE		DATE,
	GRADE_ID		NUMBER,
	FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO mem_for VALUES (1, 'user1', 'pass1', 'ȫ�浿', '��', '010-1111-2222', 'gill.@dong.net', '24/08/12', NULL);
INSERT INTO mem_for VALUES (2, 'user2', 'pass2', '��û', NULL, NULL, NULL, NULL, 30);
INSERT INTO mem_for VALUES (3, 'user3', 'pass3', '���', '��', '010-1111-2323', 'gamja@bubu.com', '24/08/12', 20);
INSERT INTO mem_for VALUES (4, 'user4', 'pass4', '����', '��', '010-8888-8888', NULL, NULL, 10);

-- ���� �ɼ� �׽�Ʈ
DELETE FROM mem_grade WHERE grade_code = 10;
SELECT * FROM mem_for;	-- GRADE_CODE�� 10���� ������ �ִ� '����'�� ���� ���� ����


--===================================================================================================

/*
	<DEFAULT �⺻��>
	�÷��� �������� �ʰ� INSERT �� NULL�� �ƴ� �⺻���� INSERT �ϰ��� �� ��, ������ �� �� �ִ� ��.
	(���� ������ �ƴϹǷ�, ���� ������ ���ʿ� �ۼ��Ѵ�.)
	
	[ǥ����]
	�÷��� �ڷ��� DEFAULR �⺻��
*/

-- ex ) MEM_DEF ���̺� ����
CREATE TABLE MEM_DEF (
	MEM_NO		NUMBER			PRIMARY KEY,
	MEM_NAME		VARCHAR2(20)		NOT NULL,
	MEM_AGE		NUMBER,
	HOBBY			VARCHAR2(20)		DEFAULT '����',
	ENROLLDATE	DATE					DEFAULT SYSDATE
);

-- �⺻�� �׽�Ʈ
INSERT INTO mem_def VALUES (1, 'ȫ�浿', 30, '������', '19/08/06');
INSERT INTO mem_def VALUES (2, '��û', 15, NULL, NULL);
INSERT INTO mem_def VALUES (3, '���', 45, DEFAULT, DEFAULT);	-- �⺻������ �����ص� ���� �ڵ����� ����.
INSERT INTO mem_def (mem_no, mem_name) VALUES (4, '����');		-- �������� ���� �÷����� NULL, �⺻���� ������ �÷����� �⺻���� ����.


--===================================================================================================

/*
	<���̺� ���� ���>
	CREATE���� ����ϸ鼭 ������ ���̺�� �����͸� ������ ������ �� �ִ�.
	
	[ǥ����]
	CREATE TABLE ���̺�� AS (������ ���̺� ������ SELECT��);
*/

-- ex ) EMPLOYEE ���̺� ����
CREATE TABLE EMPLOYEE_COPY AS (SELECT * FROM employee);


--===================================================================================================

/*
	<���̺� ����>
	
	1. ���̺��� �� ������ �Ŀ� �ڴʰ� ���������� �߰��ϴ� ���
	ALTER TABLE ���̺�� �����ҳ���
	
	- PRIMARY KEY : ALTER TALBE ���̺�� ADD PRIMARY KEY(�÷���);
	- FOREIGN KEY : ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���) REFERENCES ���������̺��[�÷���];
	- UNIQUE : ALTER TABLE ���̺�� ADD UNIQUE(�÷���);
	- CHECK : ALTER TALBE ���̺�� ADD CHECK(�÷��� ���� ���ǽ�);
	- NOT NULL : ALTER TABLE ���̺�� NODIFY �÷��� NOT NULL;
*/

-- ex )
ALTER TABLE employee ADD FOREIGN KEY(dept_code) REFERENCES department;
ALTER TABLE employee ADD MODIFY emp_no NOT NULL;		-- �̹� NOT NULL ������ �����Ǿ��ֱ⿡ ���� �߻�