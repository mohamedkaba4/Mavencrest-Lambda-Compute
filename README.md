# Mavencrest Lambda Compute

Migrate the existing Mavencrest Next.js application from Amazon EC2 to AWS Lambda.

## Goal

The current Mavencrest application runs as a persistent Next.js Node.js server on Amazon EC2.

This project converts the same application to run using AWS Lambda so compute can scale to zero when the application is not being used.

### Current Architecture

```text
User
  ↓
Route 53
  ↓
Application Load Balancer
  ↓
EC2
  ↓
Next.js
```

### Target Architecture

```text
User
  ↓
HTTPS Endpoint
  ↓
AWS Lambda
  ↓
Next.js
```

Additional AWS services will only be introduced when required for the deployment.

## Objectives

- Package the existing Next.js application for AWS Lambda
- Keep existing application functionality
- Configure required Lambda environment variables
- Test server-side rendering and API routes
- Verify authentication and database connectivity
- Measure Lambda cold-start behavior
- Confirm that compute scales to zero when idle
- Compare the Lambda deployment with the existing EC2 deployment

## Technologies

- Next.js
- Node.js
- AWS Lambda
- AWS IAM
- PostgreSQL
- Prisma
- NextAuth
- Terraform
- GitHub Actions

## Migration Approach

The EC2 deployment will remain available while the Lambda version is developed and tested.

```text
Existing EC2 Application
        │
        ├── Remains operational
        │
        └── Used as baseline
                 ↓
        Adapt Next.js for Lambda
                 ↓
           Deploy Lambda
                 ↓
        Test application
                 ↓
       Validate functionality
```

The purpose of this project is specifically to demonstrate migration from persistent virtual-machine compute to serverless compute without rewriting the application.
