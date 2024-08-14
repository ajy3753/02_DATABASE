SELECT emp_id, emp_name, salary	-- 3
FROM employee							-- 1
WHERE dept_code IS NULL;			-- 2
-- NULL �� ���� ���� IS NULL �Ǵ� IS NOT NULL�� �ؾ��Ѵ�.

/*
	<ORDER BY ��>
	SELECT�� ���� ������ �ٿ� �ۼ�, ������� ���� ���� �������� �����Ѵ�.
	
	[ǥ����]
	SELECT ��ȸ�� �÷�...
	FROM ��ȸ�� ���̺�
	WHERE ���ǽ�
	ORDER BY ���ı����� �� �÷� | ��Ī | �÷� ���� [ASC | DESC] [NULLS FIRST | NULLS LAST]
	
	- ASC : �������� (���� ������ �����ؼ� ���� ���� Ŀ���� ��) -> ���� �⺻��
	- DESC : �������� (ū ������ �����ؼ� ���� ���� �پ��� ��)
	
	-- NULL�� �⺻������ ���� ū ������ �з��ؼ� �����Ѵ�.
	- NULLS FIRST : �����ϰ��� �ϴ� �÷����� NULL�� ���� ��� �ش� �������� �� �տ� ��ġ (DESC�� �� �⺻��)
	- NULLS LAST : �����ϰ��� �ϴ� �÷����� NULL�� ���� ��� �ش� �������� �� �������� ��ġ (ASC�� �� �⺻��)
*/

SELECT * FROM employee ORDER BY bonus ASC;					-- �⺻���� ��������(ASC)�̹Ƿ�, ���� ASC�� ������ ���� ����� ����ȴ�.
SELECT * FROM employee ORDER BY bonus ASC NULLS FIRST;	-- NULL�� �ִ� ���� ���� �տ� ��ġ�ǰ�, ������������ ���ĵȴ�. (ASC�� ������ ��� ����)
SELECT * FROM employee ORDER BY bonus DESC;					-- ��������. NULLS FIRST�� �⺻������ �Ǿ��ִ�.
SELECT * FROM employee ORDER BY bonus DESC, salary ASC;	-- ���� ���ؿ� �÷����� ������ ���, �� ���� ������ ���ؼ� ���� ���� ������ ������ �� �ִ�.

-- �� ����� �����, ����(���ʽ� ����) ��ȸ (�̶� ���� �� �������� ����)
-- 1) ��Ī ���
SELECT emp_name, (salary * 12) "����" FROM employee ORDER BY ���� DESC;
-- 2) ���� ���
SELECT emp_name, (salary * 12) "����" FROM employee ORDER BY 2 DESC;		-- ����Ŭ�� ���� 1���� �����Ѵ�.

--===================================================================================================

/*
	<�Լ� FUNCTION>
	���޵� �÷����� �޾Ƽ� �Լ��� ������ ����� ��ȯ.
	
	- ������ �Լ� : N���� ���� �о�鿩�� N���� ������� ���� (���ึ�� �Լ� ���� ����� ��ȯ)
	- �׷��Լ� : N���� ���� �о�鿩�� 1���� ������� ���� (�׷��� ��� �׷캰�� �Լ� ���� ����� ��ȯ)
	
	>> SELECT ���� ������ �Լ��� �׷��Լ��� �Բ� ������� ����
	-> ��� ���� ������ �ٸ��� ����
	
	>> �Լ��� ����� �� �ִ� ��ġ : SELECT, WHERE, ORDER BY, HAVING
*/

--================== <������ �Լ�> ======================================================================

/*
	<���� ó�� �Լ�>
	- LENGTH(�÷� | '���ڿ�') :  �ش� ���ڿ��� ���ڼ��� ��ȯ
	- LENGTHB(�÷� | '���ڿ�') : �ش� ���ڿ��� ����Ʈ ���� ��ȯ
	
	'��', '��', '��' �� �ѱ��� ���� �� 3BYTE
	������, ����, Ư�����ڴ� ���� �� 1BYTE
*/

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ') FROM dual;
-- �ѱ��� ���� �� 3 ����Ʈ�̹Ƿ�, LENGTHB�� ���� 9
SELECT emp_name, LENGTH(emp_name), LENGTHB(emp_name) FROM employee;

--==================================================================

/*
	- INSTR
	���ڿ��κ��� Ư�� ������ ���� ��ġ�� ã�Ƽ� ��ȯ
	
	INSTR(�÷� | '���ڿ�', 'ã�����ϴ� ����', ['ã�� ��ġ�� ���۰�, ����]) -> ����� NUMBER
*/

