/*
	[KH ��������]
*/

-- 1. JOB ���̺��� ��� ���� ��ȸ
SELECT * FROM job;

-- 2. JOB ���̺��� ���� �̸� ��ȸ
SELECT job_name FROM job;

-- 3. DEPARTMENT ���̺��� ��� ���� ��ȸ
SELECT * FROM department;

-- 4. EMPLOYEE ���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT emp_name, email, phone, hire_date FROM employee;

-- 5. EMPLOYEE ���̺��� �����, �����, ���� ��ȸ
SELECT hire_date, emp_name, salary FROM employee;

-- 6. EMPLOYEE ���̺��� �����, ����, �Ѽ��ɾ�(���ʽ� ����), �Ǽ��ɾ�(�Ѽ��ɾ� - (����*���� 3%)) ��ȸ
SELECT	emp_name,
			salary * 12 "����",
			(salary + salary * NVL(bonus, 0)) * 12 "�Ѽ��ɾ�",
			(salary + salary * NVL(bonus, 0)) * 12 - (salary * 12 * 0.03) "�Ǽ��ɾ�"
FROM employee;

-- 7. EMPLOYEE ���̺��� SAL_LEVEL�� S1�� ����� �̸�, ����, �����, ����ó ��ȸ
SELECT emp_name, salary, hire_date, phone FROM employee WHERE salary >= 6000000 AND salary <= 100000000;

-- 8. EMPLOYEE ���̺��� �Ǽ��ɾ�(6�� ����)�� 5õ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, ����� ��ȸ
SELECT emp_name, salary, (salary + salary * NVL(bonus, 0)) * 12 - (salary * 12 * 0.03) "�Ǽ��ɾ�", hire_date
FROM employee WHERE (salary + salary * NVL(bonus, 0)) * 12 - (salary * 12 * 0.03) >= 50000000;

-- 9. EMPLOYEE ���̺��� ������ 4000000 �̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
SELECT * FROM employee WHERE salary >= 4000000 AND job_code = 'J2';

-- 10. EMPLOYEE ���̺��� DEPT_CODE�� D9 �̰ų� D5�� ��� �� ������� 02�� 1�� 1�� ���� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
SELECT emp_name, dept_code, hire_date FROM employee
WHERE dept_code IN ('D9', 'D5') AND hire_date < '02/01/01';

-- 11. EMPLOYEE ���̺��� ������� 90/01/01 ~ 01/01/01�� ����� ��ü ������ ��ȸ
SELECT * FROM employee WHERE hire_date >= '90/01/01' AND hire_date <= '01/01/01';

-- 12. EMPLOYEE ���̺��� �̸� ���� '��'���� ������ ����� �̸� ��ȸ
SELECT emp_name FROM employee WHERE emp_name LIKE '%��';

-- 13. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ��ȸ
SELECT emp_name, phone FROM employee WHERE SUBSTR(phone, 1, 3) != '010';

-- 14. EMPLOYEE ���̺��� �����ּ� '_'�� ���� 4�����̸鼭, DEPT_CODE�� D9 �Ǵ� D6�̰�,
-- ������� 90/01/01 ~ 00/12/01 �̰�, �޿��� 270�� �̻��� ����� ��ü�� ��ȸ
SELECT * FROM employee
WHERE	INSTR(email, '_', 1) = 3 AND
			dept_code IN ('D9', 'D6') AND
			hire_date >= '90/01/01' AND hire_date <= '00/12/01' AND
			salary >= 2700000;

-- 15. EMPLOYEE ���̺��� ������ ������ �ֹι�ȣ�� �̿��Ͽ� ����, ����, ���� ��ȸ
SELECT	emp_name,
			SUBSTR(emp_no, 1, 2) "����",
			SUBSTR(emp_no, 3, 2) "����",
			SUBSTR(emp_no, 5, 2) "����"
FROM employee;

-- 16. EMPLOYEE ���̺��� �����, �ֹι�ȣ ��ȸ (��, �ֹι�ȣ�� ������ϸ� ���̰� �ϰ�, '-' ���� ���� '*'�� �ٲٱ�)
SELECT emp_name, RPAD(SUBSTR(emp_no, 1, 7), 14, '*') FROM employee;

