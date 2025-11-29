# [PROJECT NAME] Constitution

Foundational principles and standards for [PROJECT NAME] development.

## Core Principles

### I. Persona-Driven Development
All development tasks are executed with appropriate personas that provide context-specific expertise. Personas shift dynamically as work evolves, ensuring optimal guidance for each phase.

### II. Test-First Development (NON-NEGOTIABLE)
All implementation must follow Test-Driven Development:
1. Write tests that define expected behavior
2. Verify tests fail initially (Red phase)
3. Implement code to make tests pass (Green phase)
4. Refactor for clarity and efficiency (Refactor phase)

### III. Constitution-First Decisions
All major decisions must align with this constitution. When development practices conflict with constitutional principles, the constitution takes precedence.

### IV. Clear Communication
- Document architectural decisions and their rationale
- Explain complex implementations
- Keep specifications up-to-date
- Share knowledge with the team

### V. Quality First
- Code must be readable and maintainable
- Comprehensive test coverage
- No known technical debt without documentation
- Regular code review and feedback

### VI. Simplicity Over Complexity
- Start with the simplest solution that works
- Add complexity only when proven necessary
- Avoid "future-proofing"
- Apply YAGNI (You Aren't Gonna Need It) principle

### VII. Continuous Learning
- Stay updated on relevant technologies
- Share discoveries and learnings
- Improve development practices
- Document lessons learned

## Development Standards

### Code Quality
- Follow project style guide and naming conventions
- Write clear, self-documenting code
- Include meaningful comments for complex logic
- Keep functions focused and testable
- Use consistent indentation and formatting

### Testing
- All features must have tests
- Tests should be independent and repeatable
- Test names should describe what they verify
- Tests should run quickly
- Maintain >80% code coverage

### Documentation
- Document public APIs and interfaces
- Explain non-obvious implementation choices
- Maintain README for major components
- Keep documentation current with code

### Code Review
- All changes require review before merge
- Reviewer checks for quality and standards compliance
- Feedback should be constructive and respectful
- Address critical issues before merge

## Architecture Guidelines

### System Design
- Design for clarity and maintainability
- Use established patterns and best practices
- Document architectural decisions
- Plan for testability and observability

### Component Separation
- Clear boundaries between components
- Minimal coupling between modules
- Each component has single responsibility
- Dependencies clearly documented

### Technology Choices
- Select technologies aligned with project needs
- Document rationale for selections
- Consider maintainability and team familiarity
- Avoid unnecessary dependencies

## Decision-Making Framework

### Major Decisions
Major decisions (architecture, technology selection, significant refactoring) should:
1. Be documented with rationale
2. Consider alternatives
3. Align with this constitution
4. Have team consensus when possible

### Change Management
- Significant changes should be reviewed
- Breaking changes require documentation
- Deprecation should follow clear timeline
- Migration paths should be provided

## Governance

### Compliance
- All development must comply with this constitution
- Exceptions require explicit justification
- Regular review of compliance
- Update constitution when practices improve

### Amendment Process
Changes to this constitution require:
- Clear rationale for change
- Documentation of what changed
- How existing code/practices are affected
- Team acknowledgment

**Version**: 1.0.0 | **Ratified**: [DATE] | **Last Amended**: [DATE]
