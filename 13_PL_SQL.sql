/*
	<PL/SQL>
	PROCEDURE LANGUAGE EXTGENSION TO SQL
	
	����Ŭ ��ü�� ���� �Ǿ��ִ� ������ ���
	SQL ���� ������ ������ ����, ����(IF), �ݺ�(FOR, WHILE)���� �����Ͽ� SQL ������ ����
	�ټ��� SQL ���� �� ���� ���డ��
	
	* PL/SQL ����
	- [�����] : DECLARE�� ����, ������ ����� ���� �� �ʱ�ȭ�ϴ� �κ�
	- ����� : BEGIN���� ����, SQL�� �Ǵ� ��� ���� ������ ����ϴ� �κ�
	- [����ó����] : EXCEPTION���� ����, ���� �߻� �� �ذ��ϱ� ���� ����
*/

SET SERVEROUTPUT ON;

-- ex ) HELLO ORACLE ���
BEGIN
	-- System.out.print("HELLO ORACLE")
	DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	1. DECLARE �����
	���� �� ��� �����ϴ� ����
	�Ϲ� Ÿ�� ����, ���۷��� Ÿ�� ����, ROW Ÿ�� ����
	
	1 ) �Ϲ� Ÿ�� ���� ���� �� �ʱ�ȭ
		[ǥ����]
		������ [CONSTANT] �ڷ��� [ := ��]
*/

-- ex )
-- 1 ) DECLARE�� ���� �� �ʱ�ȭ
DECLARE
	eid		NUMBER;
	ename	VARCHAR2(20);
	pi			CONSTANT NUMBER := 3.14;
BEGIN
	eid := 800;
	ename := '������';
	
	DBMS_OUTPUT.PUT_LINE('EID : ' || eid);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ename);
	DBMS_OUTPUT.PUT_LINE('PI : ' || pi);
END;
/

-- 2 ) �Է� ���� ���� ���
DECLARE
	eid		NUMBER;
	ename	VARCHAR2(20);
	pi			CONSTANT NUMBER := 3.14;
BEGIN
	eid := &��ȣ;
	ename := '&�̸�';
	
	DBMS_OUTPUT.PUT_LINE('EID : ' || eid);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ename);
	DBMS_OUTPUT.PUT_LINE('PI : ' || pi);
END;
/


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	2 ) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ (� Ÿ���� � �÷��� ������ Ÿ���� �����Ͽ� �� Ÿ������ ����)
*/

-- ex ) 
-- 1 ) ����� 200���� ����� ���, �����, �޿� ��ȸ
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

-- 2 ) ����� �Է� �޾� ��ȸ
DECLARE
	eid		employee.emp_id%TYPE;
	ename	employee.emp_name%TYPE;
	sal			employee.salary%TYPE;
BEGIN
	SELECT emp_id, emp_name, salary
	INTO eid, ename, sal
	FROM employee
	WHERE emp_id = '&���';

	DBMS_OUTPUT.PUT_LINE('EID : ' || eid);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ename);
	DBMS_OUTPUT.PUT_LINE('SAL : ' || sal);
END;
/


--==

/*
	[�ǽ� ����]
	���۷��� Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE�� �����ϰ�
	�� �ڷ��� EMPLOYEE(EMP_ID, EMP_NAME, JOB_CODE, SALARY), DEPARTMENT(DEPT_TITLE)���� �����ϵ���
	����ڰ� �Է��� ����� ����� ���, �����, �����ڵ�, �޿�, �μ��� ��ȸ �� �� ������ ��� ���
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
	WHERE emp_id = '&���';

	DBMS_OUTPUT.PUT_LINE('EID : ' || eid);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || ename);
	DBMS_OUTPUT.PUT_LINE('JCODE : ' || jcode);
	DBMS_OUTPUT.PUT_LINE('SAL : ' || sal);
	DBMS_OUTPUT.PUT_LINE('DTITLE : ' || dtitle);
END;
/


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	3 ) ROW Ÿ�� ���� ����
	���̺��� �� �࿡ ���� ��� �÷����� �� ���� ���� �� �ִ� ����
	
	[ǥ����]
	������ ���̺��%ROWTYPE
*/

-- ex )
DECLARE
	E	employee%ROWTYPE;
BEGIN
	SELECT *
	INTO E
	FROM employee
	WHERE emp_id = '&���';
	
	DBMS_OUTPUT.PUT_LINE('����� : ' || E.emp_name);
	DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.salary);
END;
/


--===================================================================================================

/*
	2. BEGIN �����
	
	<���ǹ�>
	1 ) IF ���ǽ� THEN ���೻�� END IF;	(IF���� �ܵ����� ����� ��)
	2 ) IF ���ǽ� THEN ���೻��1 ELSE ���೻��2 END IF;
	3 ) IF ���ǽ�1 THEN ���೻��1 ELSIF ���ǽ�2 THEN ���೻��2 ... [ELSE ���೻��] END IF;
*/

