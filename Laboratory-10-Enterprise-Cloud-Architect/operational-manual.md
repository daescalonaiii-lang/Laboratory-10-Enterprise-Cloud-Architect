# CCM101 - Cloud Computing
## Enterprise Cloud Architect – Operational Manual
**Project:** Secure Multi-Tier Web Application
**Application Stack:** WordPress + MySQL
**Prepared by:** [ILAGAY ANG PANGALAN MO DITO]
**Section:** BSIT 2A
**Instructor:** Jenkielyn C. Torres
**Date:** November 2026

---

### 1. System Overview
This document serves as the operational manual for the enterprise cloud infrastructure deployed via Docker on an Ubuntu Server VM. The architecture consists of a multi-tier application (WordPress and MySQL) running behind a secure firewall.

### 2. Architecture & Network Topology
*   **Host Machine:** Windows Laptop
*   **Hypervisor:** Oracle VirtualBox (NAT with Port Forwarding)
*   **Virtual Machine:** Ubuntu Server (Headless)
*   **Firewall:** UFW (Uncomplicated Firewall)
*   **Containerization:** Docker & Docker Compose
*   **Containers:** WordPress (Frontend), MySQL (Backend/Database)
*   **Persistent Storage:** Named Docker Volumes (`db_data` and `wp_data`)

### 3. Deployment Procedure
If the server needs to be rebuilt from scratch, follow these steps:
1. Install Docker and Docker Compose: `sudo apt install docker.io docker-compose -y`
2. Navigate to the project directory.
3. Deploy the stack: `docker-compose up -d`
4. Verify containers are running: `docker ps`

### 4. Security Configuration (Hardening)
The server enforces a Default Deny policy to protect against unauthorized access.
*   **UFW Status:** Enabled.
*   **Allowed Ports:**
    *   `Port 22` (SSH): For secure remote administration.
    *   `Port 80` (HTTP): For public web access to WordPress.
*   **Denied Ports:** All other ports (including 3306 MySQL) are blocked from external access to prevent database exposure.

### 5. Automation & Backup
A custom Bash script (`automation-script.sh`) handles database backups.
*   **Backup Schedule:** Configured via Cron to run daily at 2:00 AM.
*   **Cron Command:** `0 2 * * * /home/student/wordpress-project/automation-script.sh >> /home/student/backups/cron.log 2>&1`
*   **Retention Policy:** Old backups are automatically deleted after 7 days.
