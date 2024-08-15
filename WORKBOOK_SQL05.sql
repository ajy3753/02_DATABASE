/*
    [DML]
*/

-- 1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.
INSERT INTO tb_class_type VALUES (1, '�����ʼ�');
INSERT INTO tb_class_type VALUES (2, '��������');
INSERT INTO tb_class_type VALUES (3, '�����ʼ�');
INSERT INTO tb_class_type VALUES (4, '���缱��');
INSERT INTO tb_class_type VALUES (5, '������');
COMMIT;

-- 2. �� ������б� �л����� ������ ���ԵǾ��ִ� �л��Ϲ����� ���̺��� ������� �Ѵ�. �Ʒ� ������ �����Ͽ� ������ SQL���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�.)
CREATE TABLE tb_�л��Ϲ�����
AS SELECT student_no, student_name, student_address FROM tb_student;

-- 3. ������а� �л����� �������� ���ԵǾ��ִ� �а� ���� ���̺��� ������� �Ѵ�.
-- �Ʒ� ������ �����Ͽ� ������ SQL���� �ۼ��Ͻÿ�. (��Ʈ: ����� �پ���, �ҽŲ� �ۼ��Ͻÿ�.)
CREATE TABLE tb_������а�
AS (
    SELECT student_no, student_name, SUBSTR(student_ssn, 1, 4) AS "����⵵", professor_name, department_name
    FROM tb_student
    LEFT JOIN tb_professor ON (coach_professor_no = professor_no)
    JOIN tb_department ON (tb_student.department_no = tb_department.department_no)
    WHERE department_name = '������а�'
);

-- 4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL���� �ۼ��Ͻÿ�.
-- (��, �ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� �Ѵ�.)
UPDATE tb_department
SET capacity = (capacity * 1.1)
WHERE open_yn = 'Y';

-- 5. �й� A413042�� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21"�� ����Ǿ��ٰ� �Ѵ�. �ּ����� �����ϱ� ���� ����� SQL ���� �ۼ��Ͻÿ�.
UPDATE tb_student SET student_address = '����� ���α� ���ε� 181-21' WHERE student_no = 'A413042';

-- 6.  �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ�� �����Ͽ���. �� ������ �ݿ��� ������ SQL ������ �ۼ��Ͻÿ�.
UPDATE tb_student
SET student_ssn = SUBSTR(student_ssn, 1, 6);

-- 7. ���а� ����� �л��� 2005�� 1�б⿡ �ڽ��� ������ '�Ǻλ�����' ������ �߸��Ǿ��ٴ� ���� �߰��ϰ�� ������ ��û�Ͽ���.
-- ��� ������ Ȯ�� ���� ��� �ش� ������ ������ 3.5�� ����Ű�� �����Ǿ���. ������ SQL ���� �ۼ��Ͻÿ�.
UPDATE tb_grade SET point = 3.5
WHERE student_no = (
                                            SELECT student_no
                                            FROM tb_student
                                            JOIN tb_department USING (department_no)
                                            WHERE student_name = '�����' AND department_name = '���а�'
)
 AND class_no = (
                                    SELECT class_no
                                    FROM tb_class
                                    WHERE class_name = '�Ǻλ�����'
);

-- 8. ���� ���̺�(TB_GRADE)���� ���л����� ���� �׸��� �����Ͻÿ�.
DELETE FROM tb_grade
WHERE student_no IN (
                                            SELECT student_no
                                            FROM tb_student
                                            WHERE absence_yn = 'Y'
);

ROLLBACK;