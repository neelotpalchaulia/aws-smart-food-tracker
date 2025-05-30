# Smart Uber Eats Expense Tracker

## Project Overview

The Smart Uber Eats Expense Tracker is a cloud-native application designed to automate the process of tracking and analyzing spending on Uber Eats orders. By integrating directly with the Uber Eats API, the application provides users with real-time visibility into their food expenditure, detailed spending analytics, and tools for effective budget management. This project demonstrates the use of modern cloud architecture principles and leverages key services within Microsoft Azure to deliver a scalable, secure, and efficient solution.

### Problem Statement

Manually tracking expenses from digital services like Uber Eats is often cumbersome, prone to errors, and lacks the ability to provide dynamic insights into spending habits. This makes personal or business expense reporting and budget adherence challenging.

### Solution

The Smart Uber Eats Expense Tracker addresses this by:
- Automatically syncing order data from the Uber Eats API.
- Centralizing expense data in a secure, managed database.
- Providing a user-friendly interface for monitoring expenses.
- Generating detailed analytics and reports on spending patterns.
- Offering budget management features with customizable alerts.

## Technical Architecture

The application adopts a microservices-oriented architecture deployed on Microsoft Azure. The key components and their interactions are illustrated in the high-level diagram below:

> Note: Refer to the basic architecture diagram - architecture.md

The architecture comprises the following layers:

