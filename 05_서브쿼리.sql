 /*
	[��������]
	- �ϳ��� SQL�� �ȿ� ���Ե� �� �ٸ� SELECT��
	- ���� SQL���� ���� ���� ������ �ϴ� ����
*/

-- ex )
-- ���ö ����� ���� �μ��� ���� ����� ��ȸ
SELECT emp_name FROM employee
WHERE dept_code = (SELECT dept_code FROM employee WHERE emp_name = '���ö');
-- �� ������ ��� �޿� ���� �� ���� �޿��� �޴� ������� ���, �̸�, ���� �ڵ�, �޿� ��ȸ
SELECT emp_id, emp_name, job_code, salary FROM employee
WHERE salary >= (SELECT AVG(salary) FROM employee);


/*
	* ���������� ����
	���������� ������ ������� �� �� �� ���� �������Ŀ� ���� �з�
	
	- ������ �������� : ���������� ��ȸ ������� ������ 1���� ��
	- ������ �������� : ���������� ��ȸ ������� ���� ���� �� (���� �� 1��)
	- ���߿� �������� : ���������� ��ȸ ������� 1�������� �÷��� ���� ���� ��
	- ������ ���߿� �������� : ���������� ��ȸ ������� ���� �� ���� �÷��� ��
	
	>> ���������� ������� ���� �������� �� ���� �����ڰ� �޶�����.
*/

/*
	1. ������ ��������
	���������� ��ȸ ������� ������ 2���� �� (1�� 1��)
	�Ϲ� �񱳿����� ��� ����
*/

-- �������� )
-- 1) �� ������ ��� �޿� ���� �޿��� �� ���� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT emp_name, job_code, salary FROM employee
WHERE salary < (SELECT AVG(salary) FROM employee);

-- 2) ���� �޿��� �޴� ����� ���, �̸�, �޿�, �Ի��� ��ȸ
SELECT emp_id, emp_name, salary, hire_date FROM employee
WHERE salary = (SELECT MIN(salary) FROM employee);

-- 3) ���ö ����� �޿� ���� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT emp_id, emp_name, dept_code, salary FROM employee
WHERE salary > (SELECT salary FROM employee WHERE emp_name = '���ö');

-- 4) ���ö ����� �޿� ���� ���� �޴� ������� ���, �̸�, �μ���, �޿� ��ȸ
SELECT emp_id, emp_name, dept_title, salary FROM employee
JOIN department ON (dept_code = dept_id)
WHERE salary >= (SELECT salary FROM employee WHERE emp_name = '���ö');

-- 5) �μ��� �޿� ���� ���� ū �μ��� �μ��ڵ�, �޿� �� ��ȸ
SELECT dept_code, SUM(salary) FROM employee GROUP BY dept_code
HAVING SUM(salary) = (SELECT MAX(SUM(salary)) FROM employee GROUP BY dept_code);

-- 6) '������' ����� ���� �μ��� ������� ���, �����, ��ȭ��ȣ, �Ի���, �μ��� ��ȸ (��, ������ ��� ����)
SELECT emp_id, emp_name, phone, hire_date, dept_title FROM employee
JOIN department ON (dept_code = dept_id)
WHERE	dept_code = (SELECT dept_code FROM employee WHERE emp_name = '������')
			AND emp_name != '������';
			

----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	2. ������ ��������
	���������� ������ ������� ���� ���� �� (�÷��� 1��)
	
	1) IN (��������) : ���� ���� ����� �߿��� �� ���� ��ġ�ϴ� ���� �ִٸ� ��ȸ
	
	2) > ANY (��������) : ���� ���� ����� �߿��� �� ���� Ŭ ��� ��ȸ
	3) < ANY (��������) : ���� ���� ����� �߿��� �� ���� ���� ��� ��ȸ
	--> �񱳴�� > ANY (���������� ����� -> ��1, ��2, ��3 ...)
	
	4) > ALL (��������) : ���� ���� ��� ������� ���� Ŭ ��� ��ȸ
	5) < ALL (��������) : ���� ���� ��� ������� ���� ���� ��� ��ȸ
*/

-- ���� ���� )
-- 1) ����� �Ǵ� ������ ����� ���� ������ ������� ���, �����, �����ڵ�, �޿� ��ȸ
SELECT emp_id, emp_name, job_code, salary FROM employee
WHERE job_code IN (SELECT job_code FROM employee WHERE emp_name IN ('�����', '������'));

-- 2) �븮 �����ӿ��� ���� ���� �޿��� �� �ּ� �޿� ���� ���� �޴� ������� ���, �̸�, ����, �޿� ��ȸ
SELECT emp_id, emp_name, job_name, salary FROM employee
JOIN job USING (job_code)
WHERE	job_name = '�븮'
			AND salary >  ANY(SELECT salary FROM employee
								JOIN job USING (job_code)
								WHERE job_name = '����');


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	3. ���߿� ��������
	������� 1�������� ������ �÷� ���� ���� ���� ���
*/

