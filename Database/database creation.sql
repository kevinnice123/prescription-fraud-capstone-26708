-------------------------------------------------------------------
--  PHASE IV – DATABASE CREATION SCRIPT
--  Project: Smart Prescription Fraud Prevention System
--  Student: Kevin (ID: 26708)
--  PDB: mon_26708_prescriptionfraud_db
--  User: admin_26708
--  Password: kevin
-------------------------------------------------------------------

-------------------------------
-- 1. SWITCH TO YOUR PDB
-------------------------------
ALTER SESSION SET CONTAINER = mon_26708_prescriptionfraud_db;



-------------------------------
-- 2. CREATE TABLESPACES
-------------------------------
-- Data Tablespace
CREATE TABLESPACE prescription_data
DATAFILE 'C:\app\Kevin\product\21c\oradata\XE\PRESCRIPTION_DATA01.DBF'
SIZE 200M 
AUTOEXTEND ON NEXT 50M 
MAXSIZE UNLIMITED;

-- Index Tablespace
CREATE TABLESPACE prescription_idx
DATAFILE 'C:\app\Kevin\product\21c\oradata\XE\PRESCRIPTION_IDX01.DBF'
SIZE 100M 
AUTOEXTEND ON NEXT 25M 
MAXSIZE UNLIMITED;

-- Temporary Tablespace
CREATE TEMPORARY TABLESPACE prescription_temp
TEMPFILE 'C:\app\Kevin\product\21c\oradata\XE\PRESCRIPTION_TEMP01.DBF'
SIZE 100M 
AUTOEXTEND ON NEXT 25M;



-------------------------------
-- 3. CREATE ADMIN USER
-------------------------------
CREATE USER admin_26708 IDENTIFIED BY kevin
DEFAULT TABLESPACE prescription_data
TEMPORARY TABLESPACE prescription_temp
QUOTA UNLIMITED ON prescription_data
QUOTA UNLIMITED ON prescription_idx
ACCOUNT UNLOCK;

-- Grant Roles
GRANT CONNECT, RESOURCE, DBA TO admin_26708;

-- Additional Privileges
GRANT CREATE SESSION, CREATE TABLE, CREATE PROCEDURE,
      CREATE TRIGGER, CREATE SEQUENCE, CREATE VIEW,
      CREATE MATERIALIZED VIEW, CREATE SYNONYM,
      CREATE DATABASE LINK, CREATE JOB, AUDIT ANY,
      UNLIMITED TABLESPACE
TO admin_26708;



-------------------------------
-- 4. CREATE SEQUENCES
-------------------------------
CREATE SEQUENCE seq_patient_id START WITH 1001 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_doctor_id START WITH 2001 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_pharmacy_id START WITH 4001 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_prescription_id START WITH 3001 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_presc_item_id START WITH 3101 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_fraud_alert_id START WITH 5001 INCREMENT BY 1 NOCACHE;



-------------------------------
-- 5. CREATE MAIN TABLES
-------------------------------

-- PATIENT TABLE
CREATE TABLE patient (
  patient_id     NUMBER PRIMARY KEY,
  first_name     VARCHAR2(100) NOT NULL,
  last_name      VARCHAR2(100) NOT NULL,
  dob            DATE,
  gender         VARCHAR2(10),
  phone          VARCHAR2(30),
  email          VARCHAR2(100),
  address        VARCHAR2(400),
  national_id    VARCHAR2(50) UNIQUE,
  created_at     TIMESTAMP DEFAULT SYSTIMESTAMP
) TABLESPACE prescription_data;


-- DOCTOR TABLE
CREATE TABLE doctor (
  doctor_id      NUMBER PRIMARY KEY,
  first_name     VARCHAR2(100) NOT NULL,
  last_name      VARCHAR2(100) NOT NULL,
  license_no     VARCHAR2(50) UNIQUE,
  specialty      VARCHAR2(100),
  phone          VARCHAR2(30),
  email          VARCHAR2(100),
  created_at     TIMESTAMP DEFAULT SYSTIMESTAMP
) TABLESPACE prescription_data;


-- PHARMACY TABLE
CREATE TABLE pharmacy (
  pharmacy_id    NUMBER PRIMARY KEY,
  name           VARCHAR2(200) NOT NULL,
  address        VARCHAR2(400),
  phone          VARCHAR2(30),
  license_no     VARCHAR2(50) UNIQUE,
  created_at     TIMESTAMP DEFAULT SYSTIMESTAMP
) TABLESPACE prescription_data;


