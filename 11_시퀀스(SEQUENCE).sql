/*
	<������ SEQUENCE>
	�ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü
	�������� ���������� �����ϰ� ������Ű�鼭 �������ش�.
	
	ex ) ȸ����ȣ, �����ȣ, �Խñ� ��ȣ ��
*/

/*
	1. ������ ��ü ����
	
	[ǥ����]
	CREATE SEQUENCE ��������
	[START WITH ���ۼ���]	-> ó�� �߻���ų ���۰� ���� (�⺻�� 1)
	[INCREMENT BY ����] 	-> �� �� ������ų ���� ���� (�⺻�� 1)
	[MAXVALUE ����]			-> �ִ밪 ���� (�⺻���� ������ �ſ� ũ�Ƿ� ���X)
	[MINVALUE ����]			-> �ּҰ� ���� (�⺻�� 1)
	[CYCLE | NOCYCLE]		-> �� ��ȯ ���� (�⺻�� NOCYCEL)
	[CACHE | NOCACHE]		-> ĳ�� �޸� �Ҵ� (�⺻�� CACHE 20)
	
	* ĳ�� �޸�
	�̸� �߻��� ������ �����ؼ� �����صδ� ����
	�Ź� ȣ��� ������ ���ο� ��ȣ�� �����ϴ� �� �ƴ϶� ĳ�� �޸� ������ �̸� ������ ������ ������ �� �� �ִ�. (�ӵ��� ��������.)
	
	* ���� ���� ���
	- ���̺�� : TB_
	- ������ : SEQ_
	- Ʈ���� : TRG_
*/

-- ex )
CREATE SEQUENCE seq_test;

CREATE SEQUENCE seq_empno
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

-- [����] ���� ������ ������ ���������� ������ ���� ���� ��
SELECT * FROM user_sequences;


--===================================================================================================

/*
	2. ������ ���
	
	��������.CURRVAL : ���� ������ �� (���������� ������ NEXTVAL�� ���ప)
	��������.NEXTVAL : ���������� ������ ���� �������� �߻��� �� (���� ������ ���� INCREMENT BY ����ŭ ������ ��)
*/

-- ex )
SELECT seq_empno.CURRVAL FROM dual;
-- > NEXTVAL�� �� ���� �������� ���� ���·� CURRVAL�� ����� �� ����
-- > CURRVAL�� ���������� ������ NEXTVAL�� ���� �����ؼ� �����ִ� �ӽð��̱� ����

SELECT seq_empno.NEXTVAL FROM dual;	-- 300
SELECT seq_empno.NEXTVAL FROM dual;	-- 305
SELECT seq_empno.NEXTVAL FROM dual;	-- 310
SELECT seq_empno.NEXTVAL FROM dual;	-- 315�� �ִ밪 310�� �Ѱ�, ���� �߻�

SELECT seq_empno.CURRVAL FROM dual;	-- ����� ���� �ִ밪�� 310 (�ִ밪�� �ѱ� NEXTVAL�� ����X)

--===================================================================================================

/*
	3. �������� ���� ����
	
	ALTER SEQUENCE ��������
	[INCREMENT BY ����]
	[MAXVALUE ����]
	[MINVALUE ����]
	[CYCLE | NOCYCLE]
	[CACHE ����Ʈũ�� | NOCACHE]
	
	* START WITH�� ���� �Ұ�
*/

ALTER SEQUENCE seq_empno
INCREMENT BY 10
MAXVALUE 400;

SELECT seq_empno.NEXTVAL FROM dual;


--===================================================================================================

/*
	4. ������ ����
	
	[ǥ����]
	DROP SEQUENCE ��������;
*/

-- ex )
DROP SEQUENCE seq_empno;