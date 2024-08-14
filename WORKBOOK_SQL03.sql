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

-- 11. �й��� A313047�� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ� ���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. �̶� ����� SQL ���� �ۼ��Ͻÿ�.
-- ��, �������� "�а��̸�", "�л��̸�", "���������̸�"���� ��µǵ��� �Ѵ�.
SELECT department_name AS "�а��̸�", student_name AS "�л��̸�", professor_name AS "���������̸�"
FROM tb_student
JOIN tb_department USING (department_no)
JOIN tb_professor ON (coach_professor_no = professor_no)
WHERE student_no = 'A313047';

-- 12. 2007�⵵�� '�ΰ������' ������ ������ �л��� ã�� �л� �̸��� �����ϱ⸦ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT student_name, term_no FROM tb_grade
JOIN tb_student USING (student_no)
JOIN tb_class USING (class_no)
WHERE SUBSTR(term_no, 1, 4) = '2007'
            AND class_name = '�ΰ������';
            
-- 13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ���� �̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT class_name, department_name FROM tb_department
LEFT JOIN tb_professor USING (department_no)
JOIN tb_class USING (department_no)
WHERE category = '��ü��'
            AND professor_no IS NULL;
            
-- 14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� �Ѵ�.
-- �л��̸��� �������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� "�������� ������"���� ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ��, �������� "�л��̸�", "��������"�� ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� �Ѵ�.
SELECT student_name AS "�л� �̸�", NVL(professor_name, '�������� ������') AS "��������"
FROM tb_student
JOIN tb_department USING (department_no)
LEFT JOIN tb_professor ON (coach_professor_no = professor_no)
WHERE department_name = '���ݾƾ��а�'
ORDER BY student_no;

-- 15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а��̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT �й�, student_name AS "�̸�", department_name AS "�а��̸�", ����
FROM (
    SELECT student_no AS "�й�", ROUNd(AVG(point), 10) AS "����"
    FROM tb_grade
    GROUP BY student_no
    HAVING AVG(point) >= 4
)
JOIN tb_student ON (�й� = tb_student.student_no)
JOIN tb_department USING (department_no)
WHERE absence_yn = 'N'
ORDER BY student_no;

-- 16. ȯ�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
SELECT class_no, class_name, AVG
FROM (
    SELECT class_no, ROUND(AVG(point), 10) AS "AVG"
    FROM tb_grade
    GROUP BY class_no
)
JOIN tb_class USING (class_no)
JOIN tb_department USING (department_no)
WHERE department_name = 'ȯ�������а�'
            AND class_type LIKE '����%'
ORDER BY class_no;

-- 17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT student_name, student_address
FROM tb_student
JOIN tb_department USING (department_no)
WHERE department_no = (SELECT department_no FROM tb_student WHERE student_name = '�ְ���');

-- 18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM (
    SELECT student_no, student_name
    FROM tb_student
    JOIN tb_grade USING (student_no)
    JOIN tb_department USING (department_no)
    WHERE department_name = '������а�'
    GROUP BY student_no, student_name
    ORDER BY AVG(point) DESC
) WHERE ROWNUM <= 1;

-- 19. �� ������б��� "ȯ�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������ �ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�.
-- ��, �������� "�迭 �а���", "��������"���� ǥ�õǵ��� �ϰ�, ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ��� �Ѵ�.
SELECT department_name AS "�迭 �а���", ROUND(AVG(point), 1) AS "��������"
FROM tb_grade
JOIN tb_class USING (class_no)
JOIN tb_department USING (department_no)
GROUP BY department_name;