SELECT INSTR('AABABRL', 'B', 1) FROM dual;		-- ã�� ��ġ ���۰� 1, ���� 1 => �⺻�� (���ڿ��� �� �տ������� ã�´�.)
SELECT INSTR('AABABRL', 'B', -1) FROM dual;		-- ã�� �� �ڿ������� ã���ֳ�, ��ġ�� ���� �״�� ���´�.
SELECT INSTR('AABABRL', 'B', 1, 2) FROM dual;		-- ������ �����Ϸ��� ��ġ�� ���۰��� ǥ���ؾ��Ѵ�.

--=====================================================================

/*
	- SUBSTR
	���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ
	
	[ǥ����]
	SUBSTR(STRING, POSITION, [LENGTH])
	- STRING : ����Ÿ�� �÷� | '���ڿ�'
	- POSOTION : ���ڿ� ������ ���� ��ġ��
	- LENGTH : ������ ���� ���� (�����ϸ� ���۰����� ������ ����)
*/

SELECT SUBSTR('HEYHEYSOMLIKEITHOT', 7) FROM dual;		-- 7��° ��ġ���� ������ ����
SELECT SUBSTR('HEYHEYSOMLIKEITHOT', 5, 2) FROM dual;		-- 5��° ��ġ���� ���� 2�� ����
SELECT SUBSTR('HEYHEYSOMLIKEITHOT', 1, 6) FROM dual;
SELECT SUBSTR('HEYHEYSOMLIKEITHOT', -8, 3) FROM dual;	-- �ڿ��� 8��° ��ġ���� ���� 3�� ����

-- emp_no���� Ư�� �ڸ� ������ ��ȯ �޾� ������ �з��ϱ�
SELECT emp_name, emp_no, SUBSTR(emp_no, 8, 1) AS "����" FROM employee;

-- ����� �� ������鸸 EMP_NAME, EMP_NO ��ȸ
SELECT emp_name, emp_no FROM employee WHERE SUBSTR(emp_no, 8, 1) = '2' OR SUBSTR(emp_no, 8, 1) = '4' ORDER BY emp_name;

-- �Լ� ��ø ��� ����
-- 1) �̸����� ���̵� �κ� ����
-- 2) ��� ��Ͽ��� �����, �̸���, ���̵� ��ȸ
SELECT emp_name, email, SUBSTR(email, 1, INSTR(email, '@') - 1) "ID" FROM employee;

--=============================================================================

/*
	- LPAD / RPAD
	���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� �� �� ���
	
	[ǥ����]
	LPAD / RPAD (STRING , ���������� ��ȯ�� ���ڿ��� ����, [�����̰��� �ϴ� ����])
	
	���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� �ٿ��� ���� N���̸�ŭ�� ���ڿ��� ��ȯ
*/

-- 20��ŭ�� ���� �� EMAIL �÷� ���� ���������� �����ϰ� ������ �κ��� �������� ä���.
SELECT emp_name, LPAD(email, 20) FROM employee;

-- ������� �����, �ֹε�� ��ȣ ��ȸ ("701011-1XXXXXXXX")
SELECT emp_name, RPAD(SUBSTR(emp_no, 1, 8), 14, 'X') FROM employee;
SELECT emp_name, SUBSTR(emp_no, 1, 8) || 'XXXXXX' FROM employee;

--===========================================================================

/*
	- LTRIM / RTIRM
	���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
	
	[ǥ����]
	LTRIM / RTIRM ( STRING, [�����ϰ��� �ϴ� ���ڵ�])
	
	���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ� ��ȯ
*/

SELECT LTRIM('              K K G           ') FROM dual;
SELECT LTRIM('ABCDEFG', 'ABC') FROM dual;
SELECT RTRIM('234929340KH38283994', '29340') FROM dual;

/*
	- TRIM
	���ڿ��� �� / �� / ���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ��� ��ȯ
	TRIM([LEADING] | [TRALLING] | BOTH] �����ϰ� �ϴ� ���ڿ� FROM ���ڿ�

*/


--===================================================================================================

/*
	[����ȯ �Լ�]
	* TO_CHAR : ���� Ÿ�� �Ǵ� ��¥ Ÿ���� ���� ���� Ÿ������ ��ȯ �����ִ� �Լ�
	
	[ǥ����]
	TO_CHAR(���� | ����, [����])
*/

