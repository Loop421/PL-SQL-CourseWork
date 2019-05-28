set serveroutput on

CREATE OR REPLACE PROCEDURE register_customer
(
    p_custName IN Customer.custName%type,
    p_street IN Customer.street%type,
    p_city IN customer.city%type,
    p_state IN customer.state%type,
    p_custPhoneNumber IN customer.custphonenumber%type
)

is

begin

    insert into customer values(cust_seq.nextval, p_custName, p_street, p_city, p_state,  p_custPhoneNumber);
    dbms_output.put_line('The new customer has been successfully registered, and the user Customer ID is: ' || cust_seq.currval);

end;

execute register_customer('Ania T', '399 Jay st', 'Brooklyn', 'NY', '123-345-6543');

select * from flight;

select * from reservation;

set serveroutput on

CREATE OR REPLACE PROCEDURE find_flight
(
    p_source IN flight.source%type,
    p_destination IN flight.destination%type,
    p_flightDate IN flight.flightdate%type
)

is
    v_flightId flight.flightid%type;
    v_fare flight.fare%type;
    v_seatReamaining flight.numberofseatremaining%TYPE;

CURSOR c_find_flight is
    select flightid, fare, numberofseatremaining from flight
    where source = p_source
    and destination = p_destination
    and flightDate = p_flightDate;

begin

    open c_find_flight;
    loop
        fetch c_find_flight into v_flightId, v_fare, v_seatReamaining;
        exit when c_find_flight%NOTFOUND;
        dbms_output.put_line( v_flightId || ' ' || p_source 
        || ' ' || p_destination || ' ' || v_fare || ' ' || p_flightDate 
        || ' ' ||v_seatReamaining);
    end loop;
    close c_find_flight;
end;

execute find_flight('JFK', 'China', '05-DEC-18');

create sequence reser_seq
    start with 6
    increment by 1
    cache 100;

set serveroutput on
create or replace procedure make_a_reservation
(
    p_custid in reservation.custid%type,
    p_flightid in reservation.flightid%type,
    p_seats in reservation.numberofseat%type
)
is

    v_numseats flight.numberofseatremaining%type;

begin
    
    
    select numberofseatremaining into v_numseats
    from flight
    where flightid = p_flightid;
    
    if(v_numseats - p_seats > 0) then
        insert into reservation values(reser_seq.nextval,p_custid,p_flightid,p_seats);
        update_remainingseats(p_seats, p_flightid);
        dbms_output.put_line('The customer ' || p_custid || ' has made a reservation on flight ' 
        || p_flightid || ' with ' || p_seats || ' seats confirmed');
    else
    dbms_output.put_line('No more seats');
    end if;
end;

set serveroutput on
create or replace procedure update_remainingseats
(
    p_seats in reservation.numberofseat%type,
    p_flightid in reservation.flightid%type
)

is 
    v_numseats flight.numberofseatremaining%type;
begin
    
    
    update flight
    set numberofseatremaining = numberofseatremaining - p_seats
    where flightid = p_flightid;
    

end;

set serveroutput on

CREATE OR REPLACE PROCEDURE view_reservation
(
    p_custid in reservation.custid%type
)

is
    v_reserid reservation.reserid%type;
    v_flightid reservation.flightid%type;
    v_numberofseat reservation.numberofseat%type;

cursor c_cust_flight is
    select reserid, flightid, numberofseat from reservation
    where custid = p_custid;

begin

    dbms_output.put_line('reservationID'||chr(9)||'customerID'||chr(9)|| 'flightNumber'||chr(9)||'numberOfseats');
    dbms_output.put_line('-----------------------------------------------------------------------');
    open c_cust_flight;
    loop
        fetch c_cust_flight into v_reserid, v_flightid, v_numberofseat;
        exit when c_cust_flight%notfound;
        
        dbms_output.put_line(v_reserid ||chr(9)||chr(9)||chr(9)||chr(9)|| ' ' || p_custid ||chr(9)||chr(9)||chr(9)||chr(9)
        || ' ' || v_flightid ||chr(9)||chr(9)||chr(9)||chr(9)|| v_numberofseat);
    end loop;
    close c_cust_flight;

end;

execute view_reservation(6);

set serveroutput on
create or replace procedure flight_details
(
    p_source in flight.source%type
)

is
    v_flightid flight.flightid%type;
    v_destination flight.destination%type;
    v_fare flight.fare%type;
    v_flightdate flight.flightdate%type;
    v_seatsremaining flight.numberofseatremaining%type;
    
    cursor c_flight is
        select flightid, destination, fare, flightdate, numberofseatremaining
        from flight where source = UPPER(p_source);
    
begin

    open c_flight;
    loop
        fetch c_flight into v_flightid, v_destination, v_fare, v_flightdate, v_seatsremaining;
        exit when c_flight%NOTFOUND;
        dbms_output.put_line(v_flightid || ' ' || UPPER(p_source) || ' ' || v_destination || ' ' || v_fare 
        || ' ' || v_flightdate || ' ' || v_seatsremaining);
    end loop;
    close c_flight;

end;

execute flight_details('jfk');

set serveroutput on
CREATE OR REPLACE PROCEDURE change_fare
(
    p_flightid in flight.flightid%type,
    p_fare in flight.fare%type
)

is

begin

    
    
    update flight
    set fare = p_fare
    where flightid = p_flightid;
    
    dbms_output.put_line('Flight number : ' || p_flightid || ' fare price has been updated!');

end;

execute change_fare(22,&Enter_new_fare_amount);

set serveroutput on
CREATE OR REPLACE PROCEDURE view_all_reservation
(

    p_flightid in reservation.flightid%type
)

is
    v_reserid reservation.reserid%type;
    v_custid reservation.custid%type;
    v_numberofseat reservation.numberofseat%type;

cursor c_cust_flight is
    select reserid, custid, numberofseat from reservation
    where flightid = p_flightid;

begin

    dbms_output.put_line('reservationID'||chr(9)||'customerID'||chr(9)|| 'flightNumber'||chr(9)||'numberOfseats');
    dbms_output.put_line('----------------------------------------------------------------');
    open c_cust_flight;
    loop
        fetch c_cust_flight into v_reserid, v_custid, v_numberofseat;
        exit when c_cust_flight%notfound;
        
        dbms_output.put_line(v_reserid ||chr(9)||chr(9)||chr(9)||chr(9)|| ' ' || v_custid ||chr(9)||chr(9)||chr(9)||chr(9)
        || ' ' || p_flightid ||chr(9)||chr(9)||chr(9)||chr(9)|| v_numberofseat);
    end loop;
    close c_cust_flight;

end;

execute view_all_reservation(2);

set serveroutput on
create or replace procedure view_customer
(
    p_custid in customer.custid%type
)

is
    v_custname customer.custname%type;
    v_street customer.street%type;
    v_city customer.city%type;
    v_state customer.state%type;
    v_custphonenumber customer.custphonenumber%type;

begin

    select  custname, street, city, state, custphonenumber 
    into v_custname, v_street, v_city, v_state, v_custphonenumber
    from customer
    where custid = p_custid;
    dbms_output.put_line(p_custid || ' | ' || v_custname|| ' | ' ||v_street
    || ' | ' ||v_city|| ' | ' ||v_state|| ' | ' ||v_custphonenumber);

end;

execute view_customer(8);
