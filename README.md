# Rental-Management - Database Schema

This project defines the SQL schema for a Property Management System. It supports roles and permissions, property and unit management, tenant handling, billing, payments, maintenance, and lease tracking.

## 📦 Database: `property_management`

### ✅ Main Functional Areas:
- **User & Role Management** (`system_users`, `roles`, `roles_system_users`)
- **Property & Unit Management** (`properties`, `property_units`, `property_types`, `unit_types`, `property_status`, `property_unit_status`)
- **Tenant Management** (`tenants`, `lease_agreements`, `unit_occupation`)
- **Billing & Payments** (`tenant_bills`, `receipts`, `payment_types`)
- **Service & Maintenance** (`service_types`, `service_providers`, `maintenance_requests`)

### 🗂️ Table Creation Order:
Tables are created in an order that respects foreign key constraints. Refer to `schema.sql` or run the script in order.

### 🛠️ Setup Instructions:
1. Import the schema using MySQL Workbench or the command line:
   ```bash
   mysql -u your_username -p < schema.sql
2. Make sure to replace your_username with your actual MySQL username.

📌 Notes:
Uses AUTO_INCREMENT for primary keys.

All relevant relationships are enforced with FOREIGN KEY constraints.

Date fields are typed using DATE, while phone/contact fields use VARCHAR for flexibility.

## 👤 Author

**Denis Macharia Ndiritu**  
[LinkedIn](https://www.linkedin.com/in/denis-ndiritu-15b6a5341/) | [GitHub](https://github.com/seaSharkDenis) | [Email](mailto:denisndiritu1@gmail.com)