-- ���� -> ����
SELECT TO_CHAR(1234) FROM dual;
SELECT TO_CHAR(12, '99999') FROM dual;							-- 9�� �ڸ�����ŭ ���� Ȯ��, ������ ����
SELECT TO_CHAR(12, '00000') FROM dual;							-- 0�� �ڸ�����ŭ ���� Ȯ��, ��ĭ�� 0���� ä��
SELECT TO_CHAR(123456789, 'L999999999') FROM dual;			-- ���� ������ ������ ���� ȭ�� ������ ��Ÿ�� (��, �ڸ����� ���ڶ�� #�� ������ ����)
SELECT TO_CHAR(123456789, 'L999,999,999') FROM dual;		-- 3�ڸ� ���� ��ǥ ���

-- ��¥ -> ����
SELECT SYSDATE FROM dual;
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM dual;
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM dual;						-- AM, PM ������� ������ �����ִ� ���̱⿡ ����� ����
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM dual;						-- 24�ð�
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM dual;			-- DY : ���� ���� ǥ�� (ex. ������ -> ��)
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM dual;
SELECT TO_CHAR(SYSDATE, 'MM DD YYYY') FROM dual;
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"') FROM dual;		-- �ѱ��� ����ؼ� ǥ�� ��, " "�� �Է�

-- ex ) ������� �̸�, �Ի� ��¥(0000�� 00�� 00��) ��ȸ
SELECT emp_name, TO_CHAR(hire_date, 'YYYY"��" MM"��" DD"��"') "�Ի� ��¥" FROM employee;

-- �⵵�� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'),
		  TO_CHAR(SYSDATE, 'YY'),
		  TO_CHAR(SYSDATE, 'RRRR'),		-- RR���� ���� �����Ѵ� (���� ���X)
		  TO_CHAR(SYSDATE, 'YEAR')		-- �������� ��¥ ǥ��
FROM dual;

-- ex )
SELECT hire_date, TO_CHAR(hire_date, 'YYYY'), TO_CHAR(hire_date, 'YEAR') FROM employee;

-- ���� ���õ� ����
SELECT	TO_CHAR(SYSDATE, 'MM'),
			TO_CHAR(SYSDATE, 'MON'),
			TO_CHAR(SYSDATE, 'MONTH')
FROM dual;

-- �Ͽ� ���õ� ����
SELECT	TO_CHAR(SYSDATE, 'DDD'),		-- ������ �̹� �⵵ �������� �� ��° �ϼ����� ǥ��
			TO_CHAR(SYSDATE, 'DD'),		-- ���� ���� (�� �ڸ�)
			TO_CHAR(SYSDATE, 'D')			-- ���� -> ���� ��ȯ. �Ͽ����� 1�� �ȴ�. (ex. �� -> 4)
FROM dual;

-- ������ ��Ÿ���� ����
SELECT	TO_CHAR(SYSDATE, 'DAY'),
			TO_CHAR(SYSDATE, 'DY')
FROM dual;


--===================================================================================================

/*
	TO_DATE : ���� Ÿ�� �Ǵ� ���� Ÿ���� ��¥ Ÿ������ �����ϴ� �Լ�
	
	[ǥ����]
	TO_DATE(���� | ����. [����])
*/

SELECT TO_DATE(19961102) FROM dual;
SELECT TO_DATE(241229) FROM dual;			-- �⵵�� ���ϴ� �պκ� 2�ڸ��� 50 �̸��̸� �ڵ����� 20XX����, 50�� �̻��� 19XX�� �����ȴ�.
SELECT TO_DATE(981031) FROM dual;

SELECT TO_DATE(080704) FROM dual;			-- ���� -> ��¥ ��ȯ ��, 0���� ������ �� ����
SELECT TO_DATE('080704') FROM dual;			-- ���ڿ� �պκ��� 0�� ���� ' ' ���

SELECT TO_DATE('020505 120500') FROM dual;									-- �ð����� ǥ���� ���� ������ �������־�� �Ѵ�.
SELECT TO_DATE('020505 120500', 'YYMMDD HH24MISS') FROM dual;


--===================================================================================================

/*
	TO_NUMBER : ���� Ÿ���� �����͸� ���� Ÿ������ ��ȯ �����ִ� �Լ�
	
	[ǥ����]
	TO_NUMBER(����, [����])
*/

SELECT TO_NUMBER('010401') FROM dual;

SELECT '10000' + '50000' FROM dual;		-- ��� �����ڸ� �� ��� �ڵ����� ����ȯ
SELECT '10,000' + '50,000' FROM dual;		-- ���ڿ��� ���� ���� �ٸ� ���ڰ� ������� ��쿣 �ڵ����� ��ȯ���� �ʴ´�
SELECT TO_NUMBER('10,000', '99,999') + TO_NUMBER('50,000', '99,000') FROM dual;


--===================================================================================================

/*
	[NULL ó�� �Լ�]
	* NVL : �÷��� NULL ���� ������ ������ ���� ��� �����ִ� �Լ�
	* NVL2 : �÷��� ���� ������ ��� ��ȯ����, NULL�� ��� ��ȯ���� ���� �����Ͽ� �����ִ� �Լ�
	* NULLIF : �� ���� ��ġ�ϸ� NULL, ��ġ���� ������ �񱳴��1�� ��ȯ�ϴ� �Լ�
	
	[ǥ����]
	- NVL(�÷�, �ش� �÷��� NULL�� ��� ������ ��)
	- NVL2(�÷�, ��ȯ��1, ��ȯ��2)
	- NULLIF(�񱳴��1, �񱳴��2)
*/

