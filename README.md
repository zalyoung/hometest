# Welcome to the Automated CI/CD Pipeline Project!

This project demonstrates a complete Continuous Integration and Continuous Delivery (CI/CD) pipeline for a web application. It's designed to automate the software delivery process, making it faster, more reliable, and consistent.

## Core Technologies

At the heart of this project are several industry-standard technologies:

*   **Jenkins:** An open-source automation server that orchestrates the entire CI/CD pipeline. The pipeline is defined as code using a `Jenkinsfile`.
*   **Docker:** Used for containerizing the application and its web server. Docker ensures that the application runs consistently across different environments (Development, Testing, Production) by packaging it with all its dependencies.
*   **GitHub:** Serves as the Source Code Management (SCM) system, hosting the application's codebase and triggering the CI/CD pipeline upon code changes.
*   **Docker Registry:** Used to store and manage versioned Docker images, which are the artifacts of our build process.

## The CI/CD Workflow

Our development and deployment workflow is streamlined for efficiency and reliability:

1.  **Development:** Developers work in isolated development environments and can run pre-commit tests locally to catch issues early.
2.  **Version Control:** Code changes are pushed to the GitHub repository.
3.  **Automated Pipeline Trigger:** Each push to the repository automatically triggers the Jenkins pipeline.
4.  **Build & Test:** The pipeline builds Docker images for the application and web server (`Dockerfile.App`, `Dockerfile.Web`). Automated tests are then executed to ensure code quality.
5.  **Deployment:** Upon successful testing, the pipeline automatically deploys the application to the production environment.

This automated process ensures that every change is consistently built, tested, and deployed, reducing manual effort and the risk of errors.

For a visual representation of this workflow, please see the `process.png` diagram included in this repository.

## Project Structure

The repository is organized as follows:

*   `Jenkinsfile`: Defines the CI/CD pipeline stages and steps executed by Jenkins.
*   `myweb/`: Contains all the source code and Dockerfiles for the application.
    *   `Dockerfile.App`: Instructions for building the application's Docker image.
    *   `Dockerfile.Web`: Instructions for building the web server's Docker image.
    *   `myweb/src/`: Source code for the Java-based web application (packaged as a WAR file).
    *   `myweb/web/`: Static web content such as HTML pages, images, etc.
*   `scripts/`: A collection of utility shell scripts for tasks like:
    *   `initCDSrv.sh`: Initializing the CI/CD server.
    *   `initEnv.sh`: Setting up Docker environments.
    *   `post-commit`: A Git hook for post-commit actions in the development environment.
    *   `startApp.sh`: Starting the application in testing or production.

To understand the overall system architecture, please refer to the `architecture.png` diagram.

## Getting Started

This project serves as a practical example of implementing CI/CD practices. Whether you are a developer looking to understand automated deployment, an operations engineer interested in infrastructure as code, or simply curious about CI/CD, we hope you find this project insightful.

We encourage you to explore the codebase, examine the `Jenkinsfile`, and see how the different components work together. Welcome aboard!
