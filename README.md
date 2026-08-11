# 🔐 Crypto Intelligence Mapping

A web-based Crypto Intelligence and Transaction Analysis System designed to analyze cryptocurrency transactions, identify suspicious wallets, calculate wallet risk, and visualize relationships between wallets using graph-based intelligence mapping.

## 📌 Project Overview

Crypto Intelligence Mapping is a blockchain transaction analysis platform that helps investigate cryptocurrency wallet activity and identify potentially suspicious transactions.

The system combines:

- Cryptocurrency transaction analysis
- Wallet risk assessment
- Blacklist management
- Multi-hop wallet relationship analysis
- Graph-based transaction visualization
- MetaMask wallet integration
- Ganache blockchain environment
- Email-based security notifications
- Transaction history and reporting

## 🎯 Objectives

- Analyze cryptocurrency wallet transactions
- Identify potentially suspicious or malicious wallets
- Calculate wallet risk scores
- Maintain a blacklist of suspicious wallets
- Visualize relationships between wallets
- Analyze multi-hop transaction paths
- Connect and interact with MetaMask wallets
- Provide transaction history and security alerts
- Generate transaction reports

## 🛠️ Technology Stack

### Frontend
- JSP
- HTML5
- CSS3
- JavaScript
- Bootstrap
- SCSS

### Backend
- Java
- Java Servlets
- JDBC

### Database
- MySQL

### Blockchain
- Ganache
- MetaMask
- Web3

### Analysis & Security
- Wallet Risk Scoring
- Transaction Analysis
- Blacklist Management
- Multi-Hop Wallet Analysis
- IP Blocking
- Email Security Alerts
- Graph-Based Wallet Analysis

### Development Tools
- Apache NetBeans
- Apache Tomcat
- Apache Ant
- MySQL
- Ganache
- MetaMask

## ✨ Key Features

### 👤 User Management

- User Registration
- User Login
- User Profile Management
- User Approval
- OTP Functionality
- User Transaction History

### 💳 Transaction Management

- MetaMask Wallet Connection
- Cryptocurrency Transaction Management
- Transaction History
- Transaction Details
- Transaction Graph Visualization
- Wallet Safety Checking

### 🛡️ Threat Analysis

- Wallet Risk Scoring
- Suspicious Wallet Identification
- Blacklist Management
- Threat Analysis Logs
- IP Blocking
- Multi-Hop Wallet Analysis

### 📊 Graph-Based Intelligence Mapping

The system provides graph-based visualization to represent relationships between cryptocurrency wallets.

Example:

Wallet A → Wallet B → Wallet C → Wallet D

This helps analyze connections and transaction paths between multiple wallets.

### 🔔 Security Notifications

The system includes email notification functionality for security-related events, including the detection of suspicious wallets.

### 📄 Transaction Reports

The application includes functionality for generating transaction-related PDF reports.

## 🏗️ System Architecture

                    ┌──────────────────────┐
                    │     User / Admin     │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │    JSP Interface     │
                    │   HTML/CSS/JavaScript│
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │    Java Servlets     │
                    │   Business Logic     │
                    └──────────┬───────────┘
                               │
              ┌────────────────┼────────────────┐
              │                │                │
              ▼                ▼                ▼
       ┌─────────────┐  ┌──────────────┐  ┌─────────────┐
       │    MySQL    │  │   Ganache    │  │  MetaMask   │
       │   Database  │  │  Blockchain  │  │   Wallet    │
       └─────────────┘  └──────────────┘  └─────────────┘

🔄 Application Workflow
1. User Registration

The user creates an account by providing the required registration details.

2. User Login

Registered users can log into the application.

3. MetaMask Connection

The user can connect their MetaMask wallet to interact with the blockchain environment.

4. Transaction Analysis

Transaction information can be analyzed to determine wallet activity and transaction relationships.

5. Risk Analysis

The system evaluates wallet activity and calculates a risk score.

6. Threat Identification

Suspicious wallets can be identified and managed through blacklist and threat analysis functionality.

7. Graph Visualization

Wallet relationships and transaction paths can be represented using graph-based visualization.

