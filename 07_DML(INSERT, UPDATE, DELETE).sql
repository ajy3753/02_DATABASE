/*
	DQL (QUERY ������ ���Ǿ�) : SELECT
	DML (MANIPULATION ������ ���۾�) : INSERT, UPDATE, DELETE
	DDL (DEFINITION ������ ���Ǿ�) : CREATE, ALTER, DROP
	DCL (CONTROL ������ �����) : GRANT, REVOKE
	TCL (TRANSACTION Ʈ����� �����) : COMMIT, ROLLBACK
	
	<DML>
	������ ���� ���
	���̺� ���� ����(INSERT), ����(UPDATE), ����(DELETE) �ϴ� ����
*/

/*
	1. INSERT
	���̺� ���ο� ���� �߰��ϴ� ����
	
	[ǥ����]
	1 ) INSERT INTO ���̺�� VALUES (��, ��, �� ...... );
	���̺��� ��� �÷��� ���� ���� ���� �����ؼ� �� ���� INSERT �ϰ��� �� ��
	�÷��� ������ ���Ѽ� VALUES�� �´� Ÿ���� ���� �����ؾ���
	-> �����ϰ� ���� �����ϰų�, ���� �� ���� ������ ��� ���� �߻�
	
	2 ) INSERT INTO ���̺�� (�÷�, �÷�, �÷� ... ) VALUES (��, ��, �� ...);
	���̺� ���� ������ �÷��� ���� ���� INSERT�� �� ���
	�׷��� �� �� ������ �߰��Ǳ� ������ ���� �� �� �÷��� �⺻������ NULL�� ��
	-> NOT NULL ���� ������ �ִ� �÷��� ������ �߻��ϹǷ�, �ݵ�� ���� �־��־�� �Ѵ�.
	-> �⺻���� �����Ǿ� ������ NULL�� �ƴ� �⺻���� ��
*/

-- ex )
-- 1 ) ��ü �÷��� INSERT
INSERT INTO employee VALUES (900, '�ұ�', '880919-1234567', 'LAVYYY@NICO.COM', '01012345678', 'D7', 'J5', 4000000, 0.2, 200, SYSDATE, NULL, 'N');
-- 2 ) �Ϻ� �÷��� INSERT
INSERT INTO employee (emp_id, emp_name, emp_no, job_code, hire_date) VALUES (901, '����', '440701-1234567', 'J7', SYSDATE);

SELECT * FROM employee;


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	3 ) INSERT INTO ���̺�� (��������);
	VALUES�� ���� ���� ����ϴ� �� ��� ���������� ��ȸ�� ���� ��°�� INSERT ����
*/

-- ex ) EMP_01 ���̺��� ����� ���������� ������ INSERT
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
	�� �� �̻��� ���̺� ���� INSERT �� ��
	�̶� ���Ǵ� ���������� ������ ���
	
	[ǥ����]
	INSERT ALL
	INTO ���̺��1 VALUES (�÷�, �÷�, �÷� ... )
	VALUES (��, ��, �� ... )
	��������;
*/

-- ex )
-- 1 ) EMPLOYEE ���̺� �÷��� ������ EMP_DEPT, EMP_MANAGER ���̺� ����
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

-- 2 ) ���������� �̿��Ͽ� �� ���̺� ���ÿ� INSERT
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
	���̺� ��ϵǾ��ִ� ������ �����͸� �����ϴ� ����
	
	[ǥ����]
	UPDATE ���̺�� SET �÷� = '��';
	
	[WHERE ����] -> ���� �� ��ü ��� ���� �����Ͱ� ����
	�� UPDATE �ÿ��� ���� ������ �� Ȯ���ؾ� �Ѵ�.
*/

-- ex )
CREATE TABLE DEPT_TABLE
AS (SELECT * FROM department);

UPDATE dept_table
SET dept_title = '������ȹ��'
WHERE dept_id = 'D9';


--===================================================================================================

/*
	3 ) �÷� / �������Ǹ� / ���̺�� ����
	
	- �÷��� ���� : RENAME COLUMN ���� �÷��� TO �ٲ� �÷���
	
	- ���� ���Ǹ� ���� : RENAME CONSTRAINT ���� ���� ���Ǹ� TO �ٲ� ���� ���Ǹ�
	
	- ���̺�� ���� : RENAME TO �ٲ����̺��
*/

----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	TRUNCATE : ���̺� �ʱ�ȭ
*/