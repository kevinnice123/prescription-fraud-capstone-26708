-------------------------------------------------------------------
--  PHASE V – SAMPLE DATA INSERTION SCRIPT
--  Project: Smart Prescription Fraud Prevention System
--  Student: Kevin (ID: 26708)
--  User: admin_26708
-------------------------------------------------------------------

----------------------------
-- 1. INSERT PATIENTS
----------------------------
INSERT INTO patient (patient_id, first_name, last_name, dob, gender, phone, email, address, national_id)
VALUES (seq_patient_id.NEXTVAL, 'John', 'Mukamana', DATE '1990-05-12', 'Male', '0788001122', 'john@example.com', 'Kigali, Gasabo', '1199001234567890');

INSERT INTO patient (patient_id, first_name, last_name, dob, gender, phone, email, address, national_id)
VALUES (seq_patient_id.NEXTVAL, 'Alice', 'Uwase', DATE '1987-11-23', 'Female', '0788993344', 'alice@example.com', 'Kigali, Kicukiro', '1198709876543210');

INSERT INTO patient (patient_id, first_name, last_name, dob, gender, phone, email, address, national_id)
VALUES (seq_patient_id.NEXTVAL, 'Eric', 'Nshimiyimana', DATE '1995-03-04', 'Male', '0788432110', 'eric@example.com', 'Musanze', '1199501122334455');


----------------------------
-- 2. INSERT DOCTORS
----------------------------
INSERT INTO doctor (doctor_id, first_name, last_name, license_no, specialty, phone, email)
VALUES (seq_doctor_id.NEXTVAL, 'Dr. Jean', 'Hategekimana', 'DOC-2024001', 'General Medicine', '0788112233', 'dr.jean@example.com');

INSERT INTO doctor (doctor_id, first_name, last_name, license_no, specialty, phone, email)
VALUES (seq_doctor_id.NEXTVAL, 'Dr. Sarah', 'Mukarusagara', 'DOC-2024022', 'Pediatrics', '0788009988', 'dr.sarah@example.com');


----------------------------
-- 3. INSERT PHARMACIES
----------------------------
INSERT INTO pharmacy (pharmacy_id, name, address, phone, license_no)
VALUES (seq_pharmacy_id.NEXTVAL, 'City Health Pharmacy', 'Kigali City Center', '0788223344', 'PHARM-01');

INSERT INTO pharmacy (pharmacy_id, name, address, phone, license_no)
VALUES (seq_pharmacy_id.NEXTVAL, 'Green Care Pharmacy', 'Remera Main Road', '0788115566', 'PHARM-02');


----------------------------
-- 4. INSERT PRESCRIPTIONS
----------------------------
INSERT INTO prescription (prescription_id, patient_id, doctor_id, pharmacy_id, issue_date, valid_until, total_items, notes, status)
VALUES (
    seq_prescription_id.NEXTVAL,
    1001,  -- First patient
    2001,  -- First doctor
    4001,  -- First pharmacy
    SYSDATE,
    SYSDATE + 30,
    2,
    'Regular medication for blood pressure',
    'ISSUED'
);

INSERT INTO prescription (prescription_id, patient_id, doctor_id, pharmacy_id, issue_date, valid_until, total_items, notes, status)
VALUES (
    seq_prescription_id.NEXTVAL,
    1002,
    2002,
    4002,
    SYSDATE,
    SYSDATE + 15,
    1,
    'Pain management prescription',
    'ISSUED'
);


----------------------------
-- 5. INSERT PRESCRIPTION ITEMS
----------------------------
-- For first prescription (ID 3001)
INSERT INTO prescription_item (presc_item_id, prescription_id, drug_name, dosage, quantity, unit, instructions)
VALUES (
    seq_presc_item_id.NEXTVAL,
    3001,
    'Paracetamol',
    '500mg',
    20,
    'Tablets',
    'Take one tablet every 8 hours'
);

INSERT INTO prescription_item (presc_item_id, prescription_id, drug_name, dosage, quantity, unit, instructions)
VALUES (
    seq_presc_item_id.NEXTVAL,
    3001,
    'Amlodipine',
    '10mg',
    30,
    'Tablets',
    'Once daily in the morning'
);

-- For second prescription (ID 3002)
INSERT INTO prescription_item (presc_item_id, prescription_id, drug_name, dosage, quantity, unit, instructions)
VALUES (
    seq_presc_item_id.NEXTVAL,
    3002,
    'Ibuprofen',
    '200mg',
    15,
    'Tablets',
    'Take one tablet after meals'
);


----------------------------
-- 6. INSERT SAMPLE FRAUD ALERTS
----------------------------
INSERT INTO fraud_alert (fraud_alert_id, prescription_id, alert_type, severity, description, fraud_flag)
VALUES (
    seq_fraud_alert_id.NEXTVAL,
    3001,
    'Duplicate Prescription',
    'HIGH',
    'Patient attempted to refill prescription earlier than allowed',
    'Y'
);

INSERT INTO fraud_alert (fraud_alert_id, prescription_id, alert_type, severity, description, fraud_flag)
VALUES (
    seq_fraud_alert_id.NEXTVAL,
    3002,
    'Unusual Quantity',
    'MEDIUM',
    'Prescription issued with higher-than-normal dosage',
    'N'
);


----------------------------
-- 7. COMMIT CHANGES
----------------------------
COMMIT;

-------------------------------------------------------------------
-- END OF DATA INSERTION SCRIPT
-------------------------------------------------------------------
