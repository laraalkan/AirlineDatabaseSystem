use phpmyadmin;
CREATE DATABASE IF NOT EXISTS `cs306-flight_reservation`;
USE `cs306-flight_reservation`;


CREATE TABLE IF NOT EXISTS Airlines(
	a_id varchar(2) primary key,
    a_name varchar(100) not null,
    co2_emission decimal(3,1),
    establishment_date int,
    founder varchar(100)
); 

INSERT IGNORE INTO Airlines( a_id, a_name, co2_emission, establishment_date, founder)
values ("AA", "American Airlines", 48.7, 1934, "C. R. Smith"),
	("AF","Air France", 20.0, 1933, "Pierre Cot"),
	("CC","Continental Airlines",1.0,1921," Walter T. Varney" ),
	("DL","Delta Air Lines",35.9, 1928, "C.E. Woolman"),
	("TK","Turkish Airlines",25.7, 1933, "Fesa Evrensev"),
	("AC", "Air Canada", 13.1, 1937, "Canadian Parliment"),
	("UA","United Airlines Cargo", 44.0, 1926, "	Walter Varney"),
	("CP", "Canadian Airlines Int'l", 6.3, 1987, "Canadian Airlines Corporation"),
	("LH", "Lufthansa Cargo AG", 5.3, 1977,"German National Railway"),
	("W4", "Wizz Air Malta", 5.4, 2022,"Diarmuid Ó Conghaile");

CREATE TABLE IF NOT EXISTS Plane_Type (
	t_id int primary key,
	capacity int,
    model_name varchar(100),
    fuel_usage real,
    manufacturer varchar(100)
);

INSERT IGNORE INTO Plane_Type(t_id,capacity,model_name,fuel_usage,manufacturer)
values (1,128, " A319", 2600, "Airbus"),
	(2,150, " A320", 2500, "Airbus"),
    (3,190, " A321", 2885, "Airbus"),
    (4,102, " A321 Transcon", 2740, "Airbus"),
    (5,196, " A321neo", 2440, "Airbus"),
    (6,172, " Boeing 737-800 ", 2560, "Boeing"), 
    (7,273, "  Boeing 777-200", 6080, "Boeing"),
    (8,304, "  Boeing 777-300ER", 7500, "Boeing"),
    (9,234, " Boeing 787-8", 4900, "Boeing"),
    (10,285, "  Boeing 787-9", 5600, "Boeing");

CREATE TABLE IF NOT EXISTS Planes(
	p_id varchar(20) primary key,
    manifacture_date int,
    type_id int,
    airline_id varchar(2),
    foreign key(type_id) references Plane_Type(t_id)
		on delete cascade,
	foreign key(airline_id) references Airlines(a_id)
		on delete cascade
);


INSERT IGNORE INTO Planes(p_id, manifacture_date,type_id, airline_id)
values("AAL708", 2014,6, "AA" ),
	("AAL1405", 2020, 5, "AA"),
    ("AAL1600", 2010,6, "AA"),
    ("AAL1124",2018, 1, "AA"),
    ("AAL1400",2010, 6, "AA"),
    ("AAL2933",2018, 3, "AA"),
    ("AAL661",2009, 6, "AA"),
    ("AAL2726",2018, 9, "AA"),
    ("AAL1815",2019, 9, "AA"),
    ("AAL1546",2021, 10, "AA");
    

