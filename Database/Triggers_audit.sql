-- ============================================================
-- Enhanced Audit Triggers for Prescription Fraud System
-- Includes exception handling and old/new value logging
-- ============================================================

-- =========================
-- Patient Table Trigger
-- =========================
CREATE OR REPLACE TRIGGER trg_audit_patient
AFTER INSERT OR UPDATE OR DELETE ON patient
FOR EACH ROW
BEGIN
    BEGIN
        IF INSERTING THEN
            audit_pkg.log_action('INSERT', 'PATIENT', :NEW.patient_id,
                'New patient added: ' || :NEW.full_name);
        ELSIF UPDATING THEN
            audit_pkg.log_action('UPDATE', 'PATIENT', :NEW.patient_id,
                'Patient updated from: ' || :OLD.full_name || ' to: ' || :NEW.full_name);
        ELSIF DELETING THEN
            audit_pkg.log_action('DELETE', 'PATIENT', :OLD.patient_id,
                'Patient deleted: ' || :OLD.full_name);
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            NULL; -- Prevent audit failure from blocking DML
    END;
END;
/

-- =========================
-- Doctor Table Trigger
-- =========================
CREATE OR REPLACE TRIGGER trg_audit_doctor
AFTER INSERT OR UPDATE OR DELETE ON doctor
FOR EACH ROW
BEGIN
    BEGIN
        IF INSERTING THEN
            audit_pkg.log_action('INSERT', 'DOCTOR', :NEW.doctor_id,
                'New doctor added: ' || :NEW.full_name);
        ELSIF UPDATING THEN
            audit_pkg.log_action('UPDATE', 'DOCTOR', :NEW.doctor_id,
                'Doctor updated from: ' || :OLD.full_name || ' to: ' || :NEW.full_name);
        ELSIF DELETING THEN
            audit_pkg.log_action('DELETE', 'DOCTOR', :OLD.doctor_id,
                'Doctor deleted: ' || :OLD.full_name);
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
END;
/

-- =========================
-- Pharmacy Table Trigger
-- =========================
CREATE OR REPLACE TRIGGER trg_audit_pharmacy
AFTER INSERT OR UPDATE OR DELETE ON pharmacy
FOR EACH ROW
BEGIN
    BEGIN
        IF INSERTING THEN
            audit_pkg.log_action('INSERT', 'PHARMACY', :NEW.pharmacy_id,
                'New pharmacy added: ' || :NEW.pharmacy_name);
        ELSIF UPDATING THEN
            audit_pkg.log_action('UPDATE', 'PHARMACY', :NEW.pharmacy_id,
                'Pharmacy updated from: ' || :OLD.pharmacy_name || ' to: ' || :NEW.pharmacy_name);
        ELSIF DELETING THEN
            audit_pkg.log_action('DELETE', 'PHARMACY', :OLD.pharmacy_id,
                'Pharmacy deleted: ' || :OLD.pharmacy_name);
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
END;
/

-- =========================
-- Prescription Table Trigger
-- =========================
CREATE OR REPLACE TRIGGER trg_audit_prescription
AFTER INSERT OR UPDATE OR DELETE ON prescription
FOR EACH ROW
BEGIN
    BEGIN
        IF INSERTING THEN
            audit_pkg.log_action('INSERT', 'PRESCRIPTION', :NEW.prescription_id,
                'Prescription created');
        ELSIF UPDATING THEN
            audit_pkg.log_action('UPDATE', 'PRESCRIPTION', :NEW.prescription_id,
                'Prescription updated');
        ELSIF DELETING THEN
            audit_pkg.log_action('DELETE', 'PRESCRIPTION', :OLD.prescription_id,
                'Prescription deleted');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
END;
/

-- =========================
-- Prescription Item Table Trigger
-- =========================
CREATE OR REPLACE TRIGGER trg_audit_prescription_item
AFTER INSERT OR UPDATE OR DELETE ON prescription_item
FOR EACH ROW
BEGIN
    BEGIN
        IF INSERTING THEN
            audit_pkg.log_action('INSERT', 'PRESCRIPTION_ITEM', :NEW.presc_item_id,
                'Prescription item added: ' || :NEW.drug_name || ' (' || :NEW.dosage || ')');
        ELSIF UPDATING THEN
            audit_pkg.log_action('UPDATE', 'PRESCRIPTION_ITEM', :NEW.presc_item_id,
                'Prescription item updated from: ' || :OLD.drug_name || ' (' || :OLD.dosage || 
                ') to: ' || :NEW.drug_name || ' (' || :NEW.dosage || ')');
        ELSIF DELETING THEN
            audit_pkg.log_action('DELETE', 'PRESCRIPTION_ITEM', :OLD.presc_item_id,
                'Prescription item deleted: ' || :OLD.drug_name || ' (' || :OLD.dosage || ')');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
END;
/

-- =========================
-- Fraud Alert Table Trigger
-- =========================
CREATE OR REPLACE TRIGGER trg_audit_fraud_alert
AFTER INSERT OR UPDATE OR DELETE ON fraud_alert
FOR EACH ROW
BEGIN
    BEGIN
        IF INSERTING THEN
            audit_pkg.log_action('INSERT', 'FRAUD_ALERT', :NEW.fraud_alert_id,
                'Fraud alert added: ' || :NEW.alert_type);
        ELSIF UPDATING THEN
            audit_pkg.log_action('UPDATE', 'FRAUD_ALERT', :NEW.fraud_alert_id,
                'Fraud alert updated: ' || :NEW.alert_type);
        ELSIF DELETING THEN
            audit_pkg.log_action('DELETE', 'FRAUD_ALERT', :OLD.fraud_alert_id,
                'Fraud alert deleted: ' || :OLD.alert_type);
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
END;
/
