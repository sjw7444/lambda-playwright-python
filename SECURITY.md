# Security Policy

## Supported Versions

We currently support the following versions with security updates:

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Reporting a Vulnerability

We take the security of Lambda Playwright Python seriously. If you believe you have found a security vulnerability, please report it to us as described below.

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them to the owner of this reposity directly.

You should receive a response within 48 hours. If for some reason you do not, please follow up via email to ensure we received your original message.

Please include the following information in your report:
- Type of issue (e.g., buffer overflow, SQL injection, cross-site scripting, etc.)
- Full paths of source file(s) related to the manifestation of the issue
- The location of the affected source code (tag/branch/commit or direct URL)
- Any special configuration required to reproduce the issue
- Step-by-step instructions to reproduce the issue
- Proof-of-concept or exploit code (if possible)
- Impact of the issue, including how an attacker might exploit it

This information will help us triage your report more quickly.

## Security Best Practices

When using this project, please follow these security best practices:

1. Always use the latest version of the base image
2. Keep your AWS Lambda function code up to date
3. Follow the principle of least privilege when setting up AWS IAM roles
4. Regularly audit your dependencies for known vulnerabilities
5. Use environment variables for sensitive configuration
6. Implement proper error handling to avoid exposing sensitive information

## Security Updates

Security updates will be released as patch versions (e.g., 0.1.1, 0.1.2) and will be tagged with the appropriate security advisory in GitHub.

## Acknowledgments

We would like to thank all security researchers who have responsibly reported vulnerabilities to us. 