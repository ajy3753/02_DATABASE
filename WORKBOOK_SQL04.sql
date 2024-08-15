/*
    [DDL]
*/

-- 1. �迭 ������ ������ ī�װ� ���̺��� ������� �Ѵ�. ������ ���� ���̺��� �ۼ��Ͻÿ�.
CREATE TABLE tb_category (
    name    VARCHAR2(10),
    use_yn  CHAR(1)                 DEFAULT 'Y'
);

-- 2. ���� ������ ������ ���̺��� ������� �Ѵ�. ������ ���� ���̺��� �ۼ��Ͻÿ�.
CREATE TABLE tb_class_type (
    no          VARCHAR2(5)     PRIMARY KEY,
    name    VARCHAR2(10)
);

-- 3. TB_CATEGORY ���̺��� NAME �÷��� PRMARY KEY�� �����Ͻÿ�.
-- (KEY �̸��� �������� �ʾƵ� ������. ���� KEY �̸��� �����ϰ��� �Ѵٸ� �̸��� ������ �˾Ƽ� ������ �̸��� ����Ѵ�.)
ALTER TABLE tb_category ADD PRIMARY KEY(name);

-- 4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�.
ALTER TABLE tb_class_type MODIFY name NOT NULL;

-- 5. �� ���̺��� �÷� ���� NO�� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10����, �÷����� NAME�� ���� ���������� ���� Ÿ���� �����ϸ鼭 ũ�� 20���� �����Ͻÿ�.
ALTER TABLE tb_class_type
    MODIFY no NUMBER(10)
    MODIFY name VARCHAR2(20);
ALTER TABLE tb_category MODIFY name VARCHAR2(20);

-- 6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� ���� TB_�� ������ ���̺� �̸��� �տ� ���� ���·� �����Ѵ�.
-- (ex. CATEGORY_NAME)
ALTER TABLE tb_class_type RENAME COLUMN no TO class_type_no;
ALTER TABLE tb_class_type RENAME COLUMN name TO class_type_name;
ALTER TABLE tb_category RENAME COLUMN name TO category_name;

-- 7. TB_CATEGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ���� �����Ͻÿ�.
-- PRIMARY KEY�� �̸��� "PK_ + �÷��̸�"���� �����Ͻÿ�. (ex. PK_CATEGORY_NAME)
ALTER TABLE tb_class_type RENAME CONSTRAINT SYS_C007074 TO pk_category_name;

-- 8. ������ ���� INSERT ���� �����Ѵ�.
INSERT INTO tb_category VALUES ('����', 'Y');
INSERT INTO tb_category VALUES ('�ڿ�����', 'Y');
INSERT INTO tb_category VALUES ('����', 'Y');
INSERT INTO tb_category VALUES ('��ü��', 'Y');
INSERT INTO tb_category VALUES ('�ι���ȸ', 'Y');
COMMIT;

-- 9. TB_DEPARTMENT�� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� �θ����� �����ϵ��� FOREIGN KEY�� �����Ͻÿ�.
-- �̶� KEY �̸��� FK_���̺��̸�_�÷��̸����� �����Ѵ�. (ex. FK_DEPARTMENT_CATEGORY)
ALTER TABLE tb_department ADD FOREIGN KEY(category) REFERENCES tb_category(category_name);

-- 10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW�� ������� �Ѵ�. �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.
CREATE OR REPLACE VIEW vw_�л��Ϲ�����
AS (
    SELECT student_no AS "�й�", student_name AS "�л��̸�", student_address AS "�ּ�"
    FROM tb_student
);

-- 11. �� ��� ���б��� 1�⿡ �� ���� �а����� �л��� ���������� ���� ����� �����Ѵ�.
-- �̸� ���� ����� �л��̸�, �а��̸�, ��米���̸����� �����Ǿ��ִ� VIEW�� ����ÿ�. �̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ�.
-- (��, �� VIEW�� �ܼ� SELECT���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)
CREATE OR REPLACE VIEW vw_�������
AS (
    SELECT ROW_NUMBER() OVER (ORDER BY department_name) AS "����", student_name AS "�л��̸�", department_name AS "�а��̸�", professor_name AS "���������̸�"
    FROM tb_student
    JOIN tb_department USING (department_no)
    LEFT JOIN tb_professor ON (coach_professor_no = professor_no)
);

-- 12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW�� �ۼ��� ����.
CREATE OR REPLACE VIEW vw_�а����л���
AS (
    SELECT department_name, COUNT(student_no) AS "STUDENT_COUNT"
    FROM tb_department
    JOIN tb_student USING (department_no)
    GROUP BY department_name
);

-- 13. ������ ������ �л��Ϲ����� View�� ���ؼ� �й��� A213046�� �л��� �̸��� ���� �̸����� �����ϴ� SQL���� �ۼ��Ͻÿ�
UPDATE vw_�л��Ϲ�����
SET �л��̸�  = '������'
WHERE �й� = 'A213046';

-- 14. 13�������� ���� VIEW�� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW�� ��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�.
CREATE OR REPLACE VIEW vw_�л��Ϲ�����
AS (
    SELECT student_no AS "�й�", student_name AS "�л��̸�", student_address AS "�ּ�"
    FROM tb_student
) WITH READ ONLY;

-- 15. �� ������б��� �ų� ������û �Ⱓ�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ���� ������ �ǰ��ִ�.
-- �ֱ� 3���� �������� ������û�� ���� ���Ҵ� 3������ ã�� ������ �ۼ��غ��ÿ�.
SELECT class_no AS "�����ȣ", class_name  AS "�����̸�", COUNT(class_no) AS "������������(��)"
FROM tb_class
JOIN tb_grade USING (class_no)
WHERE term_no LIKE '2008%'
               OR term_no LIKE '2006%'
GROUP BY class_no, class_name
ORDER BY COUNT(class_no) DESC;