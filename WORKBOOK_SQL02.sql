/*
	[Additional SELECT - �Լ�]
*/

-- 1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
-- (��, ����� "�й�", "�̸�", "�����⵵"�� ǥ�õǵ��� �Ѵ�.)
SELECT student_no AS "�й�", student_name AS "�̸�", TO_CHAR(entrance_date, 'YYYY-MM-DD') AS "���� �⵵" FROM tb_student
ORDER BY entrance_date ASC;

-- 2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� �Ѵ�. �� ������ �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��غ���.
-- (* �̶� �ùٸ��� �ۼ��� SQL ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
SELECT professor_name, professor_ssn FROM tb_professor
WHERE LENGTH(professor_name) != 3;

-- 3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
-- ��, �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�.
-- (��, ���� �� 2000�� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� �Ѵ�. ���̴� '��'���� ����Ѵ�.)
SELECT	professor_name AS "�����̸�",
			EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(professor_ssn, 1, 6), 'RR/MM/DD')) AS "����"
FROM tb_professor
WHERE SUBSTR(professor_ssn, 8, 1) IN ('1', '3')
ORDER BY ���� ASC;

-- 4 . �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� ����� "�̸�"�� �������� �Ѵ�. (���� 2���� ������ ���ٰ� �����Ͻÿ�)
SELECT SUBSTR(professor_name, 2) AS "�̸�" FROM tb_professor;

-- 5. �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�?
-- �̶�, 19�쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�.
SELECT student_no, student_name FROM tb_student
WHERE EXTRACT(YEAR FROM entrance_date) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(student_ssn, 1, 6))) > 18;

-- 6. 2020�� ũ���������� ���� �����ΰ�?
SELECT TO_CHAR(TO_DATE(20201225), 'DAY') AS "2020�� ũ��������" FROM dual;

-- 7. TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD')�� ���� �� �� �� �� ��ĥ�� �ǹ��ұ�?
-- �� TO_DATE('99/10/11', 'RR/MM/DD'), TO_DATE('49/10/11', 'RR/MM/DD')�� ���� �� �� �� �� ��ĥ�� �ǹ��ұ�?
SELECT	TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'), 'YYYY"��" MM"��" DD"��"'),
			TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'), 'YYYY"��" MM"��" DD"��"')
FROM dual;

SELECT	TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'), 'YYYY"��" MM"��" DD"��"'),
			TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'), 'YYYY"��" MM"��" DD"��"')
FROM dual;

-- 8. �� ������б��� 2000�⵵ ���� �����ڵ��� �й��� A�� �����ϰ� �Ǿ��ִ�.
-- 2000�⵵ ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT student_no, student_name FROM tb_student
WHERE SUBSTR(student_no, 1, 1) != 'A';

-- 9. �й��� A517178�� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- ��, �̶� ���ȭ���� ����� "����"�̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ���ڸ������� ǥ���Ѵ�.
SELECT ROUND(AVG(point), 1) AS "����"
FROM  tb_grade
WHERE student_no = 'A517178';

-- 10. �а��� �л� ���� ���Ͽ� "�а���ȣ", "�л���(��)"�� ���·� ����� ������� ��µǵ��� �Ͻÿ�.
SELECT department_no AS "�а���ȣ", COUNT(department_no) AS "�л���(��)"
FROM tb_department
JOIN tb_student USING (department_no)
GROUP BY department_no
ORDER BY department_no;

-- 11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ��� �˾Ƴ��� SQL���� �ۼ��Ͻÿ�.
SELECT COUNT(*) FROM tb_student WHERE coach_professor_no IS NULL;

-- 12. �й��� A112113�� ���� �л��� ���� �� ������ ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- ��, �̶� ���ȭ���� ����� "�⵵", "���� �� ����"�̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.
SELECT SUBSTR(term_no, 1, 4) AS "�⵵", ROUND(AVG(point), 1) "���� �� ����"
FROM tb_grade
WHERE student_no = 'A112113'
GROUP BY SUBSTR(term_no, 1, 4);

-- 13. �а� �� ���л� ���� �ľ��ϰ��� �Ѵ�. �а���ȣ�� ���л� ���� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT department_no AS "�а��ڵ��", COUNT(absence_yn) AS "���л� ��"
FROM tb_student
WHERE absence_yn = 'Y'
GROUP BY department_no
ORDER BY department_no;

-- 14. �� ���б��� �ٴϴ� �������� �л����� �̸��� ã���� �Ѵ�. � SQL ������ ����ϸ� �����ϰڴ°�?
SELECT student_name, COUNT(*) FROM tb_student
GROUP BY student_name
HAVING COUNT(*) > 1;

-- 15. �й��� A112113�� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ����, �������� ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- (��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.)
SELECT SUBSTR(term_no, 1, 4) AS "�⵵", SUBSTR(term_no, 5, 2) AS "�б�", ROUND(AVG(point), 1)
FROM tb_grade
WHERE student_no = 'A112113'
GROUP BY term_no
ORDER BY term_no;