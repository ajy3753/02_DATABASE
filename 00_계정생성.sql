/*  [계정 생성 방법]
    CREATE USER 계정이름 IDENTIFIED BY 비밀번호;
*/
CREATE USER KH IDENTIFIED BY KH;

-- KH 계정에 최소한의 권한을 부여 (접속, 데이터 관리)
GRANT CONNECT, RESOURCE TO KH;