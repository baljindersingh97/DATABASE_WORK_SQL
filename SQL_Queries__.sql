
## CREATE OPERATIONS


-- 1. Insert a new customer into the system
INSERT INTO customers (first_name, last_name, email, phone, country)
VALUES ('Liam', 'Walker', 'liam.walker@email.com', '+44-7700-300001', 'United Kingdom');



-- 2. Create a new reservation for the customer
INSERT INTO reservations (
    customer_id, room_id, status_id, booking_date,
    check_in_date, check_out_date, adults, children, total_amount, special_requests
)
VALUES (
    21, 17, 1, NOW(),              -- status_id = 1 (Pending)
    '2025-06-15', '2025-06-18',
    2, 0, 230.00,
    'Quiet room preferred'
);



-- 3. Insert payment for the reservation
INSERT INTO payments (
    reservation_id, payment_method_id, payment_status_id,
    payment_date, payment_amount, transaction_reference
)
VALUES (
    26, 2, 2,                      -- payment_method_id = Card, status = Paid
    NOW(), 230.00,
    'TXN-20250601-0027'
);



-- 4. Add additional service (e.g., Breakfast) to reservation
INSERT INTO reservation_services (
    reservation_id, service_id, quantity, service_total
)
VALUES (
    26, 1, 3, 45.00                -- 3 services costing 45 total
);




## 🔹 READ OPERATIONS


-- 5. Retrieve full reservation details using joins
SELECT 
    r.reservation_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    rm.room_number,
    rt.type_name AS room_type,
    rs.status_name AS reservation_status,
    r.booking_date,
    r.check_in_date,
    r.check_out_date,
    r.adults,
    r.children,
    r.total_amount,
    r.special_requests
FROM reservations r
JOIN customers c ON r.customer_id = c.customer_id
JOIN rooms rm ON r.room_id = rm.room_id
JOIN room_types rt ON rm.room_type_id = rt.room_type_id
JOIN reservation_statuses rs ON r.status_id = rs.status_id
WHERE r.reservation_id = 26;



-- 6. Retrieve payment details for a reservation
SELECT 
    p.payment_id,
    p.reservation_id,
    pm.method_name AS payment_method,
    ps.status_name AS payment_status,
    p.payment_amount,
    p.payment_date,
    p.transaction_reference
FROM payments p
JOIN payment_methods pm ON p.payment_method_id = pm.payment_method_id
JOIN payment_statuses ps ON p.payment_status_id = ps.payment_status_id
WHERE p.reservation_id = 26;



-- 7. Retrieve all services linked to a reservation
SELECT 
    rs.reservation_service_id,
    rs.reservation_id,
    s.service_name,
    rs.quantity,
    rs.service_total
FROM reservation_services rs
JOIN services s ON rs.service_id = s.service_id
WHERE rs.reservation_id = 26;




## 🔹 UPDATE OPERATIONS


-- 8. Update customer phone number
UPDATE customers
SET phone = '+44-7700-399999'
WHERE customer_id = 21;



-- 9. Update reservation status from Pending (1) to Confirmed (2)
UPDATE reservations
SET status_id = 2
WHERE reservation_id = 26;



-- 10. Record status change in history table
INSERT INTO reservation_status_history (
    reservation_id, old_status_id, new_status_id,
    changed_by_staff_id, changed_at, remarks
)
VALUES (
    26, 1, 2, 2, NOW(),
    'Reservation confirmed after successful payment'
);




## 🔹 DELETE OPERATIONS


-- 11. Remove a service from the reservation
DELETE FROM reservation_services
WHERE reservation_id = 26
  AND service_id = 1;



-- 12. Delete payment record for test reservation
DELETE FROM payments
WHERE reservation_id = 26;



-- 13. Delete reservation record
DELETE FROM reservations
WHERE reservation_id = 26;



-- 14. Delete customer record
DELETE FROM customers
WHERE customer_id = 21;




# ADVANCED QUERIES (WITH COMMENTS)




-- 1. Customer reservation history (multi-table join)
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    r.reservation_id,
    rm.room_number,
    rt.type_name AS room_type,
    rs.status_name AS reservation_status,
    r.check_in_date,
    r.check_out_date,
    r.total_amount
FROM customers c
JOIN reservations r ON c.customer_id = r.customer_id
JOIN rooms rm ON r.room_id = rm.room_id
JOIN room_types rt ON rm.room_type_id = rt.room_type_id
JOIN reservation_statuses rs ON r.status_id = rs.status_id
ORDER BY c.customer_id, r.check_in_date;