-- 17. EMPLOYEE ���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ
-- (��, �� ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ǵ��� �ϰ� ��� ����(����), ����� �ǵ��� ó��)
SELECT	emp_name,
			FLOOR(hire_date - SYSDATE) * (-1) "�ٹ��ϼ�1",
			FLOOR(SYSDATE - hire_date) "�ٹ��ϼ�2"
FROM employee;

-- 18. EMPLOYEE ���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
SELECT * FROM employee WHERE MOD(emp_id, 2) = 1;

-- 19. EMPLOYEE ���̺��� �ٹ������� 20�� �̻��� ���� ���� ��ȸ
SELECT * FROM employee WHERE TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(TO_DATE(hire_date), 'YYYY') >= 20;

-- 20. EMPLOYEE ���̺��� �����, �޿� ��ȸ (��, �޿��� '\9,000,000 �������� ǥ��)
SELECT emp_name, TO_CHAR(salary, 'L999,999,999') FROM employee;

-- 21. EMPLOYEE ���̺��� ������, �μ��ڵ�, �������, ����(��) ��ȸ
-- (��, ��������� �ֹι�ȣ���� �����ؼ� 00�� 00�� 00�Ϸ� ��µǰ� �ϸ�, ���̴� �ֹι�ȣ���� ����ؼ� ��¥ �����ͷ� ��ȯ�� ���� ���)
SELECT	emp_name,
			dept_code,
			TO_CHAR(TO_DATE(SUBSTR(emp_no, 1, 6)), 'YYYY"��" MM"��" DD"��"') "�������",
			FLOOR((SYSDATE - TO_DATE(SUBSTR(emp_no, 1, 6))) / 365) || '��' "����(��)"
FROM employee;

-- 22. EMPLOYEE ���̺��� �μ��ڵ尡 D5, D6, D9�� ����� ��ȸ�ϵ� D5�� �ѹ���, D6�̸� ��ȹ��, D9�� �����η� ó��
-- (��, �μ��ڵ� ������������ ����)
SELECT	emp_name,
			dept_code,
			DECODE(dept_code, 'D5', '�ѹ���', 'D6', '��ȹ��', 'D9', '������')
FROM employee
WHERE dept_code IN ('D5', 'D6', 'D9') ORDER BY dept_code;

-- 23. EMPLOYEE ���̺꿡�� ����� 201�� �����, �ֹι�ȣ ���ڸ�, �ֹι�ȣ ���ڸ�, �ֹι�ȣ ���ڸ��� ���ڸ��� �� ��ȸ
SELECT	emp_name,
			SUBSTR(emp_no, 1, 6) "�ֹι�ȣ ���ڸ�",
			SUBSTR(emp_no, 8, 7) "�ֹι�ȣ ���ڸ�",
			SUBSTR(emp_no, 1, 6) + SUBSTR(emp_no, 8, 7) "�ֹι�ȣ ��"
FROM employee WHERE emp_id = 201;

-- 24. EMPLOYEE ���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ���� �� ��ȸ
SELECT	emp_name, dept_code,
			((salary + (salary * NVL(bonus, 0))) * 12) "����"
FROM employee WHERE dept_code = 'D5';

-- 25. EMPLOYEE ���̺��� �������� �Ի��Ϸκ��� �⵵�� ������ �� �⵵�� �Ի� �ο��� ��ȸ
-- ��ü ���� �� / 2001�� / 2002�� / 2003�� / 2004��
SELECT	COUNT(*) "��ü ���� ��",
			SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), '2001', 1, 0)) "2001�� �Ի� ��",
			SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), '2002', 1, 0)) "2002�� �Ի� ��",
			SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), '2003', 1, 0)) "2003�� �Ի� ��",
			SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), '2004', 1, 0)) "2004�� �Ի� ��"
FROM employee;

SELECT	COUNT(*) "��ü ���� ��",
			COUNT(DECODE(EXTRACT(YEAR FROM hire_date), '2001', 1, NULL)) "2001�� �Ի� ��",
			COUNT(DECODE(EXTRACT(YEAR FROM hire_date), '2002', 1, NULL)) "2002�� �Ի� ��",
			COUNT(DECODE(EXTRACT(YEAR FROM hire_date), '2003', 1, NULL)) "2003�� �Ի� ��",
			COUNT(DECODE(EXTRACT(YEAR FROM hire_date), '2004', 1, NULL)) "2004�� �Ի� ��"
FROM employee;

