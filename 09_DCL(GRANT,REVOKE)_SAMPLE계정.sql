
-- CREATE TABLE �� �� �ִ� ������ ��� ���� �߻�
-- 3_1. CREATE TABLE ���� �ο��ޱ�
-- 3_2. TABLESPACE �Ҵ� �ޱ�
CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- ���� ���̺���������� �ο��ް� �Ǹ�
-- ������ �����ϰ� �ִ� ���̺���� �����ϴ°͵� ��������
SELECT * FROM TEST;
INSERT INTO TEST VALUES(1);

-- �� ��ü�� ������ �� �ִ� CREATE VIEW ������ ���⶧���� ���� �߻�
-- 4. CREATE VIEW ���� �ο��ޱ�
CREATE VIEW V_TEST
AS SELECT * FROM TEST;

---------------------------------------------------------------

-- KH������ ���̺� �����ؼ� ��ȸ�� �� �ִ� ������ ���⶧���� ���� �߻�
-- 5. KH.EMPLOYEE�� SELECT�� �� �ִ� ���� �ο��ޱ�
SELECT *
FROM KH.EMPLOYEE;

SELECT *
FROM KH.DEPARTMENT;

-- KH������ ���̺� �����ؼ� ������ �� �ִ� ������ ���⶧���� ���� �߻�
-- 6. KH.DEPARTMENT�� INSERT�� �� �ִ� ���� �ο��ޱ�
INSERT INTO KH.DEPARTMENT VALUES('D0', 'ȸ���', 'L2');

ROLLBACK;