-- PRESCRIPTION TABLE
CREATE TABLE prescription (
  prescription_id NUMBER PRIMARY KEY,
  patient_id      NUMBER NOT NULL,
  doctor_id       NUMBER NOT NULL,
  pharmacy_id     NUMBER,
  issue_date      DATE DEFAULT SYSDATE,
  valid_until     DATE,
  total_items     NUMBER DEFAULT 0,
  notes           VARCHAR2(1000),
  status          VARCHAR2(30) DEFAULT 'ISSUED',
  created_at      TIMESTAMP DEFAULT SYSTIMESTAMP,
  CONSTRAINT fk_presc_patient FOREIGN KEY(patient_id) REFERENCES patient(patient_id),
  CONSTRAINT fk_presc_doctor FOREIGN KEY(doctor_id) REFERENCES doctor(doctor_id),
  CONSTRAINT fk_presc_pharmacy FOREIGN KEY(pharmacy_id) REFERENCES pharmacy(pharmacy_id)
) TABLESPACE prescription_data;


-- PRESCRIPTION ITEMS TABLE
CREATE TABLE prescription_item (
  presc_item_id    NUMBER PRIMARY KEY,
  prescription_id  NUMBER NOT NULL,
  drug_name        VARCHAR2(400) NOT NULL,
  dosage           VARCHAR2(100),
  quantity         NUMBER DEFAULT 1,
  unit             VARCHAR2(50),
  instructions     VARCHAR2(4000),
  created_at       TIMESTAMP DEFAULT SYSTIMESTAMP,
  CONSTRAINT fk_item_presc FOREIGN KEY(prescription_id) REFERENCES prescription(prescription_id)
) TABLESPACE prescription_data;


-- FRAUD ALERT TABLE
CREATE TABLE fraud_alert (
  fraud_alert_id  NUMBER PRIMARY KEY,
  prescription_id NUMBER,
  alert_type      VARCHAR2(100),
  alert_date      TIMESTAMP DEFAULT SYSTIMESTAMP,
  severity        VARCHAR2(20),
  description     CLOB,
  resolved_flag   CHAR(1) DEFAULT 'N' CHECK (resolved_flag IN ('Y','N')),
  resolved_date   TIMESTAMP,
  created_at      TIMESTAMP DEFAULT SYSTIMESTAMP,
  CONSTRAINT fk_fraud_presc FOREIGN KEY(prescription_id) REFERENCES prescription(prescription_id)
) TABLESPACE prescription_data;



-------------------------------
-- 6. AUDIT LOG TABLE
-------------------------------
CREATE TABLE system_audit_trail (
    audit_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_name VARCHAR2(50) NOT NULL,
    action_type VARCHAR2(20) NOT NULL,
    table_name VARCHAR2(50),
    record_id VARCHAR2(100),
    old_values CLOB,
    new_values CLOB,
    action_timestamp TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    ip_address VARCHAR2(50),
    session_id VARCHAR2(50),
    status VARCHAR2(20) DEFAULT 'SUCCESS',
    error_message CLOB,
    fraud_flag CHAR(1) DEFAULT 'N' CHECK (fraud_flag IN ('Y','N'))
) TABLESPACE prescription_data;



-------------------------------
-- 7. CREATE INDEXES
-------------------------------
CREATE INDEX idx_presc_issue_date ON prescription(issue_date) TABLESPACE prescription_idx;
CREATE INDEX idx_presc_patient    ON prescription(patient_id) TABLESPACE prescription_idx;
CREATE INDEX idx_presc_doctor     ON prescription(doctor_id) TABLESPACE prescription_idx;
CREATE INDEX idx_item_presc       ON prescription_item(prescription_id) TABLESPACE prescription_idx;
CREATE INDEX idx_fraud_presc      ON fraud_alert(prescription_id) TABLESPACE prescription_idx;
CREATE INDEX idx_audit_ts         ON system_audit_trail(action_timestamp) TABLESPACE prescription_idx;



-------------------------------
-- 8. VERIFICATION SECTION
-------------------------------
PROMPT === TABLES CREATED ===
SELECT table_name FROM user_tables ORDER BY table_name;

PROMPT === SEQUENCES CREATED ===
SELECT sequence_name FROM user_sequences ORDER BY sequence_name;

PROMPT === INDEXES CREATED ===
SELECT index_name FROM user_indexes ORDER BY index_name;

PROMPT === USER DETAILS ===
SELECT username, account_status, default_tablespace FROM user_users;

-------------------------------------------------------------------
-- END OF DATABASE CREATION SCRIPT
-------------------------------------------------------------------
