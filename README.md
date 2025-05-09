# Lambda Playwright Python Base Image

This repository contains a base Docker image for running Playwright with Python on AWS Lambda with ARM support. The image is optimized for serverless environments and includes all necessary dependencies for headless Chromium browser automation.

## Features

- Python 3.13 support with latest performance improvements
- Playwright with headless Chromium browser
- AWS Lambda ARM64 compatibility
- Optimized for serverless environments
- Minimal dependencies for Chromium only
- Uses AWS Lambda's microdnf package manager
- Enhanced type system and better type checking
- Improved memory management and performance
- VS Code dev container support with development tools

## Development Setup

### Prerequisites

- Docker
- VS Code with Remote - Containers extension
- AWS CLI (for ECR deployment)
- Python 3.13+

### VS Code Dev Container

This project includes a VS Code dev container configuration that provides:
- Git for version control
- Python development tools
- All necessary VS Code extensions
- Pre-configured testing environment

To use the dev container:
1. Open the project in VS Code
2. When prompted, click "Reopen in Container"
   - Or use the Command Palette (F1) and select "Dev Containers: Reopen in Container"

### Building Locally

```bash
docker build -t lambda-playwright-python .
```

### Testing

```bash
pytest tests/
```

## Usage as Base Image

### Pulling the Base Image

```bash
# From DockerHub
docker pull sjw7444/lambda-playwright-python:latest

# From AWS ECR
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/j9p6g6v0/lambda-playwright-python
docker pull public.ecr.aws/j9p6g6v0/lambda-playwright-python:latest
```

### Using as Base Image

Create a new Dockerfile in your project:

```dockerfile
FROM sjw7444/lambda-playwright-python:latest

# Copy your Lambda function code
COPY your_lambda_function.py ${LAMBDA_TASK_ROOT}

# Set the CMD to your handler
CMD [ "your_lambda_function.handler" ]
```

### Example Lambda Function with Headless Chromium

```python
from playwright.sync_api import sync_playwright

def handler(event, context):
    with sync_playwright() as p:
        # Launch headless Chromium
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()
        
        # Your automation code here
        page.goto('https://example.com')
        title = page.title()
        
        browser.close()
        return {'statusCode': 200, 'body': title}
```

## Project Structure

```txt
.
├── Dockerfile            # Base image Dockerfile (Chromium-only)
├── .devcontainer/        # VS Code dev container configuration
├── .github/              # GitHub Actions workflows
├── .vscode/              # VS Code settings and extensions
├── tests/                # Test files
└── requirements.txt      # Python dependencies
```

## Deployment

The base image is automatically built and deployed to both DockerHub and AWS ECR Public when changes are pushed to the main branch.

### Required Secrets

To use the deployment workflow, you need to set up the following secrets in your GitHub repository:

- `AWS_ROLE_ARN`: AWS IAM role ARN for ECR access
- `ECR_REPOSITORY`: Your ECR repository name
- `DOCKERHUB_USERNAME`: Your DockerHub username
- `DOCKERHUB_TOKEN`: Your DockerHub access token

### AWS Permissions

The AWS IAM role needs the following permissions:
- `ecr-public:GetAuthorizationToken`
- `ecr-public:BatchCheckLayerAvailability`
- `ecr-public:GetRepositoryPolicy`
- `ecr-public:DescribeRepositories`
- `ecr-public:InitiateLayerUpload`
- `ecr-public:UploadLayerPart`
- `ecr-public:CompleteLayerUpload`
- `ecr-public:PutImage`

## License

MIT License

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## Security

This repository is designed to be open source. All sensitive information is stored as GitHub secrets and not committed to the repository. If you find any security issues, please report them by creating an issue.
