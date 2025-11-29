# Security Policy

## Reporting Security Vulnerabilities

**Do not** open a public issue for security vulnerabilities. Instead, email security@example.com with:

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if you have one)

We will acknowledge receipt within 24 hours and provide a status update within 72 hours.

## Security Best Practices

When using Agent Library:

### For Projects Using Agent Library

1. **Keep dependencies updated** - Regularly update Agent Library and its dependencies
2. **Review generated code** - Always review code generated or suggested by agents
3. **Validate inputs** - Never trust agent output without human review
4. **Follow security guidelines** - Follow your organization's security policies
5. **Manage credentials** - Keep authentication tokens and credentials secure
   - Never commit credentials to git
   - Use environment variables or secure vaults
   - Add sensitive paths to `.gitignore`

### For Agent Library Developers

We take security seriously:

1. **Dependency management** - We regularly update dependencies
2. **Code review** - All changes are reviewed
3. **Testing** - Security tests are included
4. **Disclosure** - Security issues are fixed and disclosed responsibly

## Supported Versions

| Version | Supported          |
|---------|-------------------|
| 0.1.x   | :white_check_mark: |
| < 0.1   | :x:                |

## Security Updates

- Critical security issues: Patched immediately
- Important security issues: Patched in next release
- Low-severity issues: Patched in regular releases

## Vulnerability Disclosure

Once a security vulnerability is fixed:

1. We will create a security advisory
2. Affected users will be notified
3. Release notes will document the fix
4. Credit will be given to the reporter (if desired)

## Questions?

For security questions or concerns:
- Email: security@example.com
- Check [SUPPORT.md](./SUPPORT.md) for other contact options

Thank you for helping keep Agent Library secure!