1.  **Presentation Layer:** A responsive web frontend built with React and TypeScript, hosted on Azure App Service. It provides the user interface for viewing expenses, analytics, and managing budgets.
2.  **Application Layer:** Backend logic implemented using Node.js and Express, likely deployed as Azure Functions (based on the project structure and README mentions) or potentially integrated within the App Service (requires clarification from code/implementation). This layer handles API interactions, data processing, and serves data to the frontend.
3.  **Data Layer:** Utilizes Azure SQL Database for persistent storage of user and transaction data. Azure Key Vault is used for the secure management of sensitive credentials, such as API keys and database connection strings. Azure Cache for Redis is mentioned for API response caching to improve performance (though not explicitly in the provided Terraform, it's a planned component).
4.  **Integration Layer:** Connects to the external Uber Eats API for automated data retrieval. This is likely orchestrated by Azure Functions or Logic Apps for scheduled sync tasks.
5.  **Monitoring & Management Layer:** Leverages Azure Monitor, including Application Insights for application performance monitoring, Log Analytics for centralized logging, and Azure Alerts for proactive notifications based on defined metrics or log events.

## Azure Services Utilized

This project heavily relies on the following Azure services:

### Infrastructure & Compute:
-   **Azure App Service:** Hosts the frontend web application, providing a scalable and managed environment.
-   **Azure Functions:** Used for serverless execution of background tasks, such as periodic data synchronization with the Uber Eats API.
-   **(Potential) Azure Load Balancer:** Although not explicitly defined in the provided `main.tf`, a Load Balancer would typically be used in a production environment to distribute traffic across multiple instances of the App Service for high availability and scalability. *Note: Update this point based on actual deployment - the provided Terraform does not deploy a dedicated Load Balancer, App Service handles basic load balancing internally when scaled.*

### Data Storage & Security:
-   **Azure SQL Database:** A fully managed relational database service used as the primary data store for application data.
-   **Azure Key Vault:** Securely stores and manages sensitive configuration information and credentials.
-   **(Potential) Azure Active Directory (Azure AD):** Could be used for user authentication and authorization within the application, as well as managing access to Azure resources (RBAC).
-   **(Potential) Azure Cache for Redis:** An in-memory data structure store, proposed for caching API responses to reduce latency and load on the backend.

### Monitoring & Management:
-   **Azure Monitor (with Application Insights and Log Analytics):** Provides comprehensive monitoring of application performance, infrastructure health, and centralized logging for troubleshooting and analysis.
-   **Azure Logic Apps:** Mentioned for scheduled syncs, indicating a potential use case for orchestrating data retrieval workflows.
-   **Azure Alerts:** Configured within Azure Monitor to send notifications based on predefined metrics or log query results (e.g., errors, performance degradation).

## Project Structure

```
smart-food-tracker/
├── frontend/ # React frontend application (UI components, pages, services)
├── backend/ # Node.js/Express backend (API controllers, services, data models)
├── functions/ # Azure Functions for background processing (e.g., data sync)
├── infrastructure/ # Infrastructure as Code using Terraform (Azure resource definitions)
└── docs/ # Project documentation (architecture diagrams, reports)
└── README.md # Project overview and documentation
```

## Getting Started

To set up and run this project locally or deploy it to Azure, follow these steps:

### Prerequisites

-   Node.js (v14 or higher)
-   npm or yarn package manager
-   Azure CLI
-   An active Azure subscription
-   Uber Eats Developer Account and API credentials

### Local Installation and Setup

1.  Clone the repository:
    ```bash
    git clone <repository_url>
    cd smart-food-tracker
    ```
2.  Install dependencies for frontend and backend:
   ```bash
   cd frontend
    npm install # or yarn install
   cd ../backend
    npm install # or yarn install
    ```
3.  Set up environment variables:
    -   Create `.env` files in both the `frontend` and `backend` directories.
    -   Add necessary configuration, including Azure connection details and Uber Eats API credentials. Consult documentation for specific variables.
    ```dotenv
    # Example .env for backend
    UBER_EATS_API_KEY=your_api_key
    UBER_EATS_CLIENT_SECRET=your_client_secret
    DATABASE_URL=your_sql_database_connection_string
    KEY_VAULT_URI=your_key_vault_uri
    ```
4.  (Optional) Set up Azure Functions locally if developing functions.

### Azure Deployment (using Terraform)

1.  Navigate to the `infrastructure/terraform` directory.
2.  Update `terraform.tfvars` with your Azure subscription details, desired location, environment name, and sensitive information (like SQL admin password - consider using a more secure method for production).
3.  Initialize Terraform:
    ```bash
    terraform init
    ```
4.  Review the deployment plan:
    ```bash
    terraform plan
    ```
5.  Apply the configuration to deploy resources to Azure:
    ```bash
    terraform apply
    ```
    Confirm the action when prompted.

### Running the Application

1.  Start the frontend application:
   ```bash
   cd frontend
    npm start # or yarn start
    ```
    The frontend will typically run on `http://localhost:3000`.
2.  Start the backend application:
    ```bash
    cd backend
    npm start # or yarn start
    ```
    The backend API will run on a specified port (e.g., 5000).
3.  (If using Functions) Start the Azure Functions host locally.

## Uber Eats API Integration

The application integrates with the Uber Eats API using OAuth 2.0 for secure authentication. Key API interactions include:
-   Retrieving historical order data.
-   Potentially tracking real-time order status.
-   Extracting relevant expense details from order responses.

## Security Considerations

Security is a critical aspect of this project:
-   Sensitive credentials are asymmetry stored in Azure Key Vault.
-   OAuth 2.0 is implemented for secure API authentication.
-   All communication within Azure and to/from clients is secured using HTTPS/SSL/TLS.
-   Azure AD can be integrated for identity and access management.
-   Data encryption at rest (SQL Database, Key Vault) and in transit is enforced.
-   Access to Azure resources is managed via RBAC and Key Vault access policies.

## Cost Estimation

An estimate of the monthly operational costs on Azure, based on the currently deployed services (B1 App Service Plan, Basic SQL DB, Standard Key Vault, basic monitoring), is approximately **$20 - $40+ per month**. This cost can fluctuate based on data transfer, storage size, and the volume of monitoring data ingested. More aggressive usage or higher service tiers would increase costs.

## Contributing

Contributions are welcome! Please follow the standard GitHub fork and pull request workflow.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Assignment Details

This project serves as a practical demonstration of cloud computing principles and services on Microsoft Azure, fulfilling the requirements of [CLOD2004/Azure Architecture]. It showcases the ability to design, implement, and deploy a cloud-native application, utilizing services for compute, data, security, and monitoring. The accompanying project report and presentation further detail the architecture, implementation choices, and alignment with cloud best practices.