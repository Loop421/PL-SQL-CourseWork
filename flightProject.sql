Create table customer
(
    custID number,
    custName varchar2(15),
    street varchar2(20),
    city varchar2(10),
    state char(2),
    custPhoneNumber varchar(15),
    CONSTRAINT pk_custId PRIMARY KEY (custID)
);

CREATE SEQUENCE cust_seq START WITH 1;

CREATE OR REPLACE TRIGGER custID_bir
BEFORE INSERT ON customer
FOR EACH ROW

BEGIN
    SELECT cust_seq.NEXTVAL
    INTO :new.custID
    FROM dual;
END;

Create table flight
(
    flightID number,
    source varchar2(10),
    destination varchar2(15),
    fare number,
    flightDate DATE,
    numberOfSeatRemaining number,
    CONSTRAINT pk_flightID PRIMARY KEY (flightID)
);

CREATE SEQUENCE flight_seq START WITH 1;

CREATE OR REPLACE TRIGGER flight_bir
BEFORE INSERT ON flight
FOR EACH ROW

BEGIN
    SELECT flight_seq.NEXTVAL
    INTO :new.flightID
    FROM dual;
END;

create table employee
(
    emplID number,
    name varchar2(15),
    street varchar2(20),
    city varchar2(10),
    state varchar2(15),
    phoneNum varchar2(15),
    CONSTRAINT pk_emplID PRIMARY KEY (emplID)
);

create table Reservation
(
    ReserID number,
    custID number,
    flightID number,
    numberOfSeat number,
    CONSTRAINT pk_reserID PRIMARY KEY(ReserID),
    CONSTRAINT fk_custID FOREIGN KEY (custID) REFERENCES CUSTOMER(custID),
    CONSTRAINT fk_flight FOREIGN KEY (flightID) REFERENCES flight(flightID)
);

select * from customer;
select * from flight;
select * from employee;
select * from reservation;

drop table employee;

insert into customer values( CUST_SEQ.nextval,'Ashwin S','300 Jay st', 'Brooklyn', 'NY','111-222-3333');
insert into customer values( CUST_SEQ.nextval,'Mirabelle Bend','0 Sunnyside Center', 'Fort Worth', 'TX','817-257-6582');
insert into customer values( CUST_SEQ.nextval,'Gretal Brookes',	'3872 Meadow Ridge',	'Rockford',	'IL',	'815-858-6285');
insert into customer values( CUST_SEQ.nextval,	'Ania Harome','66649 Springs Hill','Mesquite','TX','214-164-2711');
insert into customer values( CUST_SEQ.nextval,'Wynne Taylder',	'5351 Blue Bill Park','Tacoma','WA','253-805-0323');



insert into flight values (flight_seq.nextval, 'JFK', 'China',400, '05-Dec-2018',50);
insert into flight values (flight_seq.nextval, 'BUF', 'South Africa',700, '	01-Feb-2019',50);
insert into flight values (flight_seq.nextval, 'ALB', 'Canada',300,'06-Jan-2019',50);
insert into flight values (flight_seq.nextval, 'LGA', 'Portugal',500, '	06-Mar-2019', 50);
insert into flight values (flight_seq.nextval, 'IAG', 'Poland',600, '23-Feb-2019',50);

insert into employee values(1, 'Cybil Storer',	'32 Eliot Place',	'Fresno',	'CA',	'209-609-8832');
insert into employee values (2, 'Nial Challenger',	'82 Raven Pass',	'Atlanta',	'GA',	'404-463-5759');
insert into employee values(3, 'Eberto Norwood',	'4 Kim Way',	'Pensacola',	'FL',	'850-531-5747');
insert into employee values(4, 'Starlin Gaw',	'3 Iowa Street',	'Lima',	'OH', '419-502-1469');
insert into employee values(5, 'Evy Janovsky',	'5 Springs Place', 'Pueblo',	'CO',	'719-428-5208');

insert into Reservation values (1,1,2,1);
insert into Reservation values (2,4,10,2);
insert into Reservation values (3,8,6,1);
insert into Reservation values (4,6,4,3);
insert into Reservation values (5,7,8,1);

Create table donor
(
IDNO number primary key,
Name varchar2(20),
STADR varchar2(20),
City varchar2(15),
SI char(2),
zip number,
datefst date,
yrgoal number,
contact varchar(15)
);

INSERT INTO donor VALUES (11111,'Stephen Daniels', '123 Eml St', 'Seekonk' , 'MA', 02345, '03_JUL-98', 500, 'John Smith');
INSERT INTO donor VALUES (12121,'Jennifer Ames', '24 Benefit St', 'Provodence' , 'RI', 02045, '24-MAY-97', 400, 'Susan Jones');
INSERT INTO donor VALUES (22222,'Carl Hersey', '24 Benefit St', 'Provodence' , 'RI', 02045, '03-JAN-98', null, 'Susan Jones');
INSERT INTO donor VALUES (23456,'Susan Ash', '21 Main St', 'Fall River' , 'MA', 02720, '04-MAR-92', 100, 'Amy Costa');
INSERT INTO donor VALUES (33333,'Nancy Taylor', '26 Oak St', 'Fall River' , 'MA', 02720, '04-MAR-92', 50, 'John Adams');
INSERT INTO donor VALUES (34567,'Robert Brooks', '36 Pine St', 'Fall River' , 'MA', 02720, '04-APR-98', 50, 'Amy Costa');

select * from donor;


set serveroutput on
declare
    v_id donor.idno%type;
    v_name donor.name%type;
    v_state donor.si%type;
    V_goal donor.yrgoal%type;
    
begin
    v_id :=&Enter_id;
    
    select name,si,yrgoal into v_name, v_state, v_goal from donor where idno = v_id;
    dbms_output.Put_line(v_name ||' '||v_state||' '|| v_goal);

end;

-- write PL/SQL code to ask the user for an city and display all the
-- names of the donors from that city

set serveroutput on
declare
    v_city donor.city%type;
    v_name donor.name%type;
    
    CURSOR c_city IS
        select name from donor where city = v_city;

begin
    v_city :='&Enter_City';
    
    open c_city;
    loop
        fetch c_city into v_name;
        exit when c_city%NOTFOUND;
        dbms_output.Put_line(v_name);
    end loop;
    close c_city;

end;





