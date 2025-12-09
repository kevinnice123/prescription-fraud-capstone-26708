-- ============================================================
-- sequences.sql
-- Description: All sequences for Prescription Fraud System
-- ============================================================

-- Sequence for Prescription ID
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM user_sequences
    WHERE sequence_name = 'SEQ_PRESCRIPTION_ID';

    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_prescription_id START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
    END IF;
END;
/

-- Sequence for Prescription Item ID
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM user_sequences
    WHERE sequence_name = 'SEQ_PRESC_ITEM_ID';

    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_presc_item_id START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
    END IF;
END;
/

-- Sequence for Fraud Alert ID
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM user_sequences
    WHERE sequence_name = 'SEQ_FRAUD_ALERT_ID';

    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_fraud_alert_id START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
    END IF;
END;
/