-- 2. Monthly revenue report using aggregation
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS revenue_month,
    SUM(payment_amount) AS total_revenue
FROM payments
WHERE payment_status_id IN (2, 3, 4)     -- Paid / Completed statuses
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY revenue_month;





-- 3. Most booked room type
SELECT 
    rt.type_name AS room_type,
    COUNT(r.reservation_id) AS total_bookings
FROM reservations r
JOIN rooms rm ON r.room_id = rm.room_id
JOIN room_types rt ON rm.room_type_id = rt.room_type_id
GROUP BY rt.type_name
ORDER BY total_bookings DESC;





-- 4. Customers with more than one reservation
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(r.reservation_id) AS total_reservations
FROM customers c
JOIN reservations r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(r.reservation_id) > 1
ORDER BY total_reservations DESC;





-- 5. Reservations with outstanding balance
SELECT 
    r.reservation_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    r.total_amount,
    COALESCE(SUM(p.payment_amount), 0) AS total_paid,
    (r.total_amount - COALESCE(SUM(p.payment_amount), 0)) AS outstanding_balance
FROM reservations r
JOIN customers c ON r.customer_id = c.customer_id
LEFT JOIN payments p ON r.reservation_id = p.reservation_id
GROUP BY r.reservation_id, c.first_name, c.last_name, r.total_amount
HAVING outstanding_balance > 0
ORDER BY outstanding_balance DESC;





-- 6. Most used hotel services
SELECT 
    s.service_name,
    SUM(rs.quantity) AS total_quantity_used,
    SUM(rs.service_total) AS total_service_revenue
FROM reservation_services rs
JOIN services s ON rs.service_id = s.service_id
GROUP BY s.service_name
ORDER BY total_quantity_used DESC, total_service_revenue DESC;





-- 7. Available rooms for a given date range
SELECT 
    rm.room_id,
    rm.room_number,
    rt.type_name,
    rt.capacity,
    rt.base_price
FROM rooms rm
JOIN room_types rt ON rm.room_type_id = rt.room_type_id
WHERE rm.availability_flag = TRUE
  AND rm.room_status NOT IN ('Occupied', 'Maintenance')
  AND rm.room_id NOT IN (
      SELECT r.room_id
      FROM reservations r
      WHERE r.status_id IN (1, 2, 5)
        AND (
            '2025-04-15' < r.check_out_date
            AND '2025-04-18' > r.check_in_date
        )
  )
ORDER BY rm.room_number;





-- 8. Average stay duration by room type
SELECT 
    rt.type_name AS room_type,
    ROUND(AVG(DATEDIFF(r.check_out_date, r.check_in_date)), 2) AS avg_stay_nights
FROM reservations r
JOIN rooms rm ON r.room_id = rm.room_id
JOIN room_types rt ON rm.room_type_id = rt.room_type_id
GROUP BY rt.type_name
ORDER BY avg_stay_nights DESC;





-- 9. Cancellation report by month
SELECT 
    DATE_FORMAT(r.booking_date, '%Y-%m') AS booking_month,
    COUNT(*) AS total_cancelled_reservations
FROM reservations r
JOIN reservation_statuses rs ON r.status_id = rs.status_id
WHERE rs.status_name = 'Cancelled'
GROUP BY DATE_FORMAT(r.booking_date, '%Y-%m')
ORDER BY booking_month;



-- 10. Staff activity (status change tracking)
SELECT 
    st.staff_id,
    CONCAT(st.first_name, ' ', st.last_name) AS staff_name,
    st.role,
    COUNT(rsh.history_id) AS total_status_changes
FROM staff st
JOIN reservation_status_history rsh 
    ON st.staff_id = rsh.changed_by_staff_id
GROUP BY st.staff_id, st.first_name, st.last_name, st.role
ORDER BY total_status_changes DESC;



-- 11. Reservation status distribution
SELECT 
    rs.status_name,
    COUNT(r.reservation_id) AS total_reservations
FROM reservation_statuses rs
LEFT JOIN reservations r ON rs.status_id = r.status_id
GROUP BY rs.status_id, rs.status_name
ORDER BY total_reservations DESC;


-- 12. Top 5 paying customers
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(p.payment_amount) AS total_paid
FROM customers c
JOIN reservations r ON c.customer_id = r.customer_id
JOIN payments p ON r.reservation_id = p.reservation_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_paid DESC
LIMIT 5;



