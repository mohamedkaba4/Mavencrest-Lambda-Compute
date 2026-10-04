# Mavencrest Lambda Compute

Migrate the existing Mavencrest Next.js storefront from Amazon EC2 to AWS Lambda without rewriting the application.

## Goal

The current Mavencrest application runs as a persistent Next.js Node.js server on Amazon EC2.

This project packages the same storefront for AWS Lambda so the compute layer can scale to zero when the application is not being used.

## Architecture

### Current

    User
      ↓
    Route 53
      ↓
    Application Load Balancer
      ↓
    EC2
      ↓
    Next.js

### Target

    User
      ↓
    HTTPS Endpoint
      ↓
    AWS Lambda
      ↓
    Lambda Web Adapter
      ↓
    Next.js

Additional AWS services will only be introduced when required for the deployment.

## How the Application Is Packaged

The main Mavencrest repository contains the source code that is actively developed, including files such as:

    page.tsx
    layout.tsx
    components/
    API routes/

The storefront is built with:

    npm run build:store

Next.js compiles the source code into production runtime files inside `.next`.

For example:

    page.tsx
        ↓
    .next/server/app/page.js

    api/products/route.ts
        ↓
    .next/server/app/api/products/route.js

The Lambda repository contains the already-built runtime version of the storefront:

    Mavencrest-Lambda-Compute/
    └── app/
        ├── apps/storefront/
        │   ├── .next/
        │   ├── public/
        │   ├── package.json
        │   └── server.js
        └── node_modules/

The Dockerfile copies this packaged application into the container:

    WORKDIR /var/task
    COPY app/ ./
    CMD ["node", "apps/storefront/server.js"]

The original `.tsx` source files are not required inside the Lambda container because their compiled production code already exists inside `.next`.

The deployment flow is:

    Mavencrest Source Code
            ↓
    Next.js Production Build
            ↓
    .next + server.js + public + node_modules
            ↓
    Mavencrest-Lambda-Compute/app/
            ↓
    Docker Build
            ↓
    Container Image
            ↓
    Amazon ECR
            ↓
    AWS Lambda
            ↓
    Lambda Web Adapter
            ↓
    Next.js Storefront

## Objectives

- Package the existing Next.js storefront for AWS Lambda
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
- Docker
- AWS Lambda
- AWS Lambda Web Adapter
- Amazon ECR
- AWS IAM
- PostgreSQL
- Prisma
- NextAuth
- Terraform
- GitHub Actions

## Migration Approach

The existing EC2 deployment remains available while the Lambda version is developed and tested.

    Existing EC2 Application
            │
            ├── Remains operational
            └── Used as baseline
                     ↓
            Build Next.js storefront
                     ↓
            Package runtime into container
                     ↓
               Deploy to Lambda
                     ↓
              Test application
                     ↓
           Validate functionality

This project demonstrates the migration of an existing persistent virtual-machine workload to serverless compute while keeping the application architecture and functionality largely unchanged.
