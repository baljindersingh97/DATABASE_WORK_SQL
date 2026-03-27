-- ============================================
-- SAMPLE DATA INSERT SCRIPT
-- HOTEL RESERVATION AND GUEST MANAGEMENT SYSTEM
-- MySQL 8.0+
-- ============================================

USE hotel_reservation_db;

-- --------------------------------------------
-- 1. LOOKUP TABLES
-- --------------------------------------------

INSERT INTO reservation_statuses (status_id, status_name) VALUES
(1, 'Pending'),
(2, 'Confirmed'),
(3, 'Cancelled'),
(4, 'Completed'),
(5, 'Checked-In'),
(6, 'Checked-Out');

INSERT INTO payment_methods (payment_method_id, method_name) VALUES
(1, 'Cash'),
(2, 'Card'),
(3, 'Bank Transfer'),
(4, 'Online Wallet');

INSERT INTO payment_statuses (payment_status_id, status_name) VALUES
(1, 'Pending'),
(2, 'Paid'),
(3, 'Partially Paid'),
(4, 'Refunded'),
(5, 'Failed');

-- --------------------------------------------
-- 2. MASTER TABLES
-- --------------------------------------------

INSERT INTO room_types (room_type_id, type_name, capacity, base_price, description) VALUES
(1, 'Standard', 2, 100.00, 'Standard room with basic facilities'),
(2, 'Deluxe', 3, 150.00, 'Deluxe room with enhanced comfort'),
(3, 'Suite', 4, 250.00, 'Spacious suite with premium facilities'),
(4, 'Family', 5, 220.00, 'Large family room suitable for groups');

INSERT INTO customers (customer_id, first_name, last_name, email, phone, country, created_at) VALUES
(1, 'John', 'Smith', 'john.smith@email.com', '+44-7700-100001', 'United Kingdom', '2025-01-10 09:15:00'),
(2, 'Emily', 'Johnson', 'emily.johnson@email.com', '+44-7700-100002', 'United Kingdom', '2025-01-12 10:20:00'),
(3, 'Michael', 'Brown', 'michael.brown@email.com', '+1-202-555-0103', 'United States', '2025-01-15 11:30:00'),
(4, 'Sophia', 'Davis', 'sophia.davis@email.com', '+49-151-1000004', 'Germany', '2025-01-18 14:10:00'),
(5, 'Daniel', 'Wilson', 'daniel.wilson@email.com', '+91-98765-10005', 'India', '2025-01-20 16:05:00'),
(6, 'Olivia', 'Martinez', 'olivia.martinez@email.com', '+34-600-100006', 'Spain', '2025-01-22 13:00:00'),
(7, 'James', 'Anderson', 'james.anderson@email.com', '+61-400-100007', 'Australia', '2025-01-25 09:45:00'),
(8, 'Ava', 'Thomas', 'ava.thomas@email.com', '+33-612-100008', 'France', '2025-01-27 08:35:00'),
(9, 'William', 'Taylor', 'william.taylor@email.com', '+1-416-555-0109', 'Canada', '2025-02-01 10:50:00'),
(10, 'Isabella', 'Moore', 'isabella.moore@email.com', '+39-320-100010', 'Italy', '2025-02-03 12:25:00'),
(11, 'Benjamin', 'Jackson', 'benjamin.jackson@email.com', '+44-7700-100011', 'United Kingdom', '2025-02-05 15:40:00'),
(12, 'Mia', 'White', 'mia.white@email.com', '+31-610-100012', 'Netherlands', '2025-02-08 09:05:00'),
(13, 'Lucas', 'Harris', 'lucas.harris@email.com', '+1-646-555-0113', 'United States', '2025-02-10 11:15:00'),
(14, 'Charlotte', 'Martin', 'charlotte.martin@email.com', '+353-85-100014', 'Ireland', '2025-02-12 17:20:00'),
(15, 'Henry', 'Thompson', 'henry.thompson@email.com', '+44-7700-100015', 'United Kingdom', '2025-02-15 10:00:00'),
(16, 'Amelia', 'Garcia', 'amelia.garcia@email.com', '+52-55-100016', 'Mexico', '2025-02-18 14:30:00'),
(17, 'Alexander', 'Martinez', 'alexander.m@email.com', '+34-600-100017', 'Spain', '2025-02-20 16:45:00'),
(18, 'Harper', 'Robinson', 'harper.robinson@email.com', '+1-213-555-0118', 'United States', '2025-02-24 13:35:00'),
(19, 'Ethan', 'Clark', 'ethan.clark@email.com', '+44-7700-100019', 'United Kingdom', '2025-02-27 08:55:00'),
(20, 'Grace', 'Lewis', 'grace.lewis@email.com', '+971-50-100020', 'United Arab Emirates', '2025-03-01 09:40:00');

