-- ============================================
-- HOTEL RESERVATION AND GUEST MANAGEMENT SYSTEM
-- Database Creation Script
-- ============================================

-- --------------------------------------------
-- 1. Create Database
-- --------------------------------------------
DROP DATABASE IF EXISTS hotel_reservation_db;
CREATE DATABASE hotel_reservation_db;
USE hotel_reservation_db;

-- --------------------------------------------
-- 2. Create Tables in Dependency Order
-- --------------------------------------------

-- 2.1 Lookup Tables
CREATE TABLE reservation_statuses (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE payment_methods (
    payment_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE payment_statuses (
    payment_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(20) NOT NULL UNIQUE
);

-- 2.2 Master Tables
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    country VARCHAR(50),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE room_types (
    room_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE,
    capacity INT NOT NULL,
    base_price DECIMAL(10,2) NOT NULL,
    description VARCHAR(255),
    CONSTRAINT chk_room_types_capacity CHECK (capacity > 0),
    CONSTRAINT chk_room_types_base_price CHECK (base_price > 0)
);

CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type_id INT NOT NULL,
    floor_number INT NOT NULL,
    room_status VARCHAR(20) NOT NULL,
    availability_flag BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT chk_rooms_floor_number CHECK (floor_number >= 0),
    CONSTRAINT chk_rooms_room_status 
        CHECK (room_status IN ('Available', 'Occupied', 'Maintenance', 'Cleaning')),
    CONSTRAINT fk_rooms_room_type
        FOREIGN KEY (room_type_id)
        REFERENCES room_types(room_type_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL UNIQUE,
    service_price DECIMAL(10,2) NOT NULL,
    active_flag BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT chk_services_price CHECK (service_price >= 0)
);

CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

-- 2.3 Transaction Tables
CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    status_id INT NOT NULL,
    booking_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    adults INT NOT NULL,
    children INT NOT NULL DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL,
    special_requests VARCHAR(255),

    CONSTRAINT chk_reservations_dates CHECK (check_out_date > check_in_date),
    CONSTRAINT chk_reservations_adults CHECK (adults >= 1),
    CONSTRAINT chk_reservations_children CHECK (children >= 0),
    CONSTRAINT chk_reservations_total_amount CHECK (total_amount >= 0),

    CONSTRAINT fk_reservations_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_reservations_room
        FOREIGN KEY (room_id)
        REFERENCES rooms(room_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_reservations_status
        FOREIGN KEY (status_id)
        REFERENCES reservation_statuses(status_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    payment_method_id INT NOT NULL,
    payment_status_id INT NOT NULL,
    payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_amount DECIMAL(10,2) NOT NULL,
    transaction_reference VARCHAR(100) UNIQUE,

    CONSTRAINT chk_payments_amount CHECK (payment_amount > 0),

    CONSTRAINT fk_payments_reservation
        FOREIGN KEY (reservation_id)
        REFERENCES reservations(reservation_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_payments_method
        FOREIGN KEY (payment_method_id)
        REFERENCES payment_methods(payment_method_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_payments_status
        FOREIGN KEY (payment_status_id)
        REFERENCES payment_statuses(payment_status_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE reservation_services (
    reservation_service_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    service_id INT NOT NULL,
    quantity INT NOT NULL,
    service_total DECIMAL(10,2) NOT NULL,

    CONSTRAINT chk_reservation_services_quantity CHECK (quantity > 0),
    CONSTRAINT chk_reservation_services_total CHECK (service_total >= 0),

    CONSTRAINT uq_reservation_service UNIQUE (reservation_id, service_id),

    CONSTRAINT fk_reservation_services_reservation
        FOREIGN KEY (reservation_id)
        REFERENCES reservations(reservation_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_reservation_services_service
        FOREIGN KEY (service_id)
        REFERENCES services(service_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE reservation_status_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    old_status_id INT NULL,
    new_status_id INT NOT NULL,
    changed_by_staff_id INT NULL,
    changed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    remarks VARCHAR(255),

    CONSTRAINT fk_status_history_reservation
        FOREIGN KEY (reservation_id)
        REFERENCES reservations(reservation_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_status_history_old_status
        FOREIGN KEY (old_status_id)
        REFERENCES reservation_statuses(status_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_status_history_new_status
        FOREIGN KEY (new_status_id)
        REFERENCES reservation_statuses(status_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_status_history_staff
        FOREIGN KEY (changed_by_staff_id)
        REFERENCES staff(staff_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- --------------------------------------------
-- 3. Create Indexes
-- --------------------------------------------

-- Customers
CREATE INDEX idx_customers_last_name
    ON customers(last_name);

-- Rooms
CREATE INDEX idx_rooms_room_type_id
    ON rooms(room_type_id);

CREATE INDEX idx_rooms_status
    ON rooms(room_status);

-- Reservations
CREATE INDEX idx_reservations_customer_id
    ON reservations(customer_id);

CREATE INDEX idx_reservations_room_id
    ON reservations(room_id);

CREATE INDEX idx_reservations_status_id
    ON reservations(status_id);

CREATE INDEX idx_reservations_dates
    ON reservations(check_in_date, check_out_date);

CREATE INDEX idx_reservations_booking_date
    ON reservations(booking_date);

-- Payments
CREATE INDEX idx_payments_reservation_id
    ON payments(reservation_id);

CREATE INDEX idx_payments_method_id
    ON payments(payment_method_id);

CREATE INDEX idx_payments_status_id
    ON payments(payment_status_id);

CREATE INDEX idx_payments_date
    ON payments(payment_date);

-- Reservation Services
CREATE INDEX idx_reservation_services_reservation_id
    ON reservation_services(reservation_id);

CREATE INDEX idx_reservation_services_service_id
    ON reservation_services(service_id);

-- Reservation Status History
CREATE INDEX idx_status_history_reservation_id
    ON reservation_status_history(reservation_id);

CREATE INDEX idx_status_history_new_status_id
    ON reservation_status_history(new_status_id);

CREATE INDEX idx_status_history_staff_id
    ON reservation_status_history(changed_by_staff_id);

CREATE INDEX idx_status_history_changed_at
    ON reservation_status_history(changed_at);