CREATE TABLE IF NOT EXISTS Staff (
    s_id INT PRIMARY KEY,
    name VARCHAR(100),
    job VARCHAR(50),
    salary FLOAT,
    experience INT
);
 CREATE TABLE IF NOT EXISTS Flights (
    f_id INT PRIMARY KEY,
    flight_date DATE,
    gate_no VARCHAR(10),
    departure_airport VARCHAR(50),
    arrival_airport VARCHAR(50),
    duration TIME,
    p_id VARCHAR(20),
    FOREIGN KEY (p_id) REFERENCES Planes(p_id) ON DELETE CASCADE
);
 CREATE TABLE IF NOT EXISTS Seats (
    seat_number VARCHAR(10),
    f_id INT,
    is_booked TINYINT(1),
    price DECIMAL(10, 2),
    near_emergency_exit TINYINT(1),
    PRIMARY KEY (seat_number, f_id),
    FOREIGN KEY (f_id) REFERENCES Flights(f_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Business (
    seat_number varchar(10),
    f_id int,
    advantages text,
    primary key (seat_number, f_id),
    foreign key (seat_number, f_id) references Seats(seat_number, f_id) on delete cascade
);

INSERT IGNORE INTO Business (seat_number, f_id, advantages)
values
    ('1A', 1, 'Lounge access'), 
    ('1B', 1, 'Priority boarding');    
    
CREATE TABLE IF NOT EXISTS Economy (
    seat_number VARCHAR(10),
    f_id INT,
    basic_meals TINYINT(1),
    baggage_included TINYINT(1),
    PRIMARY KEY (seat_number, f_id),
    FOREIGN KEY (seat_number, f_id) REFERENCES Seats(seat_number, f_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Internationalflights (
    f_id INT PRIMARY KEY,
    departure_country VARCHAR(50),
    arrival_country VARCHAR(50),
    FOREIGN KEY (f_id) REFERENCES Flights(f_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Domesticflights (
    f_id INT PRIMARY KEY,
    departure_city VARCHAR(50),
    arrival_city VARCHAR(50),
    FOREIGN KEY (f_id) REFERENCES Flights(f_id) ON DELETE CASCADE
);
  
INSERT IGNORE INTO Seats (seat_number, f_id, is_booked, price, near_emergency_exit)
VALUES 
    ('12A', 2, TRUE, 220.00, FALSE),
    ('12B', 2, FALSE, 220.00, FALSE),
    ('12C', 2, FALSE, 220.00, FALSE),
    ('13A', 3, FALSE, 180.00, TRUE),
    ('13B', 3, FALSE, 180.00, TRUE),
    ('13C', 3, TRUE, 180.00, TRUE),
    ('14A', 4, TRUE, 100.00, FALSE),
    ('15A', 5, FALSE, 300.00, TRUE),
    ('1A', 1, FALSE, 500.00, TRUE),
    ('1B', 1, FALSE, 500.00, TRUE);

INSERT IGNORE INTO Staff (s_id, name, job, salary, experience)
VALUES 
    (1, 'Olivia Johnson', 'Pilot', 90000, 5),
    (2, 'Roger Bluebell', 'Co-Pilot', 70000, 4),
    (3, 'Charlie Glass', 'Flight Attendant', 45000, 3),
    (4, 'Azula Banks', 'Flight Engineer', 80000, 6),
    (5, 'Bruce Cruz', 'Ground Staff', 35000, 2),
    (6, 'Joshua Henry', 'Air Traffic Controller', 95000, 7),
    (7, 'Rose Sullivan', 'Operations Manager', 100000, 8),
    (8, 'Hannah Blue', 'Baggage Handler', 30000, 1),
    (9, 'April Jones', 'Customer Service', 40000, 3),
    (10, 'Ian Brock', 'Maintenance Technician', 60000, 5);

INSERT IGNORE INTO Economy (seat_number, f_id)
VALUES 
    ('12A', 2),  
    ('12B', 2),  
    ('12C', 2), 
    ('13A', 3), 
    ('13B', 3), 
    ('13C', 3), 
    ('14A', 4), 
    ('15A', 5); 
           
    
INSERT IGNORE INTO Flights (f_id, flight_date, gate_no, departure_airport, arrival_airport, duration, p_id)
VALUES 
    (1, '2024-10-17', 'A1', 'CUR', 'MIA', '03:10:00', 'AAL708'), 
    (2, '2024-10-17', 'D6', 'BAQ', 'MIA', '02:50:00', 'AAL1124'),
    (3, '2024-10-16', 'E7', 'MIA', 'PHL', '02:50:00', 'AAL661'), 
    (4, '2024-10-17', 'D22', 'MIA', 'SFO', '06:15:00', 'AAL2933'),
    (5, '2024-10-16', 'A2', 'HOG', 'MIA', '01:45:00', 'AAL2726'), 
    (6, '2024-10-17', '43', 'LAX', 'MIA', '05:10:00', 'AAL1815'), 
    (7, '2024-10-16', '11', 'SJO', 'MIA', '03:05:00', 'AAL1600'),
    (8, '2024-10-16', 'D43', 'MIA', 'GND', '03:40:00', 'AAL1546'),
    (9, '2024-10-17', 'A18', 'DFW', 'MIA', '02:45:00', 'AAL1405'),
    (10, '2024-10-18', 'D19', 'MIA', 'KIN', '01:50:00', 'AAL1400');

INSERT IGNORE INTO Internationalflights (f_id, departure_country, arrival_country)
VALUES
    (1, 'Curacao', 'USA'),         -- Flight ID 1: Curacao → USA
    (2, 'Colombia', 'USA'),       -- Flight ID 2: Colombia → USA
    (5, 'Cuba', 'USA'),             -- Flight ID 5: Cuba → USA
    (7, 'Costa Rica', 'USA'),       -- Flight ID 7: Costa Rica → USA
    (8, 'USA', 'Grenada'),          -- Flight ID 8: USA → Grenada
    (10, 'USA', 'Jamaica');         -- Flight ID 10: USA → Jamaica

INSERT IGNORE INTO Domesticflights (f_id, departure_city, arrival_city)
VALUES
    (3, 'Miami', 'Philadelphia'),      -- Flight ID 3: Miami → Philadelphia
    (4, 'Miami', 'San Francisco'),     -- Flight ID 4: Miami → San Francisco
    (6, 'Los Angeles', 'Miami'),       -- Flight ID 6: Los Angeles → Miami
    (9, 'Dallas', 'Miami');            -- Flight ID 9: Dallas → Miami
CREATE TABLE IF NOT EXISTS Belongs_to (
    seat_number varchar(10),
    f_id int,
    primary key(seat_number, f_id),
    foreign key (f_id) references Flights(f_id) on delete cascade
);

INSERT IGNORE INTO Belongs_to (seat_number, f_id)
values 
	('12A',1),
    ('12B',1),
    ('13A',2),
    ('13B',2),
    ('14A',3),
    ('14B',3),
    ('15A',4),
    ('15B',4);
    
DELIMITER //

CREATE TRIGGER check_flight_time_overlap
BEFORE INSERT ON Flights
FOR EACH ROW
BEGIN
    DECLARE conflict_count INT;
    DECLARE new_end_time DATETIME;
    -- Calculate the end time of the new flight
    SET new_end_time = NEW.flight_date + INTERVAL TIME_TO_SEC(NEW.duration) SECOND;
    -- Check for overlapping flights with the same plane
    SELECT COUNT(*)
    INTO conflict_count
    FROM Flights
    WHERE p_id = NEW.p_id
      AND (
          (NEW.flight_date < (flight_date + INTERVAL TIME_TO_SEC(duration) SECOND))
          AND
          (flight_date < new_end_time)
      );

    IF conflict_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Flight schedule conflict detected for the plane.';
    END IF;
END //

DELIMITER ;