INSERT INTO rooms (room_id, room_number, room_type_id, floor_number, room_status, availability_flag) VALUES
(1, '101', 1, 1, 'Available', TRUE),
(2, '102', 1, 1, 'Available', TRUE),
(3, '103', 1, 1, 'Cleaning', TRUE),
(4, '104', 1, 1, 'Available', TRUE),
(5, '201', 2, 2, 'Available', TRUE),
(6, '202', 2, 2, 'Occupied', TRUE),
(7, '203', 2, 2, 'Available', TRUE),
(8, '204', 2, 2, 'Maintenance', FALSE),
(9, '301', 3, 3, 'Available', TRUE),
(10, '302', 3, 3, 'Occupied', TRUE),
(11, '303', 3, 3, 'Available', TRUE),
(12, '304', 3, 3, 'Cleaning', TRUE),
(13, '401', 4, 4, 'Available', TRUE),
(14, '402', 4, 4, 'Occupied', TRUE),
(15, '403', 4, 4, 'Available', TRUE),
(16, '404', 4, 4, 'Available', TRUE),
(17, '105', 1, 1, 'Available', TRUE),
(18, '205', 2, 2, 'Available', TRUE),
(19, '305', 3, 3, 'Available', TRUE),
(20, '405', 4, 4, 'Available', TRUE);

INSERT INTO services (service_id, service_name, service_price, active_flag) VALUES
(1, 'Breakfast', 15.00, TRUE),
(2, 'Laundry', 10.00, TRUE),
(3, 'Airport Pickup', 40.00, TRUE),
(4, 'Spa Access', 50.00, TRUE),
(5, 'Extra Bed', 25.00, TRUE),
(6, 'Late Checkout', 30.00, TRUE);

INSERT INTO staff (staff_id, first_name, last_name, role, email, phone) VALUES
(1, 'Alice', 'Green', 'Front Desk Manager', 'alice.green@hotel.com', '+44-7700-200001'),
(2, 'Robert', 'Hall', 'Receptionist', 'robert.hall@hotel.com', '+44-7700-200002'),
(3, 'Nina', 'Patel', 'Accounts Officer', 'nina.patel@hotel.com', '+44-7700-200003'),
(4, 'David', 'King', 'Duty Manager', 'david.king@hotel.com', '+44-7700-200004'),
(5, 'Sara', 'Baker', 'Guest Relations Executive', 'sara.baker@hotel.com', '+44-7700-200005');

-- --------------------------------------------
-- 3. TRANSACTION TABLES
-- --------------------------------------------