-- ex )
-- 1 ) �Է� ���� ����� �ش��ϴ� ����� ���, �̸�, �޿�, ���ʽ� ���
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�' ���
DECLARE
	eid		employee.emp_id%TYPE;
	ename	employee.emp_name%TYPE;
	sal			employee.salary%TYPE;
	bonus		employee.bonus%TYPE;
BEGIN
	SELECT emp_id, emp_name, salary, NVL(bonus, 0)
	INTO eid, ename, sal, bonus
	FROM employee
	WHERE emp_id = '&���';

	DBMS_OUTPUT.PUT_LINE('��� : ' || eid);
	DBMS_OUTPUT.PUT_LINE('�̸� : ' || ename);
	DBMS_OUTPUT.PUT_LINE('�޿� : ' || sal);
	IF bonus = 0
		THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�. ');
	ELSE
		DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || bonus);
	END IF;
END;
/

-- 2 ) ELSE IF
DECLARE
	score	NUMBER;
	grade	VARCHAR2(1);
BEGIN
	score := &����;
	
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
	
	DBMS_OUTPUT.PUT_LINE('���� : ' || score);
	DBMS_OUTPUT.PUT_LINE('���� : ' || grade);
END;
/
--==

/*
	[�ǽ� ����]
	DECLARE
	- ���۷��� ����(EID, ENAME, DTITLE, NCODE)
	- ���� ����(EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE)
	- �Ϲ� Ÿ�� ����(TEAM ���ڿ�) : ������, �ؿ��� �и��ؼ� ����
	
	BEGIN
	- ����ڰ� �Է��� ����� ��� ������ ������ ���, �̸�, �μ���, �ٹ������ڵ� ��ȸ �� �� ������ ����
	- NCODE���� KO�� ��� -> TEAM -> ������
	- NCODE���� KO�� �ƴ� ��� -> TEAM -> �ؿ��� ����
	- ���, �̸�, �μ���, �Ҽ�(TEAM)�� ���
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
	WHERE emp_id = '&���';
	
	IF ncode = 'KO'
		THEN team := '������';
	ELSE
		team := '�ؿ���';
	END IF;
	
	DBMS_OUTPUT.PUT_LINE('��� : ' || eid);
	DBMS_OUTPUT.PUT_LINE('�̸� : ' || ename);
	DBMS_OUTPUT.PUT_LINE('�μ� : ' || dtitle);
	DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || team);
END;
/


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	2. �ݺ���
	
	1 ) BASIC LOOP
	
	[ǥ����]
	LOOP
		�ݺ������� ������ ����
		* �ݺ����� �������� �� �ִ� ����
	END LOOP;
	
	* �ݺ����� �������� �� �ִ� ����
	1 ) IF ���ǽ� THEN EXIT; END IF;
	2 ) EXIT WHEN ���ǽ�;
*/

-- ex ) ���� i�� 10�� �Ǹ� �ݺ��� ����
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
	2 ) FOR LOOP��
	DECLARE ���� ���� ���� ��밡���� �ݺ���
	
	[ǥ����]
	FOR ���� IN �ʱⰪ..������
	LOOP
		�ݺ������� ������ ����;
	END LOOP;
*/

-- ex )
-- 1 ) DECLARE ���� ���� i�� ���� �ݺ��� ����
BEGIN
	FOR i IN 1..5
	LOOP
		DBMS_OUTPUT.PUT_LINE(i);
	END LOOP;
END;
/

-- 2 ) REVERSE�� �Ųٷ� ���
BEGIN
	FOR i IN REVERSE 1..5
	LOOP
		DBMS_OUTPUT.PUT_LINE(i);
	END LOOP;
END;
/

-- 3 ) test ���̺��� ����� 1���� 100���� INSERT�ϴ� �ݺ��� �ۼ�
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
	
	[ǥ����]
	WHILE �ݺ����� ����� ����
	LOOP
		�ݺ� ������ �۾�;
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
	3. ����ó����
	����(EXCEPTION) : ���� �� �߻��ϴ� ����
	
	EXCEPTION
		WHEN ���ܸ�1 THEN ó������1;
		WHEN ���ܸ�2 THEN ó������2;
		...
	
	* �ý��� ���� (����Ŭ���� �̸� ������ �� ����)
	- NO_DATE_FOUND : SELECT�� ����� �� �൵ ���� ��
	- TOO_MANY_ROWS : SELECT�� ����� ���� ���� ���
	- ZERO_DIVIDE : 0���� ���� ��
	- DUP_VAL_ON_INDEX : UNIQUE ���� ���� ����
*/

-- ex ) ����ڰ� �Է��� ���� �������� ����� ���
DECLARE
	result	NUMBER;
BEGIN
	result := 10/&����;
	
	DBMS_OUTPUT.PUT_LINE('��� : ' || result);
EXCEPTION
	-- WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('������ ���� �� 0���� ���� �� �����ϴ�.');
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ ���� �� 0���� ���� �� �����ϴ�.');
END;
/