-- ���� ���� )
-- 1) ������ ����� ���� �μ��ڵ�, ���� ���� �ڵ忡 �ش��ϴ� ����� ��ȸ (�����, �μ��ڵ�, �����ڵ�, �Ի���)
SELECT emp_name, dept_code, job_code, hire_date FROM employee
WHERE (dept_code, job_code) = (SELECT dept_code, job_code FROM employee WHERE emp_name = '������');

-- 2) �ڳ��� ����� ���� �����ڵ�, ���� ����� ������ �ִ� ������� ���, �����, �����ڵ�, �����ȣ ��ȸ
SELECT emp_id, emp_name, job_code, manager_id FROM employee
WHERE	(job_code, manager_id) = (SELECT job_code, manager_id FROM employee WHERE emp_name = '�ڳ���')
			AND emp_name != '�ڳ���';

			
----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	4. ������ ���߿� ��������
	���������� ��ȸ ������� ���� �� ���� ���� ���
*/

-- �������� )
-- 1) �� ���޺� �ּұ޿��� �޴� ��� ��ȸ (���, �����, �����ڵ�, �޿�)
SELECT emp_id, emp_name, job_code, salary FROM employee
WHERE (job_code, salary) IN (SELECT job_code, MIN(salary) FROM employee GROUP BY job_code);

-- 2) �� �μ��� �ְ� �޿��� �޴� ������� ���, �����, �μ��ڵ�, �޿� ��ȸ
SELECT emp_id, emp_name, dept_code, salary FROM employee
WHERE (dept_code, salary) IN (SELECT dept_code, MAX(salary) FROM employee GROUP BY dept_code)
ORDER BY dept_code;


----------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
	5. �ζ��� ��
	FROM ���� ���������� �ۼ��ϴ� ��
	���������� ������ ����� ��ġ ���̺�ó�� ���
	
	- �ַ� ����ϴ� �� >> TOP-N �м� : ���� �� ���� ��ȸ
*/

-- �������� )
-- 1) ������� ���, �̸�, ���ʽ� ���� ����, �μ��ڵ� ��ȸ (��, ���ʽ� ���� ������ NULL�� �Ǹ� �ȵǰ� 3000���� �̻��� ����鸸 ��ȸ)
SELECT emp_id, emp_name, (salary + (salary * NVL(bonus, 0))) * 12 "����", dept_code FROM employee
WHERE (salary + (salary * NVL(bonus, 0))) * 12 >= 30000000
ORDER BY ���� DESC;

-- 2) �� ���� �� �޿��� ���� ���� 5�� ��ȸ (����, �����, �޿�)
-- ROWNUM : ����Ŭ���� �����ϴ� �÷�, ��ȸ�� ������� 1���� ������ �ο��Ѵ�.
SELECT ROWNUM, emp_name, salary
FROM (SELECT emp_name, salary FROM employee ORDER BY salary DESC)
WHERE ROWNUM <= 5;

-- 3) ���� �ֱٿ� �Ի��� ��� 5�� ��ȸ (�����, �޿�, �Ի���)
SELECT emp_name, salary, hire_date
FROM (SELECT * FROM employee ORDER BY hire_date DESC)
WHERE ROWNUM <= 5;

-- 4) �μ��� ��� �޿��� ���� 3���� �μ� ��ȸ (�μ��ڵ�, ��� �޿�)
SELECT dept_code, "��� �޿�"
FROM (SELECT dept_code, ROUND(AVG(salary)) "��� �޿�" FROM employee GROUP BY dept_code ORDER BY AVG(salary) DESC)
WHERE ROWNUM <= 3;


-- �ǽ� ���� )
-- 1) �μ� �� �޿� �հ谡 ��ü �޿��� ���պ��� 20% ���� �μ��� �μ���, �μ��� �޿� �հ� ��ȸ

-- 2) ���� �� ���� ������ ��� �ڵ�, �����, ����, �μ���, ���޸� ��ȸ
SELECT emp_id, emp_name, dept_title, job_name FROM employee
JOIN department ON (dept_code = dept_id)
JOIN job USING (job_code);


--===================================================================================================

/*
	* ������ �ű�� �Լ� (WINDOW FUNCTION)
	RANK() OVER(���ı���) | DANSE_RANK() OVER(���ı���)
	
	- RANK() OVER(���ı���) : ������ ���� ������ ����� ������ �ο� �� ��ŭ �ǳʶٰ� �������
	- DANSE_RANK() OVER(���ı���) : ������ ������ �ִٰ��ص� �� ���� ����� ������ 1�� ����
	
	�� ������ SELECT�������� ���
*/

-- ���� ���� )
-- 1) �޿��� ���� ������� ������ �Űܼ� ��ȸ (�̸�, �޿�, ����)
SELECT emp_name, salary, RANK() OVER(ORDER BY salary DESC) "����" FROM employee;

-- 2) �޿��� ���� ������� 5�� ��ȸ
SELECT * FROM (SELECT emp_name, salary, RANK() OVER(ORDER BY salary DESC) "����" FROM employee)
WHERE "����" <= 5;