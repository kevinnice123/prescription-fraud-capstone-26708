# Smart Prescription Fraud Prevention System

## Project Overview
**Student:** Niyomugabo Nice Kevin (ID: 26708)  
**Course:** Database Development with PL/SQL (INSY 8311)  
**Institution:** Adventist University of Central Africa (AUCA)  
**Academic Year:** 2025-2026 | Semester: I  
**Lecturer:** Eric Maniraguha  
**Completion Date:** December 7, 2025  
**Database:** MON_26708_PRESCRIPTIONFRAUD_DB  

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
<img width="410" height="381" alt="ER DIAGRAM" src="https://github.com/user-attachments/assets/f8978ada-a13c-49f9-8f66-786a6b61357b" />


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

<img width="224" height="244" alt="main 17" src="https://github.com/user-attachments/assets/c4369507-724d-41f2-b6fd-71fd53f5f69f" />

<img width="779" height="340" alt="main 5" src="https://github.com/user-attachments/assets/db56d986-76fe-4cec-84f9-f2959a80806e" />


## Business Process Modeling

### BPMN Workflow
<img width="755" height="286" alt="BPMN" src="https://github.com/user-attachments/assets/4b3be29e-7e0b-496e-807d-7179c012a7cd" />


**Key Processes:**
1. **Patient Registration & Validation**
2. **Prescription Creation**
3. **Fraud Detection & Alerting**
4. **Prescription Issuance**

## Implementation Phases

### Phase IV: Database Creation
Database successfully created with all required configurations including tablespaces, users, and parameters.

<img width="781" height="341" alt="main 4" src="https://github.com/user-attachments/assets/1e2c3673-41da-4e57-9c43-94c26e0a8e46" />

<img width="782" height="401" alt="main 7" src="https://github.com/user-attachments/assets/6588c071-1ec5-47b8-bbb6-a77b4ea83f4e" />


### Phase V: Table Implementation
All tables created with proper constraints, indexes, and relationships. Sample data inserted for testing.

<img width="785" height="311" alt="main 13" src="https://github.com/user-attachments/assets/f95dc483-0467-48d7-ab91-2d9c674dd339" />


### Phase VI: PL/SQL Development
**Packages Implemented:**
1. `AUDIT_PKG` - Comprehensive auditing functionality
2. `PRESCRIPTION_PKG` - Prescription management procedures
3. `REPORT_PKG` - Reporting and analytics functions

<img width="788" height="290" alt="main 15" src="https://github.com/user-attachments/assets/54539fd0-c7d8-4a77-8788-8bf3f48e9ec0" />


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

## Problem Statement
This project addresses prescription fraud in healthcare systems by developing a comprehensive database solution that detects, prevents, and audits fraudulent prescription activities. The system helps pharmacies, healthcare providers, and insurance companies identify suspicious patterns and prevent financial losses.

## Project Objectives
- Design and implement a secure Oracle database for prescription management
- Develop PL/SQL procedures for fraud detection and prevention
- Implement comprehensive auditing and security mechanisms
- Create business intelligence capabilities for fraud analytics
- Ensure data integrity and compliance with healthcare regulations

## [ADDITION] Phase IV: Database Creation - Detailed Implementation

### Database Setup Scripts
Following the project naming convention: `GroupName_StudentId_FirstName_ProjectName_DB`
<img width="959" height="503" alt="2" src="https://github.com/user-attachments/assets/f892f495-c0d0-49fe-80d0-75b7573fb4f0" />


**Key Configuration Steps:**

1. **PDB Creation:**
   ```sql
   CREATE PLUGGABLE DATABASE mon_26708_prescriptionfraud_db
   ADMIN USER prescription_admin IDENTIFIED BY kevin
   FILE_NAME_CONVERT = (...);