INSERT INTO reservations (
    reservation_id, customer_id, room_id, status_id, booking_date,
    check_in_date, check_out_date, adults, children, total_amount, special_requests
) VALUES
(1, 1, 1, 6, '2025-03-05 10:15:00', '2025-03-20', '2025-03-23', 2, 0, 330.00, 'High floor preferred'),
(2, 2, 5, 6, '2025-03-08 11:00:00', '2025-03-22', '2025-03-25', 2, 1, 500.00, 'Extra towels requested'),
(3, 3, 9, 4, '2025-03-10 09:30:00', '2025-03-26', '2025-03-28', 2, 0, 540.00, 'Anniversary stay'),
(4, 4, 13, 3, '2025-03-12 15:20:00', '2025-04-02', '2025-04-06', 2, 2, 940.00, 'Early check-in requested'),
(5, 5, 2, 2, '2025-03-15 13:10:00', '2025-04-10', '2025-04-13', 1, 0, 300.00, NULL),
(6, 6, 6, 5, '2025-03-16 16:45:00', '2025-03-27', '2025-03-30', 2, 1, 495.00, 'Vegetarian breakfast'),
(7, 7, 10, 2, '2025-03-17 12:00:00', '2025-04-15', '2025-04-18', 2, 0, 790.00, 'Airport pickup needed'),
(8, 8, 14, 1, '2025-03-18 09:00:00', '2025-05-01', '2025-05-05', 2, 2, 1010.00, 'Family crib requested'),
(9, 9, 3, 4, '2025-03-19 10:30:00', '2025-03-24', '2025-03-26', 1, 0, 210.00, NULL),
(10, 10, 7, 6, '2025-03-20 14:20:00', '2025-03-21', '2025-03-24', 2, 0, 500.00, 'Late checkout requested'),
(11, 11, 11, 2, '2025-03-21 11:40:00', '2025-04-20', '2025-04-23', 2, 1, 805.00, 'Need quiet room'),
(12, 12, 15, 2, '2025-03-22 17:10:00', '2025-04-25', '2025-04-28', 2, 2, 710.00, NULL),
(13, 13, 4, 3, '2025-03-23 08:50:00', '2025-04-05', '2025-04-07', 1, 0, 200.00, 'Business trip'),
(14, 14, 18, 2, '2025-03-24 10:05:00', '2025-04-12', '2025-04-15', 2, 0, 520.00, 'Airport pickup and breakfast'),
(15, 15, 19, 1, '2025-03-24 15:25:00', '2025-05-10', '2025-05-13', 2, 0, 840.00, 'Suite with city view'),
(16, 16, 16, 2, '2025-03-25 09:35:00', '2025-04-18', '2025-04-21', 2, 2, 725.00, 'Extra bed needed'),
(17, 17, 17, 2, '2025-03-25 12:15:00', '2025-04-08', '2025-04-10', 1, 0, 230.00, NULL),
(18, 18, 20, 2, '2025-03-25 16:50:00', '2025-04-30', '2025-05-03', 2, 3, 765.00, 'Family celebration'),
(19, 19, 5, 3, '2025-03-26 10:10:00', '2025-04-01', '2025-04-03', 2, 0, 300.00, 'Cancelled due to travel change'),
(20, 20, 9, 2, '2025-03-26 13:40:00', '2025-04-22', '2025-04-25', 2, 0, 790.00, 'Spa access requested'),
(21, 1, 18, 2, '2025-03-26 17:00:00', '2025-05-18', '2025-05-21', 2, 0, 520.00, 'Repeat guest'),
(22, 3, 13, 2, '2025-03-27 08:20:00', '2025-05-22', '2025-05-26', 2, 2, 980.00, 'Airport transfer required'),
(23, 6, 11, 1, '2025-03-27 10:45:00', '2025-06-01', '2025-06-03', 2, 0, 550.00, 'Honeymoon package'),
(24, 8, 1, 2, '2025-03-27 14:15:00', '2025-04-15', '2025-04-17', 1, 0, 230.00, 'Near elevator'),
(25, 10, 7, 1, '2025-03-27 16:30:00', '2025-06-10', '2025-06-13', 2, 1, 525.00, 'Deluxe room for family');

