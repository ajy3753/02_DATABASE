/*
    [DDL]
*/

-- 1. 계열 정보를 저장할 카테고리 테이블을 만들려고 한다. 다음과 같은 테이블을 작성하시오.
CREATE TABLE tb_category (
    name    VARCHAR2(10),
    use_yn  CHAR(1)                 DEFAULT 'Y'
);

-- 2. 과목 구분을 저장할 테이블을 만들려고 한다. 다음과 같은 테이블을 작성하시오.
CREATE TABLE tb_class_type (
    no          VARCHAR2(5)     PRIMARY KEY,
    name    VARCHAR2(10)
);

-- 3. TB_CATEGORY 테이블의 NAME 컬럼에 PRMARY KEY를 생성하시오.
-- (KEY 이름을 생성하지 않아도 무방함. 만일 KEY 이름을 지정하고자 한다면 이름은 본인이 알아서 적당한 이름을 사용한다.)
ALTER TABLE tb_category ADD PRIMARY KEY(name);

-- 4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오.
ALTER TABLE tb_class_type MODIFY name NOT NULL;

-- 5. 두 테이블에서 컬럼 명이 NO인 것은 기존 타입을 유지하면서 크기는 10으로, 컬럼명이 NAME인 것은 마찬가지로 기존 타입을 유지하면서 크기 20으로 변경하시오.
ALTER TABLE tb_class_type
    MODIFY no NUMBER(10)
    MODIFY name VARCHAR2(20);
ALTER TABLE tb_category MODIFY name VARCHAR2(20);

-- 6. 두 테이블의 NO 컬럼과 NAME 컬럼의 이름을 각각 TB_를 제외한 테이블 이름이 앞에 붙은 형태로 변경한다.
-- (ex. CATEGORY_NAME)
ALTER TABLE tb_class_type RENAME COLUMN no TO class_type_no;
ALTER TABLE tb_class_type RENAME COLUMN name TO class_type_name;
ALTER TABLE tb_category RENAME COLUMN name TO category_name;

-- 7. TB_CATEGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 이름을 다음과 같이 변경하시오.
-- PRIMARY KEY의 이름은 "PK_ + 컬럼이름"으로 지정하시오. (ex. PK_CATEGORY_NAME)
ALTER TABLE tb_class_type RENAME CONSTRAINT SYS_C007074 TO pk_category_name;

-- 8. 다음과 같은 INSERT 문을 수행한다.
INSERT INTO tb_category VALUES ('공학', 'Y');
INSERT INTO tb_category VALUES ('자연과학', 'Y');
INSERT INTO tb_category VALUES ('의학', 'Y');
INSERT INTO tb_category VALUES ('예체능', 'Y');
INSERT INTO tb_category VALUES ('인문사회', 'Y');
COMMIT;

-- 9. TB_DEPARTMENT의 CATEGORY 컬럼이 TB_CATEGORY 테이블의 CATEGORY_NAME 컬럼을 부모값으로 참조하도록 FOREIGN KEY를 지정하시오.
-- 이때 KEY 이름을 FK_테이블이름_컬럼이름으로 지정한다. (ex. FK_DEPARTMENT_CATEGORY)
ALTER TABLE tb_department ADD FOREIGN KEY(category) REFERENCES tb_category(category_name);

-- 10. 춘 기술대학교 학생들의 정보만이 포함되어 있는 학생일반정보 VIEW를 만들고자 한다. 아래 내용을 참고하여 적절한 SQL 문을 작성하시오.
CREATE OR REPLACE VIEW vw_학생일반정보
AS (
    SELECT student_no AS "학번", student_name AS "학생이름", student_address AS "주소"
    FROM tb_student
);

-- 11. 춘 기술 대학교는 1년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행한다.
-- 이를 위해 사용할 학생이름, 학과이름, 담당교수이름으로 구성되어있는 VIEW를 만드시오. 이때 지도 교수가 없는 학생이 있을 수 잇음을 고려하시오.
-- (단, 이 VIEW는 단순 SELECT만을 할 경우 학과별로 정렬되어 화면에 보여지게 만드시오.)
CREATE OR REPLACE VIEW vw_지도면담
AS (
    SELECT ROW_NUMBER() OVER (ORDER BY department_name) AS "순서", student_name AS "학생이름", department_name AS "학과이름", professor_name AS "지도교수이름"
    FROM tb_student
    JOIN tb_department USING (department_no)
    LEFT JOIN tb_professor ON (coach_professor_no = professor_no)
);

-- 12. 모든 학과의 학과별 학생 수를 확인할 수 있도록 적절한 VIEW를 작성해 보자.
CREATE OR REPLACE VIEW vw_학과별학생수
AS (
    SELECT department_name, COUNT(student_no) AS "STUDENT_COUNT"
    FROM tb_department
    JOIN tb_student USING (department_no)
    GROUP BY department_name
);

-- 13. 위에서 생성한 학생일반정보 View를 통해서 학번이 A213046인 학생의 이름을 본인 이름으로 벼경하는 SQL문을 작성하시오
UPDATE vw_학생일반정보
SET 학생이름  = '안지윤'
WHERE 학번 = 'A213046';

-- 14. 13번에서와 같이 VIEW를 통해서 데이터가 변경될 수 있는 상황을 막으려면 VIEW를 어떻게 생성해야 하는지 작성하시오.
CREATE OR REPLACE VIEW vw_학생일반정보
AS (
    SELECT student_no AS "학번", student_name AS "학생이름", student_address AS "주소"
    FROM tb_student
) WITH READ ONLY;

-- 15. 춘 기술대학교는 매년 수강신청 기간만 되면 특정 인기 과목들에 수강 신청이 몰려 문제가 되고있다.
-- 최근 3년을 기준으로 수강신청이 가장 많았던 3과목을 찾는 구문을 작성해보시오.
SELECT class_no AS "과목번호", class_name  AS "과목이름", COUNT(class_no) AS "누적수강생수(명)"
FROM tb_class
JOIN tb_grade USING (class_no)
WHERE term_no LIKE '2008%'
               OR term_no LIKE '2006%'
GROUP BY class_no, class_name
ORDER BY COUNT(class_no) DESC;