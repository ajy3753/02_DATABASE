/*
	[Basic SELECT]
*/

-- 1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�,
-- ��, ��� ����� "�а� ��", "�迭"���� ǥ���ϵ��� �Ѵ�.
SELECT department_name AS "�а� ��", category AS "�迭" FROM tb_department;

-- 2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ����Ѵ�.
SELECT department_name || '�� ������ ' || capacity || '�� �Դϴ�.' AS "�а��� ����" FROM tb_department;

-- 3. "������а�"�� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û�� ���Դ�. �����ΰ�?
-- (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ������ ����)
SELECT * FROM tb_student
WHERE	department_no = 001
			AND SUBSTR(student_ssn, 8, 1) IN ('2', '4')
			AND absence_yn = 'Y';
			
-- 4. ���������� ���� ��� ��ü�ڵ��� ã�� �̸��� �Խ��ϰ��� �Ѵ�. �� ����ڵ��� �й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
-- A513079, A513090, A513110, A513110, A513119
SELECT student_name FROM tb_student
WHERE student_no IN ('A513079', 'A513090', 'A513110', 'A513110', 'A513119')
ORDER BY student_name DESC;

-- 5. ���������� 20�� �̻� 30�� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
SELECT department_name, category FROM tb_department
WHERE capacity >= 20 AND capacity <= 30;

-- 6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�. �׷� �� ������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT professor_name FROM tb_professor WHERE department_no IS NULL;

-- 7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ� Ȯ���ϰ��� �Ѵ�. ��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
SELECT * FROM tb_student WHERE department_no IS NULL;

-- 8. ������û�� �Ϸ��� �Ѵ�. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ� ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
SELECT class_no FROM tb_class WHERE preattending_class_no IS NOT NULL;

-- 9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
SELECT DISTINCT category FROM tb_department;

-- 10. 02�й� ���� �����ڵ��� ������ ������� �Ѵ�. ������ ������� ������ �������� �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
SELECT student_no, student_name, student_ssn FROM tb_student
WHERE SUBSTR(entrance_date, 1, 2) = '02'
			AND student_address LIKE '����%'
			AND absence_yn = 'N';