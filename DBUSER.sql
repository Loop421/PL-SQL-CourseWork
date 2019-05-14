CREATE TABLE DBUSER
(
    USER_ID NUMBER(5) NOT NULL,
    USERNAME VARCHAR2(20) NOT NULL,
    AGE NUMBER(3) NOT NULL,
    STATE VARCHAR2(20),
    PRIMARY KEY (USER_ID)
);

INSERT INTO DBUSER VALUES(1,'Stephen',23, 'New York');
INSERT INTO DBUSER VALUES(2,'Jennifer',25, 'New York');
INSERT INTO DBUSER VALUES(3,'Carl',35, 'New Jersey');
INSERT INTO DBUSER VALUES(4,'Susan',39, 'New Jersey');
INSERT INTO DBUSER VALUES(5,'Robert',50, 'Connecitcut');

select * from dbuser;
set serveroutput on

CREATE OR REPLACE PROCEDURE add_DBUSER
(
    p_userid IN DBUSER.USER_ID%TYPE,
    p_username IN DBUSER.USERNAME%TYPE,
    p_age IN DBUSER.AGE%TYPE,
    p_state IN DBUSER.STATE%TYPE
)
IS

BEGIN

    INSERT INTO DBUSER VALUES(p_userid, p_username, p_age, p_state);
    dbms_output.put_line('Congratulations for successfully register!!');

END;

EXECUTE add_dbuser(6, 'Bob', 45, 'Delaware');
EXECUTE add_dbuser(8, 'Ded', 60, 'Delaware');

set serveroutput on
CREATE OR REPLACE PROCEDURE delete_DBUSER
(
    p_userid IN DBUSER.USER_ID%TYPE
)

IS

BEGIN

    DELETE FROM dbuser
    WHERE USER_ID = p_userid;
    dbms_output.put_line('User id: ' || p_userid || ' was deleted');

END;

EXECUTE delete_dbuser(8);

set serveroutput on

CREATE OR REPLACE PROCEDURE search_DBUSER
(
    p_userid IN DBUSER.USER_ID%TYPE
)

IS
    p_name DBUSER.USERNAME%TYPE;

BEGIN
    SELECT USERNAME into p_name FROM DBUSER   
    WHERE USER_ID = p_userid;
    dbms_output.put_line(p_name);
END;

execute search_dbuser(6);

set serveroutput on

CREATE OR REPLACE PROCEDURE list_DBUSER
(
    --p_userid IN DBUSER.USER_ID%TYPE--
    p_state IN DBUSER.STATE%TYPE
)
IS
    
    p_name dbuser.username%type;
    
    CURSOR c_username IS
        select username from dbuser where state = p_state;

BEGIN
    open c_username;
    loop
        fetch c_username into p_name;
        exit when c_username%NOTFOUND;
        dbms_output.Put_line(p_name);
    end loop;
    close c_username;

END;

execute list_dbuser('New Jersey');

