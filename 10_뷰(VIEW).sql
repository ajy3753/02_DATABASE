/*
	<VIEW ��>
	SELECT��(������)�� �����ص� �� �ִ� ��ü
	���� ����ϴ� SELECT���� �����صθ� �� SELECT���� �Ź� �ٽ� ����� �ʿ� ���� ����� �� �ִ�.
	�ӽ� ���̺� ���� ����� ���� �����Ͱ� ����ִ� �� �ƴϴ�. -> �� ���̺�
	
	1. VIEW �������
	VIEW�� ��ü�̱� ������ CREATE������ �����.
	
	[ǥ����]
	CREATE VIEW ��� AS ��������;
	SELECT * FROM ���;		-> �䰡 ���������� ����ȴ�
	CREATE OR REPLACE VIEW ��� AS ��������;	-> ���� �̸��� �䰡 ������ ���� �����, ������ ���� ����
	
	 �� ������ VIEW ���� ���� �ִ� �� : GRANT CREATE VIEW TO ������;
*/

-- ex )
-- 1 ) �ѱ����� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ�ϴ� �� ����
CREATE VIEW VW_EMPLOYEE
AS (
	SELECT emp_id, emp_name, dept_title, salary, national_name FROM employee
	JOIN department ON (dept_code = dept_id)
	JOIN location ON (location_id = local_code)
	JOIN national USING (national_code)
	WHERE national_name = '�ѱ�'
);

SELECT * FROM VW_EMPLOYEE;

-- 2 ) ���þƿ��� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS (
	SELECT emp_id, emp_name, dept_title, salary, national_name FROM employee
	JOIN department ON (dept_code = dept_id)
	JOIN location ON (location_id = local_code)
	JOIN national USING (national_code)
	WHERE national_name = '���þ�'
);

SELECT * FROM vw_employee;


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	* �� �÷��� ��Ī �ο�
	���������� SELECT���� �Լ����̳� ���������� ����Ǿ��ִٸ� �ݵ�� ��Ī�� �ο��ؾ��Ѵ�.
*/

-- ex ) �÷��� ��Ī�� �ο��Ͽ� �ٹ������ 20�� �̻��� ����� ��ȸ�ϴ� �� ����
CREATE OR REPlACE VIEW VW_EMP_JOB
AS (
	SELECT	emp_id, emp_name, job_name,
				DECODE(SUBSTR(emp_no, 8, 1), '1', '��', '2', '��') AS "����",
				EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM hire_date) AS "�ٹ����"
	FROM employee
	JOIN job USING (job_code)
);

SELECT * FROM vw_emp_job WHERE �ٹ���� >= 20;


--===================================================================================================

/*
	2. VIEW ����
	���̺�� ���������� DROP�� ����Ѵ�.
	
	[ǥ����]
	DROP VIEW ���;
*/

-- ex ) ������ �� �����ϱ�
DROP VIEW vw_employee;
DROP VIEW vw_emp_job;

--===================================================================================================

/*
	3. VIEW DML
	������ �並 ���ؼ� DML(INSERT, UPDATE, DELETE) ��� ����
	�並 ���ؼ� �����ϰ� �Ǹ� ���� �����Ͱ� ����ִ� ���̺� �ݿ��ȴ�.
	
	* DML ��ɾ�� ������ �Ұ����� ���
	1 ) �信 ���ǵǾ����� ���� �÷��� �����Ϸ��� �ϴ� ���
	2 ) �信 ���ǵǾ����� ���� �÷� �߿� ���̽����̺� �� NOT NULL ���������� �����Ǿ��ִ� ���
	3 ) ���������̳� �Լ����� ����� ���
	4 ) �׷��Լ��� GROUP BY ���� ������ ���
	5 ) DISTINCT ������ ���Ե� ���
	6 ) JOIN�� �̿��ؼ� ���� ���̺��� ���� ���ѳ��� ���
	
	- ��κ� ��� ��ȸ�� �������� �����ȴ�. �並 ���� DML�� �� ���� �� ����.
*/

-- ex )
CREATE OR REPLACE VIEW vw_job
AS SELECT job_code, job_name FROM job;

-- 1 ) �並 ���� INSERT
INSERT INTO vw_job VALUES ('J8', '����');

-- 2 ) �並 ���� UPDATE
UPDATE vw_job SET job_name = '�˹�' WHERE job_code = 'J8';

-- 3 ) �並 ���� DELETE
DELETE vw_job WHERE job_name = '�˹�';


--===================================================================================================

/*
	4. VIEW �ɼ�
	
	[��ǥ����]
	CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ���
	AS ��������
	[WITH CHECK OPTION]
	[WITH READ ONLY];
	
	1 ) OR REPLACE : ������ ������ �䰡 ���� �� ������ �����ϰ�, ���� ��� ���� �����Ѵ�.
	2 ) FORCE | NOFORCE
		- FORCE : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 �����ǵ��� �Ѵ�.
		- NOFORCE : ���������� ����� ���̺��� �����ϴ� ���̺��̿��߸� �Ѵ�. (�⺻��)
	3 ) WITH CHECK OPTION : DML�� ���������� ����� ���ǿ� ������ �����θ� DML�� �����ϵ��� �Ѵ�.
	4 ) WITH READ ONLY : �信 ���ؼ� ��ȸ�� �����ϵ��� �����Ѵ�.
*/

-- ex )
-- 1 ) FORCE
CREATE OR REPLACE NOFORCE VIEW vw_emp
AS SELECT tcode, tname, tcontent FROM tt;
-- > ���̺��� �������� �ʾ� ��� ������ ������ �߻��Ѵ�

-- 2) NOFORCE
CREATE OR REPLACE FORCE VIEW vw_emp
AS SELECT tcode, tname, tcontent FROM tt;
-- > ���̺��� �������� �ʾƵ� ������ ������ �Բ� �䰡 �����ȴ�.

-- 3 ) WITH CHECK OPTION
CREATE OR REPLACE VIEW vw_emp
AS (
	SELECT * FROM employee
	WHERE salary >= 30000000
) WITH CHECK OPTION;

UPDATE vw_emp SET salary = 20000000 WHERE emp_id = 200;
-- > ���� �������� ���ǿ� ���� �����Ƿ� ������ ���� �ʴ´�

-- 4 ) WITH READ ONYL
CREATE OR REPLACE VIEW vw_emp
AS (
	SELECT emp_id, emp_name, bonus FROM employee
	WHERE bonus iS NOT NULL
) WITH READ ONLY;

SELECT * FROM vw_emp;