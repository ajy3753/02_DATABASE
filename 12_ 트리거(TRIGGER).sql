/*
	<Ʈ����>
	���� ������ ���̺� INSERT, UPDATE, DELETE �� DML���� ���� ��������� ���� ��
	�ڵ����� �Ź� ������ ������ �̸� �����ص� �� �ִ�.
	
	ex )
	- ȸ�� Ż�� �� ������ ȸ�� ���̺��� �����͸� DELETE�� ��, ��ٷ� Ż���� ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT ��Ų��.
	- �Ű�Ƚ���� ���� ���� �Ѱ��� �� ���������� �ش� ȸ���� ������Ʈ�� ó���Ѵ�.
	- ����� ���� ������ ���(INSERT)�� �� ������ �ش� ��ǰ�� ���� �������� �Ź� ����(UPDATE)�Ѵ�.
	
	* Ʈ������ ����
	- SQL���� ����ñ⿡ ���� �з�
	- BRFORE TRIGGER : ������ ���̺� �̺�Ʈ�� �߻��Ǳ� ���� Ʈ���Ÿ� ����
	- AFTER TRIGGER : ������ ���̺� �̺�Ʈ�� �߻��� �� Ʈ���� ����
	
	* SQL���� ���� ������ �޴� �� �࿡ ���� ����
	- ���� Ʈ���� : �̺�Ʈ�� �߻��� SQL�� ���� �� �� ���� Ʈ���� ����
	- �� Ʈ���� : �ش� SQL���� ������ ������ �Ź� Ʈ���� ���� (FOR EACH ROW �ɼ� ����ؾ���)
		-> OLD : BEFORE UPDATE(���� �� �ڷ�), BEFORE DELETE(���� �� �ڷ�)
		-> NEW : AFTER INSERT(�߰��� �ڷ�), AFTER UPDATE(���� �� �ڷ�)
	
	* Ʈ���� ���� ����
	
	[ǥ����]
	CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
	BEFORE | AFTER	INSERT | UPDATE | DELETE	ON ���̺��
	[FOR EACH ROW]
	[DECLARE ��������]
	BEGIN
		���೻��(���������� ���� �̺�Ʈ�� �߻����� �� ������ ����);
	[EXCEPTION ����ó��]
	END;
	/
*/

-- ex )
-- [���� �۾�] SERVEROUPUT ����
SET SERVEROUTPUT ON;

-- employee ���̺� ���ο� ���� INSERT �� ������ �ڵ����� ������ ��µǴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER trg_01
AFTER INSERT ON employee
BEGIN
	DBMS_OUTPUT.PUT_LINE('���Ի���� �ȳ��ϼ���.');
END;
/

INSERT INTO employee (emp_id, emp_name, emp_no, dept_code, job_code, hire_date)
VALUES (903, '����', '111111-1111111', 'D7', 'J7', SYSDATE);


----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- ���� ����
-- 1 ) ��ǰ�� ���� �����͸� ������ ���̺�(TB_PRODUCT) ����
CREATE TABLE tb_product (
	pcode	NUMBER		PRIMARY KEY,
	pname	VARCHAR2(30)	NOT NULL,
	brand		VARCHAR2(30)	NOT NULL,
	price		NUMBER,
	stock		NUMBER DEFAULT 0
);

-- 2 ) ��ǰ��ȣ �ߺ� �� �ǰԲ� �Ź� ���ο� ��ȣ�� �߻���Ű�� ������ ����
CREATE SEQUENCE seq_pcode
START WITH 200
INCREMENT BY 5;

-- ���� ������
INSERT INTO tb_product VALUES (seq_pcode.NEXTVAL, '������24', '�Ｚ', 1500000, DEFAULT);
INSERT INTO tb_product VALUES (seq_pcode.NEXTVAL, '������15', '����', 1300000, 10);
INSERT INTO tb_product VALUES (seq_pcode.NEXTVAL, '������8', '������', 800000, 20);

COMMIT;

-- 3 ) ��ǰ ����� �� �̷� ���̺� ����(TB_PRODETAIL)
CREATE TABLE TB_PRODETAIL (
	decore	NUMBER	PRIMARY KEY,
	pcode	NUMBER	REFERENCE tb_product,
	pdate		DATE			NOT NULL,
	amount	NUMBER	NOT NULL,
	status		CHAR(6)		CHECK (status IN ('�԰�', '���'))
);

--