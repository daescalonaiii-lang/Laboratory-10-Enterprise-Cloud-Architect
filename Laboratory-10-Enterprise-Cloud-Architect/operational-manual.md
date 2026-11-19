# CCM101 - Cloud Computing
## Enterprise Cloud Architect – Operational Manual

**Project:** Secure Multi-Tier Web Application  
**Application Stack:** WordPress + MySQL  
**Prepared by:** Escalona III, Desederio A.  
**Section:** BSIT-4H  
**Instructor:** Jenkielyn C. Torres  
**Date:** November 2026  

---

# TABLE OF CONTENTS
1. Executive Summary
2. Architecture Overview
    2.1 Infrastructure Architecture
    2.2 Architecture Components
    2.3 Application Stack
3. Prerequisites
    3.1 Hardware Requirements
    3.2 Software Requirements
    3.3 Required Accounts
4. Deployment Procedure
    4.1 Provision Virtual Machine
    4.2 Install Docker
    4.3 Deploy Application Stack
    4.4 Verify Container Status
5. Security Controls
    5.1 Configure UFW Firewall
    5.2 SSH and Account Security
    5.3 Database and Secret Security
    5.4 WordPress and Docker Security
6. Backup & Recovery
    6.1 Backup Schedule and Location
    6.2 Manual Database Backup
    6.3 Schedule the Automation Script
    6.4 Restore a Database Backup
7. Monitoring & Logs
8. Troubleshooting
9. Disaster Recovery Scenarios
    9.1 Container Failure
    9.2 VM Loss
    9.3 Database Corruption
10. Maintenance Calendar

---

# 1. EXECUTIVE SUMMARY
This operational manual provides the technical documentation and procedures for deploying, securing, and maintaining a production-ready WordPress and MySQL application stack.

The infrastructure runs on Ubuntu Server 26.04 within a VirtualBox hypervisor, implementing a secure multi-tier architecture designed for reliability, isolation, and data protection.

The environment incorporates the following operational capabilities:

| Component | Description |
| :--- | :--- |
| **Firewall Security** | UFW configured with a default-deny policy |
| **Containerization** | Docker-based application deployment |
| **Database Management** | MySQL 8.0 running in an isolated container |
| **Persistent Storage** | Docker named volumes for data preservation |
| **Network Configuration** | Bridged networking for LAN accessibility |
| **Disaster Recovery** | Automated backup system scheduled through Cron |

The system is designed to provide a manageable, secure, and maintainable cloud infrastructure environment while demonstrating enterprise cloud architecture principles.

---

# 2. ARCHITECTURE OVERVIEW

## 2.1 Infrastructure Architecture
The project implements a six-layer architecture, separating the physical host, virtualization environment, operating system, application services, storage, and automation processes.

*(Refer to the attached `architecture-diagram.png` for the visual representation.)*

## 2.2 Architecture Components

| Layer | Component | Function |
| :--- | :--- | :--- |
| 1 | Host Machine | Laptop running VirtualBox |
| 2 | Hypervisor | VirtualBox with Bridged Network Adapter |
| 3 | Virtual Machine | Ubuntu Server 26.04 with UFW default-deny firewall |
| 4 | Containers | wp-app (Port 80) and wp-mysql (Internal Port 3306) |
| 5 | Storage | Docker named volumes wp_data and db_data |
| 6 | Automation | Cron scheduler executing automation-script.sh at 02:00 |

## 2.3 Application Stack
The deployed environment consists of two primary Docker containers:

**WordPress Application — wp-app**
- Hosts the WordPress web application.
- Exposes HTTP traffic through Port 80.
- Connects to the MySQL database through the internal Docker network.

**MySQL Database — wp-mysql**
- Stores WordPress application data.
- Uses MySQL 8.0.
- Operates through internal Port 3306.
- Uses persistent Docker storage to protect database information.

**Data Persistence:**

| Docker Volume | Purpose |
| :--- | :--- |
| wp_data | Stores WordPress application files |
| db_data | Stores MySQL database files |

---

# 3. PREREQUISITES
Before deployment, ensure that the following hardware, software, and accounts are available.

## 3.1 Hardware Requirements

| Resource | Minimum Requirement |
| :--- | :--- |
| RAM | 4 GB |
| Processor | 2 vCPU |
| Storage | 25 GB Disk Space |
| Network | Active LAN or Internet Connection |

## 3.2 Software Requirements

| Software | Version/Requirement |
| :--- | :--- |
| VirtualBox | Version 7.2.22 |
| Operating System | Ubuntu Server 26.04 |
| Container Platform | Docker Engine |
| Application | WordPress |
| Database | MySQL 8.0 |
| Version Control | Git |

## 3.3 Required Accounts
- Active GitHub account.
- Access to the project repository.
- Administrative access to the Ubuntu Server virtual machine.

---

# 4. DEPLOYMENT PROCEDURE
This section outlines the step-by-step process for provisioning the virtual machine, installing Docker, and deploying the application stack.

## 4.1 Provision Virtual Machine
**Objective:** Create and configure the Ubuntu Server virtual machine.

**Procedure:**
1. Open VirtualBox and create a new virtual machine.
2. Configure the virtual machine with the following resources:

| Configuration | Assigned Value |
| :--- | :--- |
| Operating System | Ubuntu Server 26.04 |
| RAM | 4 GB |
| CPU | 2 vCPU |
| Disk | 25 GB |
| Network Adapter | Bridge Adapter |

3. Mount the Ubuntu Server 26.04 ISO file.
4. Start the virtual machine and complete the Ubuntu installation.
5. Enable OpenSSH during installation.
6. Log in to the Ubuntu Server terminal.

Update the system packages:
```bash
sudo apt update && sudo apt upgrade -y
