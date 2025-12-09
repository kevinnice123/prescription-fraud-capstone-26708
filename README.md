# Smart Prescription Fraud Prevention System

## Project Overview
**Student:** Kevin (ID: 26708)  
**Course:** Database Development with PL/SQL (INSY 8311)  
**Institution:** Adventist University of Central Africa (AUCA)  
**Academic Year:** 2025-2026 | Semester: I  
**Lecturer:** Eric Maniraguha  
**Completion Date:** December 7, 2025  
**Database:** MOU_26708_PRESCRIPTIONFRAUD_DB  

## Problem Statement
This project addresses prescription fraud in healthcare systems by developing a comprehensive database solution that detects, prevents, and audits fraudulent prescription activities. The system helps pharmacies, healthcare providers, and insurance companies identify suspicious patterns and prevent financial losses.

## Project Objectives
- Design and implement a secure Oracle database for prescription management
- Develop PL/SQL procedures for fraud detection and prevention
- Implement comprehensive auditing and security mechanisms
- Create business intelligence capabilities for fraud analytics
- Ensure data integrity and compliance with healthcare regulations

## Database Structure

### ER Diagram
![ER Diagram](ER_DIAGRAM.png) *Place the ER diagram screenshot here*

**Tables:**
1. `PATIENT` - Patient demographic information
2. `DOCTOR` - Healthcare provider details
3. `PHARMACY` - Pharmacy information
4. `PRESCRIPTION` - Prescription master records
5. `PRESCRIPTION_ITEM` - Individual prescription items
6. `FRAUD_ALERT` - Fraud detection alerts
7. `SYSTEM_AUDIT_TRAIL` - Comprehensive audit logging

### Database Configuration
**PDB Name:** MOU_26708_PRESCRIPTIONFRAUD_DB  
**Admin User:** ADMIN_26708  

**Tablespaces:**
- `PRESCRIPTION_DATA` (200MB) - For table data
- `PRESCRIPTION_IDX` (100MB) - For indexes
- `PRESCRIPTION_TEMP` (100MB) - Temporary tablespace

![Database Connection](main_17.png) *Place database connection screenshot*
![Tablespace Verification](main_5.png) *Place tablespace verification screenshot*

## Business Process Modeling

### BPMN Workflow
![BPMN Diagram](BPMN.png) *Place BPMN diagram screenshot*

**Key Processes:**
1. **Patient Registration & Validation**
2. **Prescription Creation**
3. **Fraud Detection & Alerting**
4. **Prescription Issuance**

## Implementation Phases

### Phase IV: Database Creation
Database successfully created with all required configurations including tablespaces, users, and parameters.

![Database Information](main_4.png) *Place database information screenshot*
![Database Parameters](main_7.png) *Place database parameters screenshot*

### Phase V: Table Implementation
All tables created with proper constraints, indexes, and relationships. Sample data inserted for testing.

![Created Objects](main_13.png) *Place created objects screenshot*

### Phase VI: PL/SQL Development
**Packages Implemented:**
1. `AUDIT_PKG` - Comprehensive auditing functionality
2. `PRESCRIPTION_PKG` - Prescription management procedures
3. `REPORT_PKG` - Reporting and analytics functions

![Package Compilation](main_15.png) *Place package compilation screenshot*

**Note:** Compilation error detected in REPORT_PKG (Line 37) - requires fixing invalid relational operator.

### Phase VII: Advanced Programming & Auditing
Implemented triggers and business rules including:
- Weekend/holiday restriction rules
- Comprehensive audit logging
- Fraud detection algorithms

## Business Intelligence & Analytics

### Key Performance Indicators (KPIs)
1. Fraud detection rate
2. Prescription validation time
3. Alert severity distribution
4. Audit compliance percentage

### Dashboard Requirements
1. **Executive Dashboard** - Overall system metrics
2. **Fraud Analytics Dashboard** - Detection patterns and trends
3. **Audit Compliance Dashboard** - Security and compliance metrics

## Installation & Setup

### Prerequisites
- Oracle Database 19c or later
- SQL Developer or similar tool
- Required privileges: CREATE SESSION, CREATE TABLE, CREATE PROCEDURE, etc.

### Quick Start
```sql
-- Connect to the database
CONNECT ADMIN_26708@MOU_26708_PRESCRIPTIONFRAUD_DB

-- Run initialization scripts
@database/scripts/01_create_tables.sql
@database/scripts/02_insert_data.sql
@database/scripts/03_create_packages.sql