-- ex ) NVL
SELECT emp_name, NVL(bonus, 0) FROM employee;
SELECT emp_name, (salary + (salary * NVL(bonus, 0))) * 12 FROM employee;

-- ex ) NVL2
SELECT emp_name, bonus, NVL2(bonus, 'O', 'X') FROM employee;

-- ex ) NULLIF
SELECT NULLIF('123', '123') FROM dual;
SELECT NULLIF('123', '456') FROM dual;


--===================================================================================================

/*
	[���� �Լ�]
	* DECODE : ���ϰ��� �ϴ� ���� �񱳰����� ���Ͽ�, �׿� �´� ������� ��ȯ�ϴ� �Լ�
	
	[ǥ����]
	DECODE(���ϰ��� �ϴ� ���(�÷�, �����, �Լ���), �񱳰�1, �����1, �񱳰�2, �����2 ...)
*/

-- ex )
SELECT	emp_id, emp_name, emp_no,
			DECODE(SUBSTR(emp_no, 8, 1), '1', '��', '2', '��', '3', '��', '4', '��', '�ܰ���') AS "����"	-- ��ġ�ϴ� �񱳰��� ���� ���, ���� ������ ������� ������.
FROM employee;

-- ���� ���� ) ������ ����, ���� �޿�, �λ�� �޿� ��ȸ�ϱ�
-- J7�� ����� �޿��� 10% �λ� (salary * 1.1)
-- J6�� ����� �޿��� 15% �λ� (salary * 1.15)
-- J5�� ����� �޿��� 20% �λ� (salary * 1.2)
-- �� �� ����� �޿��� 5% �λ� (salary * 1.05)
SELECT emp_name, salary, (salary * DECODE(job_code, 'J7', 1.1, 'J6', 1.15, 'J5', 1.2, 1.05)) "�λ�� �޿�" FROM employee;

/*
	* CASE WHEN THEN : IF, IF~ELSE�� ���� ����
	
	[ǥ����]
	CASE
			WHEN ���ǽ�1 THEN �����1
			WHEN ���ǽ�2 THEN �����2
			...
			ELSE �����
	END

*/

-- ex )
SELECT	emp_name, salary,
			CASE
					WHEN salary >= 5000000 THEN '���'
					WHEN salary >= 3500000 THEN '�߱�'
					ELSE '�ʱ�'
			END
FROM employee;


--===================================================================================================

/*
	[�׷� �Լ�]
	
	1. SUM(����Ÿ���÷�) : �ش� �÷��� ���ϴ� ��� ������ �� �հ踦 ���ؼ� ��ȯ���ִ� �ռ�
*/

-- ex )
SELECT SUM(salary) FROM employee;

-- ���� ���� )
-- 1. ���� ������� �� �޿�
SELECT SUM(salary) FROM employee WHERE SUBSTR(emp_no, 8, 1) IN ('1', '3');
-- 2. �μ��ڵ尡 D5�� ������� �� ����(�޿� * 12)
SELECT SUM(salary * 12) FROM employee WHERE dept_code = 'D5';

/*
	2. AVG(NUMBER) : �ش� �÷������� ����� ���ؼ� ��ȯ
*/

-- ex )
SELECT ROUND(AVG(salary)) FROM employee;

/*
	3. MIN(���Ÿ�԰���) : �ش� �÷��� �� ���� ���� ���� ���ؼ� ��ȯ
*/

-- ex )
SELECT MIN(emp_name), MIN(salary), MIN(hire_date) FROM employee;

/*
	4. MAX(���Ÿ�԰���) : �ش� �÷��� �� ���� ū ���� ���ؼ� ��ȯ
*/

-- ex )
SELECT MAX(emp_name), MAX(salary), MAX(hire_date) FROM employee;

/*
	5. COUNT(* | �÷� | DISTINCT �÷�) : �ش� ���ǿ� �´� ���� ������ ���� ��ȯ
	- COUNT(*) : ��ȸ�� ����� ��� ���� ������ ���� ��ȯ
	- COUNT(�÷�) : ������ �ش� �÷��� �� NULL�� ������ ���� ���� ���� ��ȯ
	- COUNT(DISTINCT �÷�) : �ش� �÷��� �� �ߺ����� ������ ���� ������ ���� ��ȯ
*/

-- ex )
SELECT COUNT(*) "��ü ��� ��" FROM employee;
SELECT COUNT(bonus) "���ʽ��� �޴� ��� ��" FROM employee;

-- ���� ���� ) ���� ������� �� �� ���� �μ��� �����Ǿ� �ִ� ���� ���ض�
SELECT COUNT(DISTINCT dept_code) FROM employee;