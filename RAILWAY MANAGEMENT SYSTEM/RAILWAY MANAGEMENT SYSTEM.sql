CREATE DATABASE RailwayManagementSystem;

USE RailwayManagementSystem;


#TRAINS
CREATE TABLE trains (
    train_id INT PRIMARY KEY AUTO_INCREMENT,
    train_name VARCHAR(100) NOT NULL,
    source VARCHAR(50) NOT NULL,
    destination VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


#PASSENGERS
CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age > 0),
    gender ENUM('Male','Female','Other'),
    phone VARCHAR(15) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



#FOOD MENU
CREATE TABLE food_menu (
    food_id INT PRIMARY KEY AUTO_INCREMENT,
    food_name VARCHAR(100) NOT NULL,
    food_type ENUM('Veg','Non-Veg'),
    price DECIMAL(10,2) NOT NULL CHECK (price > 0)
);




#COACHES
CREATE TABLE coaches (
    coach_id INT PRIMARY KEY AUTO_INCREMENT,
    train_id INT NOT NULL,
    coach_name VARCHAR(10) NOT NULL,
    coach_type ENUM('Sleeper','AC','General'),
    total_seats INT CHECK (total_seats > 0),

    FOREIGN KEY (train_id) 
    REFERENCES trains(train_id)
    ON DELETE CASCADE
);




#BOOKINGS
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    train_id INT NOT NULL,
    journey_date DATE NOT NULL,
    seat_number VARCHAR(10),
    status ENUM('Confirmed','Waiting','Cancelled') DEFAULT 'Waiting',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (passenger_id) 
    REFERENCES passengers(passenger_id)
    ON DELETE CASCADE,

    FOREIGN KEY (train_id) 
    REFERENCES trains(train_id)
    ON DELETE CASCADE
);




#PAYMENTS
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_status ENUM('Pending','Completed','Failed') DEFAULT 'Pending',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (booking_id) 
    REFERENCES bookings(booking_id)
    ON DELETE CASCADE
);



#FOOD ORDERS
CREATE TABLE food_orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    food_id INT NOT NULL,
    quantity INT CHECK (quantity > 0),
    total_price DECIMAL(10,2),

    FOREIGN KEY (booking_id) 
    REFERENCES bookings(booking_id)
    ON DELETE CASCADE,

    FOREIGN KEY (food_id) 
    REFERENCES food_menu(food_id)
    ON DELETE CASCADE
);




#ID PROOF
CREATE TABLE id_proof (
    id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    proof_type ENUM('Aadhar','PAN','Passport','Driving License'),
    proof_number VARCHAR(50) UNIQUE,

    FOREIGN KEY (passenger_id) 
    REFERENCES passengers(passenger_id)
    ON DELETE CASCADE
);


SELECT * FROM trains;
SELECT * FROM passengers;
SELECT * FROM food_menu;
SELECT * FROM coaches;
SELECT * FROM bookings;
SELECT * FROM payments;
SELECT * FROM food_orders;
SELECT * FROM id_proof;






-- Train + Passenger + Booking
-- Show passenger name with train and booking details

SELECT 
    p.name,
    t.train_name,
    b.journey_date,
    b.seat_number,
    b.status
FROM bookings b
JOIN passengers p ON b.passenger_id = p.passenger_id
JOIN trains t ON b.train_id = t.train_id;




-- Booking + Payment by Passenger
-- Show passenger booking and payment details

SELECT 
    p.name,
    t.train_name,
    b.journey_date,
    pay.amount,
    pay.payment_status
FROM payments pay
JOIN bookings b ON pay.booking_id = b.booking_id
JOIN passengers p ON b.passenger_id = p.passenger_id
JOIN trains t ON b.train_id = t.train_id;



-- Food Orders by Passenger
-- Show which passenger ordered what food

SELECT 
    p.name,
    f.food_name,
    fo.quantity,
    fo.total_price
FROM food_orders fo
JOIN bookings b ON fo.booking_id = b.booking_id
JOIN passengers p ON b.passenger_id = p.passenger_id
JOIN food_menu f ON fo.food_id = f.food_id;





-- Total bookings per train
-- Count bookings for each train

SELECT 
    t.train_name,
    COUNT(b.booking_id) AS total_bookings
FROM trains t
LEFT JOIN bookings b ON t.train_id = b.train_id
GROUP BY t.train_name;




-- Total revenue
-- Calculate total revenue

SELECT SUM(amount) AS total_revenue
FROM payments
WHERE payment_status = 'Completed';



-- Booking status count
-- Question: Count bookings by status

SELECT status, COUNT(*) 
FROM bookings
GROUP BY status;