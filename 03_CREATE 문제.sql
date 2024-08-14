--�ǽ����� --
--�������� ���α׷��� ����� ���� ���̺�� �����--
--�̶�, �������ǿ� �̸��� �ο��� ��
--   �� �÷��� �ּ��ޱ�

DROP TABLE TB_MEMBER;
DROP TABLE TB_BOOK;
DROP TABLE TB_PUBLISHER;

/*
    1. ���ǻ�鿡 ���� �����͸� ������� ���ǻ� ���̺�(TB_PUBLISHER)
    �÷� : PUB_NO(���ǻ� ��ȣ) - �⺻Ű(PUBLISHER_PK)
          PUB_NAME(���ǻ��) -- NOT NULL(PUBLISHER_NN)
          PHONE(���ǻ���ȭ��ȣ) -- �������Ǿ���
*/

CREATE TABLE TB_PUBLISHER (
	PUB_NO		NUMBER			CONSTRAINT PUBLISHER_PK	PRIMARY KEY,
	PUB_NAME	VARCHAR2(30)		CONSTRAINT PUBLISHER_NN	NOT NULL,
	PHONE		VARCHAR2(15)
);

COMMENT ON COLUMN tb_publisher.pub_no IS '���ǻ� ��ȣ';
COMMENT ON COLUMN tb_publisher.pub_name IS '���ǻ��';
COMMENT ON COLUMN tb_publisher.phone IS '���ǻ� ��ȭ��ȣ';

/*
    2. �����鿡 ���� �����͸� ������� ���� ���̺�(TB_BOOK)
    �÷� : BK_NO(������ȣ)--�⺻Ű(BOOK_PK)
          BK_TITLE(������)--NOT NULL(BOOK__NN_TITLE)
          BK_AUTHOR(���ڸ�)--NOT NULL(BOOK__NN_AUTHOR)
          BK_PRICE(����)-- �������Ǿ���
          BK_PUB_NO(���ǻ� ��ȣ)--�ܷ�Ű(BOOK_FK)(TB_PUBLISHER���̺��� ����)
                                �̶� �����ϰ� �ִ� �θ����� ������ �ڽĵ����͵� ���� �ǵ��� �ɼ�����
                                
*/

CREATE TABLE TB_BOOK (
	BK_NO			NUMBER			CONSTRAINT BOOK_PK					PRIMARY KEY,
	BK_TITLE			VARCHAR2(50)		CONSTRAINT BOOK_NN_TITLE			NOT NULL,
	BK_AUTHOR		VARCHAR2(50)		CONSTRAINT BOOK_NN_AUTHOR	NOT NULL,
	BK_PRICE			NUMBER,
	BK_PUB_NO		NUMBER,
	CONSTRAINT BOOK_FK	FOREIGN KEY(BK_PUB_NO) REFERENCES tb_publisher(pub_no) ON DELETE CASCADE
);

COMMENT ON COLUMN tb_book.bk_no IS '������ȣ';
COMMENT ON COLUMN tb_book.bk_title IS '������';
COMMENT ON COLUMN tb_book.bk_author IS '���ڸ�';
COMMENT ON COLUMN tb_book.bk_price IS '����';
COMMENT ON COLUMN tb_book.bk_pub_no IS '���ǻ� ��ȣ';

--5�� ������ ���� ������ �߰��ϱ�


/*
    3. ȸ���� ���� �����͸� ������� ȸ�� ���̺�(TB_MEMBER)
    �÷��� : MEMBER_NO(ȸ����ȣ) -- �⺻Ű(MEMBER_PK)
            MEMBER_ID(���̵�) -- �ߺ�����(MEMBER_UQ_ID)
            MEMBER_PWD(��й�ȣ) -- NOT NULL(MEMBER_NN_PWD)
            MEMBER_NAME(ȸ����) -- NOT NULL(MEMBER_NN_NAME)
            GENDER(����) -- M�Ǵ� F�� �Էµǵ��� ����(MEMBER_CK_GEN)
            ADDRESS(�ּ�) -- �������Ǿ���
            PHONE(����ó)-- �������Ǿ���
            STATUS(Ż�𿩺�) -- �⺻���� N���� ����, �׸��� N�Ǵ� Y�� �Էµǵ��� �������� ����(MEMBER_CK_STA)
            ENROLL_DATE(������) -- �⺻������ SYSDATE, NOT NULL ��������(MEMBER_NN_EN)
*/

CREATE TABLE TB_MEMBER (
	MEMBER_NO		NUMBER										CONSTRAINT MEMBER_PK				PRIMARY KEY,
	MEMBER_ID			VARCHAR2(20)									CONSTRAINT MEMBER_UQ_ID			UNIQUE,
	MEMBER_PWD		VARCHAR2(20)									CONSTRAINT MEMBER_NN_PWD		NOT NULL,
	MEMBER_NAME	VARCHAR2(15)									CONSTRAINT MEMBER_NN_NAME	NOT NULL,
	GENDER				CHAR(1)											CONSTRAINT MEMBER_CK_GEN		CHECK(GENDER IN ('M', 'F')),
	ADDRESS			VARCHAR2(100),
	PHONE				VARCHAR2(15),
	STATUS				CHAR(1)				DEFAULT 'N',			CONSTRAINT MEMBER_CK_STAS		CHECK(STATUS IN ('N', 'Y')),
	ENROLL_DATE		DATE					DEFAULT SYSDATE
);

COMMENT ON COLUMN tb_member.member_no IS 'ȸ����ȣ';
COMMENT ON COLUMN tb_member.member_id IS '���̵�';
COMMENT ON COLUMN tb_member.member_pwd IS '��й�ȣ';
COMMENT ON COLUMN tb_member.member_name IS 'ȸ����';
COMMENT ON COLUMN tb_member.gender IS '����';
COMMENT ON COLUMN tb_member.address IS '�ּ�';
COMMENT ON COLUMN tb_member.phone IS '����ó';
COMMENT ON COLUMN tb_member.status IS 'Ż�𿩺�';
COMMENT ON COLUMN tb_member.enroll_date IS '������';

--5�� ������ ���� ������ �߰��ϱ�


/*
    4.� ȸ���� � ������ �뿩�ߴ����� ���� �뿩��� ���̺�(TB_RENT)
    �÷��� : RENT_NO(�뿩��ȣ)-- �⺻Ű(RENT_PK)
            RENT_MEM_NO(�뿩ȸ����ȣ)-- �ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_BOOK_NO(�뿩������ȣ)-- �ܷ�Ű(RENT_FK_BOOK) TB_BOOK�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_DATE(�뿩��) -- �⺻�� SYSDATE
*/

CREATE TABLE TB_RENT (
	RENT_NO			NUMBER								CONSTRAINT RENT_PK			PRIMARY KEY,
	RENT_MEM_NO	NUMBER								CONSTRAINT RENT_FK_MEM	REFERENCES tb_member(member_no) ON DELETE SET NULL,
	RENT_BOOK_NO	NUMBER								CONSTRAINT RENT_FK_BOOK	REFERENCES tb_book(bk_no) ON DELETE SET NULL,
	RENT_DATE			DATE			DEFAULT SYSDATE
);

COMMENT ON COLUMN tb_rent.rent_no IS '�뿩��ȣ';
COMMENT ON COLUMN tb_rent.rent_mem_no IS '�뿩ȸ����ȣ';
COMMENT ON COLUMN tb_rent.rent_book_no IS '�뿩������ȣ';
COMMENT ON COLUMN tb_rent.rent_date IS '�뿩��';

--3�� ������ ���� ������ �߰��ϱ�


