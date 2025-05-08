CREATE DATABASE IF NOT EXISTS property_management;

USE property_management;

-- 1. Roles and Users
CREATE TABLE IF NOT EXISTS roles(
    role_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    role_name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS system_users(
    sysuser_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_name VARCHAR(255) NOT NULL,
    password VARCHAR(1000) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    othernames VARCHAR(255) NOT NULL,
    datetime_created DATE NOT NULL,
    user_last_login DATE NOT NULL,
    password_last_changed DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS roles_system_users(
    role_system_user_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    role_id INT NOT NULL,
    sysuser_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (sysuser_id) REFERENCES system_users(sysuser_id)
);

-- 2. Payment Types
CREATE TABLE IF NOT EXISTS payment_types(
    payment_type_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    payment_type VARCHAR(255) NOT NULL
);

-- 3. Property Setup
CREATE TABLE IF NOT EXISTS property_status(
    property_status_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    property_status_name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS property_types(
    property_type_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    property_type_name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS properties(
    property_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    property_name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    property_type_id INT NOT NULL,
    property_status_id INT NOT NULL,
    FOREIGN KEY (property_type_id) REFERENCES property_types(property_type_id),
    FOREIGN KEY (property_status_id) REFERENCES property_status(property_status_id)
);

-- 4. Unit Setup
CREATE TABLE IF NOT EXISTS unit_types(
    unit_type_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    unit_type_name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS property_unit_status(
    property_unit_status_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS property_units(
    property_unit_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    property_id INT NOT NULL,
    unit_type_id INT NOT NULL,
    unit_name VARCHAR(255) NOT NULL,
    property_unit_status_id INT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (unit_type_id) REFERENCES unit_types(unit_type_id),
    FOREIGN KEY (property_unit_status_id) REFERENCES property_unit_status(property_unit_status_id)
);

-- 5. Service Setup
 CREATE TABLE IF NOT EXISTS service_types(
    service_type_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    service_name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS service_providers(
    service_provider_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    company VARCHAR(255),
    contact_person VARCHAR(255),
    phone_number VARCHAR(20),
    email VARCHAR(255),
    service_type_id INT,
    address VARCHAR(1000),
    FOREIGN KEY (service_type_id) REFERENCES service_types(service_type_id)
);

-- 6. Tenants
CREATE TABLE IF NOT EXISTS tenants(
    tenant_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    surname VARCHAR(255),
    othernames VARCHAR(255),
    ID_number INT NOT NULL,
    profession VARCHAR(255),
    phone_number VARCHAR(20) NOT NULL,
    next_of_kin VARCHAR(255) NOT NULL,
    next_of_kin_contact VARCHAR(20),
    next_of_kin_relationship VARCHAR(255) NOT NULL
);

-- 7. Tenant Transactions
CREATE TABLE IF NOT EXISTS tenant_bills(
    tenant_bill_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    datetime_created DATE NOT NULL,
    total_bill_amount DECIMAL(8, 2) NOT NULL,
    amount_paid DECIMAL(8, 2) NOT NULL,
    bill_due_date DATE NOT NULL,
    tenant_id INT NOT NULL,
    property_unit_id INT NOT NULL,
    FOREIGN KEY (tenant_id) REFERENCES tenants(tenant_id),
    FOREIGN KEY (property_unit_id) REFERENCES property_units(property_unit_id)
);

CREATE TABLE IF NOT EXISTS receipts(
    receipt_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    datetime_created DATE NOT NULL,
    reference_code VARCHAR(255),
    amount_paid DECIMAL(8, 2) NOT NULL,
    payment_for VARCHAR(255) NOT NULL,
    tenant_bill_id INT NOT NULL,
    issued_by INT NOT NULL,
    paid_by VARCHAR(255) NOT NULL,
    payment_type_id INT NOT NULL,
    FOREIGN KEY (tenant_bill_id) REFERENCES tenant_bills(tenant_bill_id),
    FOREIGN KEY (issued_by) REFERENCES system_users(sysuser_id),
    FOREIGN KEY (payment_type_id) REFERENCES payment_types(payment_type_id)
);

-- 8. Lease & Occupation
CREATE TABLE IF NOT EXISTS lease_agreements(
    lease_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tenant_id INT NOT NULL,
    property_unit_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    deposit_amount DECIMAL(8, 2),
    terms TEXT,
    created_by INT NOT NULL,
    FOREIGN KEY (tenant_id) REFERENCES tenants(tenant_id),
    FOREIGN KEY (property_unit_id) REFERENCES property_units(property_unit_id),
    FOREIGN KEY (created_by) REFERENCES system_users(sysuser_id)
);

CREATE TABLE IF NOT EXISTS unit_occupation(
    unit_occupation_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    property_unit_id INT NOT NULL,
    occupied_by INT NOT NULL,
    assigned_by INT NOT NULL,
    date_occupied DATE NOT NULL,
    FOREIGN KEY (property_unit_id) REFERENCES property_units(property_unit_id),
    FOREIGN KEY (occupied_by) REFERENCES tenants(tenant_id),
    FOREIGN KEY (assigned_by) REFERENCES system_users(sysuser_id)
);

-- 9. Maintenance
CREATE TABLE IF NOT EXISTS maintenance_requests(
    maint_requests_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    property_unit_id INT NOT NULL,
    request_description TEXT NOT NULL,
    planned_date_of_maintenance DATE NOT NULL,
    service_provider INT NOT NULL,
    FOREIGN KEY (property_unit_id) REFERENCES property_units(property_unit_id),
    FOREIGN KEY (service_provider) REFERENCES service_providers(service_provider_id)
);