8. Security Alert

Security-related events can trigger email notifications.

📂 Project Structure
                                                                                  
    Crypto_Intelligence_Mapping/
    │
    ├── src/
    │   ├── java/
    │   │   ├── Admin_Log.java
    │   │   ├── AlertMailUtil.java
    │   │   ├── CheckFlagServlet.java
    │   │   ├── IPBlockFilter.java
    │   │   ├── RiskEngine.java
    │   │   ├── SendOTP.java
    │   │   ├── Send_Mail.java
    │   │   ├── Threat_Analysis_Log.java
    │   │   ├── Transaction.java
    │   │   ├── TransactionPDF.java
    │   │   ├── TxCallback.java
    │   │   ├── Update_UserProfile.java
    │   │   ├── User_Login.java
    │   │   ├── User_Register.java
    │   │   └── connection/
    │   │       └── Dbconnection.java
    │   │
    │   └── conf/
    │       └── MANIFEST.MF
    │
    ├── web/
    │   ├── JSP Pages
    │   ├── assets/
    │   │   ├── css/
    │   │   ├── js/
    │   │   ├── img/
    │   │   └── lib/
    │   └── META-INF/
    │
    ├── lib/
    │   └── Project Dependencies
    │
    ├── Correct DB/
    │   └── Database SQL Script
    │
    ├── nbproject/
    │   └── NetBeans Project Configuration
    │
    ├── build.xml
    ├── .gitignore
    └── README.md
🗄️ Database

The project includes a MySQL database script located at:

Correct DB/New Project 20260120 1732.sql

The application uses the database:

crypto_transaction

The database is accessed using JDBC.

Before running the application, configure the database connection according to your local MySQL environment.

⛓️ Blockchain Environment

The project uses:

Ganache for the local blockchain environment
MetaMask for wallet interaction
Web3 for blockchain communication

The local Ganache environment is used for development and testing.

▶️ How to Run
Prerequisites

Install and configure:

Java JDK
Apache NetBeans
Apache Tomcat
MySQL
Ganache
MetaMask
Step 1 — Clone the Repository
git clone https://github.com/Sirimavilla-Kaushik/Crypto_Intelligence_Mapping.git

Step 2 — Import the Project

Open the project in Apache NetBeans.

Step 3 — Configure MySQL

Create the required database and import:

Correct DB/New Project 20260120 1732.sql
Step 4 — Configure Database Connection

Update the database connection settings according to your local MySQL configuration.

Step 5 — Start Ganache

Start Ganache and configure the local blockchain environment used by the project.

Step 6 — Configure MetaMask

Connect MetaMask to the local blockchain network used for testing.

Step 7 — Run the Application

Deploy the project using Apache Tomcat and open the application in a browser.

🎥 Working Demo

A working demonstration video of the project is available below.

Demo Video:
PASTE-YOUR-VIDEO-LINK-HERE

Example:

https://drive.google.com/file/d/1VgPnalH8862lfU03Ej9qQPZ1OM18Gf_X/view?usp=sharing

📸 Project Highlights

The project includes interfaces for:

User Registration and Login
User Dashboard
MetaMask Connection
Transaction Management
Wallet Safety Checking
Wallet Risk Scoring
Threat Analysis
Blacklist Management
Transaction Graph Visualization
Multi-Hop Wallet Analysis
Administrative Monitoring
👨‍💻 Project Information

Project Name: Crypto Intelligence Mapping

Domain: Blockchain / Cybersecurity / Cryptocurrency Analysis

Project Type: Academic / Final Year Project

Role: Developer

Primary Technologies:

Java | JSP | Servlets | MySQL | JDBC | JavaScript |
Bootstrap | Ganache | MetaMask | Web3
📈 Key Outcome

The project provides a centralized platform for analyzing cryptocurrency transactions and wallet relationships. It helps identify suspicious wallet activity through risk scoring, blacklist management, transaction analysis, and graph-based visualization.

⚠️ Disclaimer

This project was developed for academic and demonstration purposes using a local development environment.

Blockchain, database, email, and wallet configurations may require modification before deploying the application in another environment.
