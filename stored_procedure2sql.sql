use `cs306-flight_reservation`;

DELIMITER $$
DROP PROCEDURE IF EXISTS GetAvailableSeats $$
CREATE PROCEDURE GetAvailableSeats(IN flight_id INT)
BEGIN
    SELECT seat_number, price
    FROM Seats
    WHERE f_id = flight_id AND is_booked = 0;
END $$
DELIMITER ;


DELIMITER $$
DROP PROCEDURE IF EXISTS SearchFlights $$
CREATE PROCEDURE SearchFlights(
    IN dep_airport VARCHAR(50),   -- Input: Departure airport
    IN arr_airport VARCHAR(50),   -- Input: Arrival airport
    IN flight_date DATE           -- Input: Flight date
)
BEGIN
    -- Select flights based on the input parameters
    SELECT f_id, flight_date, gate_no, departure_airport, arrival_airport, duration
    FROM Flights
    WHERE departure_airport = dep_airport
    AND arrival_airport = arr_airport
    AND flight_date = flight_date;
END $$

DELIMITER ;


CALL GetAvailableSeats(2);
CALL SearchFlights('CUR', 'MIA', '2024-10-17');


