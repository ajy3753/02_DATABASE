/*
	<GROUP BY ��>
	�׷������ ������ �� �ִ� ���� (�ش� �׷� ���� ���� ���� �׷����� ���� �� ����)
	���� ���� ������ �ϳ��� �׷����� ��� ó���ϴ� �������� ���
*/

-- ex )
SELECT SUM(salary) FROM employee;													-- ��ü ����� �ϳ��� �׷����� ��� ������ ���� ��
SELECT dept_code, SUM(salary) FROM employee GROUP BY dept_code;		-- �� �μ��� �޿� ����
SELECT dept_code, COUNT(*) FROM employee GROUP BY dept_code;			-- �� �μ��� ��� ��

-- GROUP BY�� ���� �� �ڵ� ���� ����
SELECT dept_code, COUNT(*), SUM(salary)		-- 3
FROM employee										-- 1
GROUP BY dept_code								-- 2
ORDER BY dept_code;								-- 4 ORDER BY�� ������ �������� ���� -> ������ �������� ���ִ� ���� �ƴϸ� �ǹ�X

-- ���� ���� ) �� ���޺� �� �����, ���ʽ��� �޴� ��� ��, �޿� ��, ��� �޿�, ���� �޿�, �ְ� �޿� (����: ���� ��������)
SELECT	COUNT(*) "�� ��� ��",
			COUNT(bonus) "���ʽ��� �޴� ��� ��",
			SUM(salary), AVG(salary),
			MIN(salary) "���� �޿�",
			MAX(salary) "�ְ� �޿�"
FROM employee GROUP BY dept_code;


--===================================================================================================

/*
	[HAVING ��]
	�׷쿡 ���� ������ ������ �� ���Ǵ� ���� (�ַ� �׷��Լ����� ������ ������ �����.)
*/

-- ex )
-- �� �μ��� ��� �޿� (�μ��ڵ�, ��� �޿�)
SELECT dept_code, ROUND(AVG(salary)) FROM employee GROUP BY dept_code;
-- �� �μ��� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT dept_code, ROUND(AVG(salary)) FROM employee GROUP BY dept_code HAVING AVG(salary) >= 3000000;
-- ���޺� �����ڵ�, �� �޿��� (��, ���޺� �޿����� 1000���� �̻��� ���ݸ� ��ȸ)
SELECT job_code, SUM(salary) FROM employee GROUP BY job_code HAVING sum(salary) >= 10000000;
-- �μ��� ���ʽ��� �޴� ����� ���� �μ��� �μ��ڵ�
SELECT dept_code FROM employee GROUP BY dept_code HAVING COUNT(bonus) = 0;


--===================================================================================================

/*
	SELECT * | ��ȸ�ϰ� ���� �÷��� | �Լ��� | �������
	FROM  ��ȸ�ϰ� ���� ���̺� | DUAL
	GROUP BY �׷��� ������ �Ǵ� �÷� | �Լ���
	HAVING ���ǽ�
	ORDER BY �÷� | ��Ī | ���� [ASC | DESC] [NULLS FIRST | NULLS LAST]
*/


--===================================================================================================

/*
	[���� ������]
	�������� �������� �ϳ��� ���������� ����� ������
	
	- UNION : OR | ������ (�� ������ ������ ������� ���Ѵ�)
	- INTERSECT :   AND | ������ (�� �������� ������ ������� �ߺ��� �����) 4
	
*/