INSERT INTO payments (
    payment_id, reservation_id, payment_method_id, payment_status_id,
    payment_date, payment_amount, transaction_reference
) VALUES
(1, 1, 2, 2, '2025-03-05 10:45:00', 330.00, 'TXN-20250305-0001'),
(2, 2, 2, 2, '2025-03-08 11:20:00', 250.00, 'TXN-20250308-0002'),
(3, 2, 1, 2, '2025-03-22 09:00:00', 250.00, 'TXN-20250322-0003'),
(4, 3, 4, 2, '2025-03-10 09:45:00', 540.00, 'TXN-20250310-0004'),
(5, 4, 2, 4, '2025-03-12 15:45:00', 300.00, 'TXN-20250312-0005'),
(6, 5, 3, 3, '2025-03-15 13:25:00', 100.00, 'TXN-20250315-0006'),
(7, 6, 2, 3, '2025-03-16 17:00:00', 200.00, 'TXN-20250316-0007'),
(8, 7, 4, 2, '2025-03-17 12:20:00', 790.00, 'TXN-20250317-0008'),
(9, 8, 1, 1, '2025-03-18 09:15:00', 200.00, 'TXN-20250318-0009'),
(10, 9, 2, 2, '2025-03-19 10:40:00', 210.00, 'TXN-20250319-0010'),
(11, 10, 2, 2, '2025-03-20 14:35:00', 500.00, 'TXN-20250320-0011'),
(12, 11, 3, 3, '2025-03-21 11:55:00', 300.00, 'TXN-20250321-0012'),
(13, 12, 2, 2, '2025-03-22 17:25:00', 710.00, 'TXN-20250322-0013'),
(14, 13, 1, 4, '2025-03-23 09:05:00', 100.00, 'TXN-20250323-0014'),
(15, 14, 4, 2, '2025-03-24 10:20:00', 520.00, 'TXN-20250324-0015'),
(16, 15, 2, 1, '2025-03-24 15:40:00', 300.00, 'TXN-20250324-0016'),
(17, 16, 2, 3, '2025-03-25 09:50:00', 250.00, 'TXN-20250325-0017'),
(18, 17, 1, 2, '2025-03-25 12:30:00', 230.00, 'TXN-20250325-0018'),
(19, 18, 4, 3, '2025-03-25 17:05:00', 300.00, 'TXN-20250325-0019'),
(20, 19, 2, 4, '2025-03-26 10:25:00', 150.00, 'TXN-20250326-0020'),
(21, 20, 3, 2, '2025-03-26 13:55:00', 790.00, 'TXN-20250326-0021'),
(22, 21, 2, 2, '2025-03-26 17:15:00', 520.00, 'TXN-20250326-0022'),
(23, 22, 4, 2, '2025-03-27 08:35:00', 980.00, 'TXN-20250327-0023'),
(24, 23, 2, 1, '2025-03-27 11:00:00', 150.00, 'TXN-20250327-0024'),
(25, 24, 1, 2, '2025-03-27 14:30:00', 230.00, 'TXN-20250327-0025'),
(26, 25, 4, 1, '2025-03-27 16:45:00', 200.00, 'TXN-20250327-0026');

INSERT INTO reservation_services (
    reservation_service_id, reservation_id, service_id, quantity, service_total
) VALUES
(1, 1, 1, 3, 45.00),
(2, 2, 1, 3, 45.00),
(3, 2, 2, 2, 20.00),
(4, 3, 4, 2, 100.00),
(5, 4, 3, 1, 40.00),
(6, 4, 5, 2, 50.00),
(7, 6, 1, 3, 45.00),
(8, 7, 3, 1, 40.00),
(9, 8, 5, 1, 25.00),
(10, 10, 6, 1, 30.00),
(11, 11, 1, 3, 45.00),
(12, 12, 5, 2, 50.00),
(13, 14, 1, 3, 45.00),
(14, 14, 3, 1, 40.00),
(15, 15, 4, 2, 100.00),
(16, 16, 5, 1, 25.00),
(17, 18, 1, 3, 45.00),
(18, 20, 4, 2, 100.00),
(19, 22, 3, 1, 40.00),
(20, 23, 4, 2, 100.00),
(21, 24, 6, 1, 30.00),
(22, 25, 1, 3, 45.00);

INSERT INTO reservation_status_history (
    history_id, reservation_id, old_status_id, new_status_id,
    changed_by_staff_id, changed_at, remarks
) VALUES
(1, 1, NULL, 2, 2, '2025-03-05 10:20:00', 'Reservation confirmed after card payment'),
(2, 1, 2, 5, 1, '2025-03-20 14:00:00', 'Guest checked in successfully'),
(3, 1, 5, 6, 1, '2025-03-23 11:15:00', 'Guest checked out and bill closed'),

(4, 2, NULL, 2, 2, '2025-03-08 11:10:00', 'Booking confirmed'),
(5, 2, 2, 5, 1, '2025-03-22 15:00:00', 'Family checked in'),
(6, 2, 5, 6, 1, '2025-03-25 10:30:00', 'Family checked out'),

(7, 3, NULL, 2, 5, '2025-03-10 09:35:00', 'Suite booking confirmed'),
(8, 3, 2, 4, 4, '2025-03-28 12:00:00', 'Stay completed and archived'),

(9, 4, NULL, 2, 2, '2025-03-12 15:30:00', 'Initial confirmation'),
(10, 4, 2, 3, 4, '2025-03-20 09:10:00', 'Cancelled by guest; partial refund processed'),

(11, 5, NULL, 2, 1, '2025-03-15 13:20:00', 'Reservation confirmed with deposit'),

(12, 6, NULL, 2, 2, '2025-03-16 16:55:00', 'Booking confirmed'),
(13, 6, 2, 5, 1, '2025-03-27 13:00:00', 'Guest checked in'),

(14, 7, NULL, 2, 5, '2025-03-17 12:10:00', 'Airport pickup arranged'),

(15, 8, NULL, 1, 2, '2025-03-18 09:10:00', 'Pending until advance payment clears'),

(16, 9, NULL, 2, 2, '2025-03-19 10:35:00', 'Reservation confirmed'),
(17, 9, 2, 4, 4, '2025-03-26 10:00:00', 'Completed stay'),

(18, 10, NULL, 2, 2, '2025-03-20 14:25:00', 'Confirmed immediately'),
(19, 10, 2, 5, 1, '2025-03-21 14:00:00', 'Checked in'),
(20, 10, 5, 6, 1, '2025-03-24 12:10:00', 'Checked out'),

(21, 11, NULL, 2, 5, '2025-03-21 11:50:00', 'Confirmed with partial prepayment'),
(22, 12, NULL, 2, 2, '2025-03-22 17:15:00', 'Confirmed after full payment'),

(23, 13, NULL, 2, 2, '2025-03-23 09:00:00', 'Business trip confirmed'),
(24, 13, 2, 3, 4, '2025-03-29 08:30:00', 'Cancelled due to client schedule change'),

(25, 14, NULL, 2, 1, '2025-03-24 10:15:00', 'Confirmed and transport added'),
(26, 15, NULL, 1, 2, '2025-03-24 15:35:00', 'Awaiting full advance payment'),
(27, 16, NULL, 2, 1, '2025-03-25 09:45:00', 'Confirmed with partial payment'),
(28, 17, NULL, 2, 2, '2025-03-25 12:20:00', 'Confirmed'),
(29, 18, NULL, 2, 5, '2025-03-25 16:55:00', 'Confirmed with family request note'),
(30, 19, NULL, 2, 2, '2025-03-26 10:15:00', 'Initially confirmed'),
(31, 19, 2, 3, 4, '2025-03-27 09:45:00', 'Cancelled and refund initiated'),
(32, 20, NULL, 2, 1, '2025-03-26 13:50:00', 'Confirmed'),
(33, 21, NULL, 2, 5, '2025-03-26 17:05:00', 'Repeat guest confirmed'),
(34, 22, NULL, 2, 2, '2025-03-27 08:30:00', 'Large family booking confirmed'),
(35, 23, NULL, 1, 2, '2025-03-27 10:50:00', 'Pending until package confirmation'),
(36, 24, NULL, 2, 2, '2025-03-27 14:25:00', 'Confirmed'),
(37, 25, NULL, 1, 2, '2025-03-27 16:40:00', 'Pending due to incomplete advance payment');