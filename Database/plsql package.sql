-- ============================================================
-- Combined PL/SQL Packages for Prescription Fraud System
-- ============================================================

-- =========================
-- Audit Package
-- =========================
CREATE OR REPLACE PACKAGE audit_pkg AS
    PROCEDURE log_action(
        p_action_type VARCHAR2,
        p_table_name  VARCHAR2,
        p_record_id   NUMBER,
        p_description VARCHAR2
    );
END audit_pkg;
/

CREATE OR REPLACE PACKAGE BODY audit_pkg AS
    PROCEDURE log_action(
        p_action_type VARCHAR2,
        p_table_name  VARCHAR2,
        p_record_id   NUMBER,
        p_description VARCHAR2
    ) IS
    BEGIN
        INSERT INTO system_audit_trail (
            user_name, action_type, table_name, record_id,
            action_timestamp, status, fraud_flag, old_values, new_values
        ) VALUES (
            USER,
            p_action_type,
            p_table_name,
            p_record_id,
            SYSTIMESTAMP,
            'SUCCESS',
            'N',
            NULL,
            p_description
        );
    END log_action;
END audit_pkg;
/

-- =========================
-- Prescription Package
-- =========================
CREATE OR REPLACE PACKAGE prescription_pkg AS
    PROCEDURE create_prescription(
        p_patient_id  NUMBER,
        p_doctor_id   NUMBER,
        p_pharmacy_id NUMBER,
        p_notes       VARCHAR2
    );

    PROCEDURE add_prescription_item(
        p_prescription_id NUMBER,
        p_drug_name       VARCHAR2,
        p_dosage          VARCHAR2,
        p_quantity        NUMBER,
        p_unit            VARCHAR2,
        p_instructions    VARCHAR2
    );
END prescription_pkg;
/

CREATE OR REPLACE PACKAGE BODY prescription_pkg AS

    PROCEDURE create_prescription(
        p_patient_id  NUMBER,
        p_doctor_id   NUMBER,
        p_pharmacy_id NUMBER,
        p_notes       VARCHAR2
    ) IS
        v_prescription_id NUMBER;
    BEGIN
        v_prescription_id := seq_prescription_id.NEXTVAL;

        INSERT INTO prescription (
            prescription_id, patient_id, doctor_id, pharmacy_id,
            issue_date, valid_until, total_items, notes, status
        )
        VALUES (
            v_prescription_id, p_patient_id, p_doctor_id, p_pharmacy_id,
            SYSDATE, SYSDATE + 30, 0, p_notes, 'ISSUED'
        );

        audit_pkg.log_action('CREATE', 'PRESCRIPTION', v_prescription_id, 'Prescription created');
    END create_prescription;

    PROCEDURE add_prescription_item(
        p_prescription_id NUMBER,
        p_drug_name       VARCHAR2,
        p_dosage          VARCHAR2,
        p_quantity        NUMBER,
        p_unit            VARCHAR2,
        p_instructions    VARCHAR2
    ) IS
    BEGIN
        INSERT INTO prescription_item (
            presc_item_id, prescription_id, drug_name, dosage,
            quantity, unit, instructions
        ) VALUES (
            seq_presc_item_id.NEXTVAL,
            p_prescription_id,
            p_drug_name, p_dosage, p_quantity, p_unit, p_instructions
        );

        UPDATE prescription
        SET total_items = total_items + 1
        WHERE prescription_id = p_prescription_id;

        audit_pkg.log_action('ADD_ITEM', 'PRESCRIPTION_ITEM', p_prescription_id, 'Item added');
    END add_prescription_item;

END prescription_pkg;
/

-- =========================
-- Fraud Package
-- =========================
CREATE OR REPLACE PACKAGE fraud_pkg AS
    FUNCTION is_duplicate_prescription(p_patient_id NUMBER) RETURN BOOLEAN;
    FUNCTION is_unusual_quantity(p_quantity NUMBER) RETURN BOOLEAN;
    PROCEDURE evaluate_fraud(p_prescription_id NUMBER);
END fraud_pkg;
/

CREATE OR REPLACE PACKAGE BODY fraud_pkg AS

    FUNCTION is_duplicate_prescription(p_patient_id NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM prescription
        WHERE patient_id = p_patient_id
          AND issue_date > SYSDATE - 7;

        RETURN v_count > 1;
    END;

    FUNCTION is_unusual_quantity(p_quantity NUMBER) RETURN BOOLEAN IS
    BEGIN
        RETURN p_quantity > 50;
    END;

    PROCEDURE evaluate_fraud(p_prescription_id NUMBER) IS
        v_patient_id   NUMBER;
        v_flag_dup     BOOLEAN;
    BEGIN
        SELECT patient_id INTO v_patient_id
        FROM prescription
        WHERE prescription_id = p_prescription_id;

        v_flag_dup := is_duplicate_prescription(v_patient_id);

        INSERT INTO fraud_alert (
            fraud_alert_id, prescription_id, alert_type, severity,
            description, fraud_flag
        )
        VALUES (
            seq_fraud_alert_id.NEXTVAL,
            p_prescription_id,
            'SYSTEM CHECK',
            CASE WHEN v_flag_dup THEN 'HIGH' ELSE 'LOW' END,
            'Fraud evaluation completed',
            CASE WHEN v_flag_dup THEN 'Y' ELSE 'N' END
        );

        audit_pkg.log_action('FRAUD_CHECK', 'FRAUD_ALERT', p_prescription_id, 'Fraud evaluation recorded');
    END evaluate_fraud;

END fraud_pkg;
/

-- =========================
-- Report Package
-- =========================
CREATE OR REPLACE PACKAGE report_pkg AS
    PROCEDURE monthly_fraud_summary;
    PROCEDURE doctor_activity_report(p_doctor_id NUMBER);
END report_pkg;
/

CREATE OR REPLACE PACKAGE BODY report_pkg AS

    PROCEDURE monthly_fraud_summary IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('--- MONTHLY FRAUD ALERT SUMMARY ---');
        FOR rec IN (
            SELECT alert_type, COUNT(*) AS total
            FROM fraud_alert
            WHERE action_date > ADD_MONTHS(SYSDATE, -1)
            GROUP BY alert_type
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(rec.alert_type || ' = ' || rec.total);
        END LOOP;
    END monthly_fraud_summary;

    PROCEDURE doctor_activity_report(p_doctor_id NUMBER) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('--- DOCTOR PRESCRIPTION REPORT ---');
        FOR rec IN (
            SELECT p.prescription_id, p.issue_date, p.status
            FROM prescription p
            WHERE p.doctor_id = p_doctor_id
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(
                'Prescription ' || rec.prescription_id ||
                ' | Date: ' || rec.issue_date ||
                ' | Status: ' || rec.status
            );
        END LOOP;
    END doctor_activity_report;

END report_pkg;
/
