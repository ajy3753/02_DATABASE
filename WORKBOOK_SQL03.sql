/*
	[Additinal SELECT - Option]
*/

-- 1. �л��̸��� �ּ����� ǥ���Ͻÿ�.
-- ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�, ������ �̸����� �������� ǥ���ϵ��� �Ѵ�.
SELECT student_name AS "�л� �̸�", student_address AS "�ּ���" FROM tb_student
ORDER BY student_name ASC;

-- 2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
SELECT student_name, student_ssn FROM tb_student
WHERE absence_yn = 'Y'
ORDER BY student_ssn DESC;

-- 3. �ּ����� �������� ��⵵�� �л��� �� 1900��� �й��� ���� �л����� �̸��� �й�, �ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�.
-- ��, ��� ������� "�л��̸�", "�й�", "������ �ּ�"�� ��µǵ��� �Ѵ�.
SELECT student_name AS "�л��̸�", student_no AS "�й�", student_address AS "������ �ּ�" FROM tb_student
WHERE	student_address LIKE '������%'
			OR student_address LIKE '��⵵%'
			AND SUBSTR(student_no, 1, 1) != 'A'
ORDER BY student_address DESC;

-- 4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
-- (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ����������)
SELECT professor_name, professor_ssn FROM tb_professor
WHERE department_no = '005'
ORDER BY SYSDATE - TO_DATE(SUBSTR(professor_ssn, 1, 6)) DESC;

-- 5. 2004�� 2�б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� �Ѵ�.
-- ������ ���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������ �ۼ��غ��ÿ�.
SELECT student_no, point FROM tb_grade
WHERE	class_no = 'C3118100'
			AND term_no = '200402'
ORDER BY point DESC, student_no;

-- 6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL���� �ۼ��Ͻÿ�.
SELECT student_no, student_name, department_name
FROM tb_student
JOIN tb_department USING (department_no)
ORDER BY student_name ASC;

-- 7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT class_name, department_name FROM tb_class
JOIN tb_department USING (department_no);

-- 8. ���� ���� �̸��� ã������ �Ѵ�. ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT class_name, professor_name FROM tb_class
JOIN tb_class_professor USING (class_no)
JOIN tb_professor USING (professor_no)
ORDER BY professor_name;

-- 9. 8���� ��� �� '�ι���ȸ' �迭�� ���� ������ ���� �̸��� ã������ �Ѵ�. �̿� �ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL���� �ۼ��Ͻÿ�.
SELECT class_name, professor_name FROM tb_class
JOIN tb_class_professor USING (class_no)
JOIN tb_professor USING (professor_no)
JOIN tb_department ON (tb_class.department_no = tb_department.department_no)
WHERE category = '�ι���ȸ'
ORDER BY professor_name;

-- 10. '�����а�' �л����� ������ ���Ϸ��� �Ѵ�.
-- �����а� �л����� "�й�", "�л� �̸�", "��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
-- (��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.)
SELECT student_no AS "�й�", ROUND(AVG(point), 1) AS "��ü ����"
FROM tb_grade
JOIN tb_student USING (student_no)
JOIN tb_department USING (department_no)
WHERE department_name = '�����а�'
GROUP BY student_no
ORDER